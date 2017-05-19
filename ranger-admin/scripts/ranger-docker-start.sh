#/bin/sh

# A few globals we don't expect to change
MYSQLHOST="tcp://mariadb:3306"
TIMEOUT=120

echo "--"
echo "Finishing configuring/launch of Apache Ranger"
echo "--"
# Assume JAVA_HOME is set in environment, if not let's go with default
if [[ -z $JAVA_HOME ]]
then
  echo "JAVA_HOME not set. Exiting"
  exit 1
  fi


echo "--"
echo "Waiting for MySQL/MariaDB"
echo "--"
/usr/local/bin/dockerize -wait $MYSQLHOST -timeout $TIMEOUT
rc=$?
if [[ $rc -ne 0 ]]
then
  echo "MySQL failed to become available in $TIMOUT. Please check and retry. Exiting"
  exit 1
fi
echo "--"
echo "Running ranger setup script"
echo "--"
/opt/ranger-1.0.0-SNAPSHOT-admin/setup.sh
rc=$?
if [[ $rc -ne 0 ]]
then
  echo "Ranger setup failed. Exiting"
  exit 1
fi


# Now let's start solr
echo "--"
echo "Starting solr..."
echo "--"
/opt/solr/ranger_audit_server/scripts/start_solr.sh &
# Note - launched in background, so won't check it's working for now. Ranger will ;-)

echo "--"
echo "starting Ranger server"
echo "--"
/usr/bin/ranger-admin start
rc=$?


RUN chmod +x /opt/ranger-1.0.0-SNAPSHOT-admin/ranger-docker-start.sh
RUN echo "--- Ranger running ---"  >> /opt/ranger-1.0.0-SNAPSHOT-admin/ranger-docker-start.sh
RUN echo "while [ true ]" >> /opt/ranger-1.0.0-SNAPSHOT-admin/ranger-docker-start.sh
RUN echo "do"  >> /opt/ranger-1.0.0-SNAPSHOT-admin/ranger-docker-start.sh
RUN echo "  sleep 10000"  >> /opt/ranger-1.0.0-SNAPSHOT-admin/ranger-docker-start.sh
RUN echo "done"  >> /opt/ranger-1.0.0-SNAPSHOT-admin/ranger-docker-start.sh