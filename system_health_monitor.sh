#!/bin/bash

# Thresholds
CPU_THRESHOLD=75
DISK_THRESHOLD=80
MEM_THRESHOLD=80


# macOS-specific command to check CPU usage (average of idle percentage subtracted from 100)
check_cpu() {
    cpu_usage=$(top -l 1 | awk '/CPU usage/ {print 100 - $7}' | sed 's/%//')
    echo "CPU Usage: $cpu_usage"
    if (( $(echo "$cpu_usage > $CPU_THRESHOLD" | bc -l) )); then
        osascript -e 'display notification "CPU usage is above threshold at '"$cpu_usage"'%" with title "High CPU Usage"'
        echo "High CPU Usage: $cpu_usage%"
    fi
}

# Function to check Disk usage (on root volume)
check_disk() {
    disk_usage=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')
    echo "Disk Usage: $disk_usage"
    if [ $disk_usage -gt $DISK_THRESHOLD ]; then
        osascript -e 'display notification "Disk usage is above threshold at '"$disk_usage"'%" with title "High Disk Usage"'
        echo "High Disk Usage: $disk_usage%"
    fi
}

# Function to check Memory usage
check_memory() {
    mem_usage=$(vm_stat | grep "Pages free:" | awk '{print $3}' | sed 's/\.//')
    total_mem=$(sysctl -n hw.memsize)
    mem_free=$(echo "$mem_usage * 4096" | bc -l)
    mem_usage=$(echo "(1 - $mem_free / $total_mem) * 100" | bc -l)
    echo "Memory Usage: $mem_usage"
    if (( $(echo "$mem_usage > $MEM_THRESHOLD" | bc -l) )); then
        osascript -e 'display notification "Memory usage is above threshold at '"$mem_usage"'%" with title "High Memory Usage"'
        echo "High Memory Usage: $mem_usage%"
    fi
}

check_top_processes() {
    echo "Top 5 CPU consuming processes:"
    echo -e "PID\t%CPU\tCOMMAND"
    top -l 1 -o cpu | awk 'NR>10 && NR<=15 {print $1 "\t" $3 "\t" $12}'

    echo ""
    echo "Top 5 Memory consuming processes:"
    echo -e "PID\t%MEM\tCOMMAND"
    top -l 1 -o mem | awk 'NR>10 && NR<=15 {print $1 "\t" $5 "\t" $12}'
}


# Main
check_cpu
check_disk
check_memory
check_top_processes