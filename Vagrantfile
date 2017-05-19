
BOX_NAME       = "jobsDin"
BOX_MEMORY     = 512
BOX_IP         = "192.168.20.10"
SYNCED_FOLDER  = "~/Jobs/"

Vagrant.configure("2") do |config|
	config.vm.box = "ubuntu1404x64"
	config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
	config.vm.hostname = "localhost"
	config.vm.network "private_network", ip: BOX_IP
	#config.vm.network "public_network", ip: BOX_IP


	config.vm.provider "virtualbox" do |v|
		v.name = BOX_NAME
		v.memory = BOX_MEMORY
	end

	config.vm.synced_folder SYNCED_FOLDER, "/var/www", id: "123", group: 'www-data', owner: 'www-data', mount_options: ["dmode=775", "fmode=764"]

	config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'" # avoids 'stdin: is not a tty' error.
	config.vm.provision :shell, path: "bootstrap.sh"
	config.vm.provision :shell, inline: "sudo /etc/init.d/apache2 restart", run: "always"
	config.vm.provision :shell, inline: "sudo /etc/init.d/mysql restart", run: "always"
end