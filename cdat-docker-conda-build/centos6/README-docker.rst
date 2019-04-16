===========================================
Centos 6 docker for insepcting CDT packages
===========================================

* pull centos6 image
  >>> docker pull centos:6

* build the image cdat-centos6
  The docker file is from
  https://hub.docker.com/_/centos
  >>> docker build --rm -t cdat-centos6 .

* run the container cdat-centos6, using image cdat-centos6 to create it, mounting the
  important folders. For instance ~/projects has all the CDAT
  recipes. This gives you a prompt in RedHat 6 docker.
  >>> docker run -it -v ~/projects/:/root/projects -v ~/anaconda3:/home/danlipsa/anaconda3 --name cdat-centos6 cdat-centos6

* Work with centos6

* exit the container
  >>> exit

* start the container after exit
  >>> docker container start cdat-centos6

* connect to the container
  >>> docker exec -it cdat-centos6 /bin/bash
