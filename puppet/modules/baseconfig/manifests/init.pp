# == Class: baseconfig
#
# Performs initial configuration tasks for all Vagrant boxes.
#
class baseconfig {
    #notify{
    #    "Running Yum Update":
    #        loglevel => notice
    #}

    #exec {
    #    'yum update':
    #        command => '/usr/bin/yum -y update';
    #}

    host {
        'hostmachine':
            ip => '192.168.0.1';
    }

##get yum repos
    yumrepo {
        "epel":
            mirrorlist  => "https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=\$basearch",
            descr       => "Extra Packages for Enterprise Linux 6 - \$basearch",
            enabled     => 1,
            gpgcheck    => 0;

    }

    file {
        '/root/.bashrc':
            owner  => 'root',
            group  => 'root',
            mode   => '0644',
            source => 'puppet:///modules/baseconfig/bash/.bashrc';

        '/home/vagrant/.bash_profile':
            owner  => 'vagrant',
            group  => 'vagrant',
            mode   => '0644',
            source => 'puppet:///modules/baseconfig/bash/.bash_profile';

        '/home/vagrant/.gitconfig':
            owner  => 'vagrant',
            group  => 'vagrant',
            mode   => '0644',
            source => 'puppet:///modules/baseconfig/git/.gitconfig';

        '/home/vagrant/.gitignore_global':
            owner  => 'vagrant',
            group  => 'vagrant',
            mode   => '0644',
            source => 'puppet:///modules/baseconfig/git/.gitignore_global';
    }

    package {
        [
            "vim",
            "htop",
            "git",
            "pv"
        ]:
            ensure  => present,
            require =>
                [
                    Yumrepo["epel"]
                ];
    }

    exec {
        "Install n98":
            command => "wget https://raw.githubusercontent.com/netz98/n98-magerun/master/n98-magerun.phar; chmod +x ./n98-magerun.phar; mv ./n98-magerun.phar /usr/local/bin/",
            cwd => "/root",
            creates => "/usr/local/bin/n98-magerun.phar",
            path => [
                "/usr/bin",
                "/bin"
            ]
    }

    service {
        "puppet":
            enable => true,
    }

    exec {
        "Update xdebug hostname in bash profile":
            command => "sed -i 's/serverName=Vagrant/serverName=$phpstormServerName/g' /home/vagrant/.bash_profile",
            require => File['/home/vagrant/.bash_profile'],
            path => [
                "/bin"
            ],
            cwd => '/',
    }

    exec {
        "Link Web DIR":
            command => "ln -s /vagrant /home/vagrant/site",
            cwd => "/home/vagrant",
            creates => "/home/vagrant/site",
            path => [
                "/usr/bin",
                "/bin"
            ]
    }
}
