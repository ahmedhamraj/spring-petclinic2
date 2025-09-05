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
        stage('Deploy to Tomcat') {
            steps {
                   sshagent(['ec2-ssh-key']) {
            sh '''
            echo "🔑 Testing SSH connection..."
            ssh -o StrictHostKeyChecking=no ubuntu@172.31.24.124 "echo '✅ SSH connection successful!'"

            echo "📦 Copying JAR to Tomcat webapps..."
            scp -o StrictHostKeyChecking=no \
            /var/lib/jenkins/workspace/spring-petclinic/target/spring-petclinic-3.5.0-SNAPSHOT.jar \
            ubuntu@172.31.24.124:/var/lib/tomcat9/webapps/spring-petclinic.jar
            '''
            }
        }
    }
}
