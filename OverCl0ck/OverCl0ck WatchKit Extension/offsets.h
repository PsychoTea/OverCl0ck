#ifndef OFFSETS_H
#define OFFSETS_H

#include "common.h"             // kptr_t

typedef struct
{
    const char *version;
    kptr_t base;
    // Structure offsets
    kptr_t sizeof_task;
    kptr_t task_itk_self;
    kptr_t task_itk_registered;
    kptr_t task_bsd_info;
    kptr_t proc_ucred;
    kptr_t ipc_space_is_task;
    kptr_t realhost_special;
    kptr_t iouserclient_ipc;
    kptr_t vtab_get_retain_count;
    kptr_t vtab_get_external_trap_for_index;
    // Data
    kptr_t zone_map;
    kptr_t kernel_map;
    kptr_t kernel_task;
    kptr_t realhost;
    // Code
    kptr_t copyin;
    kptr_t copyout;
    kptr_t chgproccnt;
    kptr_t kauth_cred_ref;
    kptr_t ipc_port_alloc_special;
    kptr_t ipc_kobject_set;
    kptr_t ipc_port_make_send;
    kptr_t osserializer_serialize;
    kptr_t rop_ldr_r0_r0_0xc;
} offsets_t;

#endif
