#!/bin/bash

# bashrc may not have been sourced if run from remote
export PATH="/home/mr/miniconda/bin:$PATH"

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
rm -rf /home/mr/miniconda/envs/sequencer
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
