pipeline {
    agent any
    stages {
        stage('Install') {
            steps {
                sh "bash ansible.sh"
            }
        }
        stage('Test') {
            steps {
                sh "spring-petclinic-angular-master/spring-petclinic-angular-master/src/test.ts"
            }
        }
        // stage('Deploy') {
        //     steps {
        //         sh "ansible-playbook -i inventory.yaml playbook.yaml"
        //     }
        // }
    }
}