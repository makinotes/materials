#!/bin/bash
# Deploy materials site to makinote.cn/materials/
cd "$(dirname "$0")"
source .venv/bin/activate
mkdocs gh-deploy --force
