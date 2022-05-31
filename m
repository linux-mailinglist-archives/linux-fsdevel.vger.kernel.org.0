Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B115394B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 18:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346001AbiEaQE3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 12:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242921AbiEaQE2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 12:04:28 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB838E1B7
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 May 2022 09:04:26 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id k5-20020a6bba05000000b00668eb755190so862169iof.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 May 2022 09:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=pGVLzRimVA1xcBcn6YKbWot/T/LVmDAVCNsMSsRSgFk=;
        b=b0H5pyL0GhswJHWj7zoS+evsFnMANZCTOwhoGLplFbf2KjfwBHIUIy4FfSuBhfPT8V
         E5Cx5wiXv2AAfp6njokM6GkpHn9xgaDu1ytvcnJurIEQyJ8zEgOhxWnSuVdzHtMcKBr3
         yd/7DbSnGsp87JWqiGhGyIghMo46biFHwq3mQblpaK8gTLXOrqkkwGVnhOyqjlyDoilw
         FJMODeFE/ZrKXBX+XaybXCLcY5684cN9fxjgW9Dvnik2BRZQicioamEsIrs6OE/M0Jy/
         3R0C+ZMj8lxGsxiZr3n1cSLxVyvOjzMsdJeqZ/LBNZN0vvEGOjDKXEbTbdQBj0ngrz4D
         3qUg==
X-Gm-Message-State: AOAM533mY5hxGH71w4BTAl49MS6oqt82hNx0352Cf994vGCH6jkdWgx4
        sexw7fCv6oq5VrEDQD++koxfjN3M56GRgqQSrVGhLTZpWzel
X-Google-Smtp-Source: ABdhPJzUX0yRAY9hpyzvG8bMPPpBLjzXn0w9hWm4EBFLFkKEa6ZdaYacol/MsDR64540KhF1mhuJHEJ1d65UofT5zlkpXQgWCGQW
MIME-Version: 1.0
X-Received: by 2002:a5d:9d8b:0:b0:663:9916:da83 with SMTP id
 ay11-20020a5d9d8b000000b006639916da83mr19042830iob.116.1654013065624; Tue, 31
 May 2022 09:04:25 -0700 (PDT)
Date:   Tue, 31 May 2022 09:04:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003b02c205e050ed88@google.com>
Subject: [syzbot] INFO: task hung in fuse_launder_folio
From:   syzbot <syzbot+21f1723d24cb1430ec52@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    9d004b2f4fea Merge tag 'cxl-for-5.19' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=155cc833f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d5ef46f0e355ceff
dashboard link: https://syzkaller.appspot.com/bug?extid=21f1723d24cb1430ec52
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1036d59df00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=110f21ddf00000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=142f7fa7f00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=162f7fa7f00000
console output: https://syzkaller.appspot.com/x/log.txt?x=122f7fa7f00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+21f1723d24cb1430ec52@syzkaller.appspotmail.com

INFO: task syz-executor149:3643 blocked for more than 143 seconds.
      Not tainted 5.18.0-syzkaller-10643-g9d004b2f4fea #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor149 state:D stack:27656 pid: 3643 ppid:  3603 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6431
 schedule+0xd2/0x1f0 kernel/sched/core.c:6503
 fuse_wait_on_page_writeback fs/fuse/file.c:449 [inline]
 fuse_wait_on_page_writeback+0x11e/0x170 fs/fuse/file.c:445
 fuse_launder_folio fs/fuse/file.c:2361 [inline]
 fuse_launder_folio+0xeb/0x130 fs/fuse/file.c:2351
 folio_launder mm/truncate.c:614 [inline]
 invalidate_inode_pages2_range+0x99a/0xde0 mm/truncate.c:680
 fuse_finish_open+0x2fd/0x4d0 fs/fuse/file.c:217
 fuse_open_common+0x2f0/0x500 fs/fuse/file.c:256
 do_dentry_open+0x4a1/0x11f0 fs/open.c:824
 do_open fs/namei.c:3477 [inline]
 path_openat+0x1c71/0x2910 fs/namei.c:3610
 do_filp_open+0x1aa/0x400 fs/namei.c:3637
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1254
 do_sys_open fs/open.c:1270 [inline]
 __do_sys_open fs/open.c:1278 [inline]
 __se_sys_open fs/open.c:1274 [inline]
 __x64_sys_open+0x119/0x1c0 fs/open.c:1274
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f7b892293c9
RSP: 002b:00007f7b891b92f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007f7b892b84d8 RCX: 00007f7b892293c9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000100
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f7b892b84d0
R13: 00007ffc24e5c05f R14: 00007f7b8928514c R15: 0030656c69662f2e
 </TASK>
