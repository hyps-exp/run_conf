#!/usr/bin/env python3
import json
import sys
from pathlib import Path
from datetime import datetime

def main():
    if len(sys.argv) != 2:
        print("Usage: python make_conf.py <run_number>")
        sys.exit(1)

    run_number = int(sys.argv[1])
    run_key = f"{run_number:05d}"

    db_path = Path("run_conf.json")
    if not db_path.exists():
        print("Error: run_conf.json not found.")
        sys.exit(1)

    # Load database
    with db_path.open() as f:
        db = json.load(f)

    if run_key not in db:
        print(f"Error: Run {run_key} not found in database.")
        sys.exit(1)

    params = db[run_key]
    output_dir = Path("conf")
    output_dir.mkdir(parents=True, exist_ok=True)
    output_path = output_dir / f"analyzer_hyps_{run_key}.conf"
    now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    # Write configuration file
    with output_path.open("w") as f:
        f.write(f"# auto-generated configuration for run {run_key} on {now}\n\n")
        for key, value in params.items():
            f.write(f"{key + ':':<16}{value}\n")

    print(f"Configuration written to: {output_path}")

if __name__ == "__main__":
    main()
