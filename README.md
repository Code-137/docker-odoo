# Docker Odoo

This repository contains the dockerfile to the [Odoo](https://www.odoo.com) using the [odoo-brasil](https://www.github.com/trust-code/odoo-brasil) localization and the [odoo-apps](https://www.github.com/code-137/odoo-apps).

## Requirements

To run this image, you will need a Postgres server. An easy way to do this is running the following command:

> docker run --name postgres -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo -e POSTGRES_DB=postgres -p 5432:5432 postgres:10


See [Docker Postgres](https://hub.docker.com/_/postgres/) for more informations.

## How to use this image

An easy way to use this image is running the following command:

> docker run --name odoo -d --net host -e PG_USER=odoo -e PG_PASSWORD=odoo -p 8069:8069 -p 8072:8072 code137oficial/docker-odoo:13.0


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
* DBFILTER=.*
* DEBUGPY_PORT=8888

Each parameter can be added to the command using the -e parameter_name as the following example:

> docker run --name odoo -d --net host\\  
    -e PG_USER=odoo \\  
    -e PG_PASSWORD=odoo \\  
    -e PORT=8050 \\  
    -e LONGPOLLING_PORT=8052 \\  
    -p 8069:8069 \\  
    -p 8072:8072 \\  
    code137oficial/docker-odoo:13.0

## For Developers

### Debuging

Debuging using this container could be possible using the following command:

> docker run --name odoo -d --net host\\  
    -e PG_USER=odoo \\  
    -e PG_PASSWORD=odoo \\  
    -e PORT=8050 \\  
    -e LONGPOLLING_PORT=8052 \\  
    -p 8069:8069 \\  
    -p 8072:8072 \\  
    -p 8888:8888 \\  
    code137oficial/docker-odoo:13.0 \\  
    python3 -m debugpy --listen 0.0.0.0:8888 /opt/odoo/odoo/odoo-bin -c /opt/odoo/odoo.conf

### Automated Tests

To run automated tests just use the following command:

> docker run --name odoo -d --net host\\  
    -e PG_USER=odoo \\  
    -e PG_PASSWORD=odoo \\  
    -e PORT=8050 \\  
    -e LONGPOLLING_PORT=8052 \\  
    -p 8069:8069 \\  
    -p 8072:8072 \\  
    -p 8888:8888 \\  
    code137oficial/docker-odoo:13.0 \\  
    python3 -m coverage run /opt/odoo/odoo/odoo-bin -c /opt/odoo/odoo.conf --test-enable --log-level='test' --xmlrpc-port=8069 -d unit_tests --init=sale --stop-after-init

This command will be run the tests for the sale app. To run other apps tests, insert the app name after init, and if you want to run tests to more than one apps, put the app names separated to coma.
