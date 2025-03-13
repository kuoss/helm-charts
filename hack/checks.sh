#!/bin/sh

cd $(dirname $0)
find

./check_image_tags.py
if [ $? -eq 0 ]; then
    echo "✅ check_image_tags: Success"
else
    echo "❌ check_image_tags: Failed"
    exit 1
fi

echo "✅ All checks passed successfully!"