FROM code137oficial/docker-odoo-base:15.0

	##### Repositórios TrustCode e Code 137#####
WORKDIR /opt/odoo

RUN wget https://github.com/odoo/odoo/archive/15.0.zip -O odoo.zip && \
    wget https://github.com/Trust-Code/odoo-brasil/archive/15.0.zip -O odoo-brasil.zip && \
    wget https://github.com/Code-137/odoo-apps/archive/15.0.zip -O odoo-apps.zip
    #wget https://github.com/oca/server-ux/archive/15.0.zip -O server-ux.zip && \
    #wget https://github.com/oca/reporting-engine/archive/15.0.zip -O reporting-engine.zip && \
    #wget https://github.com/oca/account-financial-reporting/archive/15.0.zip -O account-financial-reporting.zip && \
    #wget https://github.com/oca/mis-builder/archive/15.0.zip -O mis-builder.zip && \
    #wget https://github.com/Trust-Code/helpdesk/archive/15.0.zip -O helpdesk.zip && \
    #wget https://github.com/Trust-Code/trustcode-addons/archive/15.0.zip -O trustcode-addons.zip && \
    #wget https://github.com/trust-code/odoo-themes/archive/15.0.zip -O odoo-themes.zip

RUN unzip -q odoo.zip && rm odoo.zip && mv odoo-15.0 odoo && \
    unzip -q odoo-brasil.zip && rm odoo-brasil.zip && mv odoo-brasil-15.0 odoo-brasil && \
    unzip -q odoo-apps.zip && rm odoo-apps.zip && mv odoo-apps-15.0 odoo-apps && \
    #unzip -q server-ux.zip && rm server-ux.zip && mv server-ux-15.0 server-ux && \
    #unzip -q reporting-engine.zip && rm reporting-engine.zip && mv reporting-engine-15.0 reporting-engine && \
    #unzip -q account-financial-reporting.zip && rm account-financial-reporting.zip && mv account-financial-reporting-13.0 account-financial-reporting && \
    #unzip -q mis-builder.zip && rm mis-builder.zip && mv mis-builder-15.0 mis-builder && \
    #unzip -q helpdesk.zip && rm helpdesk.zip && mv helpdesk-15.0 helpdesk && \
    #unzip -q odoo-themes && rm odoo-themes.zip && mv odoo-themes-15.0 odoo-themes && \
    #unzip -q trustcode-addons.zip && rm trustcode-addons.zip && mv trustcode-addons-15.0 trustcode-addons && \
    cd odoo && find . -name "*.po" -not -name "pt_BR.po" -not -name "pt.po"  -type f -delete && \
    find . -path "*l10n_*" -delete && \
    rm -R debian && rm -R doc && rm -R setup && cd ..

ADD conf/odoo-apps-requirements /opt/sources/
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r /opt/sources/odoo-apps-requirements

	##### Configurações Odoo #####

ADD conf/odoo.conf /etc/odoo/
RUN chown -R odoo:odoo /opt && \
    chown -R odoo:odoo /etc/odoo/odoo.conf

RUN mkdir /opt/.ssh && \
    chown -R odoo:odoo /opt/.ssh

ADD bin/autoupdate /opt/odoo
ADD bin/entrypoint.sh /opt/odoo
RUN chown odoo:odoo /opt/odoo/autoupdate && \
    chmod +x /opt/odoo/autoupdate && \
    chmod +x /opt/odoo/entrypoint.sh

WORKDIR /opt/odoo

ENV PYTHONPATH=$PYTHONPATH:/opt/odoo/odoo
ENV PG_HOST=localhost
ENV PG_PORT=5432
ENV PG_USER=odoo
ENV PG_PASSWORD=odoo
ENV PG_DATABASE=False
ENV ODOO_PASSWORD=R1cK&M0rTyC-137
ENV PORT=8069
ENV LOG_FILE=/var/log/odoo/odoo.log
ENV LONGPOLLING_PORT=8072
ENV WORKERS=4
ENV DISABLE_LOGFILE=0
ENV USE_SPECIFIC_REPO=0
ENV TIME_CPU=600
ENV TIME_REAL=720
ENV DBFILTER=.*
ENV DEBUGPY_PORT=8888
ENV MAX_CRON_THREADS=0
ENV PRIVATE_APPS=False

EXPOSE $PORT $LONGPOLLING_PORT $DEBUGPY_PORT
VOLUME ["/opt/", "/etc/odoo"]
ENTRYPOINT ["/opt/odoo/entrypoint.sh"]
CMD ["/usr/bin/supervisord"]

