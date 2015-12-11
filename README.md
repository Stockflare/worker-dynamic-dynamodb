# DynamoDB Throughput Scaler

This tiny docker container uses [dynamic-dynamodb](https://github.com/sebdah/dynamic-dynamodb) in-order to flexibly scale your DynamoDB. Configuration is generated at runtime using environment variables that can be set from the `docker run` command, or injected via an env file.

> AWS NoSQL database DynamoDB is a great service, but it lacks automated throughput scaling. This is where Dynamic DynamoDB enters the stage. It provides automatic read and write provisioning for DynamoDB.

> All you need to do is to tell Dynamic DynamoDB is at which point and how much you want to scale up or down your DynamoDB tables. An example is in place. Let’s say you have way more traffic on your database during sales hours 4pm - 10pm. DynamicDB can monitor the increased throughput on your DynamoDB instance (via CloudWatch) and provision more throughput as needed. When the load is reducing Dynamic DynamoDB will sence that and automatically reduce your provisioning.

## Usage

Without an environment file:
```
docker run -e CHECK_INTERVAL=60 -e LOG_LEVEL=warning -e ... stockflare/dynamic-dynamodb
```

With an environment file:
```
docker run --env-file=.env stockflare/dynamic-dynamodb
```

## Configuration

This container also assumes that IAM Instance Profiles are being used and therefore does not provide a way for you to manually set credentials for the container.

[Confd](https://github.com/kelseyhightower/confd) is used as a onetime configuration file builder. Environment variables are used to mirror their associated configuration key, see the below examples:

```
check-interval == $CHECK_INTERVAL
reads-lower-alarm-threshold == $READS_LOWER_ALARM_THRESHOLD
```

## Configuration Defaults

| Key | Value |
|:----:|:----:|
| `AWS_REGION` | us-east-1 |
| `CHECK_INTERVAL` | 60 |
| `LOG_LEVEL` | info |
| `DYNAMODB_TABLE_REGEXP` | '.*' |
| `ENABLE_READS_AUTOSCALING` | true |
| `READS_UPPER_THRESHOLD` | 90 |
| `READS_LOWER_THRESHOLD` | 30 |
| `INCREASE_READS_WITH` | 50 |
| `DECREASE_READS_WITH` | 50 |
| `INCREASE_READS_UNIT` | percent |
| `DECREASE_READS_UNIT` | percent |
| `MIN_PROVISIONED_READS` | 1 |
| `MAX_PROVISIONED_READS` | 500 |
| `ENABLE_WRITES_AUTOSCALING` | true |
| `WRITES_UPPER_THRESHOLD` | 90 |
| `WRITES_LOWER_THRESHOLD` | 30 |
| `INCREASE_WRITES_WITH` | 50 |
| `DECREASE_WRITES_WITH` | 50 |
| `INCREASE_WRITES_UNIT` | percent |
| `DECREASE_WRITES_UNIT` | percent |
| `MIN_PROVISIONED_WRITES` | 1 |
| `MAX_PROVISIONED_WRITES` | 500 |

---

**Note:** `DYNAMODB_TABLE_REGEXP` is used to set the regular expression that the dynamic scaler will use to scale throughput on matching table names. The default is `.*`

### Optional Configuration

Additionally, some sections are disabled by default in the configuration, they can be enabled by setting the relevant environment variable below, to `"true"`:

#### `AWS_CREDENTIALS_ENABLED`
Allows the configuration of AWS Service credentials through the use of environment variables. **This is not advised.** The container assumes that an IAM Instance Profile is being used.

#### `NOTIFICATION_SERVICE_ENABLED`
Enable the SNS service that allows the DynamoDB Scaler to output notifications when scaling actions occur for the matching tables.

#### `CIRCUIT_BREAKER_ENABLED`
Cause the DynamoDB Scaler to periodically ping a specific HTTP endpoint. This endpoint must return a `200` status code for the scaler to continue to adjust throughput on the DDB Table.

#### `LOG_FILE_ENABLED`
Instead of logging output to the standard out (STDOUT), log the output to a specific file.

#### `MAINTENANCE_WINDOWS_ENABLED`
List of maintenance windows in UTC Time formats. During these windows, no scaling will occur.
