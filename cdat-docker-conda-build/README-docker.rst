===============================================
RedHat 6 docker for building CDAT conda recipes
===============================================

* pull redhat 6.10 container
  >>> docker pull registry.access.redhat.com/rhel6/rhel

* examine the container information
  >>> docker inspect registry.access.redhat.com/rhel6/rhel

* Modify the Dockerfile and enter the username and password for your Red Hat Developer Subscription.
  You can get a free subscription from Red Hat.
  
* build the image test
  >>> docker build --rm -t test .

* run the container test, using image test to create it, mounting the
  important folders. For instance ~/projects has all the CDAT
  recipes. This gives you a prompt in RedHat 6 docker.
  >>> docker run -it -v ~/projects/:/root/projects -v ~/anaconda3:/home/danlipsa/anaconda3 --name test test

* build conda recipes

* exit the container
  >>> exit
  >>> exit
  
* start the container after exit
  >>> docker container start test

* connect to the container
  >>> docker exec -it test /bin/bash
