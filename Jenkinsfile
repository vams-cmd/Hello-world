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
	    mkdir -p /home/ubuntu/jenkins/workspace/artifacts/${BUILD_NUMBER}/
            cp ${WORKSPACE}/target/demoapp-0.0.1-SNAPSHOT.jar /home/ubuntu/jenkins/workspace/artifacts/${BUILD_NUMBER}/
            '''
        }
    }
    stage ('Build Dockerimage') {
        agent {
        label 'jenkins-slave1'
        }
        steps {
            sh '''
	    docker rm -f ass_cont 2> /dev/null || true
	    docker rmi -f bvk10r/ct-assignments:1 2> /dev/null || true
	    docker rmi -f assignment1:1 2> /dev/null || true
	    sleep 30
            docker build -t assignment1:1 .
            docker tag assignment1:1 bvk10r/ct-assignments:1 
	    docker run -d --name ass_cont bvk10r/ct-assignments:1
            docker push bvk10r/ct-assignments:1
            '''
        }
    }
    stage ('Selinium') {
        agent {
        label 'jenkins-slave2'
        }
	steps {
            sh '''
	    javac ./PG1.java
	    java ./PG1.class
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
	    docker run -d --name ass_cont bvk10r/ct-assignments:1
            '''
        }
    }  
  }
}
