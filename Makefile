deploy-staging:
	aws s3 sync ./src "s3://$$(cd infra/staging && terraform output s3_bucket)/"

deploy-prod:
	aws s3 sync ./src "s3://$$(cd infra/prod && terraform output s3_bucket)/"
