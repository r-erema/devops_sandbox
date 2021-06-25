A company is storing an access key (access key ID and secret access key) in a text file on a custom AMI.
The company uses the access key to access DynamoDB tables from instances created from the AMI.
The security team has mandated a more secure solution. Which solution will meet the security team’s mandate?

A. Put the access key in an S3 bucket, and retrieve the access key on boot from the instance.  
B. Pass the access key to the instances through instance user data.  
C. Obtain the access key from a key server launched in a private subnet.  
**D. Create an IAM role with permissions to access the table, and launch all instances with the new role.**
