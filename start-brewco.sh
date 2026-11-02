#!/bin/bash

echo "Stopping previous processes..."
pkill -f "php -S localhost:8080" 2>/dev/null
sleep 1

echo "Starting PHP server for Brew & Co..."
php -S localhost:8080 -t /Applications/XAMPP/xamppfiles/htdocs/prestashop

