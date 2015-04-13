class message {
    notify {
        "Info":
            message => "
            INFORMATION:
                SSH to vagrant: vagrant ssh
                SSH info - username: vagrant, password: vagrant
                DB username: root (no password)
                DB to use: ${databaseName}
                Site: ${hostName}
                PHP Version: ${phpVersion}
                PHPStorm server name: ${phpstormServerName}
                Varnish Enabled?: ${varnish}",
            loglevel => alert
    }
}