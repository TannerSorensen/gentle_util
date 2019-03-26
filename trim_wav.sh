#!/usr/bin/env bash

# create directory for the output
input_dir="wav"
output_dir="${input_dir}_trim"
if [[ ! -d $output_dir ]]
then
    mkdir $output_dir
fi


for f in $(ls $input_dir)
do
    dur=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$input_dir/$f")
    beg="00:00:01"
    end=$(bc <<< "$dur - 2.0")
    min=$(bc <<< "$end / 60.0")
    sec=$(bc <<< "$dur % 60.0")

    f_tmp=${f/.wav/_tmp.wav}
    ffmpeg -ss $beg -t $end -i "$input_dir/$f" "$output_dir/$f_tmp"

    # create a one-second silence
    silence="silence.wav"
    fs=$(ffprobe -v error -show_entries stream=sample_rate -of default=noprint_wrappers=1:nokey=1 "$input_dir/$f")
    ffmpeg -y -f lavfi -i anullsrc=r=$fs:cl=mono -t 1 $silence

    # add silence to beginning and end
    sox $silence "$output_dir/$f_tmp" $silence "$output_dir/$f"
    rm "$output_dir/$f_tmp" $silence
done

