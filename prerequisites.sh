: '
prerequisites.sh: This script is to be used to bootstrap Ansible and dependencies on RHEL 7.x
                and Ubuntu 18.04

To run:
    chmod u+x prerequisites.sh
    ./prerequisites.sh
'

#!/bin/bash
set -o nounset
set -o errexit


if ! command -v ansible >/dev/null; then
    echo "Installing Ansible and dependencies."
    if command -v yum >/dev/null; then
        # Add EPEL repository
        sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
        sudo yum install -y ansible
        sudo yum -y install https://packages.endpoint.com/rhel/7/os/x86_64/endpoint-repo-1.7-1.x86_64.rpm
        sudo yum install -y git
    elif command -v apt-get >/dev/null; then
        sudo apt-get update -qq
        sudo apt-get install -y -qq software-properties-common
        sudo apt-add-repository --yes --update ppa:ansible/ansible
        # Install Ansible and python-lxml package (needed for ansible-pull)
        sudo apt install -y ansible python-lxml
    else
        echo "neither yum nor apt-get found!"
        exit 1
    fi
    #install requirements.yml
fi