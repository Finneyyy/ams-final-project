pipeline {
    agent any
    stages {
        stage('Install Dependencies') {
            // scripts go here
            steps {
                sh "ls"
                sh "sudo chmod +x ansible.sh"
                sh "./ansible.sh"
            }
        }

        stage('Run Terraform') {
            // its using the repo so really should only need the terraform commands
            // https://stackoverflow.com/questions/47274254/how-do-i-run-terraform-init-from-a-different-folder
            steps {
                sh 'terraform -chdir="terraform/" init '
                sh 'terraform -chdir="terraform/" plan '
                sh 'terraform -chdir="terraform/" apply'
            }
        }

        // stage('Test') {
        //     steps {
        //         sh "bash test.sh"
        //      }
        //  }
        stage('Deploy') {
            steps {
                sh "ansible-playbook -i playbook.yaml" // add inventory back at some stage
            }
        }
    }
}
