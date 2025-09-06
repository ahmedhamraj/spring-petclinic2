pipeline {
    agent any

    tools {
        maven 'Maven'   // Make sure Maven is configured in Jenkins
        jdk 'JDK17'      // Configure JDK 17 in Jenkins global tool config
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
                sh 'mvn clean package -DskipTests -U'
            }
        }    
       stage('Deploy') {
            steps {
                pipeline {
    agent any

    tools {
        maven 'Maven'   // Make sure Maven is configured in Jenkins
        jdk 'JDK17'      // Configure JDK 17 in Jenkins global tool config
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
                sh 'mvn clean package -DskipTests -U'
            }
        }    
       stage('Deploy') {
            steps {
                sshagent(['target-server-ssh']) {
                    sh '''
                        ssh-keyscan -H 172.31.24.124 >> ~/.ssh/known_hosts
                        scp target/spring-petclinic-3.5.0-SNAPSHOT.jar ubuntu@172.31.24.124:/var/lib/tomcat9/webapps/spring-petclinic.jar
                        ssh ubuntu@172.31.24.124 "sudo systemctl restart tomcat9"
                    '''
                }
            }
        }
    }
}
