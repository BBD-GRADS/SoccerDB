#!/usr/bin/env node
import "source-map-support/register";
import * as cdk from "aws-cdk-lib";
import { SoccerDbStack } from "../lib/soccer-db-stack";

const app = new cdk.App();
new SoccerDbStack(app, "soccerDbStack", {
    tags: {
        owner: "jacques.mouton@bbd.co.za",
        "created-using": "cdk",
    },
    env: { account: "683044484462", region: "eu-west-1" },
    repositoryConfig: [
        { owner: 'jmouton19', repo: 'SoccerDB' }
    ]
});
