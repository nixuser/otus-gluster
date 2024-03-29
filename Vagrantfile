# -*- mode: ruby -*-
# vi: set ft=ruby :
#
# export VAGRANT_EXPERIMENTAL="disks"

Vagrant.configure("2") do |config|
  # Base VM OS configuration.
  config.vm.box = "alma/9.3"
  config.vm.synced_folder '.', '/vagrant', disabled: false
  config.ssh.insert_key = false

  config.vm.provider :virtualbox do |v|
    v.memory = 1024
    v.cpus = 1
  end

  # Define two VMs with static private IP addresses.
  boxes = [
    { :name => "gluster1",
      :ip => "192.168.7.151",
    },
    { :name => "gluster2",
      :ip => "192.168.7.152",
    },
    { :name => "gluster3",
      :ip => "192.168.7.153",
    },
    { :name => "gluster4",
      :ip => "192.168.7.154",
    }
  ]
  # Provision each of the VMs.
  boxes.each do |opts|
    config.vm.define opts[:name] do |config|
      config.vm.hostname = opts[:name]
      config.vm.network "private_network", ip: opts[:ip]
      config.vm.disk :disk, size: "512MB", name: "disk1"
      config.vm.disk :disk, size: "512MB", name: "disk2"
      config.vm.disk :disk, size: "512MB", name: "disk3"
      config.vm.disk :disk, size: "512MB", name: "disk4"
      config.vm.disk :disk, size: "512MB", name: "disk5"

      config.vm.provision "shell",
        name: "Setup glusterfs",
        path: "install_gluster.sh"
    end
 end


      # Comment strings below and install Ansible to the host gluster1
      # Provision VMs using Ansible after the last VM is booted.
     # if opts[:name] == boxes.last[:name] 
     #   config.vm.provision "ansible" do |ansible|
     #     ansible.playbook = "playbooks/provision.yml"
     #     ansible.inventory_path = "inventory"
     #     ansible.limit = "all"
     #   end
     # end
      # Block end
    #end
  #end

end

