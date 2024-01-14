pipeline {
    agent any

    stages {
        stage('Set up environment') {
            steps {
                script {
                    // Build a Docker container
                    sh 'docker build -t playwright-framework .'

                    // Run npm install manually inside the container
                    sh 'docker run -v /var/lib/jenkins/workspace/playwright_docker:/usr/src/app playwright-framework /bin/sh -c "npm install"'
                }
            }
        }
        stage('Run Playwright Tests') {
            steps {
                script {
                    // Run Playwright tests in a Docker container
                    sh 'docker run -v /var/lib/jenkins/workspace/playwright_docker:/usr/src/app playwright-framework npm run test'
                }
            }
        }
        stage('Generate Allure report and Remove Docker Container') {
            steps {
                script {
                    sh "docker run -v ${WORKSPACE}:/usr/src/app playwright-framework allure generate allure-report --clean -o allure-report"
                    sh 'docker rmi playwright-framework'
               
                }
            }
        }
    }

    post {
        always {
            // Archive artifacts, if needed
            archiveArtifacts 'allure-report'

            // Publish Allure reports
            allure([
                includeProperties: false,
                jdk: '',
                properties: [],
                reportBuildPolicy: 'ALWAYS',
                results: ['allure-report']
            ])
        }
    }
}