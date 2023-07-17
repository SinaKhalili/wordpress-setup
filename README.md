# wordpress-setup
Just some scripts to setup a fresh DO server with nginx/mysql/php-fpm/wp. Vagrant for local testing.

I'm using an M1 mac so the vagrantfile specifies the arm version of ubuntu from
vagrant, even though DO is using intel.

# Usage

Simply run `vagrant up` if you are using an m1 mac. Make sure you have vmware fusion and
the necessary prerequisites (I couldn't get virtualbox to work). 

The setup is divided into three parts, each script is supposed to be run one after
another.

