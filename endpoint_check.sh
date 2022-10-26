#!/bin/bash
input="list"
while IFS=: read -r f1 f2 f3
do
        if ! nc -z "$f2" "$f3";
            then echo "$f1 can't be reached"
            exit 1
        fi
done < "$input"
