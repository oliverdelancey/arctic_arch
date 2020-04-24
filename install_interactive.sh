#!/bin/bash

printf "GPT or MBR: "
read partition_scheme
while [[ "$partition_scheme" != "GPT" && "$partition_scheme" != "MBR" ]]
do
    printf "Invalid partition scheme '$partition_scheme'. GPT or MBR: "
    read partition_scheme
done
printf "Partition scheme: $partition_scheme\n"
