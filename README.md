# Simple Antivirus Daemon

A simplified antivirus daemon: a shell script that periodically checks a directory for changes, and when a change is detected, scans the directory for files it considers malicious. Malicious files are flagged, printed to the terminal, quarantined into a separate directory, and removed from the original location. You will also build a restore tool that lets a user pick quarantined files from a list, one at a time, and decide whether each was falsely flagged or genuinely malicious.

## Folder Structure Hierarchy
```text
.
├── Makefile             # Automated task runner and environment wrapper
├── antivirusd.sh        # Core background monitoring and scanning daemon
├── antivirus-cron.sh    # antivirus deamon with cron job scheduling
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
3. Add cron Jobs in Linux
``` bash
# Check cron service on Linux system
sudo systemctl status cron.service
```

## Cron job syntax

```bash
# Cron job example
* * * * * sh /path/to/script.sh
```
``` bash
*   *   *   *   *  sh /path/to/script/script.sh
|   |   |   |   |              |
|   |   |   |   |      Command or Script to Execute        
|   |   |   |   |
|   |   |   |   |
|   |   |   |   |
|   |   |   | Day of the Week(0-6)
|   |   |   |
|   |   | Month of the Year(1-12)
|   |   |
|   | Day of the Month(1-31)  
|   |
| Hour(0-23)  
|
Min(0-59)
```

####

## Usage

To schedule daemon to be run every 1 minute at second 23

```bash
* * * * * sleep 23 && /home/user/labs/antivirus/antivirus-cron.sh /home/user/labs/antivirus/test_dir /home/user/labs/antivirus/quarantine_dir
```

To schedule daemon to be run every 3rd Friday of the month at 12:31 am

```bash
31 0 15-21 * 5 sh /home/user/labs/antivirus/antivirus-cron.sh /home/user/labs/antivirus/test_dir /home/user/labs/antivirus/quarantine_dir
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
