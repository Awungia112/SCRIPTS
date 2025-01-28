#!/bin/bash


function prompt_user() {
    echo "Enter source dir"
    read source
    echo "Enter dest dir"
    read dest
    echo "Enter backup file name"
    read backup
}

function create_backup() {
    prompt_user

    mkdir -p "$dest"

    tar -czf "$backup.tar.gz"  "$source" 
    mv $backup.tar.gz $dest 

}



