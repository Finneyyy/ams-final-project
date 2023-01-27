pipeline {
    agent any
    stages {
        stage('Install Dependencies') {
            steps {
                sh "sudo chmod +x install-ansible-and-jenkins.sh"
                sh "./install-ansible-and-jenkins.sh"
                script{
                    if(fileExists('terraform/terraform.tfstate')){
                        sh 'terraform -chdir="terraform/" destroy -auto-approve'
                    }
                }
            }
        }

        stage('Run Terraform') {
            steps {
                sh 'terraform -chdir="terraform/" init '
                sh 'terraform -chdir="terraform/" plan'
                sh 'terraform -chdir="terraform/" apply -auto-approve'
            }
        }

        stage('run playbook to change config'){
            steps {
                sh 'ansible-playbook config.yml'
            }
        }

        stage('build new docker images'){
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
                ansiblePlaybook credentialsId: 'MasterKeys', disableHostKeyChecking: true, installation: 'ansible-config', inventory: 'inventory.yaml', playbook: 'playbook.yaml'
            }
        }
    }
}
