import subprocess
import os

root_dir = "/home/cdsw/text2sql" if os.getenv("IS_COMPOSABLE", "") != "" else "/home/cdsw"
os.chdir(root_dir)

print(subprocess.run(["python scripts/validator/validate_env.py"], shell=True, check=True))

