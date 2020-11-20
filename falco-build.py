#!/usr/bin/env python3

import yaml
import subprocess
import os
import shlex
import datetime

TEMP_BUILD_FILE = "_falco_build_combined.sh"

with open("falco/.circleci/config.yml") as f:
    config = yaml.safe_load(f)

job_config = config["jobs"]["build/ubuntu-focal-debug"]



docker_image = job_config["docker"][0]["image"]
print("Running with docker image: {0}".format(docker_image))
print()
print("Steps ==>")

for step in job_config["steps"]:
    if step == "checkout":
        continue
    print("  ", step["run"]["name"])

cwd = os.getcwd()

p = subprocess.run(["/usr/bin/docker", "run", "-d", "--mount", "type=bind,source=" + cwd + "/falco,target=/falco", "ubuntu:focal", "sleep", "infinity"], stdout=subprocess.PIPE)

cid = p.stdout.decode("utf-8").strip()
print(cid)
print("docker container id is {0}".format(cid))

try:
    os.remove(TEMP_BUILD_FILE)
except FileNotFoundError:
    pass

intro = """
#!/bin/bash

echo "Falco Build script (generated from circleci) on {0}"
cd /falco
rm -fr build

""".format(datetime.datetime.now())

with open(TEMP_BUILD_FILE, "w") as f:
    f.write(intro)
    for step in job_config["steps"]:
        if step == "checkout":
            continue
        print("  ", step["run"]["name"])
        echo = "echo " + step["run"]["name"] + "\n"
        cmd = step["run"]["command"] + "\n"
        f.write(echo)
        f.write(cmd)
        f.write("\n\n")

os.chmod(TEMP_BUILD_FILE, 0o755)
print("Your script is ready")
print("{0}".format(TEMP_BUILD_FILE))
subprocess.run(["/usr/bin/docker", "cp", TEMP_BUILD_FILE, cid + ":/falco/build.sh"])
print("docker exec -w '/falco' -it {0} /bin/bash /falco/build.sh".format(cid))

