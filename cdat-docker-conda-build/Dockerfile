FROM registry.access.redhat.com/rhel6/rhel
MAINTAINER Dan Lipsa <dan.lipsa@kitware.com>

# Get a free Red Hat Developer Subscription

# enable subscription to be able to install packages
RUN subscription-manager register --username xxx --password xxx --auto-attach

# install required packages
RUN yum -y groupinstall "Development tools"
RUN yum -y install wget tar which
RUN yum -y install mesa-libGL-devel "@X Window System" libXt-devel

# install newer compiler 4.9.2
# See https://www.softwarecollections.org/en/scls/rhscl/devtoolset-3/
RUN yum-config-manager --enable rhel-server-rhscl-6-rpms
RUN yum -y install devtoolset-3-gcc-c++

# Enable the new compiler in bash
RUN echo $'currentver="$(gcc -dumpversion)" \n\
oldver="4.4.7" \n\
echo "Current version" ${currentver} \n\
if [ "$(printf "%s\\n" "$oldver" "$currentver" | sort -r -V | head -n1)" = "$oldver" ]; then \
  echo "Setup a new version";\
  scl enable devtoolset-3 bash;\
fi' >> ~/.bashrc

# install conda and CDAT
RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN bash Miniconda3-latest-Linux-x86_64.sh -b
RUN echo $'# added by Miniconda3 installer \n\
export PATH="/root/miniconda3/bin:$PATH" \n\
' >> ~/.bashrc
RUN /root/miniconda3/bin/conda install -y conda-build anaconda-client
RUN /root/miniconda3/bin/conda create -y -n cdat8 -c cdat/label/v80 -c conda-forge -c cdat python=3.6 cdat
RUN echo $'channels:\n\
  - conda-forge\n\
' >> ~/.condarc
