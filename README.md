# About
A simple 32-bit Vagrant LAMP stack, 100% automatic

## Details
* Serves the current directory as the web root, accessible at http://127.0.0.1:8080
* Installs adminer at http://127.0.0.1:8080/adminer
* Install Mailcatcher and forwards port 1080 to the host machine.

## Usage
* Clone this repo to the project dir
* `vagrant up`

Uses Ubuntu 14.04 LTS "Trusty Thar" 32-bit for poor schmucks like me who don't have hardware virtualization available on all machines. If you don't have that Vagrant box already, execute `vagrant box add ubuntu/trusty32`.

### Credits, references, sources
* https://serversforhackers.com/setting-up-mailcatcher
* https://gist.github.com/conroyp/741c30c44f5295f41422
