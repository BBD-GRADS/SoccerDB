import * as cdk from "aws-cdk-lib";
import { Construct } from "constructs";
import { aws_ec2 as ec2, aws_rds as rds } from "aws-cdk-lib";

export class SrcStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    const vpc = new ec2.Vpc(this, "VPC");
    cdk.Tags.of(vpc).add("owner", "rudolphe@bbd.co.za");
    cdk.Tags.of(vpc).add("created-using", "terraform");

    const dbInstance = new rds.DatabaseInstance(this, "RdsInstance", {
      engine: rds.DatabaseInstanceEngine.sqlServerSe({
        version: rds.SqlServerEngineVersion.VER_15,
      }),
      instanceType: ec2.InstanceType.of(
        ec2.InstanceClass.BURSTABLE3,
        ec2.InstanceSize.MICRO
      ),
      vpc,
      allocatedStorage: 10,
      maxAllocatedStorage: 20,
      publiclyAccessible: true,
      deletionProtection: false,
      credentials: rds.Credentials.fromGeneratedSecret("admin"),
    });
    cdk.Tags.of(dbInstance).add("owner", "rudolphe@bbd.co.za");
    cdk.Tags.of(dbInstance).add("created-using", "terraform");
  }
}
