pipeline {
    agent any

    stages {
        stage('Set up environment') {
            steps {
                script {
                    // Build a Docker container
                    // Set up new build
                    sh 'docker build -t playwright-framework .'
                    sh 'docker run -v /var/lib/jenkins/workspace/playwright_docker:/usr/src/app playwright-framework npm install'
                    // sh 'docker run -v /var/lib/jenkins/workspace/playwright_docker:/usr/src/app playwright-framework npx playwright install'
                
                }
            }
        }
        stage('Run Playwright Tests') {
            steps {
                script {
                    // Run Playwright tests in a Docker container


                    sh "docker run -v ${WORKSPACE}:/usr/src/app playwright-framework npm run test"
                    sh "docker run -v ${WORKSPACE}:/usr/src/app playwright-framework allure generate allure-report --clean -o allure-report"


                    // Debugging statements
                    sh 'ls'  // Print contents of the workspace
                    sh 'ls -la allure-report'  // Print contents of allure-report directory

                    sh 'docker rmi playwright-framework'
               
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