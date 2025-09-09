pipeline {
    agent any

    tools {
        maven 'Maven'
        jdk 'JDK17'
    }

    environment {
        REMOTE_USER = 'ubuntu'
        REMOTE_HOST = '172.31.24.124'
        REMOTE_PATH = '/home/ubuntu'
        APP_NAME = 'spring-petclinic-3.5.0-SNAPSHOT.jar'
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

        stage('Deploy') {
            steps {
                sshagent(credentials: ['ec2-ssh-key']) {
                    sh """
                    scp -o StrictHostKeyChecking=no target/${APP_NAME} ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_PATH}/
                    ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST} "pkill -f ${APP_NAME} || true"
                    ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST} "nohup java -jar ${REMOTE_PATH}/${APP_NAME} > ${REMOTE_PATH}/app.log 2>&1 &"
                    """
                }
            }
        }
    }
}


