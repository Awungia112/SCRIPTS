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
	temp_dir="/tmp/backup_temp_dir"

	mkdir -p "$dest"
	mkdir -p "$temp_dir"

	cp -r "$source" "$temp_dir"
	tar -czf "$dest/$backup.tar.gz" -C "$temp_dir" .
	rm -rf "$temp_dir"
}

# Order of exec
prompt_user
create_backup
