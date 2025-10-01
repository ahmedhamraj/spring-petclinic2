pipeline {
    agent any

    tools {
        jdk 'java'   // configured JDK name in Jenkins
        maven 'Maven'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/ahmedhamraj/spring-petclinic2.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                scp target/spring-petclinic-3.5.0-SNAPSHOT.jar ubuntu@172.31.17.72:/home/ubuntu/
                ssh ubuntu@172.31.17.72 'nohup java -jar /home/ubuntu/spring-petclinic-3.5.0-SNAPSHOT.jar &'
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check logs.'
        }
    }
}
