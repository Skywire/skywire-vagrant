# Configuration
$hostName = "vagrant.site" # e.g. vagrant.duchamplondon.com (also update this in Vagrantfile)
$databaseName = "vagrant"
$phpstormServerName = "Vagrant"
$phpVersion = "56" # set to 53, 54, 55, 56

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



if($phpVersion == '53'){
    $phpMid = ""
    $phpFolderStart = ""
}

if($phpVersion == '54'){
    $phpMid = '54-php'
    $phpFolderStart = "/opt/remi/php54/root"
}

if($phpVersion == '55'){
    $phpMid = ''
    $phpFolderStart = ""
}

if($phpVersion == '56'){
    $phpMid = '56-php'
    $phpFolderStart = "/opt/remi/php56/root"
}

include baseconfig, nginx, php, percona, message, mailhog
