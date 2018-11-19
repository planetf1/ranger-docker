# ranger-docker

## THIS PROJECT IS NOW DEPRECATED. 

### Please go to http://github.com/odpi/egeria to read about Egeria, where you will also ongoing work around deployment of a 
### variety of components using docker build scripts, and helm charts to deploy to kubernetes
### If you are interested in directly contributing this capability to Apache Ranger please feel free - and ideally get in touch so we can work on merging in the code from Egeria :-)

### Nigel Jones

<h1>Docker image for standalone ranger</h1>


This project objective is to make it easy to run a simple ranger install, locally, in order to test & experiment
with new plugins, or minor code enhancements.

This code is currently hosted on github at https://github.com/planetf1/ranger-docker 
but the hope is to integrate it into the Apache Ranger project

Update
 * MariaDB now listens externally on port 33306 to avoid clash with a locally running
   database
<h2>Current functionality</h2>
<ul>
<li>Download and build ranger itself, from git
<li>Configure & launch ranger admin server
<li>Solr active/running
<li>No ranger plugins setup
<li>little parameterization -- all hardcoded
<li>No data container
</ul>
NOTE: The build takes a long time (over 30 minutes)
<h2>Image Composition</h2>
<ul>
<li>ranger-admin - the customized ranger image, also runs solr
<li>mariadb - based off mariadb on docker hub
</ul>
<h2>Using the docker image</h2>
Go to the base directory of the extracted files & type
<pre>
docker-compose up
</pre>
Mariadb will configure & start, as will ranger including solr. The process will take around 1-2 minutes in addition
to any download time.
<p>
You can then connect to Ranger as usual for example at http://mymachine:6080/
<h3>Zero to hero in six steps (Azure)</h3>
<p>An example of how to run ranger under docker using MS Azure with very few steps -- assumes an existing Azure Account
<ol>
<li>Install Docker & GIT if not already done
<p>Go to http://www.docker.com & install docker for Windows, Mac or Linux following the instructions
<p>Also install git from https://git-scm.com/download/
<li>Create an Azure container service
<p>
Lots of possible command options, but to default to US-West & basic ubuntu server:
<pre>docker-machine create --driver azure --azure-subscription-id aaaaaaaa-bbbb-cccc-dddd-eeeeee nigeldocker</pre>
<li>Configure the environment for the new docker machine:
 <pre>docker-machine env nigeldocker</pre>
 <p>This will return a command to run as the last line which should be run such as
 <pre>FOR /f "tokens=*" %i IN ('docker-machine env nigeldocker') DO @%i</pre>
 <li>Now get hold of the ranger docker source in git
 <pre>git clone https://github.com/planetf1/ranger-docker.git</pre>
 <li>Build and run the docker images
 <pre>cd ranger-docker
docker-compose up</pre>
<li>Checking the docker container id - needed for subsequent interaction with the container
<pre>
ibmuser@ibmvm:~$ docker ps
CONTAINER ID        IMAGE                       COMMAND                  CREATED             STATUS              PORTS                                                                              NAMES
1a2ed045306c        rangerdocker_ranger-admin   "/bin/sh -c /opt/ran…"   2 hours ago         Up 2 hours          0.0.0.0:6080->6080/tcp, 0.0.0.0:6083->6083/tcp, 0.0.0.0:6182-6183->6182-6183/tcp   rangerdocker_ranger-admin_1
2abd3e403c25        rangerdocker_mariadb        "docker-entrypoint.s…"   2 hours ago         Up 2 hours          0.0.0.0:3306->3306/tcp                                                             rangerdocker_mariadb_1
</pre>
<li>>Deploying a ranger plugin (for resource lookup)
An example:
<pre>
docker exec -it 1a2ed045306c mkdir /opt/ranger-2.0.0-SNAPSHOT-admin/ews/webapp/WEB-INF/classes/ranger-plugins/gaian
docker cp ./ranger-gaian-plugin-1.0.0-SNAPSHOT.jar 1a2ed045306c:/opt/ranger-2.0
.0-SNAPSHOT-admin/ews/webapp/WEB-INF/classes/ranger-plugins/gaian
</pre>
<li>To look around the docker install for debugging etc:
<pre>
docker exec -it 1a2ed045306c /bin/bash
</pre>
 <li>Use the ranger UI
 <p>Open up a web browser and go to http://mydockermachineip:6080/
 </ol>
 <p>Docker images can also be run locally, remotely, or using other cloud providers
<h2>Issues/problems</h2>
Please add any feedback in the <a href="https://github.com/planetf1/ranger-docker/issues">issue tracker</a> on github.
Or if it relates to integration into ranger use <a href="https://issues.apache.org/jira/browse/RANGER-1572">RANGER-1572</a> 


<h2>Useful links</h2>
<ul>
<li>See the main ranger community at <a href="http://ranger.apache.org">http://ranger.apache.org</a>
<li>Dockerize - This script can be used to synchronize between different docker containers by waiting for a particular network port to become available. See more at <a href="https://github.com/jwilder/dockerize">https://github.com/jwilder/dockerize</a> -- this is also linked into by the official docker documentation as a best practice
</ul>
<h2>Contact</h2>
Nigel Jones - 
jonesn@uk.ibm.com
planetf1 on github.com
jonesn on Apache JIRA
