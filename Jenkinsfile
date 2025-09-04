pipeline {
    agent any

    tools {
        maven 'Maven3'   // Make sure Maven is configured in Jenkins
        jdk 'JDK11'      // Configure JDK 11 in Jenkins global tool config
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/ahmedhamraj/spring-petclinic.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Deploy to Tomcat') {
            steps {
                sh '''
                cp target/*.jar /opt/tomcat/webapps/
                '''
            }
        }
    }
}
