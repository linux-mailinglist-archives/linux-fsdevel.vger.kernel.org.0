Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D552014DB41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2020 14:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgA3NHR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 08:07:17 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:47925 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgA3NHR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 08:07:17 -0500
Received: by mail-io1-f70.google.com with SMTP id 13so1871041iof.14
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2020 05:07:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=lOTvOukD/lUVj4x5/yR5484vnn5bH7e+8C47S9yK3RU=;
        b=J/dOlKm61r4nt8L0OYFcCJaCBLOJ8nkuUTbhiHVrOr2Kf5/dCpc7VTd2VcpW8vQCn8
         vQh53mCv+ttlFKDGBl3X3VqYKt568gx2WwYyDBpJgMB02UoQKuYNGW608VaPLqdlmAsx
         rpDW9534PzgXQt1MfqnD/MGbGbBHSL8as1CWn2wO+ThM7M5470OQBcVSNs/gL/W5VBJR
         ynIYIcCEq5EmEs5TJD1oo3UOj8FLhRdw4vOHyuX4DF+JHrgYJDciJutoK+ZC7UtvFeiQ
         LUl7fKAoyA+rHFlRzn53r0y7Od+T9dRxEwRQY9+/a4vRq7Ki/Ds3Gd06slR/hckdfcuS
         uWBw==
X-Gm-Message-State: APjAAAVkwQ1Mq9j0tntsAE8Bf0YqbZs3wqYQZkRp2CJfZiAfARTtct0m
        hX4rADUHmwgf8M+2begPuYjEycWvPpy2XTloplrZJwv+Thf8
X-Google-Smtp-Source: APXvYqw79b5qijCZMslbzwM37BQRk64ZBJdqqeDOXkg4lVhL154z2P5SobkobeJh93e2tAsExd5bFB49mD1ASaEH50k8FOS0y+Pk
MIME-Version: 1.0
X-Received: by 2002:a02:cd0d:: with SMTP id g13mr3832686jaq.110.1580389634360;
 Thu, 30 Jan 2020 05:07:14 -0800 (PST)
Date:   Thu, 30 Jan 2020 05:07:14 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c349e1059d5b2290@google.com>
Subject: INFO: rcu detected stall in do_iter_write
From:   syzbot <syzbot+a87c28845c1590eb47e5@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    2821e26f Merge tag 'for-linus' of git://git.armlinux.org.u..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15311611e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f1c1f9c2d5c6ce1b
dashboard link: https://syzkaller.appspot.com/bug?extid=a87c28845c1590eb47e5
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1069c611e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b01d85e00000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1014e769e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1214e769e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1414e769e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a87c28845c1590eb47e5@syzkaller.appspotmail.com

hrtimer: interrupt took 32883 ns
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
	(detected by 1, t=10502 jiffies, g=11349, q=5)
rcu: All QSes seen, last rcu_preempt kthread activity 10503 (4295059717-4295049214), jiffies_till_next_fqs=1, root ->qsmask 0x0
syz-executor996 R  running task    24984 10669  10660 0x00004000
Call Trace:
 <IRQ>
 sched_show_task kernel/sched/core.c:5954 [inline]
 sched_show_task.cold+0x2ee/0x35d kernel/sched/core.c:5929
 print_other_cpu_stall kernel/rcu/tree_stall.h:410 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:538 [inline]
 rcu_pending kernel/rcu/tree.c:2827 [inline]
 rcu_sched_clock_irq.cold+0xaf4/0xc0d kernel/rcu/tree.c:2271
 update_process_times+0x2d/0x70 kernel/time/timer.c:1726
 tick_sched_handle+0xa2/0x190 kernel/time/tick-sched.c:171
 tick_sched_timer+0x53/0x140 kernel/time/tick-sched.c:1314
 __run_hrtimer kernel/time/hrtimer.c:1517 [inline]
 __hrtimer_run_queues+0x364/0xe40 kernel/time/hrtimer.c:1579
 hrtimer_interrupt+0x314/0x770 kernel/time/hrtimer.c:1641
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1110 [inline]
 smp_apic_timer_interrupt+0x160/0x610 arch/x86/kernel/apic/apic.c:1135
 apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
 </IRQ>
RIP: 0010:preempt_count arch/x86/include/asm/preempt.h:26 [inline]
RIP: 0010:check_kcov_mode kernel/kcov.c:153 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0xd/0x50 kernel/kcov.c:187
Code: 04 25 c0 1e 02 00 48 8b 80 98 13 00 00 c3 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 65 48 8b 04 25 c0 1e 02 00 <65> 8b 15 14 27 8d 7e 81 e2 00 01 1f 00 48 8b 75 08 75 2b 8b 90 80
RSP: 0018:ffffc90002067870 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: ffff88807c3ac380 RBX: ffff8880a8953ac0 RCX: ffffffff81bd09dd
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: ffffc90002067870 R08: ffff88807c3ac380 R09: ffffed10118b2e85
R10: ffffed10118b2e84 R11: ffff88808c597427 R12: 0000000000000002
R13: ffff88808c597348 R14: 0000000000000000 R15: 00000000000000d6
 fsnotify_modify include/linux/fsnotify.h:248 [inline]
 do_iter_write fs/read_write.c:974 [inline]
 do_iter_write+0x26b/0x610 fs/read_write.c:951
 vfs_iter_write+0x77/0xb0 fs/read_write.c:983
 iter_file_splice_write+0x717/0xc10 fs/splice.c:760
 do_splice_from fs/splice.c:863 [inline]
 direct_splice_actor+0x123/0x190 fs/splice.c:1037
 splice_direct_to_actor+0x3b4/0xa30 fs/splice.c:992
 do_splice_direct+0x1da/0x2a0 fs/splice.c:1080
 do_sendfile+0x597/0xd00 fs/read_write.c:1464
 __do_sys_sendfile64 fs/read_write.c:1525 [inline]
 __se_sys_sendfile64 fs/read_write.c:1511 [inline]
 __x64_sys_sendfile64+0x1dd/0x220 fs/read_write.c:1511
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4419e9
Code: e8 7c e7 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 bb 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc2dc15cd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007ffc2dc15e80 RCX: 00000000004419e9
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 00008000fffffffe R11: 0000000000000246 R12: 0000000000000000
R13: 00000000004026c0 R14: 0000000000000000 R15: 0000000000000000
rcu: rcu_preempt kthread starved for 10544 jiffies! g11349 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: RCU grace-period kthread stack dump:
rcu_preempt     R  running task    28960    10      2 0x80004000
Call Trace:
 context_switch kernel/sched/core.c:3385 [inline]
 __schedule+0x934/0x1f90 kernel/sched/core.c:4081
 schedule+0xdc/0x2b0 kernel/sched/core.c:4155
 schedule_timeout+0x486/0xc50 kernel/time/timer.c:1895
 rcu_gp_fqs_loop kernel/rcu/tree.c:1661 [inline]
 rcu_gp_kthread+0x9b2/0x18d0 kernel/rcu/tree.c:1821
 kthread+0x361/0x430 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
