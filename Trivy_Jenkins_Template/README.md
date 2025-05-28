# Trivy Jenkins Pipeline Template

This repository contains a reusable script and Jenkins pipeline template for running Trivy vulnerability scans on Docker images.

## 📁 Files

- `trivy-docker-image-scan.sh`: Shell script that runs Trivy and exits based on vulnerabilities.
- `Jenkinsfile`: Sample Jenkins pipeline with Trivy integration.
- `README.md`: Setup and usage instructions.

## 🚀 Usage

1. Clone or copy this repo into your project.
2. Make the script executable:
   ```bash
   chmod +x trivy-docker-image-scan.sh
