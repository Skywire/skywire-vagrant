# == Class: varnish
#
# Installs Varnish
#
class varnish {

    if($varnish){
        yumrepo {
            "varnish":
                baseurl    => "http://repo.varnish-cache.org/redhat/varnish-3.0/el6/\$basearch",
                descr      => "Varnish 3.0 for Enterprise Linux el6 - \$basearch",
                enabled    => 1,
                gpgcheck   => 0
        }

        package {
            "varnish":
                ensure  => present,
                require =>
                    [
                        Yumrepo["varnish"]
                    ];
        }

        service {
            "varnish":
                enable => true,
                ensure => "running",
                require => Package[
                    "varnish"
                ]
        }
    }

}
