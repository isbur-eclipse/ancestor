import json


newItem = {
    "name": "",
    "source": {
        "git_url": ""
        "docker_url": ""
    },
    "target": {
        "git_url": ""
        "docker_url": ""
    },
    "Description":""
}


with open("registry.json") as registry_file:
    Registry = json.load(registry_file)