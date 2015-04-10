class mailhog {

    package {
        [
            "golang",
            "mercurial",
            "bzr",
            "daemonize",
            "ssmtp"
        ]:
            ensure  => present
    }

    file {
        '/root/go':
            owner  => 'root',
            group  => 'root',
            recurse => true,
            ensure => 'directory'
    }

    exec {
        "Install mailhog":
            command => "go get github.com/mailhog/MailHog",
            path => [
                "/bin",
                "/usr/bin"
            ],
            cwd => '/root';

        "Setting Executable for MailHog executable":
            command => "chmod +x /root/go/bin/MailHog",
            require => Exec[
            "Install mailhog"
            ],
            path => [
                "/bin",
                "/usr/bin"
            ],
            cwd => '/root';

        "Update PHP with mailhog":
            command => "sed -i 's/sendmail_path = \\/usr\\/sbin\\/sendmail -t -i/sendmail_path = \\/usr\\/sbin\\/ssmtp -t/g' $phpFolderStart/etc/php.ini",
            require => Package["php$phpMid-fpm"],
            before => Service["php$phpMid-fpm"],
            path => [
                "/bin"
            ],
            cwd => '/';
    }

    file {
        "/etc/init.d/mailhog":
            owner  => 'root',
            group  => 'root',
            mode   => '0655',
            require => Exec["Install mailhog"],
            source => 'puppet:///modules/mailhog/mailhog.init';
    }

    service {
        "mailhog":
            enable => true,
            ensure => "running",
            require => [
                File[
                    '/etc/init.d/mailhog'
                ]
            ]
    }
}