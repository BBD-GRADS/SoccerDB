import * as cdk from "aws-cdk-lib";
import {Construct} from "constructs";
import {aws_ec2 as ec2, aws_iam as iam, aws_rds as rds} from "aws-cdk-lib";

export interface GitHubStackProps extends cdk.StackProps {
    readonly repositoryConfig: { owner: string; repo: string; filter?: string }[];
}

export class SoccerDbStack extends cdk.Stack {
    constructor(scope: Construct, id: string, props?: cdk.StackProps) {
        super(scope, id, props);

        const vpc = new ec2.Vpc(this, "soccerDbVpc", {
            maxAzs: 2,
            subnetConfiguration: [
                {
                    name: "PublicSubnet",
                    subnetType: ec2.SubnetType.PUBLIC,
                },
                {
                    name: "PrivateSubnet",
                    subnetType: ec2.SubnetType.PRIVATE_ISOLATED,
                },
            ],
        });

        const soccerDbSG = new ec2.SecurityGroup(this, "soccerDbSG", {
            vpc,
            allowAllOutbound: false,
        });

        soccerDbSG.addIngressRule(ec2.Peer.anyIpv4(), ec2.Port.tcp(1433)); //remove with host
        soccerDbSG.addEgressRule(ec2.Peer.anyIpv4(), ec2.Port.tcp(1433))

        // const bastionHostSG = new ec2.SecurityGroup(this, "bastionHostSG", {
        //   vpc,
        //   allowAllOutbound: false,
        // });

        // bastionHostSG.addEgressRule(
        //   ec2.Peer.anyIpv4(),
        //   ec2.Port.tcp(443),
        //   "Allow only HTTPS outbound"
        // );

        // const bastionHostRole = new iam.Role(this, "BastionHostRole", {
        //   assumedBy: new iam.ServicePrincipal("ec2.amazonaws.com"),
        //   description: "Role for bastion host to enable SSM access",
        // });

        // bastionHostRole.addManagedPolicy(
        //   iam.ManagedPolicy.fromAwsManagedPolicyName("AmazonSSMManagedInstanceCore")
        // );

        // const host = new ec2.BastionHostLinux(this, "BastionHost", {
        //   vpc,
        //   securityGroup: bastionHostSG,
        //   subnetSelection: { subnetType: ec2.SubnetType.PUBLIC },
        //   blockDevices: [
        //     {
        //       deviceName: "/dev/sdf",
        //       volume: ec2.BlockDeviceVolume.ebs(10, {
        //         encrypted: true,
        //       }),
        //     },
        //   ],
        // });

        const dbInstance = new rds.DatabaseInstance(this, "soccerDbInstance", {

            engine: rds.DatabaseInstanceEngine.sqlServerEx({
                version: rds.SqlServerEngineVersion.VER_16,
            }),
            instanceType: ec2.InstanceType.of(
                ec2.InstanceClass.T3,
                ec2.InstanceSize.MICRO
            ),
            vpc,
            vpcSubnets: {
                subnetType: ec2.SubnetType.PUBLIC, //private with host
            },
            allocatedStorage: 20,
            // databaseName: "soccerDb",
            publiclyAccessible: true, //false with host
            deletionProtection: false,
            credentials: rds.Credentials.fromGeneratedSecret('admin', {secretName: 'soccerDbInstanceSecret'}),
            securityGroups: [soccerDbSG],
        });
        //dbInstance.connections.allowFrom(host, ec2.Port.tcp(1433));

        // Create role for github actions to assume
        const githubDomain = 'token.actions.githubusercontent.com';

        const ghProvider = new iam.OpenIdConnectProvider(this, 'githubProvider', {
            url: `https://${githubDomain}`,
            clientIds: ['sts.amazonaws.com'],
        });

        const ghProps: GitHubStackProps = {
            repositoryConfig: [
                {owner: 'jmouton19', repo: 'SoccerDB'}]
        };

        const iamRepoDeployAccess = ghProps.repositoryConfig.map(
            (r) => `repo:${r.owner}/${r.repo}:${r.filter ?? '*'}`
        );

        const conditions: iam.Conditions = {
            StringLike: {
                [`${githubDomain}:sub`]: iamRepoDeployAccess,
            },
        };

        new iam.Role(this, 'exampleGitHubDeployRole', {
            assumedBy: new iam.WebIdentityPrincipal(
                ghProvider.openIdConnectProviderArn,
                conditions
            ),
            managedPolicies: [
                iam.ManagedPolicy.fromAwsManagedPolicyName('AdministratorAccess'),
            ],
            roleName: 'soccerDbDeployRole',
            description:
                'This role is used via GitHub Actions to deploy with AWS CDK on the target AWS account',
            maxSessionDuration: cdk.Duration.hours(1),
        });
    }

}
