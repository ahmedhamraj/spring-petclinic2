pipeline {
    agent any

    environment {
        // SSH user and JAR info
        EC2_USER   = 'ubuntu'
        JAR_NAME   = 'spring-petclinic-3.5.0-SNAPSHOT.jar'
        DEPLOY_PATH = '/home/ubuntu'
        PEM_KEY    = '/var/lib/jenkins/.ssh/jenkins-key'

        // Servers
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

        // ---- DEPLOY TO DEV ----
        stage('Deploy to Dev') {
            steps {
                echo "Deploying to DEV environment (${DEV_SERVER})"
                sh """
                    scp -i ${PEM_KEY} -o StrictHostKeyChecking=no target/${JAR_NAME} ${EC2_USER}@${DEV_SERVER}:${DEPLOY_PATH}/
                    ssh -i ${PEM_KEY} -o StrictHostKeyChecking=no ${EC2_USER}@${DEV_SERVER} '
                        pkill -f "${JAR_NAME}" || true
                        nohup java -jar ${DEPLOY_PATH}/${JAR_NAME} --server.address=0.0.0.0 > ${DEPLOY_PATH}/app.log 2>&1 &
                    '
                """
            }
        }

        // ---- PROMOTE TO QA ----
        stage('Deploy to QA') {
            steps {
                input message: "Approve promotion to QA?"
                echo "Deploying to QA environment (${QA_SERVER})"
                sh """
                    scp -i ${PEM_KEY} -o StrictHostKeyChecking=no target/${JAR_NAME} ${EC2_USER}@${QA_SERVER}:${DEPLOY_PATH}/
                    ssh -i ${PEM_KEY} -o StrictHostKeyChecking=no ${EC2_USER}@${QA_SERVER} '
                        pkill -f "${JAR_NAME}" || true
                        nohup java -jar ${DEPLOY_PATH}/${JAR_NAME} --server.address=0.0.0.0 > ${DEPLOY_PATH}/app.log 2>&1 &
                    '
                """
            }
        }

        // ---- PROMOTE TO UAT ----
        stage('Deploy to UAT') {
            steps {
                input message: "Approve promotion to UAT?"
                echo "Deploying to UAT environment (${UAT_SERVER})"
                sh """
                    scp -i ${PEM_KEY} -o StrictHostKeyChecking=no target/${JAR_NAME} ${EC2_USER}@${UAT_SERVER}:${DEPLOY_PATH}/
                    ssh -i ${PEM_KEY} -o StrictHostKeyChecking=no ${EC2_USER}@${UAT_SERVER} '
                        pkill -f "${JAR_NAME}" || true
                        nohup java -jar ${DEPLOY_PATH}/${JAR_NAME} --server.address=0.0.0.0 > ${DEPLOY_PATH}/app.log 2>&1 &
                    '
                """
            }
        }

        // ---- PROMOTE TO PROD ----
        stage('Deploy to Prod') {
            steps {
                input message: "🚨 Final approval required to deploy to PROD!"
                echo "Deploying to PROD environment (${PROD_SERVER})"
                sh """
                    scp -i ${PEM_KEY} -o StrictHostKeyChecking=no target/${JAR_NAME} ${EC2_USER}@${PROD_SERVER}:${DEPLOY_PATH}/
                    ssh -i ${PEM_KEY} -o StrictHostKeyChecking=no ${EC2_USER}@${PROD_SERVER} '
                        pkill -f "${JAR_NAME}" || true
                        nohup java -jar ${DEPLOY_PATH}/${JAR_NAME} --server.address=0.0.0.0 > ${DEPLOY_PATH}/app.log 2>&1 &
                    '
                """
            }
        }

    }

    post {
        success {
            echo "✅ Pipeline complete — deployed successfully through all environments!"
        }
        failure {
            echo "❌ Pipeline failed — check which stage stopped."
        }
    }
}
