#! /bin/bash

apacheVars () {
	read -p "Enter your future magento project folder name (For example default name project-community-edition): " name_magento_folder
	read -p "Enter your domain (For example magento.loc): " domain
	read -p "Enter your future magento project (For example default path /var/www/html. Recomendation: create folder with your magento project in your home folder): " project_path
}

projectVars () {
	read -p "Create name for your new database: " db_name
	read -p "Create login for your magento admin: " admin_username
	read -p "Create password for your magento admin: " admin_password
	read -p "Input your (or not your) email: " admin_email
	read -p "Input your (or not your) name: " admin_name
	read -p "Input your (or not your) lastname: " admin_lastname
	read -p "Input your gitlab login: " gitlab_login
	read -p "Input your gitlab password: " gitlab_password
	read -p "Input your gitlab/hub HTTPS link: " gitlink
	read -p "Input your relevant branch: " checkout_branch
	read -p "Input your MySQL username: " own_username
	read -p "Input your MySQL password: " own_password
}

projectInstruction () {
	echo " "
	echo "Do you have database file? (.sql file)"
	echo "1. Yes"
	echo "2. No"
	read -p "Enter your choise: " sql_file

	if [[ $sql_file = 1 ]]; then
		echo " "
		read -p "Input your full path to your sql file (with ./<name>.sql): " path_sql_file
		echo "Your database have plefix?"
		echo "1. Yes."
		echo "2. No."
		read -p "Enter your choise: " prefix
		if [[ $prefix = 1 ]]; then
			echo " "
			read -p "Enter your database prefix (For example 'exp_'): " database_prefix
		fi
	fi

	echo " "
	echo "Do you need reindex?: "
	echo "1. Yes"
	echo "2. No"
	read -p "Enter your choise: " reindex_status

	echo " "
	echo "Do you need downgrade or upgrade php version for this project?"
  echo " "
  echo "1. PHP 7.1"
  echo "2. PHP 7.2"
  echo "3. PHP 7.3"
  echo "4. PHP 7.4"
  echo "5. PHP 8.0"
  echo "6. Skip"
  echo " "
  read -p "Enter your choise: " php_version_cmd

}

checkVars () {
	clear
	echo " "
	echo "1. Magento project folder name (varname - name_magento_folder) - " $name_magento_folder
	echo "2. Domain (varname - domain) - " $domain
	echo "3. Project path (varname - project_path) - " $project_path
	echo "4. Database name (varname - db_name) - "$db_name
	echo "5. Login for Magento admin panel (varname - admin_username) - " $admin_username
	echo "6. Password for Magento admin panel (varname - admin_password) - " $admin_password
	echo "7. Email for Magento admin panel (varname - admin_email) - " $admin_email
	echo "8. Name for Magento admin panel (varname - admin_name) - " $admin_name
	echo "9. Lastname for Magento admin panel (varname - admin_lastname) - " $admin_lastname
	echo "10. Git login (varname - gitlab_login) - " $gitlab_login
	echo "11. Git password (varname - gitlab_password) - " $gitlab_password
	echo "12. HTTPS link for you git repository (varname - gitlink) - " $gitlink
	echo "13. Your relevant branch for git repository (varname - checkout_branch) - " $checkout_branch
	echo "14. MySQL username (varname - own_username) - " $own_username
	echo "15. MySQL password (varname - own_password) - "$own_password
	if [[ $sql_file = 1 ]]; then
		echo "16. Path to your database (varname - path_sql_file) - " $path_sql_file
		if [[ $prefix = 1 ]]; then
			echo "17. Your database prefix (varname - database_prefix) - " $database_prefix
		fi
	fi
}

changeFunction () {
	read -p "Enter here varname as should be changed: " changeble_var
	read -p "Enter here value for variable: " $changeble_var
	clear
	changeVars
}

changeVars () {
	checkVars
	echo " "
	echo "All variables for your project are listed above. Do you need to change something?"
  echo "1. Yes"
  echo "2. No"
  read -p "Enter your choise: " var_status
  if [[ $var_status = 1 ]]; then
  	changeFunction
  fi
}


