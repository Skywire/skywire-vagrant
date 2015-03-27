# == Class: php
#
# Installs PHP5 and necessary modules. Sets config files.
#
class php {
    notify {
        "Checking PHP":
            loglevel => notice
    }

    if($phpVersion == '53'){
        $phpMid = ""
        $phpFolderStart = ""
    }

    if($phpVersion == '54'){
        $phpMid = '54-php'
        $phpFolderStart = "/opt/remi/php54/root"
        yumrepo {
            "remi":
                mirrorlist  => "http://rpms.famillecollet.com/enterprise/6/remi/mirror",
                descr       => "Les RPM de remi pour Enterprise Linux 6 - \$basearch",
                enabled     => 1,
                gpgcheck    => 0,
                before      => Package[
                    "php$phpMid-devel",
                    "php$phpMid-cli",
                    "php$phpMid-fpm",
                    "php$phpMid-pdo",
                    "php$phpMid-gd",
                    "php$phpMid-process",
                    "php$phpMid-opcache",
                    "php$phpMid-pecl-zip",
                    "php$phpMid-mcrypt",
                    "php$phpMid-xml",
                    "php$phpMid-pecl-memcache",
                    "php$phpMid-common",
                    "php$phpMid-mbstring",
                    "php$phpMid-soap",
                    "php$phpMid-pecl-xdebug",
                    "php$phpMid-pecl-imagick",
                    "php$phpMid-pecl-xhprof"
                ];
        }
    }

    if($phpVersion == '55'){
        $phpMid = ''
        $phpFolderStart = ""
        yumrepo {
            "remi":
                mirrorlist  => "http://rpms.famillecollet.com/enterprise/6/remi/mirror",
                descr       => "Les RPM de remi pour Enterprise Linux 6 - \$basearch",
                enabled     => 1,
                gpgcheck    => 0,
                before      => Package[
                    "php$phpMid-devel",
                    "php$phpMid-cli",
                    "php$phpMid-fpm",
                    "php$phpMid-pdo",
                    "php$phpMid-gd",
                    "php$phpMid-process",
                    "php$phpMid-opcache",
                    "php$phpMid-pecl-zip",
                    "php$phpMid-mcrypt",
                    "php$phpMid-xml",
                    "php$phpMid-pecl-memcache",
                    "php$phpMid-common",
                    "php$phpMid-mbstring",
                    "php$phpMid-soap",
                    "php$phpMid-pecl-xdebug",
                    "php$phpMid-pecl-imagick",
                    "php$phpMid-pecl-xhprof"
                ];
            "remi-php55":
                mirrorlist => "http://rpms.famillecollet.com/enterprise/6/php55/mirror",
                descr      => "Les RPM de remi de PHP 5.5 pour Enterprise Linux 6 - \$basearch",
                enabled    => 1,
                gpgcheck   => 0,
                before     => Package[
                    "php$phpMid-devel",
                    "php$phpMid-cli",
                    "php$phpMid-fpm",
                    "php$phpMid-pdo",
                    "php$phpMid-gd",
                    "php$phpMid-process",
                    "php$phpMid-opcache",
                    "php$phpMid-pecl-zip",
                    "php$phpMid-mcrypt",
                    "php$phpMid-xml",
                    "php$phpMid-pecl-memcache",
                    "php$phpMid-common",
                    "php$phpMid-mbstring",
                    "php$phpMid-soap",
                    "php$phpMid-pecl-xdebug",
                    "php$phpMid-pecl-imagick",
                    "php$phpMid-pecl-xhprof"
                ];

        }
    }

