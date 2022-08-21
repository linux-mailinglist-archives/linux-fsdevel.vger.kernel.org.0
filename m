Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F16D59B15F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Aug 2022 05:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236868AbiHUDEg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Aug 2022 23:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbiHUDEd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Aug 2022 23:04:33 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A51529CBA
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Aug 2022 20:04:29 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id x7-20020a056e021ca700b002ded2e6331aso6023667ill.20
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Aug 2022 20:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=jRBWuLdM1EBsh9fGJskfn3SdJVJbiNRBKCYhxTrPs90=;
        b=UeKX9xL0GncvaGdBSykcEEqWfF3VYFFildRQg7jp5GsPHrDaWB+H3muUdOQ+E4mjo2
         99AvL4bmjI7nYei0Hje4lvIAYgQmNKEgvK0cTpGJLEzCoLwdQ1Lr6sXN2YfortuHMRzp
         MLmMSxqIg9qkxoCnzsKy7JtO1WFXNa9UaLGLsUIeaB3NZNi2jJ5goWYkoYXNY8RhWQfV
         F7MS8YnfUgtM+YSZU711XZ7HX33RTLlcBgEqly2HAwuYcNs0bw8I88iqYuv9aGx4QIZy
         xFNjQOJowHvF4pEikRovuvHM6Qm/CfS4D+WXbSXpx+F4mGITkE3kicqW4NFCUp6t0zB4
         7RuQ==
X-Gm-Message-State: ACgBeo1puVtQVn2ztguMM6GWjl1Vl5efkmKEuxPtZUP5+WX7E+ogtQUh
        0NHuEfzdUJ8pPN2XblOZGQSNmJ/DQN3luSx2uNdoDEWwVE8U
X-Google-Smtp-Source: AA6agR7kKuxsfgVKNd2pa8UruiSSQNnhTiIjFIutfOPUJZNZecbBr2VPcYKvMWYXO/ee8ib6NHyP4+3boRjuDh1YRn0jFvEneLyj
MIME-Version: 1.0
X-Received: by 2002:a02:860d:0:b0:345:b478:a611 with SMTP id
 e13-20020a02860d000000b00345b478a611mr6578685jai.95.1661051068556; Sat, 20
 Aug 2022 20:04:28 -0700 (PDT)
Date:   Sat, 20 Aug 2022 20:04:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e52b0905e6b796d3@google.com>
Subject: [syzbot] linux-next boot error: BUG: unable to handle kernel paging
 request in insert_header
From:   syzbot <syzbot+3dfa69b62d31d2321e39@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, mcgrof@kernel.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com,
        yzaikin@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e1084bacab44 Add linux-next specific files for 20220816
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1128e50d080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2f5fa747986be53a
dashboard link: https://syzkaller.appspot.com/bug?extid=3dfa69b62d31d2321e39
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3dfa69b62d31d2321e39@syzkaller.appspotmail.com

