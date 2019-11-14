#!/bin/sh -x

PKG_NAME=$1
WORKDIR=$2
UPLOAD_LABEL=$3
USER=cdat

#
# Arguments:
#    + WORKDIR - work directory where this script can write information to.
#
# Requirements:
#    + conda is installed, and added to PATH
#    + this script should be run on a repo top directory where 'recipe' directory resides
#    + this script assumes prep_for_build.py has been run on the repo directory and  
#      recipe/meta.yaml is generated.
#

source activate base
if [ `uname` == "Linux" ]; then
    OS=linux-64
else
    OS=osx-64
fi

if [ ! -d $WORKDIR ]; then
    mkdir $WORKDIR
fi

BASE_DIR=$(dirname "$0")
echo "BASE_DIR: $BASE_DIR"

prep_conda_env()
{
    conda clean --all
    conda install -n base -c conda-forge conda-build anaconda conda-smithy conda-verify
    conda update -y -q conda
    conda config --set anaconda_upload no
}

copy_repo_recipe()
{
    # copy project recipe to workdir
    cp -r $REPO_DIR/recipe $WORKDIR
}

get_conda_forge_configs() 
{
    # copy build configs from conda-forge to workdir

    # get conda_build_config.yaml -- this file defines the versions of 
    # globally pinned packages.
    url="https://www.github.com/conda-forge/conda-forge-pinning-feedstock.git"
    git clone $url $WORKDIR/conda-forge-pinning-feedstock
    cp $WORKDIR/conda-forge-pinning-feedstock/recipe/conda_build_config.yaml $WORKDIR/recipe

    # get the migrations folder
    cp -r $WORKDIR/conda-forge-pinning-feedstock/recipe/migrations $WORKDIR/recipe
}

copy_build_yaml_to_repo()
{
    # copy yaml's (configuration files)  generated by rerender 
    # back to repo directory.
    cp -r $WORKDIR/.ci_support $REPO_DIR/
}

#
# here, if needed, we can specify --variants "{'python': ['2.7', '3.7']}"
#
do_build()
{
    cd $REPO_DIR
    mkdir conda-bld
    export CONDA_BLD_PATH=conda-bld
    echo "XXX ls -l $REPO_DIR"
    ls -l $REPO_DIR
    echo "XXX ls -l $REPO_DIR/.ci_support"
    ls -l $REPO_DIR/.ci_support
    # conda build recipe
    if [ $OS == 'linux-64' ]; then
	for x in $(ls .ci_support/linux*yaml); do
	    echo "conda build $PKG_NAME -m ${x} -c conda-forge"
	    conda build -m ${x} -c conda-forge recipe
	done
    else
	for x in $(ls .ci_support/osx*yaml); do
	    echo "conda build $PKG_NAME -m ${x} -c conda-forge"
	    conda build -m ${x} -c conda-forge recipe
	done
    fi
}

do_upload()
{
    echo "xxx xxx CONDA_BLD_PATH: $CONDA_BLD_PATH"
    echo "xxx xxx PKG_NAME: $PKG_NAME"
    echo "xxx xxx VERSION: $VERSION"

    if [[ $UPLOAD_LABEL = 'DONT_UPLOAD' ]]; then
        return
    fi
    grep noarch recipe/meta.yaml.in 2>&1 > /dev/null
    if [[ $? = 0 ]]; then
	# noarch
	echo "CMD: anaconda -t $CONDA_UPLOAD_TOKEN upload -u $USER -l $LABEL $CONDA_BLD_PATH/noarch/$PKG_NAME-$VERSION.`date +%Y*`0.tar.bz2 --force"
	anaconda -t $CONDA_UPLOAD_TOKEN upload -u $USER -l $LABEL $CONDA_BLD_PATH/noarch/$PKG_NAME-$VERSION.`date +%Y*`0.tar.bz2 --force
    else
	# not noarch
	echo "CMD: anaconda -t $CONDA_UPLOAD_TOKEN upload -u $USER -l $LABEL $CONDA_BLD_PATH/$OS/${PKG_NAME}-$VERSION.`date +%Y*`0.tar.bz2 --force"
	anaconda -t $CONDA_UPLOAD_TOKEN upload -u $USER -l $LABEL $CONDA_BLD_PATH/$OS/${PKG_NAME}-$VERSION.`date +%Y*`0.tar.bz2 --force
    fi
    
}

##REPO_DIR=`pwd`
##echo "REPO_DIR: $REPO_DIR"

##prep_conda_env

##copy_repo_recipe

##get_conda_forge_configs

##mkdir .ci_support
##conda smithy rerender

##copy_build_yaml_to_repo

##do_build

##do_upload

#####
current_dir=`pwd`
echo "XXX current directory: $current_dir"

conda clean --all
conda install -n base -c conda-forge conda-build anaconda conda-smithy conda-verify
conda update -y -q conda
conda config --set anaconda_upload no

echo "xxx copy repo recipe xxx"
cp -r $REPO_DIR/recipe $WORKDIR

echo "xxx copy build configs from conda-forge to workdir"

# copy build configs from conda-forge to workdir

# get conda_build_config.yaml -- this file defines the versions of 
# globally pinned packages.
url="https://www.github.com/conda-forge/conda-forge-pinning-feedstock.git"
git clone $url $WORKDIR/conda-forge-pinning-feedstock
cp $WORKDIR/conda-forge-pinning-feedstock/recipe/conda_build_config.yaml $WORKDIR/recipe

# get the migrations folder
cp -r $WORKDIR/conda-forge-pinning-feedstock/recipe/migrations $WORKDIR/recipe

cd $WORKDIR
mkdir .ci_support
conda smithy rerender

echo "xxx xxx copy build yaml to repo xxx"
echo "xxx cp -r $WORKDIR/.ci_support $REPO_DIR/"
cp -r $WORKDIR/.ci_support $REPO_DIR/

echo "xxx ls -l $REPO_DIR/.ci_support"
ls -l $REPO_DIR/.ci_support

do_build

