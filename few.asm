
//This code will make enemies weapons (rifles,shotgun..) unuseable except you

[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat
alloc(newmem,2048)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here
cmp [edx+60],0
je ac_client.exe+63701
push 18
jmp exit

originalcode:
cmp [ecx],ebx
jne ac_client.exe+63701
push 18

exit:
jmp returnhere

"ac_client.exe"+6368C:
jmp newmem
nop
returnhere:

 
[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
"ac_client.exe"+6368C:
cmp [ecx],ebx
jne ac_client.exe+63701
push 18
//Alt: db 39 19 75 71 6A 18
