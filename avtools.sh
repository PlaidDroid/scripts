#!/bin/sh
# avtools compr input output
# avtools stab input output
# avtools split video-in audio-out video-out
# avtools join video-in audio-in video-out

option="${1}"

case ${option} in
    comp)
        echo "`ffmpeg -i ${2} -vcodec h264 -acodec aac ${3}.mp4`"
        ;;
    stab)
        echo "`ffmpeg -i ${2} -vf vidstabdetect -f null -`"
        echo "`ffmpeg -i ${2} -vf vidstabtransform\=smoothing\=30\:input\=\"transforms.trf\" ${3}.mp4`"
        ;;
    split)
        echo "`ffmpeg -i ${2} -vn ${3}.mp3`"
        echo "`ffmpeg -i ${2} -an ${4}.mp4`"
        ;;
    join)
        echo "`ffmpeg -i ${2} -i ${3} -c:v copy -c:a aac ${4}.mp4`"
        ;;
    *)
        echo "`basename ${0}` 
  v1.0
  a script by athulcvinod
        
Uses:
`apt-cache policy ffmpeg`

Commands:
  avtools compr input output
  avtools stab input output
  avtools split video-in audio-out video-out
  avtools join video-in audio-in video-out"
        exit 1 # Command to come out of the program with status 1
        ;; 
esac
