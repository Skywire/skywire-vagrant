# == Class: nginx
#
# Installs NGINX and necessary modules. Sets config files.
#
class nginx {

    exec {
        "Update Nginx site virtualhost name":
            command => "sed -i 's/server_name vagrant.site;/server_name $hostName;/g' /etc/nginx/conf.d/template.conf",
            path => [
                "/bin"
            ],
            cwd => '/';

        "Update Nginx xhprof virtualhost name":
            command => "sed -i 's/server_name vagrant.site;/server_name $hostName;/g' /etc/nginx/conf.d/xhprof.conf",
            path => [
                "/bin"
            ],
            cwd => '/';

        "Update XHProf hostname":
            command => "sed -i 's/vagrant.site;/$hostName;/g' /var/www/xhprof/xhprof_lib/config.php",
            path => [
                "/bin"
            ],
            cwd => '/',
    }
}