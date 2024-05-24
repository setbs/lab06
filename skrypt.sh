#!/bin/bash 

# Function to display today's date
show_date() {
    echo "Date is: $(date)"
}

# Function to clear log files
clear_logs() {
    rm -f log*.txt
    echo "All logs were deleted"
}
clear_error() {
	rm -f -r error* 
	echo "All error dirs deleted."
}
# Function to create error files
create_errors() {
    local count=${1:-100}
    for ((i=1; i<=count; i++)); do
        mkdir -p "error${i}"
        filename="error${i}/error${i}.txt"
        echo "Filename: $filename" > "$filename"
        echo "Script: $0" >> "$filename"
        echo "Date: $(date)" >> "$filename"
    done
    echo "$count error files were created"
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

# Function to clone repository and set PATH
init_repo() {
    git clone https://github.com/relet06/lab4_narzendia_it
    export PATH=$PATH:$(pwd)/lab4_narzendia_it
    echo "Repository cloned and PATH set to $(pwd)/lab4_narzendia_it"
}

# Function to display help message
show_help() {
    echo "Usage: script.sh [OPTIONS]"
    echo "Options:" 
    echo "--date -d       Display today's date"
    echo "--logs -l [N]   Create N log files, default=100"
    echo "--help -h       Display this message"
    echo "--clear -c [-e, Clear all created files. Default clear all logs. 
                      -a]		OPTION -e clear all error dirs. OPTION -a to delete all created by skrypt files"
    echo "--init          Clone repository and set PATH"
    echo "--error -e [N]  Create N error files, default=100"
} 

# Main logic
case "$1" in 
    --date|-d)
        show_date
        ;;
    --logs|-l)
        if [ -n "$2" ]; then 
            create_logs "$2"
        else
            create_logs
        fi
        ;;
    --help|-h)
        show_help
        ;;
    --clear|-c)
        if [ "$2" = "-e" ]; then
		clear_error
	elif [ "$2" = "-a" ]; then
		clear_logs 
		clear_error	
	else
		clear_logs
	fi
        ;;
    --init)
        init_repo
        ;;
    --error|-e)
        if [ -n "$2" ]; then
            create_errors "$2"
        else
            create_errors
        fi
        ;;
    *)
        echo "Invalid option. Try --help to see available options"
        ;;
esac
