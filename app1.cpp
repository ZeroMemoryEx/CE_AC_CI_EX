#include <windows.h> 
#include <vector>
#include <stdlib.h>
#include <tchar.h>
#include <iostream>
#include<TlHelp32.h>

#define address  0x0242650
#define offsett 0x4AC 
#define window "Step 2"
using namespace std;


/*

Solved By  Walczy

github :https://github.com/walczy


*/
uintptr_t GetModuleBaseAddress(DWORD procId, const wchar_t* modName)
{
    uintptr_t modBaseAddr = 0;
    HANDLE hSnap = CreateToolhelp32Snapshot(TH32CS_SNAPMODULE | TH32CS_SNAPMODULE32, procId);
    if (hSnap != INVALID_HANDLE_VALUE)
    {
        MODULEENTRY32 modEntry;
        modEntry.dwSize = sizeof(modEntry);
        if (Module32First(hSnap, &modEntry))
        {
            do
            {
                if (!_wcsicmp(modEntry.szModule, modName))
                {
                    modBaseAddr = (uintptr_t)modEntry.modBaseAddr;
                    break;
                }
            } while (Module32Next(hSnap, &modEntry));
        }
    }
    CloseHandle(hSnap);
    return modBaseAddr;
}


uintptr_t FindDMAAddy(HANDLE hProc, uintptr_t ptr, std::vector<unsigned int> offsets)
{
    uintptr_t addr = ptr;
    uintptr_t  resu;
    for (unsigned int i = 0; i < offsets.size(); ++i)
    {
        ReadProcessMemory(hProc, (BYTE*)addr, &resu, sizeof(resu), NULL);
        resu += offsets[i];
    }
    return resu;
}

int main()
{

    HWND hwnd = FindWindowA(NULL, window);
    if (hwnd == NULL)
    {
        cout << "Error Window  Not Found  !!!" << endl;
    }
    DWORD procID;
    GetWindowThreadProcessId(hwnd, &procID);
    uintptr_t modulebase = GetModuleBaseAddress(procID, L"Tutorial-i386.exe");
    HANDLE  hProcess = OpenProcess(PROCESS_ALL_ACCESS, FALSE, procID);
    uintptr_t ptr = modulebase + address;
    vector<unsigned int>  offsets =  { offsett } ;
    uintptr_t  addx = FindDMAAddy(hProcess, ptr, offsets);
    int res = NULL;
    int nv = 1000;

    ReadProcessMemory(hProcess, (LPVOID)addx, &res, sizeof(res), NULL);
    cout <<"You Value is " <<res << endl;
    cout << "Press 'A' To Pass The Challenge !!"  << endl;
    Sleep(200);
    while (true)
    {
        if (GetAsyncKeyState('A') )
        {
            Sleep(200);
            system("cls");
            WriteProcessMemory(hProcess, (LPVOID)addx, &nv, sizeof(nv), NULL);
            cout << "Congratulation you passed the challenge!!" << endl;
            ReadProcessMemory(hProcess, (LPVOID)addx, &res, sizeof(res), NULL);
            cout << "Your New Value is\t" << res << endl;
            return 0;
        }
    }
    
}

