#!/bin/bash
# trivy-k8s-scan

echo "🔍 Scanning Docker image: $imageName"

# First scan: LOW, MEDIUM, HIGH (non-blocking)
docker run --rm -v $WORKSPACE:/root/.cache/ aquasec/trivy:0.17.2 -q image \
  --exit-code 0 --severity LOW,MEDIUM,HIGH --light $imageName
low_medium_high_exit=$?

# Second scan: CRITICAL (blocking)
docker run --rm -v $WORKSPACE:/root/.cache/ aquasec/trivy:0.17.2 -q image \
  --exit-code 1 --severity CRITICAL --light $imageName
critical_exit=$?

echo "Exit Code (CRITICAL scan): $critical_exit"

# Fail build if CRITICAL issues found
if [[ $critical_exit -eq 1 ]]; then
    echo "❌ Image scanning failed. CRITICAL vulnerabilities found."
    exit 1
else
    echo "✅ Image scanning passed. No CRITICAL vulnerabilities found."
fi
