# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  src_dir = './'
  doc_root = '/vagrant_data/app/webroot'
  app_name = File.basename(File.dirname(__FILE__))
  config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.synced_folder src_dir, "/vagrant_data", :create => true, :owner=> 'vagrant', :group=>'www-data', :extra => 'dmode=775,fmode=775'
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "./vagrant-cookbooks"
    chef.add_recipe "omusubi"
    chef.json = { doc_root: doc_root}
  end

  config.vm.provision :shell, :inline => <<-EOS
    mysql -u root --execute  "create database if not exists #{app_name}"
    cd /vagrant_data; composer update
    #cd /vagrant_data/app; yes | ./Console/cake schema update
  EOS

end
