pipeline {
    agent any
    stages {
        stage('Install') {
            steps {
                sh "bash ansible.sh"
            }
        }
        // stage('Test') {
        //     steps {
        //         sh "ng test"
        //     }
        // }
        stage('Deploy') {
            steps {
                sh "ansible-playbook -i inventory.yaml playbook.yaml"
            }
        }
    }
}