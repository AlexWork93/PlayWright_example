pipeline {
    agent any

    stages {
        stage('Run Playwright Tests') {
            steps {
                script {
                    // Build and run Playwright tests in a Docker container
                    sh 'docker build -t playwright-framework .'
                    sh 'docker run playwright-framework npm run test'

                    // Generate Allure report in the same Docker container
                    sh 'docker run playwright-framework allure generate /path/to/allure-report --clean -o allure-report'
                }
            }
        }
    }

    post {
        always {
            // Archive artifacts, if needed
            archiveArtifacts 'allure-report/'

            // Publish Allure reports
            allure([
                includeProperties: false,
                jdk: '',
                properties: [],
                reportBuildPolicy: 'ALWAYS',
                results: 'allure-report/'
            ])
        }
    }
}