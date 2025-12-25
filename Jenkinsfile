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
                sh 'docker build -t 769763824228.dkr.ecr.ap-south-1.amazonaws.com/maven-web-application:${BUILD_NUMBER} .'
            }
        }

		 stage('Authenticate and Push Docker Image to AWS ECR')
        {
            steps()
            {
                sh 'aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 769763824228.dkr.ecr.ap-south-1.amazonaws.com'
                sh 'docker push 769763824228.dkr.ecr.ap-south-1.amazonaws.com/maven-web-application:${BUILD_NUMBER}'
            }
        }
	}
}