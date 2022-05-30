phpStormInstall () {
	echo "Do you need PhpStorm?"
	echo "1. Yes"
	echo "2. No"
	read -p "Enter your choise: " phpstorm_install
	if [[ $phpstorm_install = 1 ]]; then
		sudo apt update
		clear
		sudo snap install phpstorm --classic
		clear
	fi
}

gitInstall () {
	echo "Do you need git?"
	echo "1. Yes"
	echo "2. No"
	read -p "Enter your choise: " git_install
	if [[ $git_install = 1 ]]; then
		sudo apt update
		clear
		sudo apt install git -y 
		clear
	fi
}

apacheInstall () {
	echo "Do you need Apache?"
	echo "1. Yes"
	echo "2. No"
	read -p "Enter your choise: " apache_install
	if [[ $apache_install = 1 ]]; then
		sudo apt update
		clear
		sudo apt install apache2
		clear
		sudo systemctl enable apache2
		sudo systemctl enable apache2.service
		sudo systemctl restart apache2 
	fi
}

phpInstall () {
	echo "Do you need php? (All versions will be downloaded)"
	echo "1. Yes"
	echo "2. No"
	read -p "Enter your choise: " php_install
	if [[ $php_install = 1 ]]; then
		sudo apt-add-repository ppa:ondrej/php
		sudo apt-get update
		clear
		sudo apt-get install php7.1 libapache2-mod-php7.1 php7.1-cli php7.1-common php7.1-json php7.1-opcache php7.1-mysql php7.1-mbstring php7.1-mcrypt php7.1-zip php7.1-fpm -y &&
		sudo apt-get install php7.2 libapache2-mod-php7.2 php7.2-cli php7.2-common php7.2-json php7.2-opcache php7.2-mysql php7.2-mbstring php7.2-mcrypt php7.2-zip php7.2-fpm -y &&
		sudo apt-get install php7.3 libapache2-mod-php7.3 php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-mysql php7.3-mbstring php7.3-mcrypt php7.3-zip php7.3-fpm -y &&
		sudo apt-get install php7.4 libapache2-mod-php7.4 php7.4-cli php7.4-common php7.4-json php7.4-opcache php7.4-mysql php7.4-mbstring php7.4-mcrypt php7.4-zip php7.4-fpm -y &&
		sudo apt-get install php8.0 libapache2-mod-php8.0 php8.0-cli php8.0-common php8.0-json php8.0-opcache php8.0-mysql php8.0-mbstring php8.0-mcrypt php8.0-zip php8.0-fpm -y &&
		sudo apt-get install php8.1 libapache2-mod-php8.1 php8.1-cli php8.1-common php8.1-json php8.1-opcache php8.1-mysql php8.1-mbstring php8.1-mcrypt php8.1-zip php8.1-fpm -y 

		echo "file_uploads = On
        allow_url_fopen = On
        short_open_tag = On
        memory_limit = 1024M
        upload_max_filesize = 256M
        max_execution_time = 3600" | sudo tee -a /etc/php/7.1/apache2/php.ini
        clear

        echo "file_uploads = On
        allow_url_fopen = On
        short_open_tag = On
        memory_limit = 1024M
        upload_max_filesize = 256M
        max_execution_time = 3600" | sudo tee -a /etc/php/7.2/apache2/php.ini
        clear

        echo "file_uploads = On
        allow_url_fopen = On
        short_open_tag = On
        memory_limit = 1024M
        upload_max_filesize = 256M
        max_execution_time = 3600" | sudo tee -a /etc/php/7.3/apache2/php.ini
        clear

        echo "file_uploads = On
        allow_url_fopen = On
        short_open_tag = On
        memory_limit = 1024M
        upload_max_filesize = 256M
        max_execution_time = 3600" | sudo tee -a /etc/php/7.4/apache2/php.ini 
        clear

        echo "file_uploads = On
        allow_url_fopen = On
        short_open_tag = On
        memory_limit = 1024M
        upload_max_filesize = 256M
        max_execution_time = 3600" | sudo tee -a /etc/php/8.0/apache2/php.ini 
        clear

        echo "file_uploads = On
        allow_url_fopen = On
        short_open_tag = On
        memory_limit = 1024M
        upload_max_filesize = 256M
        max_execution_time = 3600" | sudo tee -a /etc/php/8.1/apache2/php.ini 
        clear
	fi
}

