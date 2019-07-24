#!/bin/bash 

float=1     # default return rounded integer output
out=""      #
precision=2 #
verbose=1   # 

USAGE="
Usage: $( basename "${0}" ) [-f] [-h] [-p <int>] [-v]

  -f       : return float value
  -h       : this help message ;)
  -p <int> : specifiy precision [default: 2] 
  -v       : verbose output; print all battery uevent info

"

OPTIND=
while getopts 'fhp:v' flag
do
 case "${flag}" in
   f) float=0;;
   h) echo -ne "${USAGE}"; exit 0;;
   p) float=0; precision=${OPTARG};;
   v) verbose=0;;
  \?) echo -ne "${USAGE}"; exit 1;;
 esac
 shift $(( OPTIND - 1 ))
done

if [[ ! ${precision} =~ ^[0-9]+$ ]]
then
 echo -ne "\nPrecision Argument Needs To Be An Integer\n\n"
 exit 1
fi

while read -r kv
do
 kv="${kv/POWER_SUPPLY_/BATSTAT_}"

 if [[ ${verbose} -eq 0 ]]
 then
  echo "${kv}" >&2
 fi
 declare "${kv}"
done </sys/class/power_supply/BAT0/uevent

## battery can strangely hold `design` charge for a few seconds
## before dropping to `full` charge again
if [[ ${BATSTAT_CHARGE_NOW} -eq ${BATSTAT_CHARGE_FULL_DESIGN} ]]
then
 pct="100.00"
else

 if [[ ${float} -eq 0 ]]
 then
  pct=$( echo "( ${BATSTAT_CHARGE_NOW} / ${BATSTAT_CHARGE_FULL} * 100 )" | bc -l )
  pct=$( printf "%.${precision}f" ${pct} )
 else
  pct=${BATSTAT_CAPACITY}
 fi
fi

# I '💜' Unicode
case "${BATSTAT_STATUS}" in
  "Full")        out="❍ 100.00%";;
  "Discharging") out="⭹ ${pct}%";;
  "Charging")    out="⭷ ${pct}%";;
  "Unknown")     out="? ---.--%";;
esac

if [[ ${verbose} -eq 0 ]]
then
 echo "BATSTAT_OUT=${out}"
else
 echo "${out}"
fi
