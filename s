#!/bin/bash

# Require gnuplot

function count_pages() {
        local file=$1

        echo $(gs -o /dev/null -sDEVICE=bbox "$file" 2>&1| grep HiResBoundingBox | wc -l)
}


function generate_multiple() {
        local howmany=$1
        
        local DIR=aaa
        local FILE_PREFIX=aaa

        mkdir -p "$DIR"

        for i in $(seq $howmany); do
                printf "Generating $i/$howmany ... "
                local file=${FILE_PREFIX}-$i
                ./make-latex.pl --title "Deep: Deep" --author "Anonymous Authors" --tar "$DIR/$file.tar" --file "$DIR/$file.ps" &>/dev/null
                printf "$(count_pages $DIR/$file.ps) pages: $DIR/$file.ps\n"
        done
}

generate_multiple $@
