from pathlib import Path
import importlib.util


ROOT = Path(__file__).resolve().parents[1]
VALIDATOR = ROOT / "scripts" / "validate_skill.py"


def load_validator():
    spec = importlib.util.spec_from_file_location("validate_skill", VALIDATOR)
    module = importlib.util.module_from_spec(spec)
    assert spec.loader is not None
    spec.loader.exec_module(module)
    return module


def test_skill_package_is_valid():
    validator = load_validator()
    errors = validator.validate_skill(ROOT)
    assert errors == []
