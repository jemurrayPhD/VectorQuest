#!/usr/bin/env python3
import argparse, json, random
from pathlib import Path

def nonzero_vec(rng):
    while True:
        x, y = rng.randint(-8, 8), rng.randint(-8, 8)
        if x != 0 or y != 0:
            return x, y

def build(kind: str, count: int, seed: int):
    rng = random.Random(seed)
    out = []
    for i in range(count):
        x, y = nonzero_vec(rng)
        out.append({
            "id": f"{kind}_easy_{i+1:03d}",
            "prompt": "Enter the vector components." if kind=="vector_components" else "Launch to hit the asteroid target.",
            "type": kind,
            "given_vectors": [],
            "target_vector": {"x": x, "y": y},
            "answer_mode": "cartesian_or_polar",
            "tolerance": 0.5,
            "difficulty": "easy",
            "tags": ["vectors", "intro", kind],
        })
    return out

def main():
    p=argparse.ArgumentParser()
    p.add_argument("--seed", type=int, default=42)
    p.add_argument("--count", type=int, default=30)
    args=p.parse_args()
    root = Path(__file__).resolve().parents[2]
    levels = root / "data" / "levels"
    levels.mkdir(parents=True, exist_ok=True)
    (levels / "vector_components_easy.json").write_text(json.dumps(build("vector_components", args.count, args.seed), indent=2))
    (levels / "asteroids_vectors_easy.json").write_text(json.dumps(build("asteroids_targeting", args.count, args.seed+1), indent=2))
    print("Generated problem banks in", levels)

if __name__ == "__main__":
    main()
