// /var/packages/SynologyPhotos/target/usr/lib/libsynophoto-plugin-model.so

#include <stdio.h>

long long _ZN9synophoto6plugin7network9IeNetwork11IsSupportedEv(void) {
    printf("__int64 __fastcall synophoto::plugin::network::IeNetwork::IsSupported(synophoto::plugin::network::IeNetwork *this) return 0\n");
    return 0LL;
}

__attribute__((constructor)) void main() {
    printf("module inject libsynophoto-plugin-model success\n");
}