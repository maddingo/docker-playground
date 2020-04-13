#!/bin/bash
eksctl create cluster \
--name plantuml \
--version 1.14 \
--region eu-central-1 \
--nodegroup-name plantuml-workers \
--node-type t3.micro \
--nodes 1 \
--nodes-min 1 \
--nodes-max 1 \
--ssh-access \
--ssh-public-key ~/.ssh/id_rsa.pub \
--managed
