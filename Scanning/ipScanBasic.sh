#!/bin/bash


ip=10.10.10
for i in $(seq 1 65535); do
	bash -c " ping -c 1 $ip.$i" &> /dev/null && echo "[*] Active $ip.$i"
done
