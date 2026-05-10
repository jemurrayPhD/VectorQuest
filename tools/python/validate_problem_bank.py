#!/usr/bin/env python3
import json
from pathlib import Path

REQUIRED = ["id","prompt","type","target_vector","tolerance","difficulty","tags"]

def validate(path: Path):
    data=json.loads(path.read_text())
    errors=[]
    for i,p in enumerate(data):
        for k in REQUIRED:
            if k not in p: errors.append(f"{path.name}[{i}] missing {k}")
        tv=p.get("target_vector",{})
        x,y=tv.get("x"),tv.get("y")
        if not isinstance(x,(int,float)) or not isinstance(y,(int,float)):
            errors.append(f"{path.name}[{i}] target_vector numeric required")
        if (x==0 and y==0) and not p.get("allow_zero_vector",False):
            errors.append(f"{path.name}[{i}] zero vector not allowed")
    return len(data), errors

def main():
    root = Path(__file__).resolve().parents[2]
    paths=[root/"data/levels/vector_components_easy.json", root/"data/levels/asteroids_vectors_easy.json"]
    total=0
    all_errors=[]
    for path in paths:
        count, errors = validate(path)
        total += count
        all_errors.extend(errors)
        print(f"{path.name}: {count} problems")
    if all_errors:
        print("Validation errors:")
        print("\n".join(all_errors))
        raise SystemExit(1)
    print(f"Validation passed for {total} problems.")

if __name__ == "__main__":
    main()
