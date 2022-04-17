# CopyFileToS3
This project provides copying any file that is written to an S3 bucket to another S3 bucket via triggered lambda function.

## Prerequisites
- sam cli
- nodejs12.x
- S3, Lambda, Cloudformation operation permissions for IAM user 

## Set Up
To run deploy.sh with parameters:
  - go to deployment path in terminal
  - use this command-> ./deploy.sh stackoperation sourcebucketname destinationbucketname region directory of template.yaml in locale

To run index.js locally:
  - npm install
  - sam local invoke Function name in template.yml --event event.json

## Usage
When the deploy.sh is run, lambda will be deployed in vpc.
When the index.js is run, file from given event.json in s3 will be copied.
  
  




