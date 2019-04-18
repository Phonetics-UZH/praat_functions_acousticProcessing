### function_addSounds.praat
# 
# Praat Script for Praat software (www.praat.org)
# Written by Volker Dellwo (volker.dellwo@uzh.ch)
#
# Description: 
# This script adds two or more sounds.  
#
# History: 
# 6.11.2012: created
# 15.1.2013: major revision and multiple bug fixes

form Add Sounds...
   comment Sounds need to have equal sampling frequencies
   comment All sounds need to have different names
   boolean remove_originals 0
endform

#Get number of selected Sounds: 
nSounds = numberOfSelected ("Sound")

if nSounds<2
   exit You must select two or more Sounds! Try again...
endif

# Load array with sounds to be added: 
for iSound to nSounds
   sound[iSound] = selected("Sound", iSound) 
endfor

# Copy first sound to be the one that every other one is added to:
select sound[1]
addedSounds= Copy... addedSounds

# Add sounds
for iSound from 2 to nSounds

   # Get the name of the sound to be added:
   select sound[iSound]
   sound2$ = selected$("Sound")

   # add sound2 to addedSounds
   select addedSounds
   Formula... (self+Sound_'sound2$'[])

endfor

# Scale peak:
select addedSounds
Scale peak... 0.9

# Remove originals (if asked for by user):
if remove_originals = 1
  select sound[1]
  for iSound from 2 to nSounds
     plus sound[iSound]
  endfor
  Remove
endif

# leave addedSounds selected:
select addedSounds







