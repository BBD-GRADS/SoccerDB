#!/usr/bin/env node
import "source-map-support/register";
import * as cdk from "aws-cdk-lib";
import { SrcStack } from "../lib/src-stack";

const app = new cdk.App();
new SrcStack(app, "SrcStack", {
  tags: {
    owner: "rudolphe@bbd.co.za",
    "created-using": "terraform",
  },
  env: { account: "683044484462", region: "eu-west-1" },
});
