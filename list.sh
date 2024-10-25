#!/bin/bash

tasks_file="todo_list.txt"
touch "$tasks_file"

function get_tasks() {
	# Add tasks
	while true; do
		read -p "Enter tasks (Type 'exit' to quit): " input
		if [[ "$input" == "exit" ]]; then
			echo "Tasks successfully added....Exiting...."
			break
		else
			echo "$input" >> "$tasks_file"
			echo "$input added to $tasks_file"
		fi
	done
}       

function view_tasks() {
	# View tasks
	if [ -s "$tasks_file" ]; then
		echo "Your current tasks are: "
		awk '{ print NR ": " $0 }' "$tasks_file"
	else
		echo "You have no items in your todo list"
	fi
}

function remove_tasks() {
	# Delete tasks
	if [ ! -s "$tasks_file" ]; then
		echo "Your file is empty."
	else
		read -p "Enter the line number of the task you wish to delete: " line_number
		sed -i "${line_number}d" "$tasks_file"
		echo "Task at line $line_number has been deleted."
	fi

}

function get_user_activity() {
        read -p "Welcome to your todo app! Enter 'add', 'remove', 'view': " preference
        if [[ "$preference" == "add" ]]; then
                get_tasks
	elif [[ "$preference" == "view" ]]; then
		view_tasks
	elif [[ "$preference" == "remove" ]]; then
		remove_tasks
        else
                echo "Invalid input. Restart app."
        fi
}

get_user_activity 