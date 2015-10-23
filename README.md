# Dynamic DynamoDB

A Docker Container and associated AWS ECS Service that runs http://dynamic-dynamodb.readthedocs.org/en/latest/index.html

The service has no external configuration other than the AWS_REGION environment variable.

The entire remaining configuration is in-container in the ```config/dynamic-dynamodb.conf``` file.



By default the service will:
 - Monitor all tables and all index every 60 seconds
 - Ensure that tables have a minimum read and write capacity of 5
 - When capacity is exceeded it will be doubled
 - Maximum capacity will not exceed 500
 - When capacity is unused the the provisioned throughput will be halved.

AWS has a limit of a maximum of 4 requests to scale down throughput on any table or index in any 24 hour period, therefore you will find tables that go under heavy load will scale up as needed, however they might not scale back down to the minimum for up to 24 hours.
