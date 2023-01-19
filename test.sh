#!/bin/bash
curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash - &&\
sudo apt-get install -y nodejs
sudo npm install -g ts-node typescript '@types/node'
sudo npm install ng
sudo npm i -g @angular/cli@11.2.11
ts-node spring-petclinic-angular-master/spring-petclinic-angular-master/src/test.ts