#
# ---
# Docker configuration file for Ranger
#
# Nigel Jones
# may 2017
#
# Caveats:
#   * Lots of hardcoded paths
#   * No containers in use yet so data will be lost each time
# ---

# Let's use UBUNTU
FROM            ubuntu

# any problems let me know
MAINTAINER      Nigel Jones <jonesn@uk.ibm.com>

# Will use these more in future

ENV		 rootpw			 admin99
ENV		 build 			 ranger-1.0.0-SNAPSHOT
ENV		 dadir			 /opt/ranger-1.0.0-SNAPSHOT-admin

# Let's start with some core packages we need
# Note: installs python 2.7 & 3 -- latter not needed. refine later.
RUN apt-get update && apt-get install -y wget libmysql-java python default-jdk

# Add dockerize wait tool - this allows VMs to wait for network ports to be available.
# Only needed if running in a docker-compose type environment, not for single image
# this is recommended on docker.com
RUN wget https://github.com/jwilder/dockerize/releases/download/v0.1.0/dockerize-linux-amd64-v0.1.0.tar.gz
RUN tar -C /usr/local/bin -xzvf dockerize-linux-amd64-v0.1.0.tar.gz


# Add the ranger admin dist. code. Will all be under ranger-1.0.0-SNAPSHOT-admin
ADD dist/ranger-1.0.0-SNAPSHOT-admin.tar.gz /opt

# Get the mysql connector ready

# Setup solr - needs java, contributed script for local solr install
WORKDIR /opt/ranger-1.0.0-SNAPSHOT-admin/contrib/solr_for_audit_setup
RUN sed -i 's|SOLR_INSTALL=false|SOLR_INSTALL=true|' install.properties
RUN sed -i 's|SOLR_DOWNLOAD_URL=|SOLR_DOWNLOAD_URL=http://www.mirrorservice.org/sites/ftp.apache.org/lucene/solr/6.5.1/solr-6.5.1.tgz|' install.properties

# This should work according to docs, but see RANGER-1565 -
#
# --RUN sed -i 's|#JAVA_HOME=|JAVA_HOME=/usr/lib/jvm/default-java|' install.properties
# --RUN ./setup.sh
#
# So this is the workaround
RUN JAVA_HOME=/usr/lib/jvm/default-java ./setup.sh


# setup the ranger server
WORKDIR /opt/ranger-1.0.0-SNAPSHOT-admin
RUN sed -i 's|db_root_password=|db_root_password=admin99|' "${dadir}/install.properties" 
RUN sed -i 's|db_password=|db_password=admin|' "${dadir}/install.properties" 
RUN sed -i 's|db_host=|db_host=mariadb|' "${dadir}/install.properties" 
RUN sed -i 's|audit_solr_urls=|audit_solr_urls=http://localhost:6083/solr/ranger_audits|' install.properties
RUN JAVA_HOME=/usr/lib/jvm/default-java /opt/ranger-1.0.0-SNAPSHOT-admin/setup.sh

# Still to do
# Configure solr here.... need parameters

# Continue

# Expose web port 
EXPOSE          80 443 6083 6080

# Now start ranger
CMD ["/opt/ranger-1.0.0-SNAPSHOT-admin/ranger-admin start"]
