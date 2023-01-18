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
        //         sh "bash ~/test.sh"
        //     }
        // }
        // stage('Deploy') {
        //     steps {
        //         sh "ansible-playbook -i inventory.yaml playbook.yaml"
        //     }
        // }
    }
}