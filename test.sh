#!/bin/bash
curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash - &&\
sudo apt-get install -y nodejs
sudo npm install -g ts-node typescript '@types/node'
sudo npm i -g @angular/cli@11.2.11
sudo npm i @angular-devkit/build-angular@0.1102.19
cd spring-petclinic-angular-master
ng test
ng e2e
