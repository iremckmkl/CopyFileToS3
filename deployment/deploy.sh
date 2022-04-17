#!/bin/bash -x
STACK_OPERATION=$1 # c for create u for update
SOURCEBUCKET=$2
DESTINATIONBUCKET=$3
region=$4
templatedirectory=$5

aws s3 mb s3://copytos3lambdafunction
aws s3api put-object  --bucket copytos3lambdafunction --key function.zip --region ${region}  --body index.js

params="ParameterKey=BucketName,ParameterValue=copytos3lambdafunction
    ParameterKey=SourceBucketName,ParameterValue=$SOURCEBUCKET
    ParameterKey=DestinationBucketName,ParameterValue=$DESTINATIONBUCKET"

subnet="subnet-0bd6f2619b6effaad"
securityID="sg-0aac249aa17d3c48a"

if ! ([ "$STACK_OPERATION" = "c" ] || [ "$STACK_OPERATION" = "u" ])
then
    echo "unknown stack operation: $STACK_OPERATION"
    exit 1
fi
if [ $STACK_OPERATION = "c" ]
then
    echo "Creating stack"
    aws --region $region cloudformation create-stack --stack-name copytos3-stack --template-body file:////$templatedirectory \
    --parameters $params --capabilities CAPABILITY_AUTO_EXPAND CAPABILITY_IAM

elif [ $STACK_OPERATION = "u" ]
then
    echo "Updating stack"
    aws --region $region cloudformation update-stack --stack-name copytos3-stack --template-body file:////$templatedirectory \
    --parameters $params --capabilities CAPABILITY_AUTO_EXPAND CAPABILITY_IAM
fi

