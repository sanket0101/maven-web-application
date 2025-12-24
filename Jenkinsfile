pipeline{
  agent any

  tools{
       maven 'maven_3.9'
  }
  stages{
	stage('Checkout'){
		steps{
			git branch: 'dev', url: 'https://github.com/sanket0101/maven-web-application.git'
		}

  }

  stage('Build'){
	steps{
		sh 'mvn clean package'
	}
	}

	stage('Docker build'){
		steps{
			sh 'docker build -t 769763824228.dkr.ecr.ap-south-1.amazonaws.com/maven-web-application:${BUILD_NUMBER} .'
		}
	}
	stage('Authenticate and Push Docker Image to AWS ECR')
        {
            steps()
            {
                sh 'docker push 769763824228.dkr.ecr.ap-south-1.amazonaws.com/maven-web-application:${BUILD_NUMBER}'
            }
        }

  }
}
