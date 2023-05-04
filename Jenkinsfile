pipeline {
    agent any
    environment {
        dockerImage = ''
        registryCredential = 'dockerhub-credentials'
        registry = "chtulasi/kopsimage"
    }
    stages {
        stage('checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'github-credential', url: 'https://github.com/mtulasi41/Jenkins-Kops-Deployment.git']])
            }
        }
        stage('ImageBuild') {
            steps {
                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }
        stage('PublishImage') {
            steps {
                script {
                    docker.withRegistry('',registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Cleaning Up Image') {
            steps {
                sh "docker rmi $registry:$BUILD_NUMBER"
            }
        }
       stage('Deploying Kopsimage container to Kubernetes') {
         steps {
           script {
             kubernetesDeploy(configs: "Deployment.yaml", "Service.yaml")
             }
           }
         }
    }
}
