# -*- mode: ruby -*-
# vi: set ft=ruby :

disk_size = 100 # in megabytes
disk_dir = '../vmdisks' # directory where additional disk files are stored
disk_controller = 'IDE' # MacOS. This setting is OS dependent. Details https://github.com/hashicorp/vagrant/issues/8105

Vagrant.configure("2") do |config|
  # Base VM OS configuration.
  config.vm.box = "centos/7"
  config.vm.synced_folder '.', '/vagrant', disabled: true
  config.ssh.insert_key = false

  config.vm.provider :virtualbox do |v|
    v.memory = 256
    v.cpus = 1
  end

  # Define two VMs with static private IP addresses.
  boxes = [
    { :name => "gluster1", :ip => "192.168.7.151" },
    { :name => "gluster2", :ip => "192.168.7.152" },
    { :name => "gluster3", :ip => "192.168.7.153" },
    { :name => "gluster4", :ip => "192.168.7.154" },
  ]
  # Provision each of the VMs.
  boxes.each do |opts|
    config.vm.define opts[:name] do |config|
      config.vm.hostname = opts[:name]
      config.vm.network "private_network", ip: opts[:ip]

      file_to_disk = File.join(disk_dir, config.vm.hostname + '.vdi')
      config.vm.provider :virtualbox do |vm|
        unless File.exist?(file_to_disk)
          vm.customize ['createhd', '--filename', file_to_disk, '--size', disk_size]
        end
        vm.customize ['storageattach', :id, '--storagectl', 'IDE', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', file_to_disk]
      end

      # Provision VMs using Ansible after the last VM is booted.
      if opts[:name] == boxes.last[:name] 
        config.vm.provision "ansible" do |ansible|
          ansible.playbook = "playbooks/provision.yml"
          ansible.inventory_path = "inventory"
          ansible.limit = "all"
        end
      end
    end
  end

end

