GMS Webviews
----

These are very rudimentary web views for most of the objects in our system. You can set it up by following the instructions below.

```bash
sudo apt-get update

sudo apt-get install git ruby1.9.1 ruby1.9.1-dev rubygems1.9.1 irb1.9.1 ri1.9.1 rdoc1.9.1 build-essential apache2 libopenssl-ruby1.9.1 libssl-dev zlib1g-dev libcurl4-openssl-dev apache2-prefork-dev libapr1-dev libaprutil1-dev postgresql postgresql-contrib libpq-dev libxslt-dev libxml2-dev

sudo gem install passenger --no-ri --no-rdoc --version='3.0.15' --install-dir=/var/lib/gems/1.9.1
sudo gem install bundler --install-dir=/var/lib/gems/1.9.1
sudo passenger-install-apache2-module --auto

sudo bash -c "echo 'LoadModule passenger_module /var/lib/gems/1.9.1/gems/passenger-3.0.15/ext/apache2/mod_passenger.so 
    PassengerRoot /var/lib/gems/1.9.1/gems/passenger-3.0.15
    PassengerRuby /usr/bin/ruby1.9.1' >| /etc/apache2/conf.d/passenger"

cd /var/www
sudo git clone git://github.com/genome/gms-webviews.git
sudo chown -R www-data /var/www/gms-webviews/
sudo /usr/bin/gem1.9.1 install bundler --no-ri --no-rdoc
cd /var/www/gms-webviews
sudo bundle install
sudo -u www-data mkdir /var/www/gms-webviews/tmp
sudo -u www-data touch /var/www/gms-webviews/tmp/restart.txt

echo '<VirtualHost *:80>
   ServerName localhost
   ServerAlias some_hostname some_other_hostname
   DocumentRoot /var/www/gms-webviews/public
   PassengerHighPerformance on
   <Directory /var/www/gms-webviews/public>
      AllowOverride all
      Options -MultiViews
   </Directory>
   AddOutputFilterByType DEFLATE text/html text/css text/plain text/xml application/json
   AddOutputFilterByType DEFLATE image/jpeg, image/png, image/gif
</VirtualHost>' > /tmp/gms-webviews.conf

sudo cp /tmp/gms-webviews.conf /etc/apache2/sites-available/gms-webviews.conf

sudo ln -s  /etc/apache2/sites-available/gms-webviews.conf  /etc/apache2/sites-enabled/gms-webviews.conf

sudo /etc/init.d/apache2 restart
```


You will need to modify the 'production' section of `/var/www/gms-webviews/config/database.yml` to point to your postgres instance and `/var/www/gms-webviews/config/solr.yml` to point at your solr instance.
You will probably also need to modify the `ServerName` and `ServerAlias` attributes of the virtual host directive in `/etc/apache2/sites-available/gms-webviews.conf` to match your environment.

You can restart the application at any time (such as after changing those config values, or pulling an update from git) by touching the file located at `/var/www/gms-webviews/tmp/restart.txt`
