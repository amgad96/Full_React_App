pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'Amgad-Docker-Cred'
    } 

    stages {
       stage('Installing Backend dependencies') {
                    steps {
                        script {
                            sh '''
                                npm update
                                npm install --save-dev jest supertest
                                npm install express
                                npm install --save-dev @babel/cli @babel/core @babel/preset-env
                                '''
                            }
                        }
                    }
                
      stage('Build Backend') {
            steps {
                    script {
                        sh 'npm run build'
                    }
                }
            }

        stage('Test Backend') {
            steps {
                    script {
                        sh 'npm test'
                    }
                }
            }

        stage('Build backend docker Image') {
            steps {
                // Extract version from package.json
                def version = sh(script: "jq -r .version package.json", returnStdout: true).trim()
                withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                script {
                    sh """
                    echo \$DOCKER_PASSWORD | docker login -u \$DOCKER_USERNAME --password-stdin
                    docker build -t amgadashraf/fbackend:${version} .
                    docker push amgadashraf/fbackend:${version} 
                    docker logout
                        """
                        }
                }
            }
        }
        stage('Deploy') {
            steps {
                // Add your deployment steps here
                echo 'Deploying Frontend and Backend...'
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
