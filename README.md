# Docker Odoo

This repository contains the dockerfile to the [Odoo](https://www.odoo.com) using the [odoo-brasil](https://www.github.com/trust-code/odoo-brasil) localization and the [odoo-apps](https://www.github.com/code-137/odoo-apps).

## Requirements

To run this image, you will need a Postgres server. An easy way to do this is running the following command:

> docker run --name db -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo -e POSTGRES_DB=postgres postgres:10

See [Docker Postgres](https://hub.docker.com/_/postgres/) for more informations.

## How to use this image

An easy way to user this image is running the following command:

> docker run --name odoo -d -e PG_USER=odoo -e PG_PASSWORD=odoo code137oficial/docker-odoo:13.0


### List of available parameters

* PYTHONPATH=$PYTHONPATH:/opt/odoo/odoo
* PG_HOST=localhost
* PG_PORT=5432
* PG_USER=odoo
* PG_PASSWORD=odoo
* PG_DATABASE=False
* ODOO_PASSWORD=123
* PORT=8069
* LOG_FILE=/var/log/odoo/odoo.log
* LONGPOLLING_PORT=8072
* WORKERS=4
* DISABLE_LOGFILE=0
* USE_SPECIFIC_REPO=0
* TIME_CPU=600
* TIME_REAL=720

Each parameter can be added to the command using the -e parameter_name as the following example:

> docker run --name odoo -d -e PG_USER=odoo -e PG_PASSWORD=odoo -e PORT=8050 -e LONGPOLLING_PORT-8052 code137oficial/docker-odoo:13.0
