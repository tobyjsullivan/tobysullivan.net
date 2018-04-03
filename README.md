# tobysullivan.net

TobySullivan.net - Personal Website

## Infrastructure

Deploy infrastructure with terraform.

### Production

```
terraform apply -var "cloudflare_email=${CLOUDFLARE_EMAIL}" -var "cloudflare_token=${CLOUDFLARE_API_KEY}" ./infra
```

### Staging

```
terraform apply -state=terraform.staging.tfstate -var 'env=staging' -var 'domain=staging.tobysullivan.net' -var 'cloudflare_domain=tobysullivan.net' -var "cloudflare_email=${CLOUDFLARE_EMAIL}" -var "cloudflare_token=${CLOUDFLARE_API_KEY}" ./infra
```

## Deploy

### Production

```
make deploy-prod
```

### Staging

```
make deploy-staging
```
