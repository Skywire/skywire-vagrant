# == Class: baseconfig
#
# Performs initial configuration tasks for all Vagrant boxes.
#
class baseconfig {

    host {
        'hostmachine':
            ip => '192.168.0.1';
    }

    file {
        '/root/.bashrc':
            owner  => 'root',
            group  => 'root',
            mode   => '0644',
            source => 'puppet:///modules/baseconfig/bash/.bashrc';

        '/home/vagrant/.bash_profile':
            owner  => 'vagrant',
            group  => 'vagrant',
            mode   => '0644',
            source => 'puppet:///modules/baseconfig/bash/.bash_profile';

        '/home/vagrant/.gitconfig':
            owner  => 'vagrant',
            group  => 'vagrant',
            mode   => '0644',
            source => 'puppet:///modules/baseconfig/git/.gitconfig';

        '/home/vagrant/.gitmessage.txt':
            owner  => 'vagrant',
            group  => 'vagrant',
            mode   => '0644',
            source => 'puppet:///modules/baseconfig/git/.gitmessage.txt';

        '/home/vagrant/.gitignore_global':
            owner  => 'vagrant',
            group  => 'vagrant',
            mode   => '0644',
            source => 'puppet:///modules/baseconfig/git/.gitignore_global';
    }

    service {
        "puppet":
            enable => true;
    }

    exec {
        "Update xdebug hostname in bash profile":
            command => "sed -i 's/serverName=Vagrant/serverName=$phpstormServerName/g' /home/vagrant/.bash_profile",
            require => File['/home/vagrant/.bash_profile'],
            path => [
                "/bin"
            ],
            cwd => '/';

        "Link Web DIR":
            command => "ln -s /vagrant /home/vagrant/site",
            cwd => "/home/vagrant",
            creates => "/home/vagrant/site",
            path => [
                "/usr/bin",
                "/bin"
            ];
    }
}
