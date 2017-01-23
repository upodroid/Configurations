TBU: To be updated

To install LEMP Stack:
```bash
wget https://raw.githubusercontent.com/upodroid/Configurations/master/lemp.sh
chmod +x lemp.sh
./lemp.sh
```

Few things, make sure the certificate is already generated before running the script. 
Make sure the pem file is in /etc/nginx/ssl and called nginx.pem and make sure the private key is in the same directory and called nginx.key
Also open the nginx config file at /etc/nginx/sites-available/default and match it to waht you need.

The script doesn't initialise MariaDB fully so you need to run the following commands, they should allow you to use mysql qithout sudo:
```
sudo mysql 
MariaDB> use mysql;
MariaDB> update user set plugin=’‘ where User=’root’;
MariaDB> flush privileges;
MariaDB> exit
```

Have fun :D 

Upo
