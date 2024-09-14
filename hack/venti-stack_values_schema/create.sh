#!/bin/bash

# Stop the script on any errors or unset variables, and treat errors in pipelines
set -euo pipefail

# Navigate to the directory where the script is located
cd "$(dirname "$0")"

###
### STEP 1: Download Prometheus values.schema.json
###

# Extract the Prometheus version from venti-stack Chart.yaml using yq
PROMETHEUS_CHART_VERSION=$(yq '.dependencies[] | select(.name == "prometheus") | .version' ../../charts/venti-stack/Chart.yaml)

# Define URLs and file paths
PROMETHEUS_SCHEMA_URL="https://raw.githubusercontent.com/prometheus-community/helm-charts/prometheus-${PROMETHEUS_CHART_VERSION}/charts/prometheus/values.schema.json"
PROMETHEUS_SCHEMA_FILE='prometheus.values.schema.json'
FLUENT_BIT_SCHEMA_FILE='fluent-bit.values.schema.json'
BASE_SCHEMA_FILE='venti-stack.base.values.schema.json'
MERGED_SCHEMA_FILE='../../charts/venti-stack/values.schema.json'

# Remove the previous Prometheus schema file if it exists
rm -f "$PROMETHEUS_SCHEMA_FILE"

# Download Prometheus values.schema.json
curl -sS -L "$PROMETHEUS_SCHEMA_URL" -o "$PROMETHEUS_SCHEMA_FILE"

# Ensure the Prometheus schema file was downloaded successfully
if [ ! -f "$PROMETHEUS_SCHEMA_FILE" ]; then
  echo 'Error 1: Prometheus schema file not found'
  exit 1
fi

# Validate the structure of the Prometheus schema file
jq -e '.properties.server.type == "object"' "$PROMETHEUS_SCHEMA_FILE" > /dev/null || {
  echo 'Error 2: .properties.server.type is not "object"'
  exit 2
}

###
### STEP 2: Merge Prometheus and Fluent-bit schemas into the base schema file
###

# Remove the previous merged schema file if it exists
rm -f "$MERGED_SCHEMA_FILE"

# Merge Prometheus and Fluent-bit schemas into the base schema
jq \
  --slurpfile prometheus "$PROMETHEUS_SCHEMA_FILE" \
  --slurpfile fluent_bit "$FLUENT_BIT_SCHEMA_FILE" \
  '.properties["prometheus"] = $prometheus[0].properties | .properties["fluent-bit"] = $fluent_bit[0].properties' \
  "$BASE_SCHEMA_FILE" > "$MERGED_SCHEMA_FILE"

# Ensure the merged schema file was created successfully
if [ ! -f "$MERGED_SCHEMA_FILE" ]; then
  echo 'Error 3: Merged schema file not found'
  exit 3
fi

# Validate the structure of the merged schema file for Prometheus
jq -e '.properties["prometheus"].server.type == "object"' "$MERGED_SCHEMA_FILE" > /dev/null || {
  echo 'Error 4: .properties["prometheus"].server.type is not "object"'
  exit 4
}

# Validate the structure of the merged schema file for Fluent-bit
jq -e '.properties["fluent-bit"].image.type == "object"' "$MERGED_SCHEMA_FILE" > /dev/null || {
  echo 'Error 5: .properties["fluent-bit"].image.type is not "object"'
  exit 5
}

# Output success message
echo "Schema merge completed successfully. Result file: $MERGED_SCHEMA_FILE"
