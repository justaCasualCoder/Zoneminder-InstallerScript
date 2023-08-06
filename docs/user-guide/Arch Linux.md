# Arch Linux

This should work on any install of Arch Linux

1. Install yay


        pacman -S fakeroot make git base-devel
        cd /opt
        git clone https://aur.archlinux.org/yay-bin.git
        chown -R temp:users ./yay-bin
        cd yay-bin
        /bin/makepkg -si

         


2. Install MySQL , PHP , and Apache


        pacman -S --noconfirm apache mysql sudo php php-apache php-fpm


3. Enable Apache2 Modules


        echo "Include conf/extra/php_module.conf" >> /etc/httpd/conf/httpd.conf
        sed -i 's/^LoadModule mpm_event_module modules\/mod_mpm_event\.so/#&/' /etc/httpd/conf/httpd.conf
        sed -i 's/^#LoadModule mpm_prefork_module modules\/mod_mpm_prefork\.so/LoadModule mpm_prefork_module modules\/mod_mpm_prefork.so/' /etc/httpd/conf/httpd.conf
        sed -i '/^#LoadModule/s/$/\nLoadModule php_module modules\/libphp.so\nAddHandler php-script .php/' /etc/httpd/conf/httpd.conf
        sed -i '$ a Include conf\/extra\/php_module.conf' /etc/httpd/conf/httpd.conf
        echo "Include conf/extra/zoneminder.conf" >> /etc/httpd/conf/httpd.conf
        sed -i 's|^#\(LoadModule proxy_module modules/mod_proxy.so\)|\1|' /etc/httpd/conf/httpd.conf
        sed -i 's|^#\(LoadModule proxy_fcgi_module modules/mod_proxy_fcgi.so\)|\1|' /etc/httpd/conf/httpd.conf
        sed -i 's|^#\(LoadModule rewrite_module modules/mod_rewrite.so\)|\1|' /etc/httpd/conf/httpd.conf
        sed -i 's|^#\(LoadModule cgid_module modules/mod_cgid.so\)|\1|' /etc/httpd/conf/httpd.conf
        sudo sed -i '$ a\LoadModule cgid_module modules/mod_cgid.so' /etc/httpd/conf/httpd.conf


4. Install Zoneminder & start Apache 


        yay -S zoneminder
        systemctl restart httpd

5.  Set up MySQL Database

        mysql_install_db --user=mysql --basedir=/usr/ --ldata=/var/lib/mysql/
        cat << EOF | mysql
        BEGIN;
        CREATE DATABASE zm;
        CREATE USER zmuser@localhost IDENTIFIED BY 'zmpass';
        GRANT ALL ON zm.* TO zmuser@localhost;
        FLUSH PRIVILEGES;
        EOF
        mariadb -u zmuser -pzmpass < /usr/share/zoneminder/db/zm_create.sql

6. Start & Enable everything


         systemctl start httpd
         systemctl start mysqld
         systemctl start php-fpm
         systemctl start zoneminder
         systemctl enable httpd
         systemctl enable mysqld
         systemctl enable php-fpm
         systemctl enable zoneminder
