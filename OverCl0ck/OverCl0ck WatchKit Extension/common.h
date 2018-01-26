#ifndef COMMON_H
#define COMMON_H

#include <stdint.h>             // uint*_t
#include <Foundation/Foundation.h>

#define LOG(str, args...) do { NSLog(@str "\n", ##args); } while(0)
#define ADDR                 "0x%08x"
#define MACH_HEADER_MAGIC    MH_MAGIC
#define MACH_LC_SEGMENT      LC_SEGMENT
typedef struct mach_header mach_hdr_t;
typedef struct segment_command mach_seg_t;
typedef uint32_t kptr_t;
typedef struct load_command mach_lc_t;

#endif
