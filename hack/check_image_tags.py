#!/usr/bin/env python3

import subprocess
import re
from collections import defaultdict
import sys
import os

def collect_images():
    # Run the helm command
    try:
        result = subprocess.run(
            ["helm", "template", "-n", "venti-stack", "vs", "../charts/venti-stack/", "-f", "../charts/venti-stack/values.yaml", "-f", "../docs/venti-stack.values.test.yaml"],
            capture_output=True, text=True, check=True
        )
    except subprocess.CalledProcessError as e:
        print(f"Error executing Helm command: {e}", file=sys.stderr)
        print(f"Standard Error: {e.stderr}", file=sys.stderr)
        sys.exit(1)

    # Use regular expressions to extract image lines
    images = re.findall(r'image:\s*(?:"|\'?)([^"\'\s]*)', result.stdout)
    return sorted(set(images))

def check_and_display_images(images):
    image_map = defaultdict(set)

    for item in images:
        # Split image name and tag
        image, tag = item.rsplit(":", 1)

        # Add the tag to the image_map
        image_map[image].add(tag)

    consistent_images = []
    inconsistent_images = []

    for image, tags in image_map.items():
        tag_list = sorted(tags)
        image_with_tags = [f"{image}:{tag}" for tag in tag_list]

        if len(tags) > 1:
            for img in image_with_tags:
                inconsistent_images.append(f"❌ {img}")
        else:
            consistent_images.append(f"✅ {image_with_tags[0]}")

    # Display consistent images
    for img in consistent_images:
        print(img)

    # Display inconsistent images
    if inconsistent_images:
        for img in inconsistent_images:
            print(img)
        sys.exit(1)

print('checks...')
images = collect_images()
check_and_display_images(images)
