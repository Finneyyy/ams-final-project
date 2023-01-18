#!/bin/bash
curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash - &&\
sudo apt-get install -y nodejs
npm install -g ts-node typescript '@types/node'
ts-node spring-petclinic-angular-master/spring-petclinic-angular-master/src/test.ts