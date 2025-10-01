pipeline {
    agent any

    tools {
        jdk 'java'   // use the configured JDK name
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
    }

    post {
        success {
            echo 'Build completed successfully!'
        }
        failure {
            echo 'Build failed. Check the logs.'
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
}
