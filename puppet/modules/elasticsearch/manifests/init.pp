# == Class: elasticsearch
#
# Installs ElasticSearch
#
class elasticsearch {

    if($elasticSearch){

        exec {
            "InstallPSK":
                command => "rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch",
                path => [
                    "/bin",
                    "/usr/bin"
                ];
        }

        yumrepo {
            "elastic":
                baseurl    => "http://packages.elastic.co/elasticsearch/1.6/centos",
                descr      => "Elasticsearch repository for 1.6.x packages",
                enabled    => 1,
                gpgcheck   => 1,
                gpgkey     => "http://packages.elastic.co/GPG-KEY-elasticsearch",
                require    => Exec["InstallPSK"];
        }

        package {
            "java":
                ensure  => present,
                before =>
                    [
                        Package["elasticsearch"]
                    ];

            "elasticsearch":
                ensure  => present,
                require =>
                    [
                        Yumrepo["elastic"]
                    ];
        }

        service {
            "elasticsearch":
                enable => true,
                ensure => "running",
                require => Package[
                    "elasticsearch"
                ]
        }
    }

}
