pipeline {
    agent any

    tools {
        jdk 'java'   // Your configured JDK
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

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                # Copy jar to EC2
                scp target/spring-petclinic-3.5.0-SNAPSHOT.jar ubuntu@172.31.17.72:/home/
                
                # Run jar on EC2 in background
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
