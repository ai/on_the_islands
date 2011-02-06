# On The Islands

## Installation

1. Get latest Ruby 1.9. For example, on Ubuntu 10.10:
   
       apt-get install ruby-1.9.1 ruby1.9.1-dev
   
2. Install Bundler gem:
   
       sudo gem1.9.1 install bundler
   
3. Install MongoDB (see <http://mongodb.org/downloads>). For example, on
   Ubuntu 10.10:
   
       sudo apt-add-repository 'deb http://downloads.mongodb.org/distros/ubuntu 10.10 10gen'
       sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
       sudo apt-get update
       sudo apt-get install mongodb-stable

4. Install node.js. For example, on Ubuntu 10.10:
   
       sudo apt-add-repository ppa:chris-lea/node.js
       sudo apt-get update
       sudo apt-get install nodejs
       sudo ln -s /usr/bin/nodejs /usr/bin/node
   
5. Install all dependency gems:
   
       bundle install
   
6. Create Mongoid config:
   
       bundle exec rails generate mongoid:config
   
7. Start game web server:
   
       bundle exec rails server
   
8. Open <http://localhost:3000> in browser.
