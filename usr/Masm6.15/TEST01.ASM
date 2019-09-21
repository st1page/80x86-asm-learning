 
.MODEL SMALL

.386

.DATA
  
  Msg DB 'Hello Àî¹úÐÛ!$'

.CODE

 Start:
  MOV AX,@data
  MOV DS,AX
  MOV DX,OFFSET Msg

  MOV AH,9
  INT 21h

  MOV  AH,4ch                 ;DOS terminate program function
  INT  21h                    

END Start
  
