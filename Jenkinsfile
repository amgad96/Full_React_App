pipeline {
    agent any 
    stages {
        stage('Apply cluster yaml files') {
            steps {
                script {
                    
                        sh 'Kubectl apply -f DB-PersistentVol.yaml'
                        sh 'Kubectl apply -f MongoDB-DS.yaml'
                        sh 'Kubectl apply -f Backend-DS.yaml'
                        sh 'Kubectl apply -f Frontend-DS.yaml'
                    }
                }
            }
    }

    post {
        always {
            cleanWs() // Clean the workspace after the build
        }
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
