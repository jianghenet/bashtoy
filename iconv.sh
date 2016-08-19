#!/bin/bash
function scandir() {
    local cur_dir parent_dir workdir
    workdir=$1
    cd ${workdir}
    if [ ${workdir} = "/" ]
    then
        cur_dir=""
    else
        cur_dir=$(pwd)
    fi

    for dirlist in $(ls -A ${cur_dir})
    do
        if test -d ${dirlist};then
            cd ${dirlist}
            scandir ${cur_dir}/${dirlist}
            cd ..
        else
             tmpfile="${cur_dir}/${dirlist}"
             if [[ "`file $tmpfile`" =~ "ASCII" ]] ; then
              echo -e "\033[33m `file $tmpfile` \033[0m"
             elif [[ "`file $tmpfile`" =~ "UTF" ]] ; then
              echo -e "\033[32m `file $tmpfile` \033[0m"
             else 
              echo -e "\033[31m `file $tmpfile` \033[0m"
             fi
        fi
    done
}

if test -d $1
then
    scandir $1
elif test -f $1
then
    echo "you input a file but not a directory,pls reinput and try again"
    exit 1
else
    echo "the Directory isn't exist which you input,pls input a new one!!"
    exit 1
fi


