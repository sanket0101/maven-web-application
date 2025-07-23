pipeline{
          
		  agent any
		  
		  tools {
		    maven 'maven9.10'
		    git 'Default'
		  }
		  
    stages{
	
	 stage('gitCheckOut'){
	  steps{
	  git branch: 'main', url: 'https://github.com/sanket0101/maven-web-application.git'
	  }
	 }
	
 stage('mavenBuild'){
  steps{
  sh "mvn clean package"
  }
 }
 
 stage('sonarAnalysis'){
  steps{
  sh "mvn sonar:sonar"
  }
 }
	
	 stage('nexusUpload'){
     steps{
     sh "mvn deploy"
     }
    }
	
    stage('tomcatHosting'){
     steps{
      sshagent(['tomcatkey']) {
        sh """
  	  scp -o StrictHostKeyChecking=no target/maven-web-application.war ubuntu@3.111.23.119:/opt/apache-tomcat-9.0.107/webapps/
  	  """
    }
     }
    }
	
	} //stages closing
	
	post {
	          success {
	              slackSend (
	                  color: 'good', // green
	                  message: "✅ *Build Success* - Job: ${env.JOB_NAME}, Build: #${env.BUILD_NUMBER}\n<${env.BUILD_URL}|Click here to view details>"
	              )
	          }
	          failure {
	              slackSend (
	                  color: 'danger', // red
	                  message: "❌ *Build Failed* - Job: ${env.JOB_NAME}, Build: #${env.BUILD_NUMBER}\n<${env.BUILD_URL}|Click here to view details>"
	              )
	          }
	          unstable {
	              slackSend (
	                  color: 'warning', // yellow
	                  message: "⚠️ *Build Unstable* - Job: ${env.JOB_NAME}, Build: #${env.BUILD_NUMBER}\n<${env.BUILD_URL}|Click here to view details>"
	              )
	          }
	      }  
  
  } //pipeline closing
