pipeline {
    agent any
    options {
        timestamps()
        disableConcurrentBuilds()
    }
    stages {
        stage('Build') {
            steps {
                sh 'mkdir -p build/classes'
                sh 'javac -d build/classes src/main/java/ug/iuea/mrm/InventoryApplication.java'
            }
        }
        stage('Test') {
            steps {
                sh 'java -cp build/classes ug.iuea.mrm.InventoryApplication --self-test'
            }
        }
        stage('Package') {
            steps {
                sh 'jar --create --file build/mrm-inventory.jar --main-class ug.iuea.mrm.InventoryApplication -C build/classes .'
                archiveArtifacts artifacts: 'build/mrm-inventory.jar', fingerprint: true
            }
        }
    }
    post {
        always { echo "Branch build finished: ${env.BRANCH_NAME}" }
        success { echo 'Manufacturing Resource Management sample passed.' }
    }
}
