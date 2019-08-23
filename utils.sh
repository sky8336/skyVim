#!/bin/bash
#
# utils.sh
#
# Copyright (C) 2018-2023 Eric MA  <eric@company.com>. All Rights Reserved.
#
# History:
#    2019/06/28 - [Eric MA] Created file
#
# Maintainer: you <your@email.com>
#    Created: 2019-06-28
# LastChange: 2019-08-22
#    Version: v0.0.03
#

logo_path=./utils/.logo
logo_files=($(ls $logo_path | awk '{print $1}'))

show_logo()
{
	cur_second=`date +%S`
	logo_num=${#logo_files[@]}
	index=$((10$cur_second%$logo_num))
	#echo "logo_num:$logo_num"
	cat $logo_path/${logo_files[index]}
}


opt_verbose=1

__echo()
{
	opt="$1"
	shift
	_msg="$@"
	if [ "$opt_no_color" = 1 ] ; then
		# strip ANSI color codes
		_msg=$(/bin/echo -e  "$_msg" | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g")
	fi
	# explicitly call /bin/echo to avoid shell builtins that might not take options
	/bin/echo $opt -e "$_msg"
}

_echo()
{
	if [ $opt_verbose -ge $1 ]; then
		shift
		__echo '' "$@"
	fi
}

_echo_nol()
{
	if [ $opt_verbose -ge $1 ]; then
		shift
		__echo -n "$@"
	fi
}

_info()
{
	_echo 1 "$@"
}

_info_nol()
{
	_echo_nol 1 "$@"
}

# print status function
pstatus()
{
	if [ "$opt_no_color" = 1 ]; then
		_info_nol "$2"
	else
		case "$1" in
			red)    col="\033[101m\033[30m";;
			green)  col="\033[102m\033[30m";;
			yellow) col="\033[103m\033[30m";;
			blue)   col="\033[104m\033[30m";;
			*)      col="";;
		esac
		_info_nol "$col $2 \033[0m"
	fi
	[ -n "$3" ] && _info_nol " ($3)"
	_info
}

# show_header common code
VERSION=0.1
tool_name="tool"

show_header()
{
	_info "\033[1;34m${tool_name} v$VERSION\033[0m"
	_info
}

# show_header common code
usage=(
)
options=(
)
ret_codes=(
)
examples=(
)
show_usage()
{
	cat <<EOF
	Usage:
		${usage[0]}

	Options:
		--no-color			Don't use color codes
		--verbose, -v			Increase verbosity level
		${options[0]}

	Return codes:
		${ret_codes[0]}

	Examples:
		`basename $0` --version
		`basename $0` --help
		`basename $0` --disclaimer
		${examples[0]}

	IMPORTANT:
	A false sense of security is worse than no security at all.
	Please use the --disclaimer option to understand exactly what this script does.
EOF
}


parse_opt_file()
{
	# parse_opt_file option_name option_value
	option_name="$1"
	option_value="$2"
	if [ -z "$option_value" ]; then
		show_header
		show_usage
		echo "$0: error: --$option_name expects one parameter (a file)" >&2
		exit 1
	elif [ ! -e "$option_value" ]; then
		show_header
		echo "$0: error: couldn't find file $option_value" >&2
		exit 1
	elif [ ! -f "$option_value" ]; then
		show_header
		echo "$0: error: $option_value is not a file" >&2
		exit 1
	elif [ ! -r "$option_value" ]; then
		show_header
		echo "$0: error: couldn't read $option_value (are you root?)" >&2
		exit 1
	fi
	echo "$option_value"
	exit 0
}

parse_opt_dir()
{
	# parse_opt_dir option_name option_value
	option_name="$1"
	option_value="$2"

	if [ -z "$option_value" ]; then
		show_header
		show_usage
		echo "$0: error: --$option_name expects one parameter (a directory)" >&2
		exit 1
	elif [ ! -d "$option_value" ]; then
		show_header
		echo "$0: error: couldn't find directory $option_value" >&2
		echo "$0: error: --$option_name expects one parameter (a directory)" >&2
		exit 1
	fi
	echo "$option_value"
	exit 0
}

#**********
# my utils
#**********

#set color
set_color()
{
	color_failed="\e[0;31m"
	color_success="\e[0;32m"
	color_yellow='\E[1;33m'
	color_blue='\E[1;34m'
	color_reset="\e[00m"
}

