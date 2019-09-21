.model medium,BASIC
.code

  public addj

addj PROC USES bp,noa:SWORD,nob:SWORD
     ;cld

     mov bx,noa
     mov cx,[bx]
     mov bx,nob
     mov ax,[bx]
     add ax,cx

     ret 4

addj ENDP
     END

