Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5CC43121
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 22:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388447AbfFLUxH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 16:53:07 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:50296 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbfFLUxH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 16:53:07 -0400
Received: by mail-io1-f71.google.com with SMTP id m26so13300171ioh.17
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jun 2019 13:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=YBsdv8D7E1Ty0uu7Bg8lmNFZhiJqH52Q0qJzpfU5W4o=;
        b=qmD1a6diAbqxzMbsSLtlSbNy5Yc7x7MetDrapOka1Ta11Ix0Wc10db+kOoU4ZwtCuU
         9h7yRBMLdE/llJApz2eNuVsshg6frXz89sUouTQ/xzAYIhXmna8UqAirir6Mz0wzb0+X
         +MSDk9j59ak3he9ii8e+LzXR9DRLeEoHb40Yer0CHCKi+1pSmHVsj1GRtLWCwbCJ/BvE
         jne57YtRm1oueq1z1Tu5EQbeB08N3qtzTXS4zDu6vksdqv02uHibScZLNp+/CGmBPp2n
         uSO+Uu3238llEPYJK50GwTjeGY6cDFW05ZJf0vnmZWgq754u4i4c/uVyu8tlZwh+FPDN
         SMog==
X-Gm-Message-State: APjAAAXZnxw0R/U5CH3wVz684qTiiTmWWLsInMpgWN5LLV6TqbWUsrDV
        znWgCDec6qmgyJQl5QUL36faw2+ATeP74iyOdj0OzpodtQ3X
X-Google-Smtp-Source: APXvYqzuitS9InGBPzlAzfrFxYdSGNVQ94lDMrNOMZJucaif7L6M7OVxv4aGh3ipFrw0WfecBg7mjuVwMvQnbjJDoVZZA3btnItR
MIME-Version: 1.0
X-Received: by 2002:a05:660c:ac8:: with SMTP id k8mr862525itl.147.1560372786518;
 Wed, 12 Jun 2019 13:53:06 -0700 (PDT)
Date:   Wed, 12 Jun 2019 13:53:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a861f6058b2699e0@google.com>
Subject: INFO: task syz-executor can't die for more than 143 seconds.
From:   syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    81a72c79 Add linux-next specific files for 20190612
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1451d31ea00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8aa46bbce201b8b6
dashboard link: https://syzkaller.appspot.com/bug?extid=8ab2d0f39fb79fe6ca40
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1250ae3ea00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1568557aa00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com

INFO: task syz-executor050:8619 can't die for more than 143 seconds.
syz-executor050 R  running task    27536  8619   8618 0x00004006
Call Trace:

Showing all locks held in the system:
1 lock held by khungtaskd/1046:
  #0: 00000000f58b83ec (rcu_read_lock){....}, at:  
debug_show_all_locks+0x5f/0x27e kernel/locking/lockdep.c:5262
1 lock held by rsyslogd/8504:
  #0: 00000000b8867a10 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xee/0x110  
fs/file.c:801
2 locks held by getty/8594:
  #0: 000000008c94b07f (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 000000006c5169d5 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/8595:
  #0: 0000000042bd87ed (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 000000009ebc0e1a (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/8596:
  #0: 00000000ad647db4 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000f68a3152 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/8597:
  #0: 0000000072ec45a9 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000daa58f5f (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/8598:
  #0: 000000007698feb5 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 0000000017a6b41f (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/8599:
  #0: 00000000f5a5df8a (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 000000003ed47aa1 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/8600:
  #0: 00000000ab9f490c (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000332ddba5 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
1 lock held by syz-executor050/8619:

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1046 Comm: khungtaskd Not tainted 5.2.0-rc4-next-20190612 #13
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold+0x63/0xa4 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x1be/0x236 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:249 [inline]
  watchdog+0xb88/0x12b0 kernel/hung_task.c:333
  kthread+0x354/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 8619 Comm: syz-executor050 Not tainted 5.2.0-rc4-next-20190612  
#13
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:get_current arch/x86/include/asm/current.h:15 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x8/0x50 kernel/kcov.c:101
Code: f4 ff ff ff e8 9d fa e9 ff 48 c7 05 ce b0 15 09 00 00 00 00 e9 a4 e9  
ff ff 90 90 90 90 90 90 90 90 90 55 48 89 e5 48 8b 75 08 <65> 48 8b 04 25  
c0 fd 01 00 65 8b 15 f0 fa 90 7e 81 e2 00 01 1f 00
RSP: 0018:ffff8880a9acfd80 EFLAGS: 00000206
RAX: 1ffffd40000720d9 RBX: 0000160000000000 RCX: ffffffff81682654
RDX: 0000000000000000 RSI: ffffffff8168263c RDI: ffffea00003906c8
RBP: ffff8880a9acfd80 R08: ffff88808fe146c0 R09: 0000000000000002
R10: ffff88808fe14f78 R11: ffff88808fe146c0 R12: ffffea0000390688
R13: dffffc0000000000 R14: ffffea0000390680 R15: 00000000049a5000
FS:  0000555555a3e880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 00000000a3d59000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  page_to_boot_pfn include/linux/kexec.h:325 [inline]
  kimage_alloc_page+0xac/0x9f0 kernel/kexec_core.c:708
  kimage_load_normal_segment kernel/kexec_core.c:802 [inline]
  kimage_load_segment+0x25d/0x740 kernel/kexec_core.c:919
  do_kexec_load+0x41a/0x600 kernel/kexec.c:157
  __do_sys_kexec_load kernel/kexec.c:251 [inline]
  __se_sys_kexec_load kernel/kexec.c:226 [inline]
  __x64_sys_kexec_load+0x1d5/0x260 kernel/kexec.c:226
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441149
Code: e8 fc ab 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 9b 09 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd407ca1e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000f6
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441149
RDX: 0000000020000100 RSI: 0000000000000001 RDI: fffffffffffffffe
RBP: 00000000006cb018 R08: 0000000000000004 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401f70
R13: 0000000000402000 R14: 0000000000000000 R15: 0000000000000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
