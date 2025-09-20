#!/bin/bash


########################## TASK 1 ###################################
sum_digits() {
    local n=$1
    local sum=0
    while [ $n -gt 0 ]; do
	sum=$((sum+(n%10)))
        n=$((n/10))
    done
    echo $sum
}

dig_sum() {
    local n=$1
    while [ $n -ge 10 ]; do
        n=$(sum_digits $n)
    done
    echo $n
}

AEM=10775
MYAEM=$AEM
result=$(dig_sum $MYAEM)
echo "The sum is N (while N<10) is: $result"

########################## TASK 2 ##################################
N=$result
random_word=$(tr -dc 'a-z' </dev/urandom | head -c $((6 + RANDOM % 3)))
total_files=$((10 + N))
for ((i=1; i<=total_files; i++)); do
    filename="${random_word}-${i}.txt"
    touch "$filename"
    echo "File is:$filename"
done

########################## TASK 3 ##################################
words=("super" "spider" "bat")

for ((i=1; i<=total_files; i++)); do
    filename="${random_word}-${i}.txt"
    tot_times=$((N + 10))
    counts=()
    remaining=$tot_times
    for ((j=0; j<${#words[@]}; j++)); do
        if [ $j -eq $((${#words[@]} - 1)) ]; then
            counts[j]=$remaining
        else
            max=$((remaining - (${#words[@]} - j - 1)))
            if [ $max -le 1 ]; then
                counts[j]=1
            else
                counts[j]=$((RANDOM % max + 1))
            fi
            remaining=$((remaining - counts[j]))
        fi
    done
    for ((j=0; j<${#words[@]}; j++)); do
        echo "${counts[j]} ${words[j]}" >> "$filename"
    done
done

########################## TASK 4 ##################################
declare -A word_totals
for word in "${words[@]}"; do
    word_totals["$word"]=0
done

for ((i=1; i<=total_files; i++)); do
    filename="${random_word}-${i}.txt"
    while read -r count word; do
        word_totals["$word"]=$((word_totals["$word"] + count))
    done < "$filename"
done

report="report"
report_file="${report}.txt"
echo "Word counts in all files:" > "$report_file"
for word in "${words[@]}"; do
    echo "$word: ${word_totals[$word]}" >> "$report_file"
done
echo "Report is in:$report_file"
