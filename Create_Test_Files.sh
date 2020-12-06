#!/bin/zsh

# In an attempt to standardise audio testing, all things being equal...
# 1. Insert CD
# 2. Run this script
#
mkdir 01 02 03 04 05

#
# Extract from Audio CD
#
cd 01
cdparanoia --batch --verbose --log-debug --output-raw $1
cdparanoia --batch --verbose --log-debug --output-wav $1
cdparanoia --batch --verbose --log-debug --output-aiff $1
cdparanoia --batch --verbose --log-debug --output-aifc $1
cd ..

#
# FLAC Works
#
flac 01/track$1.cdda.aiff 02/track$1.standard.flac
flac 01/track$1.cdda.aiff -o 02/track$1.aiff_to.flac
flac 01/track$1.cdda.wav -o 02/track$1.wav_to.flac
flac -1 01/track$1.cdda.wav -o 02/track$1.comp1_wav_to.flac
flac -8 01/track$1.cdda.wav -o 02/track$1.comp8_wav_to.flac

#
# LAME Works
#
lame 01/track$1.cdda.wav 03/128kb_cbr_track$1.wav_to.mp3
lame --vbr-new 01/track$1.cdda.wav 03/___kb_vbrnew_track$1.wav_to.mp3
lame -b 320 --vbr-new 01/track$1.cdda.wav 03/320kb_vbrnew_track$1.wav_to.mp3
lame -q 9 --vbr-new 01/track$1.cdda.wav 03/q9_vbrnew_track$1.wav_to.mp3
lame -q 1 --vbr-new 01/track$1.cdda.wav 03/q1_vbrnew_track$1.wav_to.mp3
lame --abr 128 01/track$1.cdda.wav 03/128kb_abr_track$1.wav_to.mp3
lame --abr 320 01/track$1.cdda.wav 03/320kb_abr_track$1.wav_to.mp3

#
# AAC Works.
#
# This is not the most up to date M4A/AAC encoder available. It is
# The FOSS version used. This was pulled by Brew.
#
faac --overwrite -w 01/track$1.cdda.wav -o 04/track$1.cdda.m4a

#
# Apple Lossless Works
# See: https://macosforge.github.io/alac/
#
alacconvert 01/track$1.cdda.wav 05/track$1.cdda.caf

# EOF
