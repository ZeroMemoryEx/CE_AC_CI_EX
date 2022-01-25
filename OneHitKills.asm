[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat
alloc(newmem,2048)
label(returnhere)
label(originalcode)
label(exit)
newmem: //this is allocated memory, you have read,write,execute access
//place your code here
cmp [ebx+98],1
je originalcode

cmp byte ptr [ebp+18],00
jmp exit
originalcode:
je ac_client.exe+26C0E
cmp byte ptr [ebp+18],00

exit:
jmp returnhere

"ac_client.exe"+26BE0:
jmp newmem
nop
returnhere:
 
[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
"ac_client.exe"+26BE0:
je ac_client.exe+26C0E
cmp byte ptr [ebp+18],00
//Alt: db 74 2C 80 7D 18 00
