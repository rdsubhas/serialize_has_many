# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.network 'forwarded_port', :guest => 3000, :host => 3000
  config.ssh.forward_agent = true

  if Vagrant.has_plugin?('vagrant-cachier')
    config.cache.scope = :box
  else
    puts "Run `vagrant plugin install vagrant-cachier` to reduce caffeine intake when provisioning"
  end

  # Provision as root
  config.vm.provision :shell, privileged: true, inline: <<-SCRIPT
    echo "Installing necessary packages..."
    add-apt-repository -y ppa:brightbox/ruby-ng-experimental
    apt-get -y update
    apt-get -y install build-essential git libxml2-dev libxslt1-dev imagemagick zlib1g-dev ruby2.2 ruby2.2-dev nodejs curl wget libsqlite3-dev

    echo "Setting up postgres authentication..."
    echo 'host all all 0.0.0.0/0 trust' > /etc/postgresql/9.3/main/pg_hba.conf
    service postgresql restart

    echo "Setting up ruby..."
    echo 'gem: --no-ri --no-rdoc' > /etc/gemrc
    gem install bundler
  SCRIPT

  # Provision as vagrant user
  config.vm.provision :shell, privileged: false, inline: <<-SCRIPT
    echo "Installing gems..."
    cd /vagrant
    bundle install

    cd /vagrant/example
    bundle install
  SCRIPT

end
