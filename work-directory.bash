#!/bin/bash

function wd {
	(
		save="$HOME/work-directory"
		name="$save/_$2"

		[ ! -d "$save" ] && mkdir "$save"

		if [ "$1" = "save" ] || [ "$1" = "remove" ] || [ "$1" = "go" ]; then
			if [ "$2" = "" ]; then
				echo 'Require name!'
				exit 1
			fi
		fi

		if [ "$1" = "remove" ] || [ "$1" = "go" ]; then
			if [ ! -f "$name" ]; then
				echo 'Name does not exist!'
				exit 1
			fi
		fi

		if [ "$1" = "save" ]; then
			echo "$PWD" > "$name"
		exit; fi

		if [ "$1" = "remove" ]; then
			rm "$name"
		exit; fi

		if [ "$1" = "go" ]; then
			if [ ! -d "$(cat $name)" ]; then
				echo 'Invalid path!'
				exit 1
			fi
		exit; fi

		if [ "$1" = "list" ]; then
			shopt -s nullglob
			for file in "$save"/*; do
				printf '    %s ---> %s' "${file##*/_}" "$(cat $file)"
				[ ! -d $(cat $file) ] && printf ' [invalid]'
				printf '\n'
			done
		exit; fi

		echo 'usage:'
		echo '    wd (save|remove|go) (name)'
		echo '    wd list'
	) && \
	if [ "$1" = "go" ]; then
		cd "$(cat $HOME/work-directory/_$2)"
	fi
}
