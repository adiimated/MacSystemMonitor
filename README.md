# MacSystemMonitor

This script is designed to monitor the health of your macOS system, checking for CPU, disk, and memory usage. If any of these metrics exceed predefined thresholds, the script will trigger a desktop notification to alert the user. Additionally, it lists the top 5 CPU and memory-consuming processes.

## Usage

1. Clone the repository or download the script
```
git clone https://github.com/adiimated/MacSystemMonitor.git
```
2. Make the script executable: 
```
chmod +x system_health_monitor.sh
```
3. To run the script, navigate to its directory in the terminal and execute it by typing:
```
./system_health_monitor.sh
```

## What the Script Does

1. CPU Usage Check: Alerts if CPU usage is above the defined threshold.
2. Disk Usage Check: Alerts if disk usage on the root volume is above the defined threshold.
3. Memory Usage Check: Alerts if memory usage is above the defined threshold.
4. Process Check: Lists the top 5 processes consuming the most CPU and memory.

## Configurable Thresholds
You can adjust the following thresholds at the top of the script according to your needs:
`CPU_THRESHOLD`, `DISK_THRESHOLD` and `MEM_THRESHOLD`.

## Notifications
Alerts are displayed as desktop notifications using osascript, which is part of macOS's automation tools.

Feel free to fork the project and submit pull requests with enhancements or fixes.