manualEnv () {
	if [[ $prefix = 1 ]]; then
	echo "<?php
return [
    'backend' => [
        'frontName' => 'admin'
    ],
    'crypt' => [
        'key' => '09a3d6f3d970b3914f7a695a0bc0e71f'
    ],
    'db' => [
        'table_prefix' => '$database_prefix',
        'connection' => [
            'default' => [
                'host' => 'localhost',
                'dbname' => '$db_name',
                'username' => '$own_username',
                'password' => '$own_password',
                'active' => '1'
            ]
        ]
    ],
    'resource' => [
        'default_setup' => [
            'connection' => 'default'
        ]
    ],
    'x-frame-options' => 'SAMEORIGIN',
    'MAGE_MODE' => 'developer',
    'session' => [
        'save' => 'db'
    ],
    'cache_types' => [
        'config' => 1,
        'layout' => 1,
        'block_html' => 1,
        'collections' => 1,
        'reflection' => 1,
        'db_ddl' => 1,
        'compiled_config' => 1,
        'eav' => 1,
        'customer_notification' => 1,
        'config_integration' => 1,
        'config_integration_api' => 1,
        'full_page' => 1,
        'config_webservice' => 1,
        'translate' => 1,
        'vertex' => 1
    ],
    'install' => [
        'date' => 'Tue, 16 Jan 2018 11:30:55 +0000'
    ],
    'system' => [
        'default' => [
            'dev' => [
                'debug' => [
                    'debug_logging' => '0'
                ]
            ]
        ]
    ],
    'queue' => [
        'consumers_wait_for_messages' => 0
    ],
];" | sudo tee -a $project_path/$name_magento_folder/app/etc/env.php
sudo chmod -R 777 $project_path/$name_magento_folder/app/etc/env.php
fi

if [[ $prefix = 2 ]]; then
	echo "<?php
return [
    'backend' => [
        'frontName' => 'admin'
    ],
    'crypt' => [
        'key' => '09a3d6f3d970b3914f7a695a0bc0e71f'
    ],
    'db' => [
        'connection' => [
            'default' => [
                'host' => 'localhost',
                'dbname' => '$db_name',
                'username' => '$own_username',
                'password' => '$own_password',
                'active' => '1'
            ]
        ]
    ],
    'resource' => [
        'default_setup' => [
            'connection' => 'default'
        ]
    ],
    'x-frame-options' => 'SAMEORIGIN',
    'MAGE_MODE' => 'developer',
    'session' => [
        'save' => 'db'
    ],
    'cache_types' => [
        'config' => 1,
        'layout' => 1,
        'block_html' => 1,
        'collections' => 1,
        'reflection' => 1,
        'db_ddl' => 1,
        'compiled_config' => 1,
        'eav' => 1,
        'customer_notification' => 1,
        'config_integration' => 1,
        'config_integration_api' => 1,
        'full_page' => 1,
        'config_webservice' => 1,
        'translate' => 1,
        'vertex' => 1
    ],
    'install' => [
        'date' => 'Tue, 16 Jan 2018 11:30:55 +0000'
    ],
    'system' => [
        'default' => [
            'dev' => [
                'debug' => [
                    'debug_logging' => '0'
                ]
            ]
        ]
    ],
    'queue' => [
        'consumers_wait_for_messages' => 0
    ],
];" | sudo tee -a $project_path/$name_magento_folder/app/etc/env.php
sudo chmod -R 777 $project_path/$name_magento_folder/app/etc/env.php
fi
}


apacheHost () {
echo "<VirtualHost *:80>
<Directory $project_path/$name_magento_folder>
    Allow from all
          Options Indexes FollowSymLinks Multiviews
          AllowOverride All
          Order allow,deny
          Require all granted
      </Directory>
  ServerAdmin webmaster@localhost
  DocumentRoot $project_path/$name_magento_folder
  ErrorLog ${APACHE_LOG_DIR}/error.log
  ServerName $domain
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>" | sudo tee -a /etc/apache2/sites-available/$domain.conf

sudo sed -i "1i127.0.0.1  	$domain" /etc/hosts

sudo a2ensite $domain.conf
sudo a2enmod rewrite

sudo systemctl restart apache2.service
sudo systemctl restart apache2

clear
}

