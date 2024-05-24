#!/bin/bash 

# Date function
show_date() {
    echo "Date is: $(date)"
}
#Clear log 
dellog() {
	rm -f log*.txt
	echo "All logs was deleted"
}

# Function to create log files
create_logs() { 
    local count=${1:-100}
    for ((i=1; i<=count; i++)); do
        filename="log${i}.txt"
        echo "Filename: $filename" > "$filename"
        echo "Script: $0" >> "$filename"
        echo "Date: $(date)" >> "$filename"
    done
    echo "$count log files were created"
}

# Help function
show_help() {
    echo "Usage: script.sh [OPTIONS]"
    echo "Options:" 
    echo "--date        Display today's date"
    echo "--logs [N]    Create N log files, default=100"
    echo "--help        Display this message"
	echo "--dellog 		I added this func to clear my disk from this files while i testing sktypt"
} 

# Main logic
case "$1" in 
    --date)
        show_date
        ;;
    --logs)
        if [ -n "$2" ]; then 
            create_logs "$2"
        else
            create_logs
        fi
        ;;
    --help)
        show_help
        ;;
	--dellog)
		dellog
	;;
    *)
        echo "Invalid option. Try --help to see available options and use GUI"
        ;;
esac