sqlInstall () {
	echo "Do you need MySQL/MariaDB?"
	echo "1. Yes"
	echo "2. No"
	read -p "Enter your choise: " sql_install
	if [[ $sql_install = 1 ]]; then
		read -p "Enter your future username for MySQL: " db_username
		read -p "Enter your future password for MySQL: " db_password
		sudo apt update
		sudo apt-get install mariadb-server mariadb-client -y
		sudo systemctl enable mariadb.service
		sudo systemctl restart mariadb.service
		sudo systemctl enable mariadb
		sudo systemctl restart mariadb
		sudo systemctl restart mysql
		clear
		echo "1. Skip; 2. Yes; 3. 1111; 4. 1111; 5. Yes; 6. Yes; 7. Yes; 8 Yes;"
		echo " "
		sudo mysql_secure_installation
		sudo mysql -e \
		"CREATE USER '$db_username'@'localhost' IDENTIFIED BY '$db_password';"
		sudo mysql -e \
		"GRANT ALL PRIVILEGES ON *.* TO '$db_username'@'localhost' WITH GRANT OPTION;" 
		sudo mysql -e \
		"FLUSH PRIVILEGES;"
		sudo systemctl restart mariadb
		sudo systemctl restart mysql
		clear
	fi
}

phpmyadminInstall () {
	echo "Do you need phpmyadmin?"
	echo "1. Yes"
	echo "2. No"
	read -p "Enter your choise: " phpmyadmin_install
	if [[ $phpmyadmin_install = 1 ]]; then
		clear
		echo "1. Apache 2; 2. dbconfig-common - Yes;"
		echo " "
		sudo add-apt-repository --remove ppa:nijel/phpmyadmin
		sudo apt update
		sudo apt install phpmyadmin
		sudo phpenmod mbstring
		sudo mv /etc/phpmyadmin/apache.conf /etc/apache2/conf-available/phpmyadmin.conf
		sudo a2enconf phpmyadmin
		sudo systemctl restart apache2
		clear
	fi
}

composerInstall () {
	echo "Do you need Composer?"
	echo "1. Yes"
	echo "2. No"
	read -p "Enter your choise: " composer_install
	if [[ $composer_install = 1 ]]; then
		clear
		echo "Choose Composer version"
		echo " "
		echo "1. 1.10.16"
		echo "2. 2.x"
		echo "3. Skip"
		read -p "Enter your choise: " compsoer_version
		case $compsoer_version in 
			1)
			curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer --version=1.10.16 
			clear
			break;;
			2)
			curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer 
			clear
			break;;
			*)
			clear
			break;;
		esac;
	fi
}

elasticInstall () {
	echo "Do you need Elastichsearch?"
	echo "1. Yes"
	echo "2. No"
	read -p "Enter your choise: " elastic_install
	if [[ $elastic_install = 1 ]]; then
		sudo apt install openjdk-8-jdk -y
		curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
		echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
		sudo apt update
		clear

		sudo apt install elasticsearch
		sudo /usr/share/elasticsearch/bin/elasticsearch-plugin install analysis-phonetic
		sudo /usr/share/elasticsearch/bin/elasticsearch-plugin install analysis-icu
		clear

		sudo systemctl start elasticsearch
		sudo systemctl start elasticsearch.service
		sudo systemctl enable elasticsearch
		sudo systemctl enable elasticsearch.service
		sudo systemctl restart elasticsearch
		sudo systemctl restart elasticsearch.service
		curl -X GET 'http://localhost:9200'

		sudo systemctl restart elasticsearch
		sudo systemctl restart elasticsearch.service 
	fi
}

usergroupInstall () {
	echo "Do you need add your user to www-data group?"
	echo "1. Yes"
	echo "2. No"
	read -p "Enter your choise: " usergroup_install
	if [[ $usergroup_install = 1 ]]; then
		sudo usermod -a -G www-data $USER
	fi
}

lampInstall () {
	sudo apt install curl
	clear
	phpStormInstall
	gitInstall
	apacheInstall
	phpInstall
	sqlInstall
	phpmyadminInstall
	composerInstall
	elasticInstall
	usergroupInstall
}

lampInstall
clear
echo " "
echo "Great job!"
echo " "
