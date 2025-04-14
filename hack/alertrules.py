#!/usr/bin/env python3

import requests
import yaml

# Define the sections with name, prefix, and URL
sections = [
    {
        'name': 'kubernetes',
        'prefix': 'k',
        'url': 'https://raw.githubusercontent.com/samber/awesome-prometheus-alerts/refs/heads/master/dist/rules/kubernetes/kubestate-exporter.yml'
    },
    {
        'name': 'node',
        'prefix': 'n',
        'url': 'https://raw.githubusercontent.com/samber/awesome-prometheus-alerts/master/dist/rules/host-and-hardware/node-exporter.yml'
    },
    {
        'name': 'prometheus',
        'prefix': 'p',
        'url': 'https://raw.githubusercontent.com/samber/awesome-prometheus-alerts/refs/heads/master/dist/rules/prometheus-self-monitoring/embedded-exporter.yml'
    }
]

# Initialize dictionary to hold transformed rules for each section
awesome_rules = {
    section['name']: {'enabled': True, 'rules': {}} for section in sections
}

for section in sections:
    prefix = section['prefix']
    url = section['url']

    # Download each YAML file
    response = requests.get(url)

    if response.status_code != 200:
        print(f"Failed to download file from {url}. Status code: {response.status_code}")
        continue

    # Parse the YAML content
    parsed_data = yaml.safe_load(response.text)

    # Transform the content
    for index, rule in enumerate(parsed_data['groups'][0]['rules'], start=1):
        key = f'{prefix}{str(index).zfill(2)}'
        
        # Change 'Host' to 'Node' in the alert name for 'node' prefix
        alert_name = rule['alert']
        if prefix == 'n':
            alert_name = alert_name.replace('Host', 'Node')

        # Disable rules with 'predict_linear' in the expression
        enabled = True
        if 'predict_linear' in rule['expr']:
            enabled = False

        description = rule['annotations']['description']
        description = description.replace('\n  VALUE = {{ $value }}\n  LABELS = {{ $labels }}', '')
        description += ' ({{ $value }})'
        
        info = rule['annotations']['summary'] 
        info = info.split('(')[-1].split(')')[0]
        
        summary = f'({info}) {description}'
        summary = summary.replace('"', '')
        summary = summary.replace(':', '')
                
        transformed_data = {
            'alert': f'{key}-{alert_name}',
            'expr': rule['expr'],
            'severity': rule['labels']['severity'],
            'summary': summary,
            'enabled': enabled,
        }
        
        # Add 'for' if it exists in the rule
        if 'for' in rule:
            transformed_data['for'] = rule['for']

        # Disable rules with 'predict_linear' in the expression

        # Store the transformed rule in the appropriate section
        awesome_rules[section['name']]['rules'][key] = transformed_data

# Wrap the content into the required top-level structure under 'venti'
output_data = {
    'venti': {
        'config': {
            'alertRules': {
                'defaultRules': {
                    'enabled': True,
                    **awesome_rules
                }
            }
        }
    }
}

# Define the new filename
output_filename = 'venti-stack_values_defaultRules.yaml'

# Add a comment indicating the script used for generation
yaml_comment = "# This file is generated by `make alertrules`\n"

# Save all transformed data to the output file
with open(output_filename, 'w') as outfile:
    outfile.write(yaml_comment)
    yaml.dump(output_data, outfile, width=float("inf"), default_flow_style=False)

print(f"Transformation and saving completed successfully. Output saved to {output_filename}.")

