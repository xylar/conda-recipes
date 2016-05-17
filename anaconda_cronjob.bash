SRC_DIR=`dirname $0`
cd ${SRC_DIR}
SRC_DIR=`pwd`
GIT_REPO=${HOME}/anaconda-cron/uvcdat
cd ${GIT_REPO}
git pull
cd ${SRC_DIR}
export PATH=/export/doutriaux1/anaconda2/bin:$PATH
python ./build_updated_packages.py -d 1 -u days -g ${GIT_REPO} -c uvcdat -l nighlty -V
