pipeline {
  agent any
 
  tools {
  maven 'Maven3'
  }
  stages {
    stage ('Checkout') {
      steps {
      git branch: 'stage', credentialsId: 'Github_username', url: 'https://github.com/vams-cmd/Hello-world.git'
      }
    }  
    stage ('Build') {
      steps {
      sh 'mvn clean install -f pom.xml'
      }
    }
    stage ('Code Quality') {
      steps {
          withSonarQubeEnv('SonarQube') {
		  sh 'mvn -f ${WORKSPACE}/pom.xml sonar:sonar'
          }
      }
    }
    stage ('Build Dev') {
      steps {
          build quietPeriod: 30, job: 'Dev'
      }
    }	  
  }
}
