// /usr/lib/libsynosdk.so.7

#include <stdio.h>

long SYNOFSIsRemoteFS(int a1) {
    printf("_BOOL8 __fastcall SYNOFSIsRemoteFS(int a1) return false(0)\n");
    return 0L;
}

__attribute__((constructor)) void main() {
    printf("module inject libsynosdk success\n");
}