INFO: task syz-executor149:3644 blocked for more than 143 seconds.
      Not tainted 5.18.0-syzkaller-10643-g9d004b2f4fea #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor149 state:D stack:28224 pid: 3644 ppid:  3603 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5116 [inline]
 __schedule+0xa00/0x4b30 kernel/sched/core.c:6431
 schedule+0xd2/0x1f0 kernel/sched/core.c:6503
 io_schedule+0xba/0x130 kernel/sched/core.c:8618
 folio_wait_bit_common+0x4f2/0xa90 mm/filemap.c:1324
 __folio_lock mm/filemap.c:1690 [inline]
 folio_lock include/linux/pagemap.h:942 [inline]
 folio_lock include/linux/pagemap.h:938 [inline]
 __filemap_get_folio+0xca5/0xf00 mm/filemap.c:1962
 truncate_inode_pages_range+0x37d/0x1530 mm/truncate.c:378
 truncate_inode_pages mm/truncate.c:452 [inline]
 truncate_pagecache+0x63/0x90 mm/truncate.c:753
 fuse_finish_open+0x39b/0x4d0 fs/fuse/file.c:213
 fuse_open_common+0x2f0/0x500 fs/fuse/file.c:256
 do_dentry_open+0x4a1/0x11f0 fs/open.c:824
 do_open fs/namei.c:3477 [inline]
 path_openat+0x1c71/0x2910 fs/namei.c:3610
 do_filp_open+0x1aa/0x400 fs/namei.c:3637
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1254
 do_sys_open fs/open.c:1270 [inline]
 __do_sys_creat fs/open.c:1346 [inline]
 __se_sys_creat fs/open.c:1340 [inline]
 __x64_sys_creat+0xc9/0x120 fs/open.c:1340
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f7b892293c9
RSP: 002b:00007f7b891982f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007f7b892b84e8 RCX: 00007f7b892293c9
RDX: 00007f7b892293c9 RSI: 0000000000000000 RDI: 00000000200001c0
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f7b892b84e0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f7b892b84e0
R13: 00007ffc24e5c05f R14: 00007f7b8928514c R15: 0030656c69662f2e
 </TASK>

Showing all locks held in the system:
2 locks held by pr/ttyS0/16:
1 lock held by khungtaskd/29:
 #0: ffffffff8bd86860 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6491
2 locks held by getty/3282:
 #0: ffff88814bbdf098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc90002cd62e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xcea/0x1230 drivers/tty/n_tty.c:2075
2 locks held by syz-executor149/3644:
 #0: ffff888074660460 (sb_writers#9){.+.+}-{0:0}, at: do_open fs/namei.c:3470 [inline]
 #0: ffff888074660460 (sb_writers#9){.+.+}-{0:0}, at: path_openat+0x1b3c/0x2910 fs/namei.c:3610
 #1: ffff888072ef9c50 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:741 [inline]
 #1: ffff888072ef9c50 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: fuse_open_common+0x35d/0x500 fs/fuse/file.c:243

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 29 Comm: khungtaskd Not tainted 5.18.0-syzkaller-10643-g9d004b2f4fea #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1e6/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:220 [inline]
 watchdog+0xc22/0xf90 kernel/hung_task.c:378
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 16 Comm: pr/ttyS0 Not tainted 5.18.0-syzkaller-10643-g9d004b2f4fea #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:io_serial_in+0x83/0xa0 drivers/tty/serial/8250/8250_port.c:461
Code: 53 1a fd 48 8d 7d 40 44 89 e1 48 b8 00 00 00 00 00 fc ff df 48 89 fa d3 e3 48 c1 ea 03 80 3c 02 00 75 16 66 03 5d 40 89 da ec <5b> 0f b6 c0 5d 41 5c c3 e8 20 10 67 fd eb a6 e8 49 10 67 fd eb e3
RSP: 0018:ffffc90000157ac0 EFLAGS: 00000002
RAX: dffffc0000000000 RBX: 00000000000003fd RCX: 0000000000000000
RDX: 00000000000003fd RSI: ffffffff84601dcc RDI: ffffffff908cd3a0
RBP: ffffffff908cd360 R08: 0000000000000001 R09: 000000000000001f
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: fffffbfff2119abf R14: fffffbfff2119a76 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe2f39f108 CR3: 00000000237d6000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 serial_in drivers/tty/serial/8250/8250.h:115 [inline]
 wait_for_xmitr+0x9a/0x210 drivers/tty/serial/8250/8250_port.c:2089
 serial8250_console_putchar+0x1d/0x60 drivers/tty/serial/8250/8250_port.c:3310
 uart_console_write+0x59/0x100 drivers/tty/serial/serial_core.c:1935
 serial8250_console_write+0xa57/0xc30 drivers/tty/serial/8250/8250_port.c:3382
 call_console_driver kernel/printk/printk.c:2075 [inline]
 __console_emit_next_record+0x896/0xa60 kernel/printk/printk.c:2916
 console_emit_next_record kernel/printk/printk.c:3721 [inline]
 printk_kthread_func.cold+0x702/0x73d kernel/printk/printk.c:3837
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>
----------------
Code disassembly (best guess):
   0:	53                   	push   %rbx
   1:	1a fd                	sbb    %ch,%bh
   3:	48 8d 7d 40          	lea    0x40(%rbp),%rdi
   7:	44 89 e1             	mov    %r12d,%ecx
   a:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  11:	fc ff df
  14:	48 89 fa             	mov    %rdi,%rdx
  17:	d3 e3                	shl    %cl,%ebx
  19:	48 c1 ea 03          	shr    $0x3,%rdx
  1d:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  21:	75 16                	jne    0x39
  23:	66 03 5d 40          	add    0x40(%rbp),%bx
  27:	89 da                	mov    %ebx,%edx
  29:	ec                   	in     (%dx),%al
* 2a:	5b                   	pop    %rbx <-- trapping instruction
  2b:	0f b6 c0             	movzbl %al,%eax
  2e:	5d                   	pop    %rbp
  2f:	41 5c                	pop    %r12
  31:	c3                   	retq
  32:	e8 20 10 67 fd       	callq  0xfd671057
  37:	eb a6                	jmp    0xffffffdf
  39:	e8 49 10 67 fd       	callq  0xfd671087
  3e:	eb e3                	jmp    0x23


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
