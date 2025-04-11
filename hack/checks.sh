#!/bin/sh

PROJECT_ROOT=$(realpath $(dirname $0)/..)

cd $PROJECT_ROOT/charts/lethe-stack/
helm dependency build

cd $PROJECT_ROOT/hack/
./check_image_tags.py
if [ $? -eq 0 ]; then
    echo "✅ check_image_tags: Success"
else
    echo "❌ check_image_tags: Failed"
    exit 1
fi

echo "✅ All checks passed successfully!"