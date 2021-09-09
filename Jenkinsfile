pipeline {
    agent {
        label "EC2-LAUNCH-JENKINS"
    }
    parameter{
        string(name: 'VPC_ID', defaultValue: 'vpc-0d8460217b5ebd713' description: 'VPC id')
        string(name: 'INSTANCE_TYPE', defaultValue: 't2.micro' description: 'WebServer EC2 instance type')
    }
    stages("Step 1.2: Create ec2 Instance") {
        stage('Submit Stack') {
            steps {
            sh "aws cloudformation create-stack --stack-name ec2-jenkins-jobs --template-body file://CloudFormationTemplates/ec2.cf.json --region 'ap-southeast-2' --parameters ParameterKey=VpcId,ParameterValue=${VPC_ID} ParameterKey=InstanceType,ParameterValue=${INSTANCE_TYPE}" 
            }
        }
    }
}