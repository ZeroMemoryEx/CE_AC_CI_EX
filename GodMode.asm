[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat
alloc(newmem,2048)
label(returnhere)
label(originalcode)
label(exit)

newmem:
cmp [ebx+238],0
jne originalcode
xor edi,edi
sub [ebx+04],edi
jmp exit

originalcode:
sub edi,eax
sub [ebx+04],edi
exit:
jmp returnhere

"ac_client.exe"+29D1D:
jmp newmem
returnhere:
[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
"ac_client.exe"+29D1D:
sub edi,eax
sub [ebx+04],edi
//Alt: db 2B F8 29 7B 04
