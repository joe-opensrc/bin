#!/bin/bash

d=1 # decr
i=1 # incr
m=1 # mute
t=3 # msg delay
M=1 # unmute
T=1 # toggle


if [[ $# -eq 0 ]]
then

cat <<-EOU

  Usage: $(basename ${0}) ( -T | -M | -d | -i | -m ) [ -t <sec> ]
  
  -T := toggle muted state
  -M := unmute sound
  -d := decrement volume 10%
  -i := increment volume 10%
  -m := mute sound
  -t := set notify-send expire-time, in seconds (default: ${t})

EOU
  
  exit 0

fi

OPTIND=
while getopts 'dimt:MT' flag
do
 case "${flag}" in
  d) d=0; msg="Vol -10%";;
  i) i=0; msg="Vol +10%";;
  m) m=0; msg="Muted";   M=1; T=1; t=5;;
  t) t=${OPTARG};;
  M) M=0; msg="Unmuted"; m=0; T=1; t=5;; 
  T) T=0; t=5;;
 esac
 shift $(( ${OPTIND} - 1 ))
 OPTIND=
done

# proper arg checking is for the weak,
# and un-lazy ;)
# TODO: allow incr/decr to be user input

if [[ ${m} -eq 0 ]]
then
  pactl set-sink-mute 0 1
fi

if [[ ${T} -eq 0 ]]
then
  pactl set-sink-mute 0 toggle
fi

if [[ ${M} -eq 0 ]]
then
  pactl set-sink-mute 0 0
fi

if [[ ${i} -eq 0 ]]
then
  pactl set-sink-volume 0 +10% 
fi

if [[ ${d} -eq 0 ]]
then
  pactl set-sink-volume 0 -10% 
fi

vol_info=$( pactl list sinks | grep -A 9 '^Sink #0' | grep -E 'Volume|Mute' )
vol=$(   echo "${vol_info}" | grep 'Volume' | awk_field_slicer -o 5 )
muted=$( echo "${vol_info}" | grep 'Mute'   | awk_field_slicer -o 2 )

if [[ "${muted}" == "yes" ]]
then
  msg="Muted ${msg}"
else
  msg="Unmuted ${msg}"
fi

msg="(${vol}) ${msg}"
notify-send -t $(( ${t} * 1000 )) "${msg}"
