Docker image for standalone ranger

Nigel Jones - jonesn@uk.ibm.com (planetf1 on github.com, jonesn on Apache JIRA)

This project objective is to make it easy to run a simple ranger install, locally, in order to test & experiment
with new plugins, or minor code enhancements.

Caveats/Todos

* parameterize the ranger build to be used
* identify data that would benefit from being pulled out into a container
* See if mysql can be merged back into the same container as ranger -- small footprint and removes the overhead
of also having to use docker-compose
* Work with ranger team to integrate the build of a docker container into the actual build of ranger

Useful links

Dockerize - This script can be used to synchronize between different docker containers by waiting for a particular network port to become available. See more at https://github.com/jwilder/dockerize -- this is also linked into by the official docker documentation as a best practice
