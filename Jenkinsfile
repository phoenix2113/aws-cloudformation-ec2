pipeline {
    agent any
    parameters {
        string(name: 'VPC_ID', defaultValue: 'vpc-0d8460217b5ebd713', description: 'VPC id')
        string(name: 'INSTANCE_TYPE', defaultValue: 't2.micro', description: 'WebServer EC2 instance type')
    }

    
    stages("Create ec2 Instance") {
        stage('STEP 1: Create Iam Role') {
            steps {
            sh "aws cloudformation create-stack --stack-name ec2-Iam-Role --template-body file://CloudFormationTemplates/IAM.cf.json --region 'ap-southeast-2'--capabilities CAPABILITY_NAMED_IAM CAPABILITY_IAM" 
            }
        }

        stage('STEP 2: Launch EC2') {
            steps {
            sh "aws cloudformation create-stack --stack-name ec2-jenkins-jobs --template-body file://CloudFormationTemplates/ec2.cf.json --region 'ap-southeast-2' --parameters ParameterKey=VpcId,ParameterValue=${VPC_ID} ParameterKey=InstanceType,ParameterValue=${INSTANCE_TYPE}" 
            }
        }
    }
}