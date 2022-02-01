pipeline {
  agent any
 
  tools {
  maven 'Maven3'
  }
  stages {
    stage ('Selinium') {
        agent {
        label 'jenkins-slave2'
        }
	steps {
	    sh '''
	    javac ./PG1.java
	    java ./PG1
	    '''
	    }
    }
    stage('Approval for Prod Deployment') {
        steps {
            echo "Taking approval from Manager for Prod Deployment"
            timeout(time: 7, unit: 'DAYS') {
            input message: 'Do you want to deploy into Prod ?', submitter: 'admin'
            }
        }
    }
    stage ('Deployment Notification') {
        steps {
        emailext body: '''$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS:
Check console output at $BUILD_URL to view the results.''', recipientProviders: [buildUser()], subject: 'Deployed to QA', to: 'vamsikrishna1001@gmail.com'
        }
    }
 }
}
