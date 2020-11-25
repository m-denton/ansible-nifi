# Charter Playbooks

NiFi and Nifi Registry playbooks for Charter CPCS UAT and PROD environments.

## Requirements 

- Ansible 2.x (Tested on 2.9.5)
- Temporary user with passwordless SSH and root access to remote servers

## Usage

1. Install roles

```shell
ansible-galaxy install -f -r requirements.yml
```

2. Run desired playbook against desired environment, for example:

```shell
ansible-playbook -i playbooks/env/uat nifi.yml
```

## TODO

- Add download of custom nars to augment-nifi.yml
