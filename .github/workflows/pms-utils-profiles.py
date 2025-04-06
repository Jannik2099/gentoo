#!/usr/bin/env python3

import concurrent.futures
from pathlib import Path
from typing import Optional
import pms_utils
import sys

repo = pms_utils.repo.Repository(sys.argv[1])


with open(repo.path / "profiles" / "profiles.desc") as f:
    lines = filter(lambda x: not x.startswith("#") and len(x) > 1, f.readlines())

profiles = map(lambda x: x.split()[1], lines)


def check_profile(path: Path) -> Optional[str]:
    profile_path = repo.path / "profiles" / path
    try:
        pms_utils.profile.Profile(profile_path)
    except Exception as e:
        return f"failed to validate profile {path}, error {e}"
    return None


success = True

with concurrent.futures.ProcessPoolExecutor() as pool:
    results = pool.map(check_profile, profiles)
    failures = filter(None, results)
    for failure in failures:
        print(failure)
        success = False

if not success:
    exit(1)
