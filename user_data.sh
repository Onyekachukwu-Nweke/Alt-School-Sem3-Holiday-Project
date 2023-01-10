#!/bin/bash
sudo apt update -y
sudo apt install -y --no-install-recommends php8.1
sudo apt-get install -y php8.1-cli php8.1-common php8.1-mysql php8.1-zip php8.1-gd php8.1-mbstring php8.1-curl php8.1-xml php8.1-bcmath php8.1-fpm
sudo systemctl reload php8.1-fpm
git clone https://github.com/Onyekachukwu-Nweke/server_stats_template.git
sudo apt install -y nginx
sudo mv server_stats_template/assets /var/www/html/
sudo mv server_stats_template/index.php /var/www/html/
git clone https://github.com/Onyekachukwu-Nweke/Alt-School-Sem3-Holiday-Project.git
sudo cat Alt-School-Sem3-Holiday-Project/nginx | sudo tee /etc/nginx/sites-available/default
sudo mv /var/www/html/index.nginx-debian.html ../
sudo systemctl reload php8.1-fpm
sudo systemctl restart nginx