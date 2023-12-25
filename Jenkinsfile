pipeline {


    options {
        timestamps()
    }

    agent any

    stages {
        stage('Check scm') {
            agent any
            steps {
                checkout scm
            }
        }

        stage('Build'){
            steps{
                echo "Building ...${BUILD_NUMBER}"
                echo "Build completed"
            }
        }

        stage('Test') {
            agent {
                docker {
                    image 'alpine'
                    args '-u=root'
                }
            }
            steps {
                script {
                    sh 'apk add --update python3 py3-pip'
                    sh 'python3 -m venv /path/to/venv'
                    sh '/path/to/venv/bin/pip install xmlrunner'
        
                    // Виконуємо ваші тести
                    sh '/path/to/venv/bin/python3 test.py'
                }
            }

            post {
                always {
                    junit 'test-reports/*.xml'
                }
                success {
                    echo "Application testing successfully completed"
                }
                failure {
                    echo "Oooppss!!! Tests failed!"
                }
            }
        }
        stage('Build and Push Docker Image') {
            steps {
                script {
                    // Build Docker image
                    def DOCKER_IMAGE = 'opanegr/repo'
                    sh "docker build -t ${DOCKER_IMAGE} -f Dockerfile ."

                    withCredentials([usernamePassword(credentialsId: 'LandPDOCKER', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                    sh 'docker login -u $DOCKERHUB_USERNAME -p $DOCKERHUB_PASSWORD'
                    }
                    sh "docker push ${DOCKER_IMAGE}"
                }
            }
        }
    }
}
