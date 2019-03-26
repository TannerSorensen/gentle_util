#!/usr/bin/env python

import sys
import json
from pydub import AudioSegment

def write_audio(f_in, f_out, beginning_time, end_time):
    t1 = beginning_time * 1000
    t2 = end_time * 1000
    audio_clip = AudioSegment.from_wav(f_in)
    audio_clip = audio_clip[t1:t2]
    audio_clip.export(f_out, format="wav")
    

wav_filename = sys.argv[1]
json_filename = sys.argv[2]

d = json.loads(open(json_filename).read())
idx = 0
for w in d['words']:
    if w['case']=='success':
        w_name = w['alignedWord']
        offset = 0.0
        for ph in w['phones']:
            ph_name = ph['phone']
            ons = float(w['start'])+offset
            offset += float(ph['duration'])
            end =  ons + offset
            out_filename = '_'.join([str(idx).zfill(6), w_name, ph_name])+'.wav'
            write_audio(wav_filename, out_filename, ons, end)
            idx += 1
            
    
