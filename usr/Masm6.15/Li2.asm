 
DATA SEGMENT          ;定义数据段   
  SUM DW ?			  ;变量SUM用来保存结果
DATA ENDS          

STACK SEGMENT STACK   ;定义数据段
  DB 100 DUP(0)
STACK ENDS

CODE SEGMENT 'CODE'   ;定义代码段
     ASSUME CS:CODE,DS:DATA,SS:STACK

 START:
     MOV AX,DATA
     MOV DS,AX
     MOV CX,1         ;CX是计数器,用于每次产生一个新数并控制循环何时结束
 CYCLE:
     ADD SUM,CX       ;加上当前数
     INC CX           ;产生下一个新数
     CMP CX,11        ;比较(CX)和12看是否可以结束
     JLE CYCLE        ;未结束转CYCLE继续
     
     MOV AX,SUM
     AAM			  ;将该值转化为BCD数字	
     ADD AX,3030H     ;转化为ASCII码
     
     MOV BX,AX        ;数字存于BX中
          
     MOV AH,2		  ;显示高位数字	
     MOV DL,BH
     INT 21H
     MOV DL,BL        ;显示低位数字
     INT 21H
          
          
     MOV AH,4CH       ;返回操作系统
     INT 21H

CODE ENDS
     END START                    