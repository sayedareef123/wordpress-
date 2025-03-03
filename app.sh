#!/bin/bash

sudo apt update -y && sudo apt upgrade -y

# Install Nginx
echo "Installing Nginx..."
sudo apt install -y nginx

# Start and enable Nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Install MySQL
echo "Installing MySQL..."
sudo apt install -y mysql-server

# Secure MySQL installation
echo "Securing MySQL..."
sudo mysql_secure_installation <<EOF

y
y
y
y
y
EOF

# Create MySQL database and user
echo "Configuring MySQL for WordPress..."
DB_NAME="wrordpess"
DB_USER="devops"
DB_PASS="root"
sudo mysql -e "CREATE DATABASE ${DB_NAME};"
sudo mysql -e "CREATE USER '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';"
sudo mysql -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Install PHP and required extensions
echo "Installing PHP and extensions..."
sudo apt install -y php-fpm php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip

PUBLIC_IP=$(curl -s http://checkip.amazonaws.com)
# Configure Nginx for WordPress
echo "Configuring Nginx..."
sudo cat <<EOL > /etc/nginx/sites-available/wordpress
server {
    listen 80;
    server_name $PUBLIC_IP;

    root /var/www/html/wordpress;
    index index.php index.html index.htm;

    location / {
        try_files \$uri \$uri/ /index.php?\$args;
    }

    location ~ \.php\$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.ht {
        deny all;
    }

    gzip on;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;
}
EOL

# Enable the Nginx configuration
sudo ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx

# Download and configure WordPress
echo "Downloading and configuring WordPress..."
wget https://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz
sudo mv wordpress /var/www/html/
sudo chown -R www-data:www-data /var/www/html/wordpress
sudo chmod -R 755 /var/www/html/wordpress



echo "Setup completed successfully!"