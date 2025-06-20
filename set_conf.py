#!/usr/bin/env python3
import sys
import json
from pathlib import Path

def parse_conf_file(conf_path: Path):
    """Parse analyzer.conf file into key-value pairs."""
    params = {}
    with conf_path.open() as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith("#"):
                continue
            if ":" in line:
                key, value = line.split(":", 1)
                params[key.strip()] = value.strip()
    params["REF"] = conf_path.name
    return params

def load_database(db_path: Path):
    if db_path.exists():
        with db_path.open() as f:
            return json.load(f)
    else:
        return {}

def save_database(db_path: Path, db):
    with db_path.open("w") as f:
        json.dump(db, f, indent=4)

def add_range_to_db(db, run_min, run_max, params):
    for run in range(run_min, run_max + 1):
        run_key = f"{run:05d}"
        db[run_key] = dict(params)
        print(f"Added run {run_key}")
    return db

def main():
    if len(sys.argv) != 4:
        print("Usage: python set_conf.py <run_min> <run_max> <conf_file>")
        sys.exit(1)

    run_min = int(sys.argv[1])
    run_max = int(sys.argv[2])
    conf_file = Path(sys.argv[3])

    if run_max < run_min:
        print("Error: max_run must be greater than or equal to min_run.")
        sys.exit(1)

    if not conf_file.exists():
        print(f"Error: conf file '{conf_file}' does not exist.")
        sys.exit(1)

    db_path = Path("run_conf.json")
    db = load_database(db_path)
    params = parse_conf_file(conf_file)
    db = add_range_to_db(db, run_min, run_max, params)
    save_database(db_path, db)

    print(f"Updated {db_path} with runs {run_min} to {run_max}.")

if __name__ == "__main__":
    main()

