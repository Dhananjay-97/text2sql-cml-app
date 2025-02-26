import os
import subprocess

import cmlapi

root_dir = "/home/cdsw/tex2sql  " if os.getenv("IS_COMPOSABLE", "") != "" else "/home/cdsw"
os.chdir(root_dir)

print(subprocess.run(["git", "stash"], check=True))
print(subprocess.run(["git", "pull", "--rebase"], check=True))
print(subprocess.run(["bash", "scripts/refresh_project.sh"], check=True))

print(
    "Project refresh complete. Restarting the Text2SQL Application to pick up changes, if this isn't the initial deployment."
)

client = cmlapi.default_client()
project_id = os.environ["CDSW_PROJECT_ID"]
apps = client.list_applications(project_id=project_id)
if len(apps.applications) > 0:
    # find the application named "Text2SQL" and restart it
    text2sql_app = next((app for app in apps.applications if app.name == "Text2SQL"), None)
    if text2sql_app:
        app_id = text2sql_app.id
        print("Restarting app with ID: ", app_id)
        client.restart_application(application_id=app_id, project_id=project_id)
    else:
        print("No Text2SQL application found to restart. This can happen if someone renamed the application.")
        if os.getenv("IS_COMPOSABLE", "") != "":
            print("Composable environment. This is likely the initial deployment.")
        else:
            raise ValueError("Text2SQL application not found to restart")
else:
    print("No applications found to restart. This is likely the initial deployment.")
