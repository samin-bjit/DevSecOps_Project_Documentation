## CodeCommit Configuration

Step 1: Create an IAM User with AWSCodeCommitPowerUser policy.

![codecommit-IAM-user-permission.png](D:\DevSecOps_Project_Documentation\Images\codecommit-IAM-user-permission.png)

Step 2: Create Repositories

![codecommit-repositories.png](D:\DevSecOps_Project_Documentation\Images\codecommit-repositories.png)

Step 3: Add your SSH keys to the newly created user in Step 1 security credentials. Up to 5 SSH can be added per IAM user.

![Vaccine-SCM-user-IAM-Global.png](D:\DevSecOps_Project_Documentation\Images\Vaccine-SCM-user-IAM-Global.png)

![Vaccine-SCM-user-SSH-Keys.png](D:\DevSecOps_Project_Documentation\Images\Vaccine-SCM-user-SSH-Keys.png)

Step 4: Again under Security Credentials for HTTPS access to your repositories you need to generate git credentials for your account. 

![Vaccine-SCM-user-IAM-HTTPS-Git-Cred.png](D:\DevSecOps_Project_Documentation\Images\Vaccine-SCM-user-IAM-HTTPS-Git-Cred.png)

Step 5: Copy the username and password that IAM generated for you, either by showing, copying, and then pasting this information into a secure file on your local computer, or by choosing Download credentials to download this information as a .CSV file. You need this information to connect to CodeCommit.

Step 6: Check your connection by cloning one of the repositories.

----

## ECR(Elastic Container Registry) Setup

Step 1: Go over to ECR and create a private repository with a name of your choosing.

![Elastic-Container-Registry-Create-Repository.png](D:\DevSecOps_Project_Documentation\Images\Elastic-Container-Registry-Create-Repository.png)

Step 2: Next, go to Permissions>Edit JSON Policy and delete the default and set the following permissions for the repository

```json
{

  "Version": "2012-10-17",

  "Statement": [

    {

      "Effect": "Allow",

      "Principal": "*",

      "Action": [

        "ecr:BatchGetImage",

        "ecr:DescribeImages",

        "ecr:GetDownloadUrlForLayer",

        "ecr:PullImage"

      ]

    }

  ]

}
```

----

## S3 Bucket Configuration

Step 1: Go over to S3 and create a private bucket for the project. Check if the settings matches the following screenshots and keep the defaults for rest of the configurations.

![](D:\DevSecOps_Project_Documentation\Images\S3-bucket-1.png)

![](D:\DevSecOps_Project_Documentation\Images\S3-bucket-2.png)

![](D:\DevSecOps_Project_Documentation\Images\S3-bucket-3.png)



## CodePipeline Setup

The following steps will showcase the creation and configuration of a single pipeline. For our project we will create a total of 4 pipelines for each services in our Microservice application.

Step 1: 

























AWS EKS Setup

Configure the following in the machine you are going to access the cluster:  

- AWS CLI

- AWS IAM Authenticator

- Kubectl

Run the following command to get kubeconfig file for the new cluster:

Linux:

aws eks –region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)

Windows:

set region_code=region-code

set cluster_name=my-cluster

set account_id=111122223333

for /f "tokens=*" %%a in ('aws eks describe-cluster --region %region_code% --name %cluster_name% --query "cluster.endpoint" --output text') do set cluster_endpoint=%%a

for /f "tokens=*" %%a in ('aws eks describe-cluster --region %region_code% --name %cluster_name% --query "cluster.certificateAuthority.data" --output text') do set certificate_data=%%a

aws eks update-kubeconfig --region %region_code% --name %cluster_name%

aws eks –region ap-southeast-1 update-kubeconfig –name vaccination-system-eks

# AWS Load balancer Controller Configuration

## Create Identity provider

Step 1: Copy OpenIDConnect URL from EKS overview

![](https://lh4.googleusercontent.com/YI_Psh2E5PnaP_0jw7h9osFx3NQvRpNSA-MpV4K2KwPlztBVxIlX5hYnHDuZiVUcHKshspD6X4Qxa2Qy_sRSnrxR2UTCbshRxbfHo4sOzUTV0f3ijs4yYJzO_CpVVwsqh_gdwcXiECmXzeX6PbHfUbPgqv3hjHEA)

Step 2: Go to IAM console>Identity Provider and create a OpenID Connect provider using the connector provider URL copied in the earlier step. Use sts.amazonaws.com as the audience.![](https://lh4.googleusercontent.com/YDHbuMepmIUFaH1lM2_SiVtfemCNQhv_x8MA6_He5W_XwdwtmaHpGx0sCU-ECRy2Uml4dSM54VujP9BjHG_uQ_lwcXP99pAwRNIpy04AHspSOixiydRBZ8vg-QZqMIA7EZThDDxN9PoktoaTBvgLIpRAB7_qDUt1)

Step 3: Now create an IAM policy from AWS load balancer controller documentation for the version you are using. I am using v2.6.1 in this project.  
https://github.com/kubernetes-sigs/aws-load-balancer-controller/blob/v2.6.1/docs/install/iam_policy.json


