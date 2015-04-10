# == Class: percona
#
# Installs PERCONA and necessary modules. Sets config files.
#
class percona {
    notify {
        "Checking Percona":
            loglevel => notice
    }

    yumrepo {
        "percona-release":
            baseurl     => "http://repo.percona.com/release/\$releasever/RPMS/\$basearch",
            descr       => "Percona-Release YUM repository - \$basearch",
            enabled     => 1,
            gpgcheck    => 0;

        "percona-release-noarch":
            baseurl     => "http://repo.percona.com/release/\$releasever/RPMS/noarch",
            descr       => "Percona-Release YUM repository - noarch",
            enabled     => 1,
            gpgcheck    => 0;
    }

    package {
        [
            'Percona-Server-server-55'
        ]:
            ensure  => present,
            require =>
                [
                    Yumrepo["percona-release"],
                    Yumrepo["percona-release-noarch"]
                ];
    }

    #enabled from start up and ensure running
    service {
        "mysql":
            enable => true,
            ensure => "running",
            require => Package['Percona-Server-server-55']
    }

    exec {
        "Create Main Database":
            command => "mysql -u root --execute='CREATE DATABASE IF NOT EXISTS ${databaseName};'",
            require => Service['mysql'],
            path => [
                "/usr/bin",
                "/usr/sbin"
            ],
            cwd => '/';

        "Create xhprof Database":
            command => "mysql -u root --execute='CREATE DATABASE IF NOT EXISTS xhprof;'",
            require => Service['mysql'],
            path => [
                "/usr/bin",
                "/usr/sbin"
            ],
            cwd => '/';

        "Setup xhprof tables":
            command => "mysql -u root xhprof < /vagrant/puppet/modules/percona/files/xhprof.sql",
            require => Exec["Create xhprof Database"],
            path => [
                "/usr/bin",
                "/usr/sbin"
            ],
            cwd => '/';
}
}