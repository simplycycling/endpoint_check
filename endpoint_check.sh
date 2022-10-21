#!/bin/bash
input="list"
while IFS=: read -r f1 f2 f3
do
        nc -zv -J 1 "$f2" "$f3"
        echo "$f1"
done < "$input"
