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
                publishOverSsh([
                    servers: [
                        [
                            serverName: 'target-server',
                            transfers: [
                                [
                                    sourceFiles: 'target/spring-petclinic.jar',
                                    removePrefix: 'target',
                                    remoteDirectory: '/var/lib/tomcat9/webapps'
                                ]
                            ],
                            execCommand: 'sudo systemctl restart tomcat9'
                        ]
                    ]
                ])
            }
        }
    }
}
