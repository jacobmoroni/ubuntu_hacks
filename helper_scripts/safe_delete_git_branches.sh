#!/bin/bash

branches=$(git branch)
ignore_list=$(ls)
ignore_list+=("rc")
ignore_list+=("master")
ignore_list+=("dev")
ignore_list+=("main")
ignore_list+=("dev-4.0")
ignore_list+=("dev-4.3")
for branch in $branches
do
  if [[ ! ${ignore_list[@]} =~ $branch ]]
  then  
    git_hist_branch=$(git log | grep $branch)
    if [[ "$git_hist_branch" == *"Merge branch"* ]]; then
      read -p "$branch Has been merged. Would you like to delete? [y/N] " -n 1 -r
      if [[ $REPLY =~ ^[Yy]$ ]]
      then
        echo ""  
        echo "deleting $branch"
        git branch -D $branch
      fi
    else
      echo ""
      echo "$branch not merged. Not deleting"
    fi
  fi
done

