<h1>Docker image for standalone ranger</h1>


This project objective is to make it easy to run a simple ranger install, locally, in order to test & experiment
with new plugins, or minor code enhancements.

This code is currently hosted on github at https://github.com/planetf1/ranger-docker 
but the hope is to integrate it into the Apache Ranger project
<h2>Current functionality</h2>
<ul>
<li>Configure & launch ranger admin server
<li>Solr active/running
<li>No ranger plugins setup
<li>little parameterization -- all hardcoded
<li>No data container
</ul>
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
