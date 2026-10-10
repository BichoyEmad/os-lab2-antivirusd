# Simple Antivirus Daemon

A simplified antivirus daemon: a shell script that periodically checks a directory for changes, and when a change is detected, scans the directory for files it considers malicious. Malicious files are flagged, printed to the terminal, quarantined into a separate directory, and removed from the original location. You will also build a restore tool that lets a user pick quarantined files from a list, one at a time, and decide whether each was falsely flagged or genuinely malicious.

## Folder Structure Hierarchy
```text
.
├── Makefile             # Automated task runner and environment wrapper
├── antivirusd.sh        # Core background monitoring and scanning daemon
├── restore.sh           # Interactive recovery control panel menu tool
├── .gitignore           # Excludes local runtime logs and test materials
├── test_dir/            # Monitored directory workspace (Files only)
└── quarantine_dir/      # Secure sandbox destination for isolated threats
```

## Installation

1. User should have Linux working OS
2. Create the test directory (default antivirus direrctory in the Makefile)

```bash
mkdir -p test_dir
```

## Usage

To run the antivirus daemon
```bash
make
```
To run the restore quarantined malicious files tool
```bash
make restore
```

## Flagged texts and extensions

Flagged texts and extensions are defined in and array at `antivirusd.sh`
``` bash
3	MALICIOUS_EXTS=("exe" "bat" "vbs" "scr" "ps1")
4	MALICIOUS_TEXTS=("virus" "trojan" "malware" "worm" "ransomware")
```

## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License

[MIT](https://choosealicense.com/licenses/mit/)
