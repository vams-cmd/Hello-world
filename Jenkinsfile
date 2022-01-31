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
    stage ('save artifacts') {
        agent {
        label 'jenkins-slave1'
        }
        steps {
            sh '''
            cp ${WORKSPACE}/target/demoapp-0.0.1-SNAPSHOT.jar /opt/
            '''
        }
    }
    stage ('Build Dockerimage') {
        agent {
        label 'jenkins-slave1'
        }
        steps {
            sh '''
	    docker rm bvk10r/ct-assignments:1
	    docker rm assignment1:1
            docker build -t assignment1 .
            docker tag assignment1:latest bvk10r/ct-assignments:1
	    docker run -d --name ass_cont bvk10r/ct-assignments:1
            docker push bvk10r/ct-assignments:1
            '''
        }
    }
    stage ('Pull Docker Image') {
        agent {
        label 'jenkins-slave1'
        }
        steps {
            sh '''
	    docker rm -f ass_cont 2> /dev/null || true
	    docker rmi -f bvk10r/ct-assignments:1 2> /dev/null || true
	    docker pull bvk10r/ct-assignments:1
	    docker run --name ass_cont bvk10r/ct-assignments:1
            '''
        }
    }  
  }
}
