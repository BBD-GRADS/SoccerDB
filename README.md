# Soccer DB Setup

## First time deployment and setup

First install NodeJS

Then to install the AWS CLI run

 ``` 
 npm install -g aws-cli 
 ```  

Then to configure your AWS CLI credentials run

 ```
 aws configure 
```   

Then to install the AWS CDK run

```  
npm i -g aws-cdk  
```  

Then to deploy the resources required by the AWS CDK to your AWS account run

```  
cdk bootstrap  
```  

Configure a role on AWS IAM to use for your deployments with the following policy statements attached, which will
allow  
your workflow to assume the roles required by the CDK for deployments

```  
{  
 "Action": "sts:AssumeRole", 
 "Resource": "arn:aws:iam::*:role/cdk-*", 
 "Effect": "Allow"
},  
{  
 "Action": "secretsmanager:GetSecretValue",  
 "Resource": "*",
 "Effect": Allow
}  
```  

Configure the following repository variables for the actions in GitHub

```  
key: AWS_SECRET_NAME  
value: soccerDbInstanceSecret  
  
key: AWS_DEPLOY_ROLE  
value: <The arn of the deploy role created above>  
  
key: AWS_REGION  
value: The AWS region to deploy to eg. eu-west-1  
```  

Then connect to your RDS database instance by using the values for the host, username and password that you find in
the "*soccerDbInstanceSecret*" in AWS Secrets Manager using SQL Server Management Studio (Or a similar tool).  
Execute the following SQL statement to create the database

```  
USE master;  
GO  
  
CREATE DATABASE SoccerDB;  
GO  
```  

Then go to the GitHub repository and click on Actions. Select the "*Deploy DB Changes*" workflow, click "*Run
workflow*".  
Input "*db.sql*" in the "*Changelog file name*" field. Then click the green "*Run Workflow*" button. Once it completes
your database will have all tables created with their constraints, relations etc.

Now you can run the workflow again with any of the changelog files found in the */scripts* directory in order to
create  
the functions, views and procedures as needed.

## Further Deployments

Any new changes to the infrastructure as code can be deployed using the "*Deploy Infrastructure*" workflow on GitHub  
actions

Any additional SQL scripts you wish to run must be added to the */scripts* directory. This can then be deployed by
running  
the  "*Deploy DB changes*" workflow from GitHub actions.

## Useful commands

* `cdk deploy`  deploy this stack to your default AWS account/region (manual deployment)
* `cdk diff`    compare deployed stack with current state
