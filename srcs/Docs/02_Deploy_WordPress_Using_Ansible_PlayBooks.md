# Deploy WordPress ON AZ Cloud Using Ansible playbooks

## 1. Create VM to deploy WordPress
- cloun repo and named it /home/issam/cloud
- Run vm_playbook.yml playbook using ansible vault
`ansible-playbook -e @secret.yml --ask-vault-pass vm_playbook.yml`

## 3. Deploy WP
- Change new WPVM public ip in /wordpress/mariadb/conf/wp.sql
- Change new WPVM public ip in /playbooks/hosts
  `
  [WPVM]
  104.211.40.69   ansible_ssh_user=issam    ansible_ssh_pass=issam123!
  `
- Lunch wp_playbook.yml playbook using ansible vault
`ansible-playbook -e @secret.yml --ask-vault-pass wp_playbook.yml`

## Redeploy
- Delete repo /home/issam/clound_1 in WPVM
- Delete /home/issam/data
- Clean and remove all docker images, containers and volumes