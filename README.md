# Prerequisites

Before you begin, ensure you have the following prerequisites in place:

1. **AWS IAM Roles and Policies**

   The following IAM roles need to be established with proper policies:

   ```
   eb_instance_profile   = <Your-EB-Instance-Profile-ARN>
   eb_service_role       = <Your-EB-Service-Role-ARN>
   codepipeline_role_arn = <Your-CodePipeline-Role-ARN>
   ```

2. **Bitbucket Connection**

   Establish a connection to your Bitbucket repository:

   ```
   bitbucket_connection_arn = <Your-Bitbucket-Connection-ARN>
   ```

3. **Elastic Beanstalk Policy**

   Ensure that your Elastic Beanstalk service role has the necessary permissions. At a minimum, it should include the following managed policy:

 
   Depending on your specific needs, you might also need to attach additional policies or create a custom policy that includes permissions for services like S3, EC2, CloudWatch, etc.

4. **AWS CLI and Elastic Beanstalk CLI**

   Make sure you have the AWS CLI and EB CLI installed and configured with the appropriate credentials.

5. **Required Software**

   - Git
   - Your preferred code editor
   - Any language-specific dependencies for your project

Remember to replace the placeholder values (enclosed in `<>`) with your actual ARNs and other specific details.
