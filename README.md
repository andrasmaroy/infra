# infra

## Initial setup

Fill in your SSH public key in [setup.sh](setup.sh) then copy it to the target host and run as root to setup requirements for Ansible.

On the local machine:

0. Optionally create a virtualenv
1. Run `pip install -r requirements.txt` to install dependencies
2. Fill in the `hosts` file

## Usage

The playbook can be ran like so:
```bash
ansible-playbook site.yml
```

For a dry run the `check`, `diff` and `verbose` parameters can be added:
```bash
ansible-playbook -C -D -v site.yml
```

To run only on a subset of hosts the `limit` parameter can be added:
```bash
ansible-playbook -l SUBSET site.yml
```
