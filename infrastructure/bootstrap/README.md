# bootstrapping the environment

## Pre-requisites

1. Power up hardware
1. Connect everything per diagram
1. Log into router
1. `ansible-galaxy collection install vyos.vyos`

## Run commands

`ansible-playbook -i ../../inventory.yml --private-key ~/.ssh/id_ed25519 1-update-router-system.yml`
