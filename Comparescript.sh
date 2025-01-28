#!/bin/bash

usage () {
        # Specify usage of sscript
        echo "$0 <directory_path> [-r] [--fix]"
        echo "-r : search recursively within the specified directory"
        echo "--fix : deletes duplicate files"
        echo "--help: usage"
        exit 1
}

recursive=false
fix=false

if [[ $# -lt 1 ]]; then 
        usage
fi

directory=$1
shift

if [[ ! -d "$directory" ]]; then
        echo "$directory is not a valid directory"
        exit 1
fi


while [[ $# -gt 0 ]]; do
        case $1 in 
                -r) recursive=true; shift ;;
                --fix) fix=true; shift ;;
                -h|--help) usage ;;
                *) echo "Error: Invalid option $1"; usage ;;
        esac
done

remove_duplicates() {
    local dir=$1
    declare -A file_map  # Associative array to store checksums and file paths

    # Print table header
    printf "%-50s %-10s\n" "File Path" "Duplicate"
    printf "%-50s %-10s\n" "---------" "---------"

    # Find files (recursively or not)
    if $recursive; then
        files=$(find "$dir" -type f)
    else
        files=$(find "$dir" -maxdepth 1 -type f)
    fi

    # Process files
    for file in $files; do
        checksum=$(md5sum "$file" | awk '{print $1}')
        if [[ -v file_map["$checksum"] ]]; then
            printf "%-50s %-10s\n" "$file" "Yes (${file_map["$checksum"]})"
            if $fix; then
                read -p "Delete duplicate file '$file'? [y/N]: " confirm
                if [[ $confirm == [yY] ]]; then
                    rm "$file"
                    echo "Deleted: $file"
                fi
            fi
        else
            file_map["$checksum"]=$file
            printf "%-50s %-10s\n" "$file" "No"
        fi
    done
}

remove_duplicates "$directory"


