pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = 'Playwright framework'
    }

    stages {
        stage('Checkout') {
            steps {
                // Assuming your code is in a Git repository
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    docker.build DOCKER_IMAGE
                }
            }
        }

        stage('Run Tests in Docker Container') {
            steps {
                script {
                    // Run the tests inside the Docker container
                    docker.image(DOCKER_IMAGE).inside {
                        // Execute the commands needed to run your tests
                        sh 'npm install'
                        sh 'npm test'
                    }
                }
            }
        }

        stage('Publish Allure Report') {
            steps {
                script {
                    // Assuming Allure results are generated in a directory named 'allure-results'
                    docker.image(DOCKER_IMAGE).inside {
                        sh 'npm run allure-report'
                        archiveArtifacts 'allure-report'
                    }
                }
            }
        }
    }

    post {
        always {
            // Clean up Docker resources
            script {
                docker.image(DOCKER_IMAGE).remove()
            }
        }
    }
}