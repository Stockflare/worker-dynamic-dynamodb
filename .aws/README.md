# AWS Cloudformation

TODO

### Dependencies

| Stack | Description |
|---|---|
| environment | Environment Configuration Cloudformation |
| network | Configures the Private VPC and its networking |
| lambda-stack-outputs | Lambda Stack Outputs Cloudformation |
| registry | Private Docker Registry hosted inside the VPC |
| kibana | Kibana Logging Cloudformation |
| ecs | The ECS Cluster configured inside the VPC |

---

### Parameters

Should be configured from the appropriate configuration file within this folder.

| Parameter | Default | Description |
|---|---|---|
| ServiceName | `null`  | Name that the service will use for its docker containers `-n ...`  |
| ServicePort | `null`  | Port that the service will bind itself to on the instance |
| ServiceImage | `null`  | The image name for the repository, should be `stockflare/api-news-source` |
| ServiceVersion | `null`  | The service version you'd like to launch, typically a git revision. |
