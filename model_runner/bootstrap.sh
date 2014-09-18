#!/bin/bash

sudo apt-get -y install git curl tmux

if ! conda &> /dev/null
then
    mkdir -p build; cd build
    echo "Download and install miniconda for python 2.7"
    if [[ ! -e Miniconda-3.6.0-Linux-x86_64.sh ]]
    then
        curl -s -o Miniconda-3.6.0-Linux-x86_64.sh http://repo.continuum.io/miniconda/Miniconda-3.6.0-Linux-x86_64.sh
        chmod 755 Miniconda-3.6.0-Linux-x86_64.sh
    fi
    ./Miniconda-3.6.0-Linux-x86_64.sh -b
    cd
    echo 'export PATH="/home/mr/miniconda/bin:$PATH"' >> .bashrc
fi

# bashrc may not have been sourced if run from remote
export PATH="/home/mr/miniconda/bin:$PATH"

echo "install conda-build"
# run in bg because otherwise it exits this process on completion
conda install conda-build &
wait $!

echo "Setup Model Runner"
rm -rf model_runner
git clone https://github.com/SEL-Columbia/model_runner
# run in bg because otherwise it exits this process on completion
conda create -n model_runner --file model_runner/requirements.txt &
wait $!

echo "Setup recipes to be installed"
git clone https://github.com/SEL-Columbia/conda-recipes

echo "Building Sequencer"
# run in bg because otherwise it exits this process on completion
cd conda-recipes
git pull
conda build Sequencer &
wait $!
cd

echo "Setup Sequencer env"
# delete Sequencer and sequencer conda env
rm -rf Sequencer
rm -rm /home/mr/miniconda/envs/sequencer
git clone https://github.com/SEL-Columbia/Sequencer
cd Sequencer
# run in bg because otherwise it exits this process on completion
conda create -n sequencer --file requirements.txt &
wait $!
cd

echo "Install sequencer"
source activate sequencer
conda install -n sequencer --use-local /home/mr/miniconda/conda-bld/linux-64/sequencer--np18py27_0.tar.bz2
echo "Done"
