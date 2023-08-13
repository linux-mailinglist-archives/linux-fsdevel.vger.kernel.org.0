Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E5E77AEF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 01:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjHMXmR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Aug 2023 19:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjHMXmN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Aug 2023 19:42:13 -0400
Received: from mail-pf1-f207.google.com (mail-pf1-f207.google.com [209.85.210.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C177F18F
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Aug 2023 16:42:08 -0700 (PDT)
Received: by mail-pf1-f207.google.com with SMTP id d2e1a72fcca58-686ed1d2536so5796336b3a.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Aug 2023 16:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691970128; x=1692574928;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QwzFxG9z9O8CEGW1AZ0pmLjoMmU2HvlAKlMv4vFTfsI=;
        b=a1Q1ktEJTvi4Fed3dn3Gt/X5GiHErh9ft3cJaQ/BedY5v2IMXJU2IFyjWdBr0IyqSV
         uirkdjdA1mGH89BEvDUF9P98l9bxs5lEAHbNPUkP61B5dQPtMhyBYs5409N/ZoH+Hlp4
         l+4/l0NxT/IxGDuHpRvC00QkzN4WI58d9tfhkc9lZuVuGLz0giuweZLUsJiEZGESw0C5
         XzfC1gb5bLOHZdl0vPCi7zGDc4/c3u/TakF60PQyXgbgEQowEBhPDD2q7p1OuVi05vgU
         x5hMi+ORtKwdyqaBBw3WZsNpmALXxgSwuPfLPYA9diMca0Dk8cVO/p89qsJQNaLhEvrz
         t1AA==
X-Gm-Message-State: AOJu0YyRsfpemAYZU89SLLaIhAk+rCsMfBB2BXwv7e4sAzxkV1poEYFc
        BWd/qWv4drh3dAEaON1Cyh62U8B9v/SyYeVYOOL7U395gmrz
X-Google-Smtp-Source: AGHT+IGhpwngGL0rLAxNlMfAvTKucEnUAd7hrKlbQZegz7zc0uzd39GX51dLv/H7kMBRygCQyELrRQEkDAFeidCQmTFAfGYTCJcV
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:1a4f:b0:687:9855:ab23 with SMTP id
 h15-20020a056a001a4f00b006879855ab23mr3876770pfv.1.1691970128277; Sun, 13 Aug
 2023 16:42:08 -0700 (PDT)
Date:   Sun, 13 Aug 2023 16:42:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007779580602d67eba@google.com>
Subject: [syzbot] [ext4?] INFO: rcu detected stall in sys_unlink (3)
From:   syzbot <syzbot+c4f62ba28cc1290de764@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, brauner@kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    21ef7b1e17d0 Add linux-next specific files for 20230809
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13bf4caba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28e9e38cc16e8f0
dashboard link: https://syzkaller.appspot.com/bug?extid=c4f62ba28cc1290de764
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113d612da80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e961d9a9b52d/disk-21ef7b1e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f5c9bb17b02c/vmlinux-21ef7b1e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ebef5bdf7465/bzImage-21ef7b1e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c4f62ba28cc1290de764@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 1-.... } 2634 jiffies s: 1829 root: 0x2/.
rcu: blocking rcu_node structures (internal RCU debug):

Sending NMI from CPU 0 to CPUs 1:
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
NMI backtrace for cpu 1
CPU: 1 PID: 5138 Comm: udevd Not tainted 6.5.0-rc5-next-20230809-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:preempt_count_sub+0x4/0x150 kernel/sched/core.c:5881
Code: 00 00 00 00 66 90 f3 0f 1e fa 48 c7 c7 20 a0 3f 90 e9 50 c0 59 00 f3 0f 1e fa 48 c7 c7 20 a0 3f 90 e9 e0 b1 59 00 f3 0f 1e fa <48> c7 c0 e0 25 0b 92 53 89 fb 48 ba 00 00 00 00 00 fc ff df 48 89
RSP: 0018:ffffc900001f03b0 EFLAGS: 00000087
RAX: 000000000000083c RBX: 000000a6e635ee26 RCX: 0000000000000001
RDX: 000000a600000000 RSI: ffffffff8ac8b300 RDI: 0000000000000001
RBP: 000000a6e635e5ea R08: 0000000000000005 R09: 0000000000000000
R10: 00000000000026fb R11: 205d314320202020 R12: 0000000000000001
R13: 0000000000000899 R14: fffffbfff24668e6 R15: dffffc0000000000
FS:  00007f96452c3c80(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555557032788 CR3: 0000000067820000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 delay_tsc+0x6a/0xb0 arch/x86/lib/delay.c:77
 wait_for_lsr+0x96/0x180 drivers/tty/serial/8250/8250_port.c:2087
 serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3366 [inline]
 serial8250_console_write+0xce5/0x1060 drivers/tty/serial/8250/8250_port.c:3444
 console_emit_next_record kernel/printk/printk.c:2910 [inline]
 console_flush_all+0x4e8/0xf70 kernel/printk/printk.c:2966
 console_unlock+0x10c/0x260 kernel/printk/printk.c:3035
 vprintk_emit+0x189/0x630 kernel/printk/printk.c:2307
 dev_vprintk_emit drivers/base/core.c:4838 [inline]
 dev_printk_emit+0xfb/0x140 drivers/base/core.c:4849
 __dev_printk+0xf5/0x270 drivers/base/core.c:4861
 _dev_warn+0xe5/0x120 drivers/base/core.c:4905
 usb_rx_callback_intf0+0x11c/0x1a0 drivers/media/rc/imon.c:1771
 __usb_hcd_giveback_urb+0x359/0x5c0 drivers/usb/core/hcd.c:1671
 usb_hcd_giveback_urb+0x389/0x430 drivers/usb/core/hcd.c:1754
 dummy_timer+0x1415/0x35f0 drivers/usb/gadget/udc/dummy_hcd.c:1987
 call_timer_fn+0x1a0/0x580 kernel/time/timer.c:1700
 expire_timers kernel/time/timer.c:1751 [inline]
 __run_timers+0x764/0xb10 kernel/time/timer.c:2022
 run_timer_softirq+0x58/0xd0 kernel/time/timer.c:2035
 __do_softirq+0x218/0x965 kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1109
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:setup_object+0x1e/0x80 mm/slub.c:1851
Code: 7b ff ff ff 0f 1f 84 00 00 00 00 00 55 48 89 f5 53 48 89 fb 48 83 ec 08 66 90 48 89 ee 48 89 df e8 07 8d 00 00 48 83 7b 48 00 <75> 27 48 83 c4 08 5b 5d c3 f7 47 08 00 04 01 80 74 de ba bb 00 00
RSP: 0018:ffffc90003e0fcc8 EFLAGS: 00000246
RAX: ffff888063eee600 RBX: ffff888014a48780 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888063eef610
RBP: ffff888063eee600 R08: 0000000000000001 R09: 0000000000000000
R10: ffff888063eef600 R11: dffffc0000000000 R12: ffff888063eed500
R13: 0000000000000006 R14: 0000000000000003 R15: 00000000ffffffff
 allocate_slab+0x194/0x380 mm/slub.c:2053
 new_slab mm/slub.c:2070 [inline]
 ___slab_alloc+0x8bc/0x1570 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 slab_alloc mm/slub.c:3486 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
 kmem_cache_alloc+0x392/0x3b0 mm/slub.c:3502
 getname_flags.part.0+0x50/0x4d0 fs/namei.c:140
 getname_flags include/linux/audit.h:319 [inline]
 getname fs/namei.c:219 [inline]
 __do_sys_unlink fs/namei.c:4443 [inline]
 __se_sys_unlink fs/namei.c:4441 [inline]
 __x64_sys_unlink+0xb3/0x110 fs/namei.c:4441
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f9644f17da7
Code: f0 ff ff 73 01 c3 48 8b 0d 7e 90 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 57 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 51 90 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007ffc1910a9c8 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 0000555eb5e4c120 RCX: 00007f9644f17da7
RDX: 0000000000000000 RSI: 0000555eb6b73b35 RDI: 00007ffc1910a9d8
RBP: 00007ffc1910a9d8 R08: 0000000000000000 R09: 768766f3344e6084
R10: 0000000000000000 R11: 0000000000000206 R12: 0000555eb6b57650
R13: 000000000aba9500 R14: 0000000003938700 R15: 0000555eb5e4c160
 </TASK>
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
