pipeline {
    agent any // Specifies that the pipeline can run on any available agent

    tools {
        // Defines tools to be used in the pipeline, e.g., Maven
        jdk 'java 17'
        maven 'maven 3.9.11' // 'M3' should be configured as a Maven installation in Jenkins Global Tool Configuration
    }

    stages {
        stage('Checkout') {
            steps {
                // Fetches the source code from a Git repository
                git changelog: false, credentialsId: '555bac67-2c63-4ad9-baa3-401e115b91e1', poll: false, url: 'https://github.com/AKdevops-World/maven-web-application.git'
            }
        }

        stage('Build') {
            steps {
                // Builds the Java application using Maven to produce a WAR file
                sh 'mvn clean package'
            }
        }

        stage('Deploy') {
            steps {
                // Copies the generated WAR file to the Tomcat webapps directory
                // Replace 'your-tomcat-server-ip' and '/opt/tomcat/webapps/' with your actual values
                // Ensure SSH access and necessary permissions are configured on the Tomcat server
                sh 'scp target/*.war admin@192.168.0.107:/opt/tomcat/webapps/'
            }
        }
    }

    post {
        // Defines actions to take after the pipeline completes
        always {
            // Cleans up the workspace on the Jenkins agent
            cleanWs()
        }
        failure {
            // Sends a notification if the pipeline fails
            echo 'Pipeline failed! Check console output for details.'
        }
        success {
            // Sends a notification if the pipeline succeeds
            echo 'Pipeline successfully deployed the application.'
        }
    }
}
