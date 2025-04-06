#!/usr/bin/env python3

import pms_utils
import sys

repo = pms_utils.repo.Repository(sys.argv[1])
success = True

for category in repo:
    for package in category:
        for ebuild in package:
            try:
                ebuild.metadata
            except Exception as e:
                print(f"failed to validate metadata of ebuild {ebuild}, error {e}")
                success = False

if not success:
    exit(1)
