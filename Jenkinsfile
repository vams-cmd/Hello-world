pipeline {
  agent any
 
  tools {
  maven 'Maven3'
  }
  stages {
    stage ('Checkout') {
      steps {
      git branch: 'Ass2', credentialsId: 'Github_username', url: 'https://github.com/vams-cmd/Hello-world.git'
      }
    }  
    stage ('Build') {
      steps {
      sh 'mvn clean install -f pom.xml'
      }
    }
  }
}
