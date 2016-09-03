
;get env from shell
input=getenv('input')
openr,lun,input,/Get_lun

; Read one line at a time, saving the result into array
array = intarr(100)
WHILE NOT EOF(lun) DO BEGIN & $
		  READF, lun, array & $
		    array = [array] & $
		ENDWHILE

; Close the file and free the file unit
	FREE_LUN, lun

;=================================================== 
print,array
print, n_elements(array)
print,size(array)
print,mean(array)

exit

