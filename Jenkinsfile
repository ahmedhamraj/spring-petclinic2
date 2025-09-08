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
    }
}
