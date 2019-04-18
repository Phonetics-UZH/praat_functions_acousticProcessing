### function_spectralShifting.praat
# 
# Praat Script for Praat software (www.praat.org)
# Written by Volker Dellwo (volker.dellwo@uzh.ch)
#
# Description: 
# This script shifts a spectral band by a specified frequency using a technique based on
# amplitude modulation
#
# History: 
# 13.3.2013: created

form Shift spectral band...
    comment Multiple object selection possible
    integer lower_band_frequency 50	
    integer upper_band_frequency 5000
    positive filter_slope 100
    positive shift_band_by 150
    choice direction 1
       button up
       button down
endform

nSelected = numberOfSelected("Sound")

# Fill array with selected sound id numbers: 
for iSelected to nSelected
   sound[iSelected] = selected("Sound", iSelected)
endfor

# Loop through sounds: 
for iSelected to nSelected
   select sound[iSelected]
   name$ = selected$("Sound")
   filtered = Filter (pass Hann band)... lower_band_frequency upper_band_frequency filter_slope
   Formula... self*(1/2 * sin(2*pi*shift_band_by*x) )
   final[iSelected]= Filter (pass Hann band)... lower_band_frequency+shift_band_by upper_band_frequency+shift_band_by 100
   Scale intensity... 70
   Rename... 'name$'_shifted_'shift_band_by'_Hz
   select filtered
   Remove
endfor

# Keep all sounds selected: 
select final[1]
for iSelected from 2 to nSelected
   plus final[iSelected]
endfor

