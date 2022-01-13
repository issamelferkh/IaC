# Wordpress

## 1. Create VM
- Resource:  https://docs.microsoft.com/en-us/azure/developer/ansible/vm-configure?tabs=ansible
- Look at vm_playbook.yml playbook
- use ansible vault to hide passwords
`ansible-playbook -e @secret.yml --ask-vault-pass vm_playbook.yml`

## 2. Install Python, docker and update WPVM
- intall sshpass in AnsibleMaster to use login and pass

- Create inventory file to control WPVM
`
[WPVM]
52.168.80.224   ansible_ssh_user=issam    ansible_ssh_pass=issam123!
`

- Change path in /etc/ansible/ansible.cfg
`
inventory      = /home/issam/playbooks/hosts
host_key_checking= False
`

- lunch docker.yml playbook
`ansible-playbook -e @secret.yml --ask-vault-pass vm_playbook.yml`

## 3. Deploy WP
- docker_playbook.yml

