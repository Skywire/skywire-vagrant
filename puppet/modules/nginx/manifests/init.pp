# == Class: nginx
#
# Installs NGINX and necessary modules. Sets config files.
#
class nginx {

    yumrepo {
        'nginx':
            baseurl     => "http://nginx.org/packages/centos/\$releasever/\$basearch/",
            descr       => "Nginx Repo",
            enabled     => 1,
            gpgcheck    => 0;
    }

    package {
        [
            'nginx'
        ]:
            ensure  => present,
            require =>
                [
                    Yumrepo["nginx"]
                ];
    }

    exec {
        'create_self_signed_sslcert':
            command => "openssl req -newkey rsa:2048 -nodes -keyout site.key  -x509 -days 365 -out site.crt -subj '/CN=${hostName}'",
            cwd     => '/etc/ssl',
            creates => [
                "/etc/ssl/site.key",
                "/etc/ssl/site.crt"
            ],
            path => [
                "/usr/bin",
                "/usr/sbin"
            ]
    }

    file {
        '/etc/nginx/nginx.conf':
            owner  => 'root',
            group  => 'root',
            mode   => '0644',
            source => 'puppet:///modules/nginx/nimbus/nginx.conf',
            require => Package['nginx'];

        '/etc/nginx/conf':
            ensure => 'directory',
            before => File['/etc/nginx/conf/skywire-enable-maintenance-mode.conf'],
            require => Package['nginx'];

        '/etc/nginx/conf/skywire-enable-maintenance-mode.conf':
            owner  => 'root',
            group  => 'root',
            mode   => '0644',
            source => 'puppet:///modules/nginx/nginx/global-for-all-platforms/conf/skywire-enable-maintenance-mode.conf',
            require => [
                Package['nginx'],
                File['/etc/nginx/conf']
            ];

        '/etc/nginx/conf/url-redirects.conf':
            owner  => 'root',
            group  => 'root',
            mode   => '0644',
            source => 'puppet:///modules/nginx/nginx/global-for-all-platforms/conf/skywire-url-redirects.conf',
            require => [
                Package['nginx'],
                File['/etc/nginx/conf']
            ];

        '/etc/nginx/conf.d/template.conf':
            owner  => 'root',
            group  => 'root',
            mode   => '0644',
            source => 'puppet:///modules/nginx/nimbus/template.conf',
            require => Package['nginx'];

        '/etc/nginx/conf.d/xhprof.conf':
            owner  => 'root',
            group  => 'root',
            mode   => '0644',
            source => 'puppet:///modules/nginx/nimbus/xhprof.conf',
            require => Package['nginx'];

        '/var/www':
            owner  => 'root',
            group  => 'root',
            recurse => true,
            ensure => 'directory',
            before => File['/var/www/xhprof'];

        '/var/www/xhprof':
            owner  => 'vagrant',
            group  => 'vagrant',
            recurse => true,
            ensure => 'directory',
            source => 'puppet:///modules/nginx/xhprof',
            require => Package['nginx'];

        '/var/www/xhprof/xhprof_lib/config.php':
            owner  => 'vagrant',
            group  => 'vagrant',
            source => 'puppet:///modules/nginx/xhprof-local/config.php',
            require => File['/var/www/xhprof']
    }

    exec {
        "Update Nginx site virtualhost name":
            command => "sed -i 's/server_name vagrant.site;/server_name $hostName;/g' /etc/nginx/conf.d/template.conf",
            require => File['/etc/nginx/conf.d/template.conf'],
            path => [
                "/bin"
            ],
            cwd => '/';

        "Update Nginx xhprof virtualhost name":
            command => "sed -i 's/server_name vagrant.site;/server_name $hostName;/g' /etc/nginx/conf.d/xhprof.conf",
            require => File['/etc/nginx/conf.d/xhprof.conf'],
            path => [
                "/bin"
            ],
            cwd => '/';

        "Update XHProf hostname":
            command => "sed -i 's/vagrant.site;/$hostName;/g' /var/www/xhprof/xhprof_lib/config.php",
            require => File['/var/www/xhprof/xhprof_lib/config.php'],
            path => [
                "/bin"
            ],
            cwd => '/',
    }

    #enabled from start up and ensure running
    service {
        "nginx":
            enable => true,
            ensure => "running",
            require => [
                File[
                    '/etc/nginx/nginx.conf',
                    '/etc/nginx/conf/skywire-enable-maintenance-mode.conf',
                    '/etc/nginx/conf/url-redirects.conf',
                    '/etc/nginx/conf.d/template.conf',
                    '/etc/nginx/conf.d/xhprof.conf',
                    '/var/www/xhprof'
                ],
                Exec["create_self_signed_sslcert"]
            ]
    }
}