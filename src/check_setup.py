from pathlib import Path

import pandas as pd


RAW_DATA_DIR = Path("data/raw")

csv_files = sorted(RAW_DATA_DIR.glob("*.csv"))

print(f"Pandas version: {pd.__version__}")
print(f"Number of CSV files found: {len(csv_files)}")

for file_path in csv_files:
    print(file_path.name)