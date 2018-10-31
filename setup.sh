#!/bin/bash

mkdir -p data/saved_sessions
cd data/saved_sessions

# fallback to curl if wget not available (e.g. git bash in Windows)
WGET='wget'
if ! [ -x "$(command -v git)" ]; then
	WGET='curl -O'
fi

echo 'Downloading models...'
${WGET} http://visual.cs.ucl.ac.uk/pubs/liftingFromTheDeep/res/init_session.tar.gz
${WGET} http://visual.cs.ucl.ac.uk/pubs/liftingFromTheDeep/res/prob_model.tar.gz

echo 'Extracting models...'
tar -xvzf init_session.tar.gz
tar -xvzf prob_model.tar.gz
rm -rf init_session.tar.gz
rm -rf prob_model.tar.gz
cd ../..

echo 'Installing dependencies...'
pip3 install scikit-image

echo 'Cloning and installing dependencies...'
mkdir Dependencies && cd Dependencies
git clone https://github.com/ildoonet/tf-pose-estimation.git && cd tf-pose-estimation
pip3 install --user -r requirements.txt && python3 setup.py install --user
cd ../.. && rm -r --interactive=never Dependencies

echo 'Done'
