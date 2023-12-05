# JasperHealth
Below is the Technical Interview for JasperHealth


## Requirment to Deploy to AWS 

- Terraform CLI
- AWS Access Key
- AWS Secret Access Key


#### how to deploy code.

Retreive your AWS credentials & export as Terraform Environment Varaible

```
MacOs:
export TF_VAR_access_key=<Access_Key>
export TF_VAR_secret_access_key=<Secret_Access_Key>
---

Windows: 
$env:TF_VAR_access_key='<Access_Key>'
$env:TF_VAR_secret_access_key='<Secret_Access_Key>'

```


Terraform init & deploy

```

terraform init
terraform plan 

Deploy to AWS:

terraform apply
```

---

## Jasper Take Home Assignment – DevSecOps

### Project Brief – Cloud Function
Configure and deploy a cloud function(or similar like Lambda) into any of the big 3 cloud providers. This function should be publicly available and return a basic string like “Hello World” or whatever you want. 

__Bonus:__ Deploy the function in an automated way using any tool of your choosing.

### Guidelines
- The function is configured via IaC. It could be Terraform, something else you’re more familiar with, or something you want to experiment with.
- Use either AWS, GCP, or Azure. 
- Please don’t spend more than 2-3 hours on this project.
- We ask that you complete this project within 1 week of receiving these instructions. Please reach out if you need more time.

-----



