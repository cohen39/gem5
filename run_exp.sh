#!/bin/bash
CPU_TYPES=("DerivO3CPU" "MinorCPU")
ISSUEWIDTH="8" #2
SYS_CLOCKS=("1GHz" "4GHz")
L2_SIZES=("256kB" "2MB" "16MB") #None, 256KB, 2MB, 16MB
COMPILER="O3_Vec" #O1, O3_Vec
CMDS=("lfsr")
#CMDS=("mm" "sieve" "merge" "spmv" "lfsr")
#INP="01101000010" #argc

for CPU_TYPE in "${CPU_TYPES[@]}"
do
	for SYS_CLOCK in "${SYS_CLOCKS[@]}"
	do
		for L2_SIZE in "${L2_SIZES[@]}"
		do
			for CMD in "${CMDS[@]}"
			do
				build/X86/gem5.opt configs/example/se.py --cmd=./configs/hw1/cs251a-microbench/"$CMD" \
						--cpu-type="$CPU_TYPE" --sys-clock="$SYS_CLOCK"  --l2_size="$L2_SIZE" --l1i_size=32kB \
						--l1d_size=32kB --caches --l2cache
				mkdir -p configs/hw1/experiments/"$CMD"/"$CPU_TYPE"_"$ISSUEWIDTH"_"$SYS_CLOCK"_"$L2_SIZE"_"$COMPILER"				
				cp ~/gem5/m5out/config.ini ~/gem5/m5out/stats.txt ~/gem5/configs/hw1/experiments/"$CMD"/"$CPU_TYPE"_"$ISSUEWIDTH"_"$SYS_CLOCK"_"$L2_SIZE"_"$COMPILER"
			done
		done
	done
done


