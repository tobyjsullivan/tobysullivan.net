deploy-staging:
	aws s3 sync ./src "s3://$$(terraform output -state=terraform.staging.tfstate s3_bucket)/"

deploy-prod:
	aws s3 sync ./src "s3://$$(terraform output s3_bucket)/"
