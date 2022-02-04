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
        agent {
        label 'jenkins-slave1'
        }
        steps {
        sh 'mvn clean install -f pom.xml'
      }
    }
    stage ('Build & push image to ECR') {
        agent {
        label 'jenkins-slave1'
        }
        steps {
            sh '''
            cd /home/ubuntu/jenkins/workspace/New_Assignment2
	    docker rmi -f 773567626102.dkr.ecr.us-east-1.amazonaws.com/assignment_two:latest 2> /dev/null || true
	    docker rmi -f assignment_two:latest 2> /dev/null || true
            aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 773567626102.dkr.ecr.us-east-1.amazonaws.com
            docker build -t assignment_two:latest .
            docker tag assignment_two:latest 773567626102.dkr.ecr.us-east-1.amazonaws.com/assignment_two:latest
            docker push 773567626102.dkr.ecr.us-east-1.amazonaws.com/assignment_two:latest
            '''
        }
    }    
  }
}

