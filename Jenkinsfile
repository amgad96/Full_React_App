@Library('Kube_cluster') _ // Load the shared library
pipeline {
    agent any
//This command to check  
    environment {
        DOCKER_CREDENTIALS_ID = 'Amgad-Docker-Cred'
    }
    stages {           
      stage('Build Frontend') {
            steps {
                    script {
                        sh 'npm install'
                        sh 'npm run build'
                            }
                        }
                    }

        stage('Test Frontend') {
            steps {
                    script {
                        sh 'npm install'
                        sh 'npm test'
                    }
                }
            }
               

        stage('Build frontend docker Image') {
            steps {
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        script {
                            def version = sh(script: "jq -r .version package.json", returnStdout: true).trim()
                            sh """
                            echo \$DOCKER_PASSWORD | docker login -u \$DOCKER_USERNAME --password-stdin
                            docker build -t amgadashraf/ffrontend:"v${version}" .
                            docker push amgadashraf/ffrontend:"v${version}" 
                            docker logout
                                """
                                }
                        }
                }
            }

        stage('Deploy') {
            steps {
                // Add your deployment steps here
                deployApp()
                echo 'Frontend Deployed'
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

