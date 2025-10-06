pipeline {
    agent any

    environment {
        EC2_USER   = 'ubuntu'
        JAR_NAME   = 'spring-petclinic-3.5.0-SNAPSHOT.jar'
        PEM_KEY    = '/var/lib/jenkins/.ssh/jenkins-key'

        DEV_SERVER  = '172.31.16.143'
        QA_SERVER   = '172.31.27.38'
        UAT_SERVER  = '172.31.19.230'
        PROD_SERVER = '172.31.24.144'
    }

    stages {

        stage('Build') {
            steps {
                echo "Building ${JAR_NAME}..."
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Unit Test') {
            steps {
                echo "Running unit tests..."
                sh 'mvn test'
            }
        }

        stage('Deploy to Dev') {
            steps {
                echo "Deploying to DEV environment (${DEV_SERVER})"
                sh """
                    scp -i ${PEM_KEY} -o StrictHostKeyChecking=no target/${JAR_NAME} ${EC2_USER}@${DEV_SERVER}:/home/ubuntu/
                    ssh -i ${PEM_KEY} -o StrictHostKeyChecking=no ${EC2_USER}@${DEV_SERVER} 'nohup java -jar /home/ubuntu/${JAR_NAME} >/dev/null 2>&1 & exit'
                """
            }
        }

        stage('Deploy to QA') {
            steps {
                input message: "Approve promotion to QA?"
                echo "Deploying to QA environment (${QA_SERVER})"
                sh """
                    scp -i ${PEM_KEY} -o StrictHostKeyChecking=no target/${JAR_NAME} ${EC2_USER}@${QA_SERVER}:/home/ubuntu/
                    ssh -i ${PEM_KEY} -o StrictHostKeyChecking=no ${EC2_USER}@${QA_SERVER} 'nohup java -jar /home/ubuntu/${JAR_NAME} >/dev/null 2>&1 & exit'
                """
            }
        }

        stage('Deploy to UAT') {
            steps {
                input message: "Approve promotion to UAT?"
                echo "Deploying to UAT environment (${UAT_SERVER})"
                sh """
                    scp -i ${PEM_KEY} -o StrictHostKeyChecking=no target/${JAR_NAME} ${EC2_USER}@${UAT_SERVER}:/home/ubuntu/
                    ssh -i ${PEM_KEY} -o StrictHostKeyChecking=no ${EC2_USER}@${UAT_SERVER} 'nohup java -jar /home/ubuntu/${JAR_NAME} >/dev/null 2>&1 & exit'
