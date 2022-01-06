## help
- Create ansible-vault
- `ansible-vault create file.yml`

- Cat ansible-vault file
- `ansible-vault view file.yml`

- Edit ansible-vault file
- `ansible-vault edit file.yml`

- Pass secret file 
- `ansible-playbook -e @secret.yml --ask-vault-pass main.yml`