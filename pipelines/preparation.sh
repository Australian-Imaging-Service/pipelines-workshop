#!/usr/bin/env bash

#ssh-keygen -t rsa -N "" -f $HOME/.ssh/id_rsa
#echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc

# Clone the pipelines-community repository

if [ ! -d ~/git/pipelines-community ]; then
    git clone https://github.com/Australian-Imaging-Service/pipelines-community.git ~/pipelines-community
fi
pushd ~/pipelines-community

# Update the pipelines-community repository
git pull

# Install the pipelines-community repository
pip install -r ./requirements.txt
pip install bash_kernel
python -m bash_kernel.install


# Pre-build/pull the required XNAT docker images to save time
xnat4tests start --with-data openneuro-t1w
xnat4tests stop
pydra2app make xnat ./specs/australian-imaging-service-community/examples/zip.yaml --spec-root ./specs  --for-localhost
pydra2app make xnat ./specs/australian-imaging-service-community/examples/bet.yaml --spec-root ./specs  --for-localhost
popd
