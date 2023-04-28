#!/bin/bash

clear
# Display Help
help_menu() {
  echo "Provide at least one argument"
  echo "Script options:"
  echo ""
  echo "Syntax: ./run.sh <option> <file1> <file2>"
  echo "____________________________________________"
  echo "options:"
  echo " merge - Merge the files"
  echo " unique - Extract the Unique keys along with their values"
  echo " common - Extract the Common (key, value) pairs"
  echo " sort - Sort the files by key"
  echo "____________________________________________"
  echo "Pease choose Command : merge, common, unique, sort"
}


get_commands_and_yaml_files() {
  read -p "Enter a command: " command
  if [ "$command" != "merge" ] && [ "$command" != "unique" ] && [ "$command" != "common" ] && [ "$command" != "sort" ]; then
    echo "Error: Invalid command"
    exit 1
  fi

  read -p "Enter the path to the first YAML file: " yaml_file1
  read -p "Enter the path to the second YAML file: " yaml_file2
}



files_checks(){  
  if [ ! -f "$yaml_file1" ]; then
    echo "Error: $yaml_file1 does not exist"
    exit 1
  fi
  
  if [ ! -f "$yaml_file2" ]; then
    echo "Error: $yaml_file2 does not exist"
    exit 1
  fi

}

yq_command() {
  if [ "$command" = "merge" ]; then
  #    yq eval -j "$yaml_file1" "$yaml_file2"
    yq e "$yaml_file1" "$yaml_file2"
  elif [ "$command" = "unique" ]; then
    yq eval -N 'to_entries | unique' "$yaml_file1" "$yaml_file2"
#    keys=$(yq eval -N 'keys | unique' "$yaml_file1" "$yaml_file2")
#    value=$(yq ".$key" "$yaml_file1" "$yaml_file2") 
#    for key in $keys; do
#    echo $keys
#    echo "$value"
#    key_list=$(yq eval -N 'keys | unique' "$yaml_file1" "$yaml_file2") 
#    echo $key_list | sed 's/-*//g'
#    echo $key_list | sed 's/^[ \t]*//'
#    echo $key_list
#    for yq_key in $key_list;do
#    clean_key=$(echo $key_list | sed 's/- *//g')
#    for key in $clean_key; do
#    echo $word
#    echo $clean_key
#    echo $line
#    yq_r=$(yq ".$key" "$yaml_file1" "$yaml_file2")
#    echo $yq_r
#    done
  elif [ "$command" = "common" ]; then
    yq eval -N 'to_entries' "$yaml_file1" "$yaml_file2"
  elif [ "$command" = "sort" ]; then
    yq eval -N 'keys' "$yaml_file1" "$yaml_file2"
  fi
}
help_menu
get_commands_and_yaml_files
files_checks
yq_command
