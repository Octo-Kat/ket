#!/bin/bash
## Build Automation Scripts
##
## Copywrite 2014 - Donald Hoskins <grommish@gmail.com>
## on behalf of Team Octos et al.

find ket '(' -name 'jflte*.sh' ! -name 'jfall.sh' ')' -print |
        while read FILENAME
        do
	${FILENAME} $1 $2
        done
