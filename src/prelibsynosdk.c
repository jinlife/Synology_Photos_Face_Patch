// /usr/lib/libsynosdk.so.7

#include <stdio.h>
#include <stdbool.h>

bool SYNOFSIsRemoteFS(int a1) {
    printf("_BOOL8 __fastcall SYNOFSIsRemoteFS(int a1) return false(0)\n");
    return false;
}

__attribute__((constructor)) void main() {
    printf("module inject success\n");
}