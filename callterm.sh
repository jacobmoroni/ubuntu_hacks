#!/usr/bin/zsh
# -*- coding: utf-8 -*-

TPID=$(pgrep -f terminator)
if [ "$TPID" ]
then
  echo "RUNNING"
else
  terminator
fi
