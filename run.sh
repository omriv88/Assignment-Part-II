#!/bin/bash

#clear
# Display Help
help_menu() {
  echo ""
  echo ""
  echo "This script receive a command to execute and 2 Yaml files as input."
  echo ""
  echo "options:"
  echo " merge - Merge the files"
  echo " unique - Extract the Unique keys along with their values"
  echo " common - Extract the Common (key, value) pairs"
  echo " sort - Sort the files by key"
  echo ""
  echo "Commands : merge, common, unique or sort"
  echo ""
}


get_commands_and_yaml_files() {
  read -p "Please Enter a command: " command
  if [ "$command" != "merge" ] && [ "$command" != "unique" ] && [ "$command" != "common" ] && [ "$command" != "sort" ]; then
    echo "Error: Invalid command"
    exit 1
  fi

  read -p "Please Enter tha name of the first YAML file: " yaml_file1
  read -p "Please Enter the name of the second YAML file: " yaml_file2
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
