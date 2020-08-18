#!/usr/bin/bash
#v1.0 by sandylaw <freelxs@gmail.com> 2020-08-18
#This script will list the website.
#reference :https://blog.csdn.net/sky619351517/article/details/77016845
#Eg. bash webtree $URL
# shellcheck disable=SC1091
branch_vline="│   "           #Branch vertical line
#branch_null="    " #null separation branch
middle_branch_end="├── "
last_branch_end="└── "                                                                                                                                                                                                                                                                   #the last file branch
branch_sum=""
filecount=0
directorycount=0
URL=$1
function help() {
    # Display Help
    echo "Usage:"
    echo
    echo "This script will list the website, like tree for local."
    echo
    echo "Syntax: bash webtree URL"
    echo
}
function loadhelp() {
    if [ "$1" == "-h" ] || [ "$1" == "--help" ] || [ "$1" == "-help" ]; then
        help
        exit 0
    fi
}
loadhelp
function check_url() {
    wget --spider -q -o /dev/null  --tries=1 -T 5 "$1"
    if ! wget --spider -q -o /dev/null  --tries=1 -T 5 "$1"; then
        echo 1
    else
        echo 0
    fi
}
isurl=$(check_url "$URL")
if [ "$isurl" == 0 ] && [ "${URL: -1}" == "/" ]; then
    :
elif     [ "$isurl" == 0 ] && [ "${URL: -1}" != "/" ]; then
    URL=$URL"/"
else
    echo "Please check the URL: $URL"
    exit 1
fi

function webtree() {
    URL=$1
    num=0
    read -ra WEBDIR <<< "$(wget -O - "$URL" 2> /dev/null | grep href= | awk -F '"' '{print $2}' | sort | uniq | tr "\\n" " ")"
    for d in ${WEBDIR[*]}; do
        thelastfile=${#WEBDIR[@]}
        num=$((num + 1))
        URL=$1
        if [[ $thelastfile -eq $num ]]; then
            if [ "${d: -1}" == "/" ]; then
                directorycount=$((directorycount + 1))
                echo -e "${branch_sum}${last_branch_end}\\033[1;34m$d\\033[0m"
                branch_sum=${branch_sum}${branch_vline}
                URL=$URL"$d"
                # 调用自身
                webtree "$URL"
                branch_sum=${branch_sum%${branch_vline}}
            else
                filecount=$((filecount + 1))
                echo -e "${branch_sum}$last_branch_end\\033[1;32m$d\\033[0m"
            fi
        else
            if [ "${d: -1}" == "/" ]; then
                directorycount=$((directorycount + 1))
                echo -e "${branch_sum}${middle_branch_end}\\033[1;34m$d\\033[0m"
                branch_sum=${branch_sum}${branch_vline}
                URL=$URL"$d"
                # 调用自身
                webtree "$URL"
                branch_sum=${branch_sum%${branch_vline}}
            else
                filecount=$((filecount + 1))
                echo -e "${branch_sum}$middle_branch_end\\033[1;32m$d\\033[0m"
            fi

        fi
    done
}

if [ -z "$URL" ]; then
    echo -e "\\033[1;34m.\\033[0m"
else
    #echo -e "\\033[1;34m$1\\033[0m"
    webtree "$URL"
    echo
    echo "$directorycount directories,  $filecount files"
fi

rm -rf wget-log
