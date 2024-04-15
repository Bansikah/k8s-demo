## Commands used
```
alias tf=terraform
terraform -help
tf init
tf plan
tf apply
tf show
terraform fmt command automatically updates configurations in the current directory for readability and consistency.
```

It’s also possible to make sure your configuration is syntactically valid and internally consistent by using the ``terraform validate`` command.

With ``terraform apply`` command Terraform will print the execution plan which describes the actions Terraform will take to change your infrastructure to match the configuration.

In this case the (+) near the resource “docker_container” “nginx” means that Terraform will create this resource.

Terraform will now pause and wait for your approval before proceeding. So typing “yes” Terraform will proceed with the real execution.

After creation point your browser to the VM ip (you can get this using Linux command “ip addr list”) and ``:8000 (in my case 0.0.0.0:8000)``

# Terraform State

Terraform wrote data into a file called ``terraform.tfstate`` to store the IDs and properties of the resources. Terraform state file is the only way Terraform can track which resources it manages so you must store your state file securely and restrict access to only trusted team members who need to manage your infrastructure.

In production, we recommend storing your state remotely with Terraform Cloud or Terraform Enterprise. In general, Terraform supports the following backends:

``local:`` The local backend stores state on the local filesystem, locks that state using system APIs and performs operations locally
``remote:`` The remote backend is unique among all other Terraform backends because it can both store state snapshots and execute operations for Terraform Cloud’s CLI-driven run workflow. It used to be called an “enhanced” backend
``azurerm:`` Stores the state as a Blob with the given Key within the Blob Container within the Blob Storage Account
``consul:`` Stores the state in the Consul KV store at a given path (support state locking)

``cos:`` Stores the state as an object in a configurable prefix in a given bucket on Tencent Cloud Object Storage (COS) (support state locking)
``gcs:`` Stores the state as an object in a configurable prefix in a pre-existing bucket on Google Cloud Storage (GCS). The bucket must exist before configuring the backend. (support state locking)

``http:`` Stores the state using a simple REST client. The state will be fetched via GET, updated via POST, and purged with DELETE. The method used for updating is configurable.
``Kubernetes:`` Stores the state in a Kubernetes secret (support state locking)

``oss:`` Stores the state as a given key in a given bucket on Stores Alibaba Cloud OSS. This backend also supports state locking and consistency checking via Alibaba Cloud Table Store, which can be enabled by setting the tablestore_table field to an existing TableStore table name
``pg:`` Stores the state in a Postgres database version 10 or newer (support state locking)

``S3:`` Stores the state as a given key in a given bucket on Amazon S3. This backend also supports state locking and consistency checking via Dynamo DB, which can be enabled by setting the dynamodb_table field to an existing DynamoDB table name
To Inspect the current state, use ``terraform show``

To Manually manage the state, Terraform has a built-in command called terraform state. Eg: terraform state list to list the resources in the project:
[Source](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build)

# Updating and Deleting configurations and infrastructures
Infrastructure is continuously evolving, and Terraform helps you manage that change. As you change Terraform configurations, Terraform builds an execution plan that only modifies what is necessary to reach your desired state.

When using Terraform in production, we recommend that you use a version control system to manage your configuration files and store your state in a remote backend such as Terraform Cloud or Terraform Enterprise.

To see a change in action, just modify the port mapping with 8888 as the external port
Execute terraform apply to preview the execution and apply the changes:

The prefix ``-/+`` means that Terraform will destroy and recreate the resource, rather than updating it in place. Terraform can update some attributes in place (indicated by the ~ prefix) but changing the port the container must be destroyed.

Type yes to confirm and check the correctness by pointing the browser to ``http://<VM_ip>:8888``

Source: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-change

Once you no longer need infrastructure, you may want to destroy it to reduce your security exposure and costs. For example, you may remove a production environment from service, or manage short-lived environments like building or testing systems.

The ``terraform destroy`` command terminates resources managed by your Terraform project. Like an update, Terraform will preview the execution using the ``-`` prefix which indicates that the instance will be destroyed.

Source: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-destroy 

- Installing terraform on ubuntu
```
https://zerotomastery.io/cheatsheets/terraform-cheat-sheet/#declaring-variables


https://blog.linoproject.net/terraform-study-notes-terraform-basics-and-workflow/
```