pipeline {
    agent any

    parameters {
        choice(name: 'ENV', choices: ['dev','qa','uat','prod'], description: 'Select environment')
    }

    environment {
        PEM_KEY = '/var/lib/jenkins/.ssh/jenkins-key'
        JAR_NAME = 'spring-petclinic-3.5.0-SNAPSHOT.jar'
        EC2_USER = 'ubuntu'
    }

    stages {
        stage('Deploy') {
            steps {
                script {
                    // Define servers map here
                    def SERVERS = [
                        dev: '172.31.16.143',
                        qa:  '172.31.27.38',
                        uat: '172.31.19.230',
                        prod:'172.31.24.144'
                    ]

                    def EC2_HOST = SERVERS[params.ENV]
                    echo "Deploying to ${params.ENV.toUpperCase()} environment (${EC2_HOST})"

                    sh """
                    scp -i ${PEM_KEY} -o StrictHostKeyChecking=no target/${JAR_NAME} ${EC2_USER}@${EC2_HOST}:/home/ubuntu/
                    ssh -i ${PEM_KEY} -o StrictHostKeyChecking=no ${EC2_USER}@${EC2_HOST} 'nohup java -jar /home/ubuntu/${JAR_NAME} >/dev/null 2>&1 & exit'
                    """
                }
            }
        }
    }
}
