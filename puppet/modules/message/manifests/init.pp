class message {
    notify {
        #"
        #INFORMATION:
        #SSH to vagrant: vagrant ssh
        #DB username: root (no password)
        #DB to use: vagrant
        #Site: vagrant.site
        #":
        "Info":
            message => "
            INFORMATION:
                SSH to vagrant: vagrant ssh
                SSH info - username: vagrant, password: vagrant
                DB username: root (no password)
                DB to use: ${databaseName}
                Site: ${hostName}",
            loglevel => alert
    }
}