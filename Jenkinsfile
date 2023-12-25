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
        sh '/path/to/venv/bin/pip install unittest2==1.1.0' 
        sh '/path/to/venv/bin/pip install xmlrunner' 
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
        
        stage('Build') {
            steps {
                echo "Building ...${BUILD_NUMBER}" 
                echo "Build completed"
            }
        }

        stage('Docker Build'){
            steps {
                sh 'pwd'
                sh 'docker build -t lab3 /var/jenkins_home/workspace/exam'
                // sh 'docker run lab3 test'
            }
        }
        stage('Build Docker Image Info') {
            steps {
                script {
                    // Отримати хеш коміту для тегу образу
                    def commitHash = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
                    // Створити тег образу
                    def imageTag = "lab3:${commitHash}"
                    // Записати тег образу у файл
                    writeFile file: 'docker-image-tag', text: imageTag
                }
            }
        }
        stage('Build and Push') {
    steps {
        script {
            def imageTag = readFile 'docker-image-tag'
            sh "docker build -t ${imageTag} -f Dockerfile ."

            // Використання облікових даних Docker Hub для логіну
            withCredentials([usernamePassword(credentialsId: 'your_credentials_id', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                sh 'docker login -u $DOCKERHUB_USERNAME -p $DOCKERHUB_PASSWORD'
                sh "docker push ${imageTag}"
            }
        }
    }
}

    }
}
