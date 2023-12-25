pipeline {
    options {timestamps()}

    agent any
    environment {
        DOCKER_IMAGE = 'annaiiv/exam_app'
        FLASK_APP = 'app.py'

        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
    }

    stages {
        stage('Check scm') {
            steps {
                // Checkout the code from your version control system (e.g., Git)
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo "Building ...${BUILD_NUMBER}"
                echo "Build compleated."
            }
        }

        stage('Test') {
            agent{
                docker{
                    image 'alpine'
                    args '-u=\"root\"'
                }
            }
            steps{
                sh "apk add --update python3 py-pip"
                sh "pip install Flask"
                sh  "pip install xmlrunner"
                sh "python3 test.py"
                echo "Test section compleated."
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                script {
                    // Build Docker image
                    sh "docker build -t ${DOCKER_IMAGE} -f Dockerfile ."
                    // Push Docker image to Docker Hub
                    // withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    //     sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}"
                    // }
                    sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                    sh "docker push ${DOCKER_IMAGE}"
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh "echo 'Deploying Flask app...'"
                }
                
            }
        }

    }


  post { 
        always { 
            echo 'The pipeline completed'
            junit allowEmptyResults: true, testResults:'**/test_reports/*.xml'
            sh 'docker logout'
        } 
        success {                    
            echo "Flask Application Up and running!!"
        } 
        failure { 
            echo 'Build stage failed'
            error('Stopping early…') 
        } 
    }
}
