DIR = test_dir
MALICIOUS_DIR = quarantine_dir
INTERVAL = 5

.PHONY: run-daemon
run-daemon: setup
	./antivirusd.sh $(DIR) $(MALICIOUS_DIR) $(INTERVAL)

.PHONY: restore
restore: setup
	./restore.sh $(DIR) $(MALICIOUS_DIR)

.PHONY: setup
setup:
	mkdir -p $(MALICIOUS_DIR)
