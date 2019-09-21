.DOSSEG
.MODEL tiny
.CODE

ORG 100h

Start:
     
     jmp lgxx


Msg DB 'Hello LiGuoXiong!$'
  

lgxx:  
  MOV DX,OFFSET Msg
   
  MOV AH,9
  INT 21h

  .EXIT ;DOS Exit                    

END
  
