# Configuration
$hostName = "vagrant.site" # e.g. vagrant.duchamplondon (also update this in Vagrantfile)
$databaseName = "vagrant"
$phpstormServerName = "Vagrant"
$phpVersion = "55" # set to 53, 54, 55, 56

# create a new run stage to ensure certain modules are included first
stage {
    'pre':
        before => Stage['main'];
    'last':
        require => Stage['main'];
}

# add the baseconfig module to the new 'pre' run stage
# add message as last to execute
class {
    'baseconfig':
        stage => 'pre';
    'message':
        stage => 'last';
}

# set defaults for file ownership/permissions
File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
}

Package {
    allow_virtual => true
}

include baseconfig, nginx, php, percona, message
