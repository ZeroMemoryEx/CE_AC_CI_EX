{ 
  This code will make both enemies and allies players weapons (rifles,shotgun..) unuseable except grenade and knife
}

[ENABLE]

aobscanmodule(peace,ac_client.exe,75 71 6A 18 68 2C 19 4E 00 6A 0B E8 12) // should be unique
alloc(newmem,$1000)

label(code)
label(return)

newmem:

code:
  je ac_client.exe+63701
  push 18
  push ac_client.exe+E192C
  jmp return

peace:
  jmp newmem
  nop 4
return:
registersymbol(peace)

[DISABLE]

peace:
  db 75 71 6A 18 68 2C 19 4E 00

unregistersymbol(peace)
dealloc(newmem)

{
// ORIGINAL CODE - INJECTION POINT: ac_client.exe+6368E

ac_client.exe+63676: 8B C7           - mov eax,edi
ac_client.exe+63678: 2B C8           - sub ecx,eax
ac_client.exe+6367A: 8B F9           - mov edi,ecx
ac_client.exe+6367C: 52              - push edx
ac_client.exe+6367D: 8B DF           - mov ebx,edi
ac_client.exe+6367F: E8 1C BF FF FF  - call ac_client.exe+5F5A0
ac_client.exe+63684: 8B 4E 14        - mov ecx,[esi+14]
ac_client.exe+63687: 33 DB           - xor ebx,ebx
ac_client.exe+63689: 83 C4 04        - add esp,04
ac_client.exe+6368C: 39 19           - cmp [ecx],ebx
// ---------- INJECTING HERE ----------
ac_client.exe+6368E: 75 71           - jne ac_client.exe+63701
// ---------- DONE INJECTING  ----------
ac_client.exe+63690: 6A 18           - push 18
ac_client.exe+63692: 68 2C 19 4E 00  - push ac_client.exe+E192C
ac_client.exe+63697: 6A 0B           - push 0B
ac_client.exe+63699: E8 12 CE FB FF  - call ac_client.exe+204B0
ac_client.exe+6369E: D9 EE           - fldz 
ac_client.exe+636A0: 83 C4 0C        - add esp,0C
ac_client.exe+636A3: 53              - push ebx
ac_client.exe+636A4: 51              - push ecx
ac_client.exe+636A5: D9 1C 24        - fstp dword ptr [esp]
ac_client.exe+636A8: 6A 01           - push 01
}
