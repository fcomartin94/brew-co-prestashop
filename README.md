# Brew & Co. — PrestaShop

Specialty coffee store built with PrestaShop 8.1.7 as part of my ecommerce portfolio.

## Demo
[Watch demo video](https://youtu.be/_N138kK4SGU)

## Stack
- PrestaShop 8.1.7
- PHP 8.5.7 (Homebrew)
- MySQL via XAMPP
- Theme: Classic

## Features
- 10 products across 3 categories: Single Origin, Blends, Equipment
- Custom homepage with image slider and featured products
- Standard Delivery carrier (4.99€)
- Free shipping on orders over 30€
- Bank transfer and cash on delivery payment methods
- Custom store branding and logo

## Local Environment Setup

### The Problem
Setting up PrestaShop locally on macOS presented two main challenges:

1. **PHP compatibility**: XAMPP's built-in PHP 8.2.4 lacked the `intl` extension required by PrestaShop. Compiling it manually was not viable.
2. **MySQL port conflict**: XAMPP's MySQL and Homebrew's MySQL both tried to use port 3306, preventing them from running simultaneously.

### The Solution
- Use **Homebrew PHP 8.5.7** (which includes `intl`) as the PHP server via the built-in development server (`php -S`).
- Use **XAMPP's MySQL** as the database server, started via the XAMPP control panel.
- The database was migrated from Homebrew MySQL to XAMPP MySQL by exporting with `mysqldump` and fixing collation incompatibilities (`utf8mb4_0900_ai_ci` → `utf8mb4_general_ci`).

### Startup Script
To simplify the startup process, a shell script was created:

```bash
#!/bin/bash

echo "Stopping previous processes..."
pkill -f "php -S localhost:8080" 2>/dev/null
sleep 1

echo "Starting PHP server for Brew & Co..."
php -S localhost:8080 -t /Applications/XAMPP/xamppfiles/htdocs/prestashop
```

### How to Run
1. Open XAMPP and click **Start** on MySQL
2. Run the startup script: `~/Desktop/start-brewco.sh`
3. Open `http://localhost:8080` in your browser
4. Back office: `http://localhost:8080/admin635tpjc6qfi4kszl8ot/index.php`