phpVersion () {
	case $php_version_cmd in

    1)
    sudo a2dismod php7.2 
    sudo a2dismod php7.3
    sudo a2dismod php7.4
    sudo a2enmod php7.1  
    sudo service apache2 restart  
    sudo update-alternatives --set php /usr/bin/php7.1  
    sudo update-alternatives --set phar /usr/bin/phar7.1  
    sudo update-alternatives --set phar.phar /usr/bin/phar.phar7.1
    clear
    ;;

    2)
    sudo a2dismod php7.1
    sudo a2dismod php7.3
    sudo a2dismod php7.4  
    sudo a2enmod php7.2  
    sudo service apache2 restart       
    sudo update-alternatives --set php /usr/bin/php7.2  
    sudo update-alternatives --set phar /usr/bin/phar7.2  
    sudo update-alternatives --set phar.phar /usr/bin/phar.phar7.2
    clear
    ;;

    3)
    sudo a2dismod php7.1
    sudo a2dismod php7.2
    sudo a2dismod php7.4 
    sudo a2enmod php7.3  
    sudo service apache2 restart     
    sudo update-alternatives --set php /usr/bin/php7.3  
    sudo update-alternatives --set phar /usr/bin/phar7.3  
    sudo update-alternatives --set phar.phar /usr/bin/phar.phar7.3
    clear
    ;;

    4)
    sudo a2dismod php7.1
    sudo a2dismod php7.2
    sudo a2dismod php7.3 
    sudo a2enmod php7.4  
    sudo service apache2 restart  
    sudo update-alternatives --set php /usr/bin/php7.4 
    sudo update-alternatives --set phar /usr/bin/phar7.4  
    sudo update-alternatives --set phar.phar /usr/bin/phar.phar7.4
    clear
    ;;

    5)
    sudo a2dismod php7.1
    sudo a2dismod php7.2
    sudo a2dismod php7.3
    sudo a2dismod php7.4 
    sudo a2enmod php8.0  
    sudo service apache2 restart  
    sudo update-alternatives --set php /usr/bin/php8.0  
    sudo update-alternatives --set phar /usr/bin/phar8.0  
    sudo update-alternatives --set phar.phar /usr/bin/phar.phar8.0
    clear
    ;;

    6)
    clear
    ;;

  esac;
}

projectPermissions () {
	cd $project_path/$name_magento_folder
	find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} +
	find var generated vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} +
	chown -R :www-data .
	chmod u+x bin/magento
}

projectRepository () {
	link="https://"
  gitpass=${gitlab_login}:${gitlab_password}@
  git clone ${gitlink//$link/${link}${gitpass}} $project_path/$name_magento_folder
  git -C $project_path/$name_magento_folder checkout $checkout_branch
  git pull ${gitlink//$link/${link}${gitpass}}
}

installDatabase () {
	if [[ $sql_file = 1 ]]; then
				mysql -u $own_username -p$own_password -e \
      "CREATE DATABASE $db_name; USE $db_name; GRANT ALL PRIVILEGES ON $db_name.* TO $own_username@localhost IDENTIFIED BY '$own_password'"
	    echo "Wait until your $db_name import data from $path_sql_file"
	    mysql -u $own_username -p$own_password $db_name < $path_sql_file
	    if [[ $prefix = 1 ]]; then
	    	cd $project_path/$name_magento_folder
	        manualEnv
	     		clear
	        mysql -u $own_username -p$own_password -e \
	      "USE $db_name; UPDATE ${database_prefix}core_config_data SET value = 'http://$domain/' WHERE path LIKE 'web/unsecure/base_url';"
	    		mysql -u $own_username -p$own_password -e \
	      "USE $db_name; UPDATE ${database_prefix}core_config_data SET value = 'http://$domain/' WHERE path LIKE 'web/secure/base_url';"
      fi
	    if [[ $prefix = 2 ]]; then
	    	cd $project_path/$name_magento_folder
	        manualEnv
	        clear
	    	  mysql -u $own_username -p$own_password -e \
	    	"USE $db_name; UPDATE core_config_data SET value = 'http://$domain/' WHERE path LIKE 'web/unsecure/base_url';"
	    	  mysql -u $own_username -p$own_password -e \
	    	"USE $db_name; UPDATE core_config_data SET value = 'http://$domain/' WHERE path LIKE 'web/secure/base_url';"
	    fi
    elif [[ $sql_file = 2 ]]; then
    		mysql -u $own_username -p$own_password -e \
      "CREATE DATABASE $db_name; USE $db_name; GRANT ALL PRIVILEGES ON $db_name.* TO $own_username@localhost IDENTIFIED BY '$own_password'"
  fi
}

deployFunction () {
	if [[ $reindex_status = 1 ]]; then
		cd $project_path/$name_magento_folder
	  bin/magento setup:upgrade
	  bin/magento setup:di:compile
	  bin/magento setup:static-content:deploy -f -j 4
	  bin/magento ind:res
	  bin/magento ind:rei
	  bin/magento c:f
	  bin/magento admin:user:create 
	  bin/magento c:st
	  bin/magento c:f
  fi
    
  if [[ $reindex_status = 2 ]]; then
    cd $project_path/$name_magento_folder
    bin/magento setup:upgrade
    bin/magento setup:di:compile
    bin/magento setup:static-content:deploy -f -j 4
    bin/magento c:f
    bin/magento admin:user:create 
    bin/magento c:st
    bin/magento c:f
  fi
}

installFunction () {
	clear
	apacheVars
	projectVars
	projectInstruction
	changeVars
	phpVersion
	apacheHost
	projectRepository
	composer install --working-dir=$project_path/$name_magento_folder
  sudo rm -rf $project_path/$name_magento_folder/app/etc/env.php
  projectPermissions
  installDatabase
  deployFunction
}

installFunction