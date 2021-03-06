# terraform-aws-lambda-bot

A bot with AWS Lambda and Puppeteer and it is managed by Terraform. It also adds a CloudWatch event rule to trigger the bot regularly.

[chrome-aws-lambda](https://github.com/alixaxel/chrome-aws-lambda) is packaged as AWS Lambda layer to provide Chromium binary.

## Setup

```sh
# Build Chrome AWS Lambda (For AWS Lambda Layer)
chmod +x build_layer.sh
./build_layer.sh

# Build Lambda
cd src
chmod +x build_src.sh
./build_src.sh
cd ..
```

## Deploy

```sh
terraform plan -var-file="production.tfvars"
terraform apply -var-file="production.tfvars"
```

## Try

Trigger Lambda with the following event

```json
{
  "url": "https://www.google.com"
}
```
