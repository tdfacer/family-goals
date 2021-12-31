# family-goals

## init

* Configured project using existing s3/dynamo locking
* Followed [these](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs) instructions for mongodbatlas provider
* Make sure to use tags from module (tdfacer/terrafacer), then update `main.tf` and run `terraform init` to pull in module changes

## import

If using the free-tier Atlas cluster, the API will not support creation. To get around this, one can create the cluster via the console then import the resource. This is done by:

1. Deploying the stack with `create_cluster` set to false
2. Navigating through the Atlas UI to the newly created project
3. Creating a new "Database," making sure to specify the free tier
4. Once complete, using `terraform import` to import the cluster

* Note: you will need the project ID for the import command
* ID can can obtained by executing  `terraform state show module.atlas_cluster.mongodbatlas_project.project`
* Import command for the cluster: `terraform import module.atlas_cluster.mongodbatlas_cluster.cluster-test <project_id>-<cluster_name>[0]`
  * Note: Make sure to include the index, `[0]` suffix, or because we are using `count` in the module
  * If the count is not specified, terraform will detect a resource change and try to replace the cluster with this action specified: `delete_because_wrong_repetition`

## Secrets

### Get secret from access key

* `terraform show -json | jq -r '.values.root_module.child_modules[].resources[] | select(.name|contains("access_key")) |.values.id,.values.secret'`

### Add secret to github repo

* Go to settings -> secrets
* Add new repository secret
* Add `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, and `AWS_REGION`
