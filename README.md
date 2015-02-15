Web User Auth Protection

1.  Challenge:
a.  You have been asked to perform a penetration test on a web site that was a prototype and is now being used in production.  The customer suspects that the user authentication needs more locking down, but knows little else.  You have been given nothing but a web URL.  Visit the URL to see where the user logs in.  You should be able to break in and view the flag.
b.  To successfully meet the challenge, no changes to the web site are required or allowed.
 
2.  Administrative instructions
a.  Load apache
b.  Create pass_protected directory
$sudo mkdir /var/www/html/pass_protected
$cd /var/www/html/pass_protected
$sudo vi  index.html
<html><body>The flag is - MCA-B281FAEE
</body></html>
ZZ
3.  Create root index.html file
a.  $sudo vi  /var/www/html/index.html
<html>
<body>
<p>Welcome to the prototype system!</p>
<p><a href="pass_protected">Password protected directory!</a></p>
<p>Unauthorized use is prohibited!</p>
</body>
</html>
ZZ
4.  Create .htpasswd file
a.  $sudo htpasswd -cb /var/www/html/.htpasswd user1 dragon
b.  $sudo chmod 444 .htpasswd 
5.  vi  /etc/httpd/httpd.conf
a.  Add this:
<Directory "/var/www/html/pass_protected">
  AuthType Basic
  AuthName "Authentication Required"
  AuthUserFile "/var/www/html/.htpasswd"
  Require valid-user
  Order allow,deny
  Allow from all
</Directory>
2.  Comment out this
#<Files ~ "^\.ht">
#    Order allow,deny
#    Deny from all
#    Satisfy all
#</Files>
c.  ZZ
1.  $sudo apachectl restart
6.  Test the site
3.  Solution:
a.  (MITRE testing only)
1.  My (Perry Engle's) personal  test site can be seen at http://ec2-67-202-56-156.compute-1.amazonaws.com/
b.  Go to webserver - see the file
1.  Click the link, you should see the pop-up
c.  Run Nikto.pl against the server
d.  Notice that .htpasswd is visible
e.  Get it
f.  Run john on it
1.  Standard dictionary -
2.  $/pentest/passwords/john/john -session=webcracking2 -wordlist=/pentest/passwords/john/password.lst -rules=sing
le .htpasswd
4.  Use the password to access directory /pass_protected
a.  Done!
 

