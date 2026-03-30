
# OSS Audit – Linux Kernel Open Source Software

## Capstone Project

### Field Details

* **Student Name:** Piyush Aggarwal
* **Registration No.:** 24BCE10387
* **Course:** Open Source Software (OSS NGMC)
* **Chosen Software:** Linux Kernel
* **License Audited:** GNU General Public License v2 (GPL v2) 

---

## About This Project

This repository is part of the Open Source Audit capstone for the OSS NGMC course. It contains five shell scripts that demonstrate practical Linux skills while exploring the Linux Kernel as an open-source project, including its origin, license, philosophy, and ecosystem.

---

## Repository Structure

```bash
oss-audit-24BCE10387/
├── script1_system_identity.sh       
├── script2_package_inspector.sh     
├── script3_disk_permission_auditor.sh 
├── script4_log_analyzer.sh          
├── script5_manifesto_generator.sh   
└── README.md                       
```

---

## Script Descriptions

### Script 1, System Identity Report

Displays a welcome screen showing the Linux distribution, kernel version, current user, home directory, system uptime, date and time, and the open-source license of the operating system, which is GPL v2 for Linux.

**Concepts used:**
variables, `echo`, command substitution `()`, `/etc/os-release` parsing, `uname`, `whoami`, `uptime`.

---

### Script 2, FOSS Package Inspector

Checks if a specified package is installed on the system. It displays its version and license, and uses a `case` statement to print a note about each FOSS project.

**Concepts used:**
`if-then-else`, `case` statement, `rpm -qi` / `dpkg -l`, `grep -E`, command-line arguments `1`, `command -v`.

---

### Script 3, Disk and Permission Auditor

Loops through a predefined list of important Linux system directories and kernel-related paths, reporting their permissions, owner, and size. It also lists currently loaded kernel modules.

**Concepts used:**
`for` loop, arrays, `ls -ld`, `du -sh`, `awk`, `cut`, `df -h`, `lsmod`.

---

### Script 4, Log File Analyzer

Reads a log file line by line using a `while read` loop. It counts how many lines match a keyword, with a default of `error`, and displays the last five matching lines. It can auto-detect log files if none are given and has a retry mechanism for empty files.

**Concepts used:**
`while IFS= read -r`, counter variables, `if-then`, `grep -i`, `tail`, command-line arguments, `$()`.

---

### Script 5, Open Source Manifesto Generator

Interactively collects three answers from the user and creates a personalized open-source philosophy statement using string concatenation. It saves the output to a `.txt` file and displays it.

**Concepts used:**
`read -p`, string concatenation with `+=`, writing to files with `>` and `>>`, `cat`, `date`, functions, input validation.

---

## Dependencies

All scripts use only standard POSIX/Bash built-ins and common Linux utilities:

| Utility            | Purpose                  | Usually pre-installed? |
| ------------------ | ------------------------ | ---------------------- |
| `bash`             | Shell interpreter        | Yes                    |
| `uname`            | Kernel/OS info           | Yes                    |
| `df`, `du`         | Disk usage               | Yes                    |
| `ls`, `awk`, `cut` | File and text processing | Yes                    |
| `grep`             | Pattern matching         | Yes                    |
| `rpm` or `dpkg`    | Package info             | Distro-dependent       |
| `lsmod`            | Kernel modules list      | Yes, most distros      |
| `bc`               | Math for percentages     | Usually yes            |

---

## How to Run Each Script on Linux

### Step 1, Clone the repository

```bash
git clone https://github.com/YOUR_USERNAME/oss-audit-24BCE10387.git
cd oss-audit-24BCE10387
```

### Step 2, Make all scripts executable

```bash
chmod +x *.sh
```

### Step 3, Run each script

#### Script 1, System Identity Report

```bash
./script1_system_identity.sh
```

#### Script 2, FOSS Package Inspector

```bash
# Check if 'git' is installed (default)
./script2_package_inspector.sh

# Check a specific package
./script2_package_inspector.sh git
./script2_package_inspector.sh firefox
./script2_package_inspector.sh python3
```

#### Script 3, Disk and Permission Auditor

```bash
./script3_disk_permission_auditor.sh
```

**Note:** Some directories like `/var/log` may show limited size info without `sudo`.

---

#### Script 4, Log File Analyzer

```bash
# Auto-detect log file, search for 'error'
./script4_log_analyzer.sh

# Specify a log file and keyword
./script4_log_analyzer.sh /var/log/syslog error
./script4_log_analyzer.sh /var/log/kern.log kernel

# On systems with /var/log/messages (Fedora/RHEL)
./script4_log_analyzer.sh /var/log/messages warning
```

---

#### Script 5, Open Source Manifesto Generator

```bash
./script5_manifesto_generator.sh
# Follow the interactive prompts
# Output is saved to manifesto_[yourusername].txt
```

---

## Notes on Linux Compatibility

* Scripts have been tested on Ubuntu 22.04 and later, Fedora 38 and later, and Debian 12.
* Script 2 checks whether the system uses `rpm` (Red Hat/Fedora) or `dpkg` (Debian/Ubuntu).
* Script 4 finds the correct log file path for your distribution.
* All scripts are written in standard Bash and avoid making distro-specific assumptions wherever possible.

---
