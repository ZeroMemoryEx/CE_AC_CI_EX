{ Step 7
  Author : anas
  This script does blah blah blah
}

[ENABLE]

aobscanmodule(INJECT,Tutorial-i386.exe,83 AB A4 04 00 00 01) // should be unique
alloc(newmem,$1000)

label(code)
label(return)

newmem:

code:
  add dword ptr [ebx+000004A4],02
  jmp return

INJECT:
  jmp newmem
  nop 2
return:
registersymbol(INJECT)

[DISABLE]

INJECT:
  db 83 AB A4 04 00 00 01

unregistersymbol(INJECT)
dealloc(newmem)

{
