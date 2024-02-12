import * as cdk from "aws-cdk-lib";

export interface GitHubStackProps extends cdk.StackProps {
    repositoryConfig: { owner: string; repo: string; filter?: string }[];
}
