# VectorQuest

VectorQuest is a Godot 4 educational prototype that teaches vector components, cartesian/polar conversion, and vector targeting through arcade-style mini-games.

## Required tools
- Godot 4.x
- Python 3.12+
- pytest

## Generate problem banks
```bash
python3 tools/python/generate_problem_bank.py --seed 42 --count 25
```

## Validate problem banks
```bash
python3 tools/python/validate_problem_bank.py
```

## Run Python tests
```bash
pytest tests/python/test_problem_bank.py
```

## Open the Godot project
1. Open Godot 4.x Project Manager.
2. Import this folder (`project.godot`).
3. Run `scenes/main/GameShell.tscn` to access both mini-games.

## Implemented mini-games
- **Vector Components Drill**: target vector display on a grid, keyboard-friendly input, tolerance-based checking, and educational feedback (submitted/correct vector, component error, magnitude, angle).
- **Vector Addition Asteroids**: stationary asteroid target, vector launch entry (cartesian or polar), hit detection with tolerance, score/streak/accuracy/time tracking.

## Next milestones
- Improve UI polish and HUD layout for retro arcade readability.
- Add guided hints and step-by-step decomposition feedback.
- Introduce medium/hard level banks and richer difficulty progression.
- Add additional reusable modes (projection puzzle, cave navigation).
