#!/bin/bash

# Use the first argument as image name or default to Dockerfile's first FROM instruction
dockerImageName=${1:-$(awk 'NR==1 {print $2}' Dockerfile)}
echo "Scanning image: $dockerImageName"

# Run Trivy scans
docker run --rm -v $WORKSPACE:/root/.cache/ aquasec/trivy:0.17.2 -q image \
  --exit-code 0 --severity HIGH --light "$dockerImageName"

docker run --rm -v $WORKSPACE:/root/.cache/ aquasec/trivy:0.17.2 -q image \
  --exit-code 1 --severity CRITICAL --light "$dockerImageName"

exit_code=$?
echo "Exit Code : $exit_code"

# Determine outcome
if [[ "$exit_code" == 1 ]]; then
    echo "❌ Image scanning failed. CRITICAL vulnerabilities found."
    exit 1
else
    echo "✅ Image scanning passed. No CRITICAL vulnerabilities found."
fi
