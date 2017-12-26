#!/usr/bin/env python
import os
import sys

if __name__ == "__main__":
    if len(sys.argv) > 3:
        run_arg = sys.argv[2]
        if not run_arg.startswith('--settings'):
            os.environ.setdefault("DJANGO_SETTINGS_MODULE", "admin.settings.settings")
    else:
        os.environ.setdefault("DJANGO_SETTINGS_MODULE", "admin.settings.settings")

    from django.core.management import execute_from_command_line

    execute_from_command_line(sys.argv)
