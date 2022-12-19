# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.require_version ">= 2.0.1"

$cpus   = ENV.fetch("ISLANDORA_VAGRANT_CPUS", "1")
$memory = ENV.fetch("ISLANDORA_VAGRANT_MEMORY", "4096")
$hostname = ENV.fetch("ISLANDORA_VAGRANT_HOSTNAME", "islandora8")
$virtualBoxDescription = ENV.fetch("ISLANDORA_VAGRANT_VIRTUALBOXDESCRIPTION", "Islandora 8")

# The Vagrant Base Box to use. Currently works with 'ubuntu/jammy64'.
$vagrantBox = ENV.fetch("ISLANDORA_DISTRO", "ubuntu/jammy64")

# See the "install profile" section of the README for the full gamut available.
$drupalProfile = ENV.fetch("ISLANDORA_INSTALL_PROFILE", "starter")

# Build the base box, defaults to install a machine with the existing one.
$buildBaseBox=ENV.fetch("ISLANDORA_BUILD_BASE", "false").to_s.downcase == "true"

# vagrant is the main user
$vagrantUser = "vagrant"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provider "virtualbox" do |v|
    if $buildBaseBox
      v.name = "Islandora 8 Ansible Base Box"
    else
      v.name = "Islandora 8 Ansible Sandbox Instance"
    end
  end

  config.vm.hostname = $hostname

  # Every Vagrant virtual environment requires a box to build off of.
  if $buildBaseBox
    config.vm.box = $vagrantBox
  else
    config.vm.box = "islandora_base"
  end

  # Configure home directory
  home_dir = "/home/" + $vagrantUser

  # Configure sync directory
  config.vm.synced_folder ".", home_dir + "/islandora"

  config.vm.network :forwarded_port, guest: 8000, host: 8000 # Apache
  config.vm.network :forwarded_port, guest: 8080, host: 8080 # Tomcat
  config.vm.network :forwarded_port, guest: 3306, host: 3306 # MySQL
  config.vm.network :forwarded_port, guest: 5432, host: 5432 # PostgreSQL
  config.vm.network :forwarded_port, guest: 8983, host: 8983 # Solr
  config.vm.network :forwarded_port, guest: 8161, host: 8161 # Activemq
  config.vm.network :forwarded_port, guest: 8081, host: 8081 # API-X

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", $memory]
    vb.customize ["modifyvm", :id, "--cpus", $cpus]
    vb.customize ["modifyvm", :id, "--description", $virtualBoxDescription]
    vb.customize ["modifyvm", :id, "--audio", "none"]
    vb.customize ["modifyvm", :id, "--uart1", "0x3F8", "4"]
    vb.customize ["modifyvm", :id, "--uartmode1", "disconnected" ]
  end

  if $vagrantBox != "islandora/8" then
    config.vm.provision :ansible do |ansible|
      ansible.compatibility_mode = "auto"
      ansible.playbook = "playbook.yml"
      ansible.galaxy_role_file = "requirements.yml"
      ansible.galaxy_command = "ansible-galaxy install --role-file=%{role_file}"
      ansible.limit = "all"
      ansible.inventory_path = "inventory/vagrant"
      ansible.host_vars = {
        "all" => { "ansible_ssh_user" => $vagrantUser }
      }
      ansible.extra_vars = { "islandora_distro" => $vagrantBox,
                             "islandora_profile" => $drupalProfile,
                             "islandora_build_base_box" => $buildBaseBox }
    end
  end

end
