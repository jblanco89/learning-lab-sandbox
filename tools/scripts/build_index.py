import yaml
from pathlib import Path
from collections import defaultdict

index = defaultdict(list)

for tag_file in Path(".").rglob("tags.yml"):
    with open(tag_file) as f:
        tags = yaml.safe_load(f)

    entry = tag_file.parent.as_posix()

    for lang in tags.get("language", []):
        index[f"language:{lang}"].append(entry)

    for domain in tags.get("domain", []):
        index[f"domain:{domain}"].append(entry)

    for tech in tags.get("techniques", []):
        index[f"technique:{tech}"].append(entry)

with open("docs/index.md", "w") as out:
    out.write("# General Index\n\n")
    for key, values in sorted(index.items()):
        out.write(f"## {key}\n")
        for v in values:
            out.write(f"- {v}\n")
        out.write("\n")
