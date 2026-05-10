import json
from pathlib import Path
from math import hypot, isclose, cos, sin, radians, atan2, degrees

ROOT = Path(__file__).resolve().parents[2]

def load(name):
    return json.loads((ROOT / "data" / "levels" / name).read_text())

def test_required_fields_present():
    for name in ["vector_components_easy.json", "asteroids_vectors_easy.json"]:
        for p in load(name):
            for key in ["id","prompt","type","target_vector","tolerance","difficulty","tags"]:
                assert key in p

def test_vectors_nonzero():
    for name in ["vector_components_easy.json", "asteroids_vectors_easy.json"]:
        for p in load(name):
            x,y=p["target_vector"]["x"],p["target_vector"]["y"]
            assert not (x==0 and y==0)

def test_cartesian_polar_consistency():
    x, y = 3.0, 4.0
    mag = hypot(x,y)
    ang = degrees(atan2(y,x))
    rx = cos(radians(ang))*mag
    ry = sin(radians(ang))*mag
    assert isclose(rx, x, abs_tol=1e-6)
    assert isclose(ry, y, abs_tol=1e-6)