#获取开始时间和路径
get_start_time()
{
	start_time=$(date +"%s")
}

#echo install time
echo_execu_time()
{
    end_time=$(date +"%s")
    tdiff=$(($end_time-$start_time))
    hours=$(($tdiff / 3600 ))
    mins=$((($tdiff % 3600) / 60))
    secs=$(($tdiff % 60))
    echo
	echo -n -e "${color_success}#### executed completed successfully! "
    if [ $hours -gt 0 ] ; then
        echo -n -e "($hours:$mins:$secs (hh:mm:ss))"
    elif [ $mins -gt 0 ] ; then
        echo -n -e "($mins:$secs (mm:ss))"
    elif [ $secs -gt 0 ] ; then
        echo -n -e "($secs seconds)"
    fi
	echo -e " ####${color_reset}"
    echo
}

# log APIs

error_exit()
{
	echo -e "${color_failed}Error: $1${color_reset}" 1>&2
	exit 1
}

warning_log()
{
	echo -e "${color_yellow}Warning: $1${color_reset}" 1>&2
}

blue_log()
{
	echo -e "${color_blue}$1${color_reset}" 1>&2
}

successful_log()
{
	echo -e "${color_success}$1${color_reset}"
}

# $1: progress: [0~100]
# $2: log
progress_log()
{
	# $1 is must
	if [[ -z $1 ]]; then
		echo "${FUNCNAME[0]} at least need 1 param"
		exit
	fi

	local now=$1
	local all=100

	local bar_log=$2

	if [[ $now -gt $all ]]; then
		now=$all
	fi

	local percent=`awk BEGIN'{printf "%f", ('$now'/'$all')}'`
	local percent_len=`awk BEGIN'{printf "%d", (100*'$percent')}'`

	printf "[%3d%%] %s\n" "$percent_len" "$bar_log"
}
#

check_chardev_file()
{
	# check_file param_value
	param_value="$1"

	if [ -z "$param_value" ]; then
		echo "$0: error[${FUNCNAME[1]}()]: expects one parameter (a dev node)" >&2
		exit 1
	elif [ ! -e "$param_value" ]; then
		echo "$0: error[${FUNCNAME[1]}()]: couldn't find file $param_value" >&2
		exit 1
	elif [ ! -c ${param_value} ]; then
		echo "$0: error[${FUNCNAME[1]}()]: $param_value is not a char file" >&2
		exit 1
	fi
	echo "$param_value"
}

check_file()
{
	# check_file param_value
	param_value="$1"
	if [ -z "$param_value" ]; then
		echo "$0: error[${FUNCNAME[1]}()]: expects one parameter (a file)" >&2
		exit 1
	elif [ ! -e "$param_value" ]; then
		echo "$0: error[${FUNCNAME[1]}()]: couldn't find file $param_value" >&2
		exit 1
	elif [ ! -f "$param_value" ]; then
		echo "$0: error[${FUNCNAME[1]}()]: $param_value is not a file" >&2
		exit 1
	elif [ ! -r "$param_value" ]; then
		echo "$0: error[${FUNCNAME[1]}()]: couldn't read $param_value (are you root?)" >&2
		exit 1
	fi
	echo "$param_value"
}

check_dir()
{
	# check_dir param_value
	param_value="$1"

	if [ -z "$param_value" ]; then
		echo "$0: error[${FUNCNAME[1]}()]: expects one parameter (a directory)" >&2
		exit 1
	elif [ -L "$param_value" ]; then
		echo "$0: error[${FUNCNAME[1]}()]: $param_value is a softlink" >&2
		echo "$0: error[${FUNCNAME[1]}()]: expects one parameter (a directory)" >&2
		exit 1
	elif [ ! -d "$param_value" ]; then
		echo "$0: error[${FUNCNAME[1]}()]: couldn't find directory $param_value" >&2
		echo "$0: error[${FUNCNAME[1]}()]: expects one parameter (a directory)" >&2
		exit 1
	fi
	echo "$param_value"
}


clean_file()
{
	local file=$1
	# clean_file  file
	if [ -f "$file" ]; then
		rm $file
	fi
}


date=`date +%F | sed 's/-//g'``date +%T | sed 's/://g'`
