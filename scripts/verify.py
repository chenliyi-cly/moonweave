#!/usr/bin/env python3
"""Reproducible compiler, unit, example, CLI and SVG acceptance gate (stdlib only)."""
import argparse
import json
import subprocess
import sys
from pathlib import Path
import xml.etree.ElementTree as ET

ROOT = Path(__file__).resolve().parents[1]


def run(args, success=True):
    result = subprocess.run(args, cwd=str(ROOT), stdout=subprocess.PIPE,
                            stderr=subprocess.PIPE, encoding="utf-8", errors="replace", timeout=180)
    if (result.returncode == 0) != success:
        raise RuntimeError("Command failed acceptance: " + repr(args) + "\n" + result.stdout + result.stderr)
    return result.stdout


def verify(target):
    for args in [["moon", "fmt", "--check"],
                 ["moon", "check", "--target", target, "--deny-warn"],
                 ["moon", "build", "--target", target],
                 ["moon", "test", "--target", target]]:
        print(run(args).strip(), flush=True)
    def cli(*args, success=True):
        return run(["moon", "run", "cmd/moonweave", "--target", target, "--", *args], success)
    assert cli("plain", "1", "1").strip() == "#.\n.#"
    doc = json.loads(cli("satin", "5", "2", "json"))
    assert doc["schema"] == "moonweave/1" and doc["shafts"] == 5
    assert all(len(row) == 4 for row in doc["lifts"])
    report = json.loads(cli("twill", "2", "2", "report"))
    assert report["repeat_size"] == {"warp": 4, "pick": 4}
    assert len(report["front"]) == 8 and len(report["back"]) == 8
    svg = ET.fromstring(cli("plain", "1", "1", "svg"))
    assert svg.attrib["viewBox"] == "0 0 32 32" and len(svg) == 3
    assert "cli.integer" in cli("plain", "oops", "1", success=False)
    assert "weave.twill" in cli("twill", "0", "2", success=False)
    for name, expected in [("plain", "平纹 8×8"), ("loom", "2/2 斜纹"), ("reconstruct", "0 个交点差异")]:
        output = run(["moon", "run", "examples/" + name, "--target", target])
        assert expected in output, (name, output)
    print("PASS " + target + ": compiler + unit tests + 3 examples + CLI/error/JSON/SVG acceptance", flush=True)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--target", choices=["wasm-gc", "wasm", "js", "native"], default="wasm-gc")
    args = parser.parse_args()
    try:
        verify(args.target)
    except (RuntimeError, AssertionError, subprocess.TimeoutExpired) as error:
        print(str(error), file=sys.stderr)
        sys.exit(1)
