pipeline {
    agent any
    stages {
        stage('Install Dependencies') {
            // scripts go here
            steps {
                // installs ansible and terraform
                sh "sudo chmod +x ansible.sh"
                sh "./ansible.sh"
                
                // added check to see if terraform tfstate exists
                // then run terraform destroy (destroys all network/ec2)
                script{
                    if(fileExists('terraform/terraform.tfstate')){
                        sh 'terraform -chdir="terraform/" destroy -auto-approve'
                    }
                }
            }
        }
        // added by eoin
        stage('Run Terraform') {
            // its using the repo so really should only need the terraform commands
            // https://stackoverflow.com/questions/47274254/how-do-i-run-terraform-init-from-a-different-folder
            // https://stackoverflow.com/questions/60497054/integrating-the-terraform-plan-output-into-jenkins
            steps {
                sh 'terraform -chdir="terraform/" init '
                sh 'terraform -chdir="terraform/" plan'
                sh 'terraform -chdir="terraform/" apply -auto-approve'
            }
        }

        stage('run playbook to change config'){
            // an ansible playbook that clones down the repo,
            // changes the config using replace
            steps {
                sh 'ansible-playbook config.yml'
            }
        }

        stage('build and push docker image'){
            steps {
                dir('angular/'){
                    sh 'docker build -t 5pectr3/petclinic-frontend:latest .'
                }
                dir('rest/'){
                    sh 'docker build -t 5pectr3/petclinic-backend:latest .'
                }
            }
        }

        stage('Push images to Hub'){
            steps{
                script{
                    withCredentials([string(credentialsId: '5pectr3', variable: 'dockerhubpwd')]){
                        sh 'sudo docker login -u 5pectr3 -p ${dockerhubpwd}'
                    }
                    sh 'sudo docker push 5pectr3/petclinic-frontend:latest'
                    sh 'sudo docker push 5pectr3/petclinic-backend:latest'
                }
            }
        }

        stage('Deploy main playbook') {
            steps {
                // sh "ansible-playbook -i inventory.yaml playbook.yaml" // add inventory back at some stage
                ansiblePlaybook credentialsId: 'MasterKeys', disableHostChecking: true, installation: 'ansible-config', inventory: 'inventory.yaml', playbook: 'playbook.yaml'
            }
        }
    }
}
