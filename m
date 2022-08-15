Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE40593464
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Aug 2022 20:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbiHOSBN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Aug 2022 14:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbiHOSAc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Aug 2022 14:00:32 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EF613D02
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Aug 2022 11:00:30 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id i3-20020a5d8403000000b0067bd73cc9eeso4512616ion.19
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Aug 2022 11:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=Az43P0Rd0jYbTPd/Nxto4Saoi87cm2HRKHFKeg3PBBE=;
        b=5smazEpGCGdlEThmeOizJGE0dHbo1kiFDAaUvciFGgzumrm9oeFM8VZ+Fh1ryx1sCh
         OciFy+ceTiTYoL6oE39lAMCUBl2r3YT0XM8+kWvK7YLplZE/I6A7HcInoXaPPQGNeqr/
         Nk6m82oswsMvnUInonpl+XNJnBTbSg9Ym/1qt1qhCqGgLCRtbVs8CX8fXRqTB01lE6cw
         lgebnpzasICiEaQGi9687caZEXo6Ua8WApKy0NLTKCgkKE8RaKJLmj+pUzrbSBEsB4WM
         0oV5DsRqoPkI04fakb0fR61Usj8mYdXgOdHZHCfEyXykQlklLDnRfrfMix28VI2o9fBb
         Woig==
X-Gm-Message-State: ACgBeo1slY/ACI3M6IuUXx1QSstGoJk0W6BaSE3tJisaX1EDfu2DjPKh
        FPprGBdzbLmlOpTIAsCJnF2asuDt/FHdYzV/XsRMhuXpJmj5
X-Google-Smtp-Source: AA6agR75sNLYWjc61JGTHeROxl0JUzJfW7rIzB/t7xF/GpO+Paq1G3fmXgIm31wKxJUjlWCL1am+WDkZQ/Yv/cVgC7/T743XMgsH
MIME-Version: 1.0
X-Received: by 2002:a05:6638:31c1:b0:33f:2450:46a9 with SMTP id
 n1-20020a05663831c100b0033f245046a9mr7773176jav.45.1660586429877; Mon, 15 Aug
 2022 11:00:29 -0700 (PDT)
Date:   Mon, 15 Aug 2022 11:00:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000045967505e64b68aa@google.com>
Subject: [syzbot] upstream boot error: BUG: unable to handle kernel paging
 request in insert_header
From:   syzbot <syzbot+6b418544e63ef025d64e@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org, syzkaller-bugs@googlegroups.com,
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

HEAD commit:    9f162193d6e4 radix-tree: replace gfp.h inclusion with gfp_..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=166b56f3080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6bcb425ba129b87
dashboard link: https://syzkaller.appspot.com/bug?extid=6b418544e63ef025d64e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6b418544e63ef025d64e@syzkaller.appspotmail.com

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
VMCI host device registered (name=vmci, major=10, minor=120)
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
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.19.0-syzkaller-14377-g9f162193d6e4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:strlen+0x1a/0x90 lib/string.c:487
Code: e8 db 51 a6 fd 48 8b 74 24 08 48 8b 3c 24 eb c0 48 b8 00 00 00 00 00 fc ff df 48 89 fa 55 48 89 fd 48 c1 ea 03 53 48 83 ec 08 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 48 80 7d 00 00
RSP: 0000:ffffc90000067588 EFLAGS: 00010296
RAX: dffffc0000000000 RBX: ffff8881472f8008 RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffff88814727b000 RDI: ffff000000000000
RBP: ffff000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88801e795600
R13: ffff88814727b190 R14: 0000000000000003 R15: ffff000000000000
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffdc0000000000 CR3: 000000000bc8e000 CR4: 00000000003506f0
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
 do_one_initcall+0xfe/0x650 init/main.c:1296
 do_initcall_level init/main.c:1369 [inline]
 do_initcalls init/main.c:1385 [inline]
 do_basic_setup init/main.c:1404 [inline]
 kernel_init_freeable+0x6b1/0x73a init/main.c:1611
 kernel_init+0x1a/0x1d0 init/main.c:1500
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
CR2: ffffdc0000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:strlen+0x1a/0x90 lib/string.c:487
Code: e8 db 51 a6 fd 48 8b 74 24 08 48 8b 3c 24 eb c0 48 b8 00 00 00 00 00 fc ff df 48 89 fa 55 48 89 fd 48 c1 ea 03 53 48 83 ec 08 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 48 80 7d 00 00
RSP: 0000:ffffc90000067588 EFLAGS: 00010296
RAX: dffffc0000000000 RBX: ffff8881472f8008 RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffff88814727b000 RDI: ffff000000000000
RBP: ffff000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88801e795600
R13: ffff88814727b190 R14: 0000000000000003 R15: ffff000000000000
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffdc0000000000 CR3: 000000000bc8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	e8 db 51 a6 fd       	callq  0xfda651e0
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
