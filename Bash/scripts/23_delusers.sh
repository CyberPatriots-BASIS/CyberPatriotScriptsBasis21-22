#! /bin/bash

  
function f_users {
  
  echo "Script: [$SCRIPT_NUM] ::: Remove users - games gnats irc list news sync uucp"

  for users in games gnats irc list news sync uucp; do
    userdel -r "$users" 2> /dev/null
  done

  ((SCRIPT_NUM++))
}