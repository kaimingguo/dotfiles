# dotfiles

A configuration file - powered by [Ansible](https://ansible.com/).

## Building a configuration file using Ansible Playbooks

The inventory file `hosts` defines the nodes in which the stacks should be
configured.

Create inventory file in `inventory/` directory:

```
touch inventory/hosts
```

Add your hostsname in section (use platform, host, etc.):

```
[unix]
localhost ansible_connection=local

[desktop]
server1

[darwin]
host1 ansible_user=user
```

The stack can be deployed using the following command:

```
ansible-playbook site.yml
```

## License

Distributed under the BSD 2-Clause license, see [LICENSE](./LICENSE) for
more information.

<!--
[//]: <> vim: set nofoldenable filetype=markdown :
-->
