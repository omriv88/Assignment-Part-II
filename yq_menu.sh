#!/bin/bash

clear
# Display Help
help_menu() {
  echo "yq - commands"
  echo "Syntax: ./run.sh <option> <file1.yml> <file2.yml>"
  echo "____________________________________________"
  echo "options:"
  echo " merge - Merge the files"
  echo " unique - Extract the Unique keys along with their values"
  echo " common - Extract the Common (key, value) pairs"
  echo " sort - Sort the files by key"
  echo "____________________________________________"
  echo "Pease choose Command : merge, common, unique, sort"
}


get_commands_and_files() {
  read -p "Enter a command: " command
  if [ "$command" != "merge" ] && [ "$command" != "common" ] && [ "$command" != "unique" ] && [ "$command" != "sort" ]; then
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
    yq eval -j "$yaml_file1" "$yaml_file2"
  elif [ "$command" = "common" ]; then
    yq eval-all '(.[0] * .[1])' "$yaml_file1" "$yaml_file2"
  elif [ "$command" = "unique" ]; then
    yq 'keys | unique' "$yaml_file1" "$yaml_file2"
  elif [ "$command" = "sort" ]; then
    yq 'keys' "$yaml_file1" "$yaml_file2"
  fi
}
help_menu
get_commands_and_files
files_checks
yq_command
