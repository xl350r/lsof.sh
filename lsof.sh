#!/bin/bash

help() {
	echo "## lsof.sh ##"
	echo "Author: Daniel Hoberecht"
	echo "Trimmed down version of lsof written in bash for devices without lsof"
	echo "+------------------------------------+"
	echo "| !! THIS APP MUST BE RUN AS ROOT !! |"
	echo "+------------------------------------+"
	echo "Usage: ./lsof.sh [-p <pid>] [-t <App Name>] [-a] [-c]"
	echo "-a list all open files for all processes"
	echo "-t list all open files for for grepped app."
	echo "-p list all open files for pid."
	echo "-c prints count of all files open by all processes"
	echo "-m list all mapped files for pid"
	echo "-n list all mapped files for name"
	exit
}

get_all_files() {
	if [ "$EUID" -ne 0 ]
	then
	echo "This must be run as root."
	else
	find /proc/[1-9]* -maxdepth 0 | while read line;
	do
		pid_number="$(echo $line | cut -d '/' -f 3)";
		echo "-- $pid_number --";
		exe=$(readlink $line/exe);
		for entry in "$line"/fd/*;
		do
			opened_by="$(stat -c '%U' $entry 2>/dev/null)"
			echo "$pid_number ; $exe ; $opened_by ; $entry ; $(readlink $entry)";
		done
	done
	fi
}

count_open_files() {
	if [ "$EUID" -ne 0 ]
	then
		echo "This must be run as root."
	else
		find /proc/[1-9]* -maxdepth 0 | while read pid;
		do 
			for entry in "$pid"/fd/*;
			do
				printf .
			done
		done | wc -c
fi
}

get_app_files() {
	filename=$1
	if [ "$EUID" -ne 0 ]
	then
		echo "This must be run as root."
	else
		find /proc/[1-9]* -maxdepth 0 | while read line; 
		do 
			if readlink $line/exe | grep -q $filename; then
				pid_number="$(echo $line | cut -d '/' -f 3)";
				exe=$(readlink $line/exe);
				for entry in "$line"/fd/*;
				do
					opened_by="$(stat -c '%U' $entry 2>/dev/null)"
					echo "$pid_number ; $exe ; $opened_by ; $entry ; $(readlink $entry)";
				done
			fi
		done 
	fi
}

get_pid_files() {
	pid=$1
	if [ "$EUID" -ne 0 ]
	then
		echo "This must be run as root."
	else
		if [ -d /proc/$pid ]; then
			exe=$(readlink /proc/$pid/exe);
			for entry in /proc/$pid/fd/*;
			do
				opened_by="$(stat -c '%U' $entry 2>/dev/null)"
				echo  "$pid ; $exe ; $opened_by ; $entry ; $(readlink $entry)"
			done
		else
			echo "No Such process : $pid"
		fi
	fi
}

get_mapped_files_by_pid() {
	pid=$1
	if [ "$EUID" -ne 0 ]
	then 
		echo "This must be run as root."
	else
		if [ -d /proc/$pid ]; then
			exe=$(readlink /proc/$pid/exe);
			for entry in /proc/$pid/map_files/*;
			do
				opened_by="$(stat -c '%U' $entry 2>/dev/null)"
				echo  "$pid ; $exe ; $opened_by ; $entry ; $(readlink $entry)"
			done
		else
			echo "No Such process : $pid"
		fi
	fi
}

get_mapped_files_by_name() {
	filename=$1
	if [ "$EUID" -ne 0 ]
	then
		echo "This must be run as root."
	else
		find /proc/[1-9]* -maxdepth 0 | while read line; 
		do 
			if readlink $line/exe | grep -q $filename; then
				pid_number="$(echo $line | cut -d '/' -f 3)";
				exe=$(readlink $line/exe);
				for entry in "$line"/map_files/*;
				do
					opened_by="$(stat -c '%U' $entry 2>/dev/null)"
					echo "$pid_number ; $exe ; $opened_by ; $entry ; $(readlink $entry)";
				done
			fi
		done 
	fi

}

## Thanks to 'https://stackoverflow.com/questions/16483119/an-example-of-how-to-use-getopts-in-bash' for making this simple.
while getopts ":ahct:p:n:m:" o; do
	case "${o}" in
		a)
			get_all_files
			exit 0
		;;
		p)
			get_pid_files ${OPTARG}
			exit 0
		;;
		t)
			get_app_files ${OPTARG}
			exit 0
		;;
		n)
			get_mapped_files_by_name ${OPTARG}
			exit 0
		;;
		m) 
			get_mapped_files_by_pid ${OPTARG}
			exit 0
			;;
		c) 
			count_open_files
			exit 0
		;;
		h | *)
			help
			exit 0 
		;;
	esac
done