    if($phpVersion == '56'){
        $phpMid = '56-php'
        $phpFolderStart = "/opt/remi/php56/root"
        yumrepo {
            "remi":
                mirrorlist  => "http://rpms.famillecollet.com/enterprise/6/remi/mirror",
                descr       => "Les RPM de remi pour Enterprise Linux 6 - \$basearch",
                enabled     => 1,
                gpgcheck    => 0,
                before      => Package[
                    "php$phpMid-devel",
                    "php$phpMid-cli",
                    "php$phpMid-fpm",
                    "php$phpMid-pdo",
                    "php$phpMid-gd",
                    "php$phpMid-process",
                    "php$phpMid-opcache",
                    "php$phpMid-pecl-zip",
                    "php$phpMid-mcrypt",
                    "php$phpMid-xml",
                    "php$phpMid-pecl-memcache",
                    "php$phpMid-common",
                    "php$phpMid-mbstring",
                    "php$phpMid-soap",
                    "php$phpMid-pecl-xdebug",
                    "php$phpMid-pecl-imagick",
                    "php$phpMid-pecl-xhprof"
                ];
            "remi-php56":
                mirrorlist => "http://rpms.famillecollet.com/enterprise/6/php56/mirror",
                descr      => "Les RPM de remi de PHP 5.6 pour Enterprise Linux 6 - \$basearch",
                enabled    => 1,
                gpgcheck   => 0,
                before     => Package[
                    "php$phpMid-devel",
                    "php$phpMid-cli",
                    "php$phpMid-fpm",
                    "php$phpMid-pdo",
                    "php$phpMid-gd",
                    "php$phpMid-process",
                    "php$phpMid-opcache",
                    "php$phpMid-pecl-zip",
                    "php$phpMid-mcrypt",
                    "php$phpMid-xml",
                    "php$phpMid-pecl-memcache",
                    "php$phpMid-common",
                    "php$phpMid-mbstring",
                    "php$phpMid-soap",
                    "php$phpMid-pecl-xdebug",
                    "php$phpMid-pecl-imagick",
                    "php$phpMid-pecl-xhprof"
                ];
        }
    }

    package {
        [
            "php$phpMid-devel",
            "php$phpMid-cli",
            "php$phpMid-fpm",
            "php$phpMid-pdo",
            "php$phpMid-gd",
            "php$phpMid-process",
            "php$phpMid-opcache",
            "php$phpMid-pecl-zip",
            "php$phpMid-mcrypt",
            "php$phpMid-xml",
            "php$phpMid-pecl-memcache",
            "php$phpMid-common",
            "php$phpMid-mbstring",
            "php$phpMid-soap",
            "php$phpMid-pecl-xdebug",
            "php$phpMid-pecl-imagick",
            "php$phpMid-pecl-xhprof"
        ]:
            ensure  => present,
            require =>
                [
                    Yumrepo["epel"]
                ];
    }

    if($phpVersion == '53'){
       package {
           [
               "php$phpMid-pdo_mysql"
           ]:
               ensure  => present,
               require =>
                   [
                       Package["php$phpMid-devel"]
                   ];
       }
    } else {
        package {
            [
                "php$phpMid-mysqlnd"
            ]:
                ensure  => present,
                require =>
                    [
                        Package["php$phpMid-devel"]
                    ];
        }
    }

    #enabled from start up and ensure running
    service {
        "php$phpMid-fpm":
            enable => true,
            ensure => "running",
            require => Package[
                "php$phpMid-devel",
                "php$phpMid-cli",
                "php$phpMid-fpm",
                "php$phpMid-pdo",
                "php$phpMid-gd",
                "php$phpMid-process",
                "php$phpMid-opcache",
                "php$phpMid-pecl-zip",
                "php$phpMid-mcrypt",
                "php$phpMid-xml",
                "php$phpMid-pecl-memcache",
                "php$phpMid-common",
                "php$phpMid-mbstring",
                "php$phpMid-soap",
                "php$phpMid-pecl-xdebug",
                "php$phpMid-pecl-imagick",
                "php$phpMid-pecl-xhprof"
            ]
    }

    file {
        "$phpFolderStart/etc/php.d/skywire_updates.ini":
            owner  => 'root',
            group  => 'root',
            mode   => '0644',
            require => Package["php$phpMid-devel"],
            source => 'puppet:///modules/php/skywire_updates.ini';
    }


    ##install composer
    exec {
        "Install Composer":
            command => "curl -sS https://getcomposer.org/installer | php; mv composer.phar /usr/local/bin/composer",
            cwd => "/root",
            creates => "/usr/local/bin/composer",
            path => [
                "/usr/bin",
                "/bin"
            ],
            require => Package["php$phpMid"]
    }

    if($phpVersion != '53') {
        exec {
            "Link PHP":
                command => "ln -s /usr/bin/php$phpVersion /usr/bin/php",
                cwd => "/root",
                creates => "/usr/bin/php",
                path => [
                    "/usr/bin",
                    "/bin"
                ]
        }
    }

    exec {
        "sed -i 's/user = apache/user = vagrant/g' $phpFolderStart/etc/php-fpm.d/www.conf":
            require => Package["php$phpMid-fpm"],
            path => [
                "/bin"
            ],
            cwd => '/',
    }

    exec {
        "sed -i 's/group = apache/group = vagrant/g' $phpFolderStart/etc/php-fpm.d/www.conf":
            require => Package["php$phpMid-fpm"],
            path => [
                "/bin"
            ],
            cwd => '/',
    }
}
