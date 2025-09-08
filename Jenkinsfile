pipeline 
{
    agent any

    stages 
    {
        stage('continus download') 
        {
            steps 
            {
                git branch: 'main', url: 'https://github.com/ahmedhamraj/spring-petclinic.git'
            }
        }
        stage('continus build') 
        {
            steps 
            {
                'mvn clean package -DskipTests -U'
            }
        }
	stage('continus deploy') 
        {
            steps 
            {
                sh '''scp /var/lib/jenkins/workspace/spring-petclinic/target/spring-petclinic-3.5.0-SNAPSHOT.jar ubuntu@172.31.24.124:/var/lib/tomcat9/webapps/spring-petclinic.jar'''
 
            }
        }
    }
}
