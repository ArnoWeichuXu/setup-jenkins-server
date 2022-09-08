#!/bin/bash
eval `ssh-agent -s`
ssh-add ../terraform/.ssh/jr_p3_key_pair.pem
ansible-playbook site.yml