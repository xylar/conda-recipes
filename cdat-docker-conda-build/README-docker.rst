===============================================
RedHat 6 docker for building CDAT conda recipes
===============================================

* pull redhat 6.10 container
  >>> docker pull registry.access.redhat.com/rhel6/rhel

* examine the container information
  >>> docker inspect registry.access.redhat.com/rhel6/rhel

* Modify the Dockerfile and enter the username and password for your Red Hat Developer Subscription.
  You can get a free subscription from Red Hat at
  https://developers.redhat.com/#
  bottom of the screen, red box, Sign me up>
  
* build the image cdat-conda-build-7
  >>> docker build --rm -t cdat-conda-build-7 .

* run the container cdat-conda-build-7, using image cdat-conda-build-7 to create it, mounting the
  important folders. For instance ~/projects has all the CDAT
  recipes. This gives you a prompt in RedHat 6 docker.
  >>> docker run -it -v ~/projects/:/root/projects -v ~/anaconda3:/home/danlipsa/anaconda3 --name cdat-conda-build-7 cdat-conda-build-7

* build conda recipes

* exit the container
  >>> exit
  >>> exit
  
* start the container after exit
  >>> docker container start cdat-conda-build-7

* connect to the container
  >>> docker exec -it cdat-conda-build-7 /bin/bash
