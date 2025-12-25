pipeline{
  agent any

 tools {
	maven 'maven3'
	}

  stages
    {
        stage('Checkout Code to Jenkins from GitHub')
        {
            steps()
            {
                git branch: 'dev', url: 'https://github.com/sanket0101/maven-web-application.git'
            }
        }

	 stage('Build Artifact using Maven')
        {
            steps()
            {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image')
        {
            steps()
            {
                sh 'docker build -t 1412345567.dkr.ecr.ap-south-1.amazonaws.com/maven-web-application:${BUILD_NUMBER} .'
            }
        }
	}
}