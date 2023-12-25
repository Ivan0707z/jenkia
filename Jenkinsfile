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
                        // Кроки, які вже були в вашому коді
                        sh 'apk add --update python3 py-pip'
                        sh 'pip install unittest2==1.1.0'
                        sh 'pip install xmlrunner'
            
                        // Нові кроки для використання віртуального середовища
                        sh 'apk add --update bash'
            
                        // Створюємо та активуємо віртуальне середовище
                        sh 'python3 -m venv venv'
                        sh 'source venv/bin/activate'
            
                        // Виконуємо ваші тести
                        sh 'python3 test.py'
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
                    def DOCKER_IMAGE = 'anne738/my-repo-for-exam'
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
