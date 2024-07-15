pipeline {
    agent any
//This command to check  
    environment {
        DOCKER_CREDENTIALS_ID = credentials('Amgad-Docker-Cred')
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
                            script {
                                withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS_ID}", usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                                sh """
                                echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin
                                docker build -t amgadashraf/ffrontend:v6 frontend
                                docker push amgadashraf/ffrontend:v6
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

