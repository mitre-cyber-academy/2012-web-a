package "apache2" do
  action :install
end

bash "challenge" do
  user "root"
  code <<-EOH
    
    # cleanup
    rm /var/www/*
    rm /etc/apache2/sites-enabled/*
    rm /etc/apache2/sites-available/*
    
    # virtual host
    mv /home/ubuntu/chef-solo/cookbooks/challenge/aux/host /etc/apache2/sites-available/
    ln -s /etc/apache2/sites-available/host /etc/apache2/sites-enabled/host
    
    # apache conf
    mv /home/ubuntu/chef-solo/cookbooks/challenge/aux/apache2.conf /etc/apache2
    
    # all challenge files
    mv /home/ubuntu/chef-solo/cookbooks/challenge/aux/* /var/www/
    
    # access controll
    htpasswd -cb /var/www/.htpasswd user1 dragon
    
    # permissions
    chown -R root:root /var/www/*
    chown -R root:root /var/www/.*
    chmod -R 555 /var/www/*
    chmod -R 555 /var/www/.*
    
  EOH
end

service "apache2" do
  action[:restart]
end