#!/bin/bash
LOG_FILE="access.log"
REPORT_FILE="report.txt"

total_requests=$(awk 'END {print NR}' "$LOG_FILE")

unique_ips=$(awk '{print $1}' "$LOG_FILE" | sort | uniq | wc -l)

methods=$(awk '{print $6}' "$LOG_FILE" | tr -d '"' | sort | uniq -c | awk '{printf "%s: %s\n", $2, $1}')

popular_url_data=$(awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -1)

popular_url_count=$(echo "$popular_url_data" | awk '{print $1}')

popular_url_path=$(echo "$popular_url_data" | awk '{print $2}')

{
    echo "Logs report:"
    echo "=============="
    echo "Total requests: $total_requests"
    echo "Unique IP count: $unique_ips"
    echo "=============="
    echo "Requests by methods:"
    echo "$methods"
    echo "=============="
    echo "Most popular URL: $popular_url_count"
    echo "$popular_url_path"
} > "$REPORT_FILE"

echo "Report created here: $REPORT_FILE"
