
[ENABLE]
aobscanmodule(INJECT,ac_client.exe,29 7B 04 8B C7) // should be unique
alloc(newmem,$1000)

label(code)
label(return)

newmem:
cmp [ebx+444],3
jne code
sub [ebx+04],0
mov eax,edi
jmp return

code:
  mov [ebx+04],0
  mov eax,edi
  jmp return

INJECT:
  jmp newmem
return:
registersymbol(INJECT)

[DISABLE]
INJECT:
  db 29 7B 04 8B C7

unregistersymbol(INJECT)
dealloc(newmem)

{
ac_client.exe+29CFD: 2B F0                    - sub esi,eax
ac_client.exe+29CFF: 0F BF 84 24 1E 01 00 00  - movsx eax,word ptr [esp+0000011E]
ac_client.exe+29D07: 89 44 24 0C              - mov [esp+0C],eax
ac_client.exe+29D0B: 89 73 08                 - mov [ebx+08],esi
ac_client.exe+29D0E: DB 44 24 0C              - fild dword ptr [esp+0C]
ac_client.exe+29D12: DE CA                    - fmulp st(2),st(0)
ac_client.exe+29D14: DC C9                    - fmul st(1),st(0)
ac_client.exe+29D16: DE E1                    - fsubrp st(1),st(0)
ac_client.exe+29D18: E8 43 05 09 00           - call ac_client.exe+BA260
ac_client.exe+29D1D: 2B F8                    - sub edi,eax
// ---------- INJECTING HERE ----------
ac_client.exe+29D1F: 29 7B 04                 - sub [ebx+04],edi
// ---------- DONE INJECTING  ----------
ac_client.exe+29D22: 8B C7                    - mov eax,edi
ac_client.exe+29D24: 5F                       - pop edi
ac_client.exe+29D25: 5E                       - pop esi
ac_client.exe+29D26: 8B E5                    - mov esp,ebp
ac_client.exe+29D28: 5D                       - pop ebp
ac_client.exe+29D29: C2 04 00                 - ret 0004
ac_client.exe+29D2C: 9E                       - sahf 
ac_client.exe+29D2D: 9C                       - pushfd 
ac_client.exe+29D2E: 42                       - inc edx
ac_client.exe+29D2F: 00 B1 9C 42 00 C5        - add [ecx-3AFFBD64],dh
}
