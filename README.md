# Brew & Co. — PrestaShop

Specialty coffee store built with PrestaShop 8.1.7 as part of my ecommerce portfolio.

## Demo
[Watch demo video](https://youtu.be/_N138kK4SGU)

## Stack
- PrestaShop 8.1.7
- PHP 8.5.7 (Homebrew) — original local setup
- MySQL via XAMPP — original local setup
- Docker Compose — later re-validated on a containerized environment (see below)
- Theme: Classic

## Features
- 10 products across 3 categories: Single Origin, Blends, Equipment
- Custom homepage with image slider and featured products
- Standard Delivery carrier (4.99€)
- Free shipping on orders over 30€
- Bank transfer and cash on delivery payment methods
- Custom store branding and logo

## Local Environment Setup

Running PrestaShop locally on macOS with XAMPP surfaced two conflicts: XAMPP's
bundled PHP 8.2.4 lacks the `intl` extension PrestaShop requires (not viable to
compile in manually), and XAMPP's MySQL competes with Homebrew's MySQL for port
3306, so both can't run at once.

Resolved by splitting the two services across their working installs instead of
patching either one: Homebrew PHP 8.5.7 (which already includes `intl`) serves
the app via its built-in development server (`php -S`), while XAMPP's MySQL —
started from its own control panel — remains the database server. The database
was migrated from Homebrew MySQL to XAMPP MySQL via `mysqldump`, fixing a
collation incompatibility in the process (`utf8mb4_0900_ai_ci` →
`utf8mb4_general_ci`).

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

> **Note:** MySQL must be started manually from the XAMPP control panel before running the script. The script only handles the PHP server — it does not start MySQL automatically because XAMPP manages it through its own GUI.

## Docker Environment

This project was originally built on the XAMPP + Homebrew PHP setup described above.
It was later re-validated on Docker Compose (`docker-compose.yml`), the same approach
used across the rest of this portfolio, to confirm the store also runs cleanly in a
containerized environment without the manual PHP/MySQL version juggling XAMPP
required.

```bash
docker compose up -d
```

PrestaShop's install wizard loads correctly on `http://localhost:8082` (port 8082,
chosen to avoid clashing with the other Dockerized projects in this portfolio, which
use 8080 and 8081).
