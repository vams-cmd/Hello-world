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
    }
	steps {
            sh '''
	    javac ./PG1.java
	    java ./PG1
	    '''
    }
	  
  }
}
