import * as cdk from "aws-cdk-lib";
import { Construct } from "constructs";
import { aws_ec2 as ec2, aws_rds as rds } from "aws-cdk-lib";

export class SoccerDbStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    const vpc = new ec2.Vpc(this, "dbVpc");

    const dbInstance = new rds.DatabaseInstance(this, "soccerDb", {
      engine: rds.DatabaseInstanceEngine.sqlServerSe({
        version: rds.SqlServerEngineVersion.VER_16,
      }),
      instanceType: ec2.InstanceType.of(
        ec2.InstanceClass.T3,
        ec2.InstanceSize.MICRO
      ),
      vpc,
      allocatedStorage: 10,
      publiclyAccessible: true,
      deletionProtection: false,
      credentials: rds.Credentials.fromGeneratedSecret("admin"),
    });
  }
}
