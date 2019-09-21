.model medium
.code

  public addj

addj proc

     push bp
     mov bp,sp

     mov bx,[bp+8]
     mov cx,[bx]
     mov bx,[bp+6]
     mov ax,[bx]
     add ax,cx

     pop bp

     ret 4
addj endp
     end

