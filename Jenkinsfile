pipeline {
    agent any

    stages {
        stage('Run Playwright Tests') {
            steps {
                script {
                    // Pull and run Playwright Docker image, generate Allure reports
                    // sh 'docker run -v $(pwd)/allure-results:/path/to/allure-results your-playwright-image'
                    sh 'docker build -t playwright-framework .'
                    sh 'docker run playwright-framework npm run test'
                    sh 'docker run playwright-framework allure generate allure-results --clean -o allure-report'

                    // Debugging statements
                    sh 'ls -la'  // Print contents of the workspace
                    sh 'ls -la allure-report'  // Print contents of allure-report directory
               
                    // sh 'sudo docker build -t playwright-framework .'
                    // sh 'sudo docker run playwright-framework npm run test'
                    // sh 'sudo docker run playwright-framework allure generate allure-results --clean -o allure-report'

                    // sh 'sudo docker run playwright-framework allure open allure-report'
                }
            }
        }
    }

    post {
        always {
            // Archive artifacts, if needed
            archiveArtifacts 'workspace/allure-report/**'
        
            // Publish Allure reports
            allure([
            includeProperties: false,
            jdk: '',
            properties: [],
            reportBuildPolicy: 'ALWAYS',
            results: 'workspace/allure-report/'
            ])
        }
    }
}