input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
ACPI: button: Sleep Button [SLPF]
ACPI: \_SB_.LNKC: Enabled at IRQ 11
virtio-pci 0000:00:03.0: virtio_pci: leaving for legacy driver
ACPI: \_SB_.LNKD: Enabled at IRQ 10
virtio-pci 0000:00:04.0: virtio_pci: leaving for legacy driver
ACPI: \_SB_.LNKB: Enabled at IRQ 10
virtio-pci 0000:00:06.0: virtio_pci: leaving for legacy driver
virtio-pci 0000:00:07.0: virtio_pci: leaving for legacy driver
N_HDLC line discipline registered with maxframe=4096
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
00:05: ttyS2 at I/O 0x3e8 (irq = 6, base_baud = 115200) is a 16550A
00:06: ttyS3 at I/O 0x2e8 (irq = 7, base_baud = 115200) is a 16550A
Non-volatile memory driver v1.3
Linux agpgart interface v0.103
ACPI: bus type drm_connector registered
[drm] Initialized vgem 1.0.0 20120112 for vgem on minor 0
[drm] Initialized vkms 1.0.0 20180514 for vkms on minor 1
Console: switching to colour frame buffer device 128x48
platform vkms: [drm] fb0: vkmsdrmfb frame buffer device
usbcore: registered new interface driver udl
brd: module loaded
loop: module loaded
zram: Added device: zram0
null_blk: disk nullb0 created
null_blk: module loaded
Guest personality initialized and is inactive
VMCI host device registered (name=vmci, major=10, minor=119)
Initialized host personality
usbcore: registered new interface driver rtsx_usb
usbcore: registered new interface driver viperboard
usbcore: registered new interface driver dln2
usbcore: registered new interface driver pn533_usb
nfcsim 0.2 initialized
usbcore: registered new interface driver port100
usbcore: registered new interface driver nfcmrvl
Loading iSCSI transport class v2.0-870.
scsi host0: Virtio SCSI HBA
st: Version 20160209, fixed bufsize 32768, s/g segs 256
Rounding down aligned max_sectors from 4294967295 to 4294967288
db_root: cannot open: /etc/target
slram: not enough parameters.
ftl_cs: FTL header not found.
wireguard: WireGuard 1.0.0 loaded. See www.wireguard.com for information.
wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
eql: Equalizer2002: Simon Janes (simon@ncm.com) and David S. Miller (davem@redhat.com)
MACsec IEEE 802.1AE
tun: Universal TUN/TAP device driver, 1.6
BUG: unable to handle page fault for address: ffffdc00116021f8
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc1-next-20220816-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:strlen+0x1a/0x90 lib/string.c:487
Code: e8 0b e9 a5 fd 48 8b 74 24 08 48 8b 3c 24 eb c0 48 b8 00 00 00 00 00 fc ff df 48 89 fa 55 48 89 fd 48 c1 ea 03 53 48 83 ec 08 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 48 80 7d 00 00
RSP: 0000:ffffc90000067588 EFLAGS: 00010296
RAX: dffffc0000000000 RBX: ffff888020740008 RCX: 0000000000000000
RDX: 1fffe000116021f8 RSI: ffff888147656000 RDI: ffff00008b010fc0
RBP: ffff00008b010fc0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88814018d600
R13: ffff8881476560b0 R14: 0000000000000013 R15: ffff00008b010fc0
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffdc00116021f8 CR3: 000000000bc8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __fortify_strlen include/linux/fortify-string.h:141 [inline]
 insert_entry fs/proc/proc_sysctl.c:164 [inline]
 insert_header+0x2c0/0xf90 fs/proc/proc_sysctl.c:259
 __register_sysctl_table+0x6fb/0x10a0 fs/proc/proc_sysctl.c:1379
 __devinet_sysctl_register+0x156/0x280 net/ipv4/devinet.c:2586
 devinet_sysctl_register net/ipv4/devinet.c:2626 [inline]
 devinet_sysctl_register+0x160/0x230 net/ipv4/devinet.c:2616
 inetdev_init+0x286/0x580 net/ipv4/devinet.c:279
 inetdev_event+0xa85/0x1610 net/ipv4/devinet.c:1534
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:87
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1945
 call_netdevice_notifiers_extack net/core/dev.c:1983 [inline]
 call_netdevice_notifiers net/core/dev.c:1997 [inline]
 register_netdevice+0x1127/0x1680 net/core/dev.c:10103
 virtnet_probe+0x1378/0x2f30 drivers/net/virtio_net.c:3929
 virtio_dev_probe+0x577/0x870 drivers/virtio/virtio.c:305
 call_driver_probe drivers/base/dd.c:530 [inline]
 really_probe+0x249/0xb90 drivers/base/dd.c:609
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:748
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:778
 __driver_attach+0x223/0x550 drivers/base/dd.c:1150
 bus_for_each_dev+0x147/0x1d0 drivers/base/bus.c:301
 bus_add_driver+0x4c9/0x640 drivers/base/bus.c:618
 driver_register+0x220/0x3a0 drivers/base/driver.c:240
 virtio_net_driver_init+0x93/0xd2 drivers/net/virtio_net.c:4108
 do_one_initcall+0xfe/0x650 init/main.c:1299
 do_initcall_level init/main.c:1374 [inline]
 do_initcalls init/main.c:1390 [inline]
 do_basic_setup init/main.c:1409 [inline]
 kernel_init_freeable+0x6b1/0x73a init/main.c:1616
 kernel_init+0x1a/0x1d0 init/main.c:1505
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
CR2: ffffdc00116021f8
---[ end trace 0000000000000000 ]---
RIP: 0010:strlen+0x1a/0x90 lib/string.c:487
Code: e8 0b e9 a5 fd 48 8b 74 24 08 48 8b 3c 24 eb c0 48 b8 00 00 00 00 00 fc ff df 48 89 fa 55 48 89 fd 48 c1 ea 03 53 48 83 ec 08 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 48 80 7d 00 00
RSP: 0000:ffffc90000067588 EFLAGS: 00010296
RAX: dffffc0000000000 RBX: ffff888020740008 RCX: 0000000000000000
RDX: 1fffe000116021f8 RSI: ffff888147656000 RDI: ffff00008b010fc0
RBP: ffff00008b010fc0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88814018d600
R13: ffff8881476560b0 R14: 0000000000000013 R15: ffff00008b010fc0
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffdc00116021f8 CR3: 000000000bc8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	e8 0b e9 a5 fd       	callq  0xfda5e910
   5:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
   a:	48 8b 3c 24          	mov    (%rsp),%rdi
   e:	eb c0                	jmp    0xffffffd0
  10:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  17:	fc ff df
  1a:	48 89 fa             	mov    %rdi,%rdx
  1d:	55                   	push   %rbp
  1e:	48 89 fd             	mov    %rdi,%rbp
  21:	48 c1 ea 03          	shr    $0x3,%rdx
  25:	53                   	push   %rbx
  26:	48 83 ec 08          	sub    $0x8,%rsp
* 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2e:	48 89 fa             	mov    %rdi,%rdx
  31:	83 e2 07             	and    $0x7,%edx
  34:	38 d0                	cmp    %dl,%al
  36:	7f 04                	jg     0x3c
  38:	84 c0                	test   %al,%al
  3a:	75 48                	jne    0x84
  3c:	80 7d 00 00          	cmpb   $0x0,0x0(%rbp)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
