# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.require_version ">= 2.0.1"
host = RbConfig::CONFIG['host_os']

# List memory
if host =~ /darwin/
  $detected_cpus = `sysctl -n hw.ncpu`.to_i
  # conver to MB
  $mem = `sysctl -n hw.memsize`.to_i / 1024 / 1024
elsif host =~ /linux/
  $detected_cpus = `nproc`.to_i
  $mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024
else
  # else windows commands
  $detected_cpus = `wmic cpu get NumberOfCores`.split("\n")[2].to_i
  $mem = `wmic OS get TotalVisibleMemorySize`.split("\n")[2].to_i / 1024
end

# Use whichever is larger, 1/2 the RAM or 4GB.
$mem = [$mem / 2, 4096].max

$cpus   = ENV.fetch("ISLANDORA_VAGRANT_CPUS", "1")
$memory = ENV.fetch("ISLANDORA_VAGRANT_MEMORY", $mem)

$hostname = ENV.fetch("ISLANDORA_VAGRANT_HOSTNAME", "islandora8")
$virtualBoxDescription = ENV.fetch("ISLANDORA_VAGRANT_VIRTUALBOXDESCRIPTION", "Islandora 8")

$vms_running = `VBoxManage list runningvms | wc -l | sed 's/[^0-9]//g'`.to_i
$cpus_checks = ENV.fetch("ISLANDORA_VAGRANT_CPUS", "")

# Available boxes are 'ubuntu/xenial64' and 'centos/7'
$vagrantBox = ENV.fetch("ISLANDORA_DISTRO", "ubuntu/bionic64")

# On Ubuntu, user is ubuntu, on all others, user is vagrant
$vagrantUser = if $vagrantBox == "ubuntu/bionic64" then "ubuntu" else "vagrant" end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provider "virtualbox" do |v|
    v.name = "Islandora 8 Ansible"
  end

  config.vm.hostname = $hostname

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = $vagrantBox

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
    if $vms_running == 0
      if $cpus_checks == ""
        vb.customize ["modifyvm", :id, "--ioapic", "on"]
        vb.customize ["modifyvm", :id, "--cpus", $detected_cpus]
      else
        vb.customize ["modifyvm", :id, "--cpus", $cpus]
      end
    else
      vb.customize ["modifyvm", :id, "--cpus", $cpus]
    end

    vb.customize ["modifyvm", :id, "--memory", $memory]
    vb.customize ["modifyvm", :id, "--description", $virtualBoxDescription]
    vb.customize ["modifyvm", :id, "--audio", "none"]
  end

  config.vm.provision :ansible do |ansible|
    ansible.compatibility_mode = "auto"
    ansible.playbook = "playbook.yml"
    ansible.galaxy_role_file = "requirements.yml"
    ansible.galaxy_command = "ansible-galaxy install --role-file=%{role_file} --roles-path=roles/external"
    ansible.limit = "all"
    ansible.inventory_path = "inventory/vagrant"
    ansible.host_vars = {
      "all" => { "ansible_ssh_user" => $vagrantUser }
    }
    ansible.extra_vars = { "islandora_distro" => $vagrantBox }
  end

end
