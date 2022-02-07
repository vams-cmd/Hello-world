#!/usr/bin/env groovy
def currentDay = new Date(System.currentTimeMillis())[Calendar.DAY_OF_WEEK]
Calendar today = Calendar.getInstance()
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
    stage ('save artifacts') {
	when {
    	  allOf {
             expression { return currentDay == Calendar.SATURDAY }
             expression { return currentDay == Calendar.SUNDAY }
	  }
	}	    
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
    stage ('Code Quality') {
	when {
    	  allOf {
             expression { return currentDay == Calendar.SATURDAY }
             expression { return currentDay == Calendar.SUNDAY }
	  }
	}	    
      steps {
          withSonarQubeEnv('SonarQube') {
          sh 'mvn -f pom.xml sonar:sonar'
          }
      }
    }	  
    stage ('Build & push image to ECR') {
	when {
    	  allOf {
             expression { return currentDay == Calendar.SATURDAY }
             expression { return currentDay == Calendar.SUNDAY }
	  }
	}	    
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
    stage ('Creating EKS cluster') {
	when {
    	  allOf {
             expression { return currentDay == Calendar.SATURDAY }
             expression { return currentDay == Calendar.SUNDAY }
	  }
	}	    
        agent {
        label 'jenkins-slave1'
        }
        steps {
            sh '''
            cd /home/ubuntu/jenkins/workspace/New_Assignment2/terraform
            terraform init
            terraform plan
            terraform apply -auto-approve
            '''
        }
    }
    stage ('Deployment') {
	when {
    	  allOf {
             expression { return currentDay == Calendar.SATURDAY }
             expression { return currentDay == Calendar.SUNDAY }
	  }
	}	    
        agent {
        label 'jenkins-slave1'
        }
        steps {
            sh '''
            cd /home/ubuntu/jenkins/workspace/New_Assignment2/k8s
            aws eks --region us-east-1 update-kubeconfig --name demo
            kubectl apply -f aws-test.yaml
            kubectl apply -f deployment.yaml
            kubectl apply -f public-lb.yaml
            kubectl apply -f private-lb.yaml
            kubectl apply -f cluster-autoscaler.yaml
            '''
        }
    }	  
  }
}

