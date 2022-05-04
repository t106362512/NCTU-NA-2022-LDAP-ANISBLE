# ansible-openldap playbook

A short description of the project

## How to use

## Creating venv (optional but highly recommended)

The easiest way to ensure you have the right ansible and properly libs installed is to use a python venv. You only have to set it up once:

```sh
    python3 -m venv .env
    .env/bin/pip install --upgrade pip
    .env/bin/pip install ansible[azure]==2.9.13
```

After creating the venv you can enter it in order to use ansible (this has to be repeated once per shell session):

```sh
    source .env/bin/activate
```

### Running playbook locally

1. Run `ansible-galaxy install -r roles/requirements.yml -p roles` in this directory to get the required Ansible roles.
2. Run `ansible-playbook -c local -i inventory/inventory.ini ansible-openldap-playbook.yml`

### Running playbook on remote target server from local machine

1. Run `ansible-galaxy install -r roles/requirements.yml -p roles` in this directory to get the required Ansible roles.
2. Run `ansible-playbook -i inventory/<inventory_file> --key-file "~/.ssh/<private_key>" -u <user-remote> ansible-openldap-playbook.yml`

### Running playbook in dry mode (check)

1. Run `ansible-galaxy install -r roles/requirements.yml -p roles` in this directory to get the required Ansible roles.
2. Run `ansible-playbook -i inventory/<inventory_file> --key-file "~/.ssh/<private_key>" -u <user-remote> ansible-openldap-playbook.yml --diff --check`

### Provisioning with Vagrant

1. Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads).
2. Download and install [Vagrant](http://www.vagrantup.com/downloads.html).
3. Create Virtual environment
4. Run `ansible-galaxy install -r roles/requirements.yml -p roles` in this directory to get the required Ansible roles.
5. Run `vagrant up` from `provisioner` folder to build the VM .
6. Run `vagrant destroy` from `provisioner` folder to delete the VM .

## License

MIT license

## Author

[cwang](mailto:cwang@cc.cs.nctu.edu.tw)

## Version

Release date: 2021-11-15
Version: 0.1.0
