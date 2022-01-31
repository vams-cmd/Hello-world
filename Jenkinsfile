pipeline {
  agent any
 
  tools {
  maven 'Maven3'
  }
  stages {
    stage ('Checkout') {
      steps {
      git branch: 'stage', credentialsId: 'Github_username', url: 'https://github.com/vams-cmd/maven-helloworld.git'
      }
    }  
    stage ('Build') {
      steps {
      sh 'mvn clean install -f pom.xml'
      }
    }
    stage ('save artifacts') {
        agent {
        label 'jenkins-slave1'
        }
        steps {
            sh '''
            cp /home/ubuntu/jenkins/workspace/1st_Assignment_dev/target/my-app-1.0-SNAPSHOT.jar /home/ubuntu/jenkins/workspace/1st_Assignment_dev
            '''
        }
    }
    stage ('save artifacts') {
        agent {
        label 'jenkins-slave1'
        }
        steps {
            sh '''
            cd /home/ubuntu/jenkins/workspace/1st_Assignment_dev
			docker rm -f ass_cont 2> /dev/null || true
			docker rmi -f bvk10r/ct-assignments:1 2> /dev/null || true			
			docker pull bvk10r/ct-assignments:1
			docker run --name ass_cont bvk10r/ct-assignments:1
            '''
        }
    }  
  }
}
