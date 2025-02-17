# README

## Installation and Usage Guide

This document provides installation and usage instructions for the following security and linting tools:

- **TFLint**: A Terraform linter for checking best practices and potential errors.
- **Terrascan**: A static code analyzer for Infrastructure as Code (IaC) security.
- **Trivy**: A vulnerability scanner for containers, code repositories, and cloud configurations.

---

## 1. TFLint

### Installation

#### macOS (Homebrew)

```sh
brew install tflint
```

#### Linux

```sh
curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install.sh | bash
```

#### Windows (Scoop)

```sh
scoop install tflint
```

### Configuration

Before using TFLint, create a `.tflint.hcl` file in the root of your project with the following content:

```hcl
plugin "aws" {
  enabled = true
  version = "0.24.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

plugin "azurerm" {
  enabled = true
  version = "0.24.0"
  source  = "github.com/terraform-linters/tflint-ruleset-azurerm"
}
```

Additional rules/plugins can be added manually as needed.

### Usage

#### Initialize TFLint

```sh
tflint --init
```

#### Run TFLint on a Terraform project

```sh
tflint
```

#### Run with verbose output

```sh
tflint --debug
```

---

## 2. Terrascan

### Installation

#### macOS (Homebrew)

```sh
brew install terrascan
```

#### Linux (Binary Installation)

```sh
curl -L https://github.com/tenable/terrascan/releases/latest/download/terrascan-linux-amd64 -o terrascan
chmod +x terrascan
sudo mv terrascan /usr/local/bin/
```

#### Windows

Download the latest release from [Terrascan Releases](https://github.com/tenable/terrascan/releases) and add it to your system path.

### Usage

#### Scan Terraform files

```sh
terrascan scan
```

#### Output results in JSON format

```sh
terrascan scan -o json
```

---

## 3. Trivy

### Installation

#### macOS (Homebrew)

```sh
brew install trivy
```

#### Linux (APT-based)

```sh
sudo apt install trivy
```

#### Linux (Binary Installation)

```sh
curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh
```

#### Windows

Download the latest binary from [Trivy Releases](https://github.com/aquasecurity/trivy/releases) and add it to your system path.

### Usage

#### Scan Terraform Plan Files

Trivy can scan Terraform Plan files (snapshots) or their JSON representations. To create a Terraform Plan and scan it, run the following command:

```sh
terraform plan --out tfplan
trivy config tfplan
```

To scan a Terraform Plan representation in JSON format, run the following command:

```sh
terraform show -json tfplan > tfplan.json
trivy config tfplan.json
```

#### Scan a Docker image for vulnerabilities

```sh
trivy image nginx:latest
```

#### Scan a filesystem for vulnerabilities

```sh
trivy fs .
```

#### Scan a Kubernetes cluster

```sh
trivy k8s --report summary
```

#### Generate results in JSON format

```sh
trivy image --format json -o results.json nginx:latest
```

---

## Conclusion

These tools help ensure security and best practices in Terraform, container, and cloud configurations. Regularly scan your infrastructure code and containers to maintain a secure environment.

For more details, visit:

- [TFLint Documentation](https://github.com/terraform-linters/tflint)
- [Terrascan Documentation](https://github.com/tenable/terrascan)
- [Trivy Documentation](https://github.com/aquasecurity/trivy)

