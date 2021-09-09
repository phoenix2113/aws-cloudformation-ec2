pipeline {
    agent any
    stages {
        stage('Submit Stack') {
            steps {
            sh "aws cloudformation create-stack --stack-name ec2-jenkins-jobs --template-body file://CloudFormation Template/ec2.cf.json --region 'ap-southeast-2'"
            }
        }
    }
}