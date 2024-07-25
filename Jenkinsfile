@Library('Kube_cluster') _ // Load the shared library
pipeline {
    agent any 
    stages {
        stage('Apply cluster yaml files') {
            steps {
                script {
                    deployApp()
                    echo "Yaml files Applied"
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
