Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0EF7275835
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 14:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgIWMsR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 08:48:17 -0400
Received: from mail-il1-f206.google.com ([209.85.166.206]:39685 "EHLO
        mail-il1-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgIWMsR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 08:48:17 -0400
Received: by mail-il1-f206.google.com with SMTP id r10so16090479ilq.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2020 05:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=9amvSa+VcDc4r++Yk6yADA7yaRZOWiehjYanwAasRAA=;
        b=jx5txnYMuRr5zUEWNy1J+nIL6p5ZdKfXX58PiTa03jNL90XHBbvVSjyMFoJxVEpeE0
         OfFT4CJtIFktI+gy6XWQSUwoshReWSE4VhqoIYeeR+nRDuAh3/PvMGBsyqH+22g3cYCT
         2c/VhbwWw5wFUGQvBkkxSjZmPnq+H/PtJQOihcWNVuZ/uNkxoKtlj9wmzuo9gi9E6NUv
         M6H7w7c4jl5e4AtevT8CAkLh1CfpQPnFFd1KO7lh5tDQ8ox06UFSj4vZi74ezMIp0xiM
         WHB1AVJ8psqmKjRnfYoqR7/2RjthPg8GfMj/CXPr0KnkGMDlUOqQ/NjPXeCuJACZq+mP
         W9wg==
X-Gm-Message-State: AOAM530MEgPHvbv5u6mx2eJsjiK53rj/VNSZUBuPY9pLYUerlkn5zdea
        O0FlfVa81cT81AxkpatxEpAlCPUzdmZkKczcB8xg4sjkS77z
X-Google-Smtp-Source: ABdhPJw5gA+YlKULybj+s9D+XDakwy7FaflxmkySVHNr+TJXS+EHmV74AGCbL+EXgKZoc9Jp47/RhS77ildXDLy+xqZEJjHwx3ha
MIME-Version: 1.0
X-Received: by 2002:a02:76d5:: with SMTP id z204mr7801821jab.93.1600865295462;
 Wed, 23 Sep 2020 05:48:15 -0700 (PDT)
Date:   Wed, 23 Sep 2020 05:48:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000044f9f005affa7fb1@google.com>
Subject: INFO: task can't die in request_wait_answer
From:   syzbot <syzbot+ea48ca29949b1820e745@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    dcf2427b Add linux-next specific files for 20200923
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=111346c5900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=254e028a642027c
dashboard link: https://syzkaller.appspot.com/bug?extid=ea48ca29949b1820e745
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ea48ca29949b1820e745@syzkaller.appspotmail.com

INFO: task syz-executor.3:19649 can't die for more than 143 seconds.
task:syz-executor.3  state:D stack:27488 pid:19649 ppid:  6909 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3777 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4526
 schedule+0xcf/0x270 kernel/sched/core.c:4604
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_lookup_name+0x258/0x5c0 fs/fuse/dir.c:352
 fuse_lookup+0xdf/0x390 fs/fuse/dir.c:390
 fuse_atomic_open+0x210/0x340 fs/fuse/dir.c:533
 atomic_open fs/namei.c:2970 [inline]
 lookup_open.isra.0+0xc09/0x1350 fs/namei.c:3076
 open_last_lookups fs/namei.c:3178 [inline]
 path_openat+0x96d/0x2730 fs/namei.c:3366
 do_filp_open+0x17e/0x3c0 fs/namei.c:3396
 do_sys_openat2+0x16d/0x420 fs/open.c:1168
 do_sys_open fs/open.c:1184 [inline]
 __do_sys_openat fs/open.c:1200 [inline]
 __se_sys_openat fs/open.c:1195 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1195
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45e179
Code: Bad RIP value.
RSP: 002b:00007fe86377ac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000021e00 RCX: 000000000045e179
RDX: 0000000000000000 RSI: 0000000020002040 RDI: ffffffffffffff9c
RBP: 000000000118cf88 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118cf4c
R13: 00007ffe2255861f R14: 00007fe86377b9c0 R15: 000000000118cf4c
INFO: task syz-executor.3:19649 blocked for more than 143 seconds.
      Not tainted 5.9.0-rc6-next-20200923-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.3  state:D stack:27488 pid:19649 ppid:  6909 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3777 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4526
 schedule+0xcf/0x270 kernel/sched/core.c:4604
 request_wait_answer+0x505/0x7f0 fs/fuse/dev.c:402
 __fuse_request_send fs/fuse/dev.c:421 [inline]
 fuse_simple_request+0x526/0xc10 fs/fuse/dev.c:503
 fuse_lookup_name+0x258/0x5c0 fs/fuse/dir.c:352
 fuse_lookup+0xdf/0x390 fs/fuse/dir.c:390
 fuse_atomic_open+0x210/0x340 fs/fuse/dir.c:533
 atomic_open fs/namei.c:2970 [inline]
 lookup_open.isra.0+0xc09/0x1350 fs/namei.c:3076
 open_last_lookups fs/namei.c:3178 [inline]
 path_openat+0x96d/0x2730 fs/namei.c:3366
 do_filp_open+0x17e/0x3c0 fs/namei.c:3396
 do_sys_openat2+0x16d/0x420 fs/open.c:1168
 do_sys_open fs/open.c:1184 [inline]
 __do_sys_openat fs/open.c:1200 [inline]
 __se_sys_openat fs/open.c:1195 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1195
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45e179
Code: Bad RIP value.
RSP: 002b:00007fe86377ac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000021e00 RCX: 000000000045e179
RDX: 0000000000000000 RSI: 0000000020002040 RDI: ffffffffffffff9c
RBP: 000000000118cf88 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118cf4c
R13: 00007ffe2255861f R14: 00007fe86377b9c0 R15: 000000000118cf4c

Showing all locks held in the system:
4 locks held by kworker/u4:6/255:
 #0: ffff8880ae536098 (&rq->lock){-.-.}-{2:2}, at: rq_lock kernel/sched/sched.h:1292 [inline]
 #0: ffff8880ae536098 (&rq->lock){-.-.}-{2:2}, at: __schedule+0x284/0x2200 kernel/sched/core.c:4444
 #1: ffff8880ae520ec8 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x305/0x440 kernel/sched/psi.c:833
 #2: ffff8880ae525698 (&base->lock){-.-.}-{2:2}, at: lock_timer_base+0x5a/0x1f0 kernel/time/timer.c:947
 #3: ffffffff8dd778e0 (&obj_hash[i].lock){-.-.}-{2:2}, at: debug_object_activate+0x12e/0x3e0 lib/debugobjects.c:636
1 lock held by khungtaskd/1176:
 #0: ffffffff8a553d40 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6221
2 locks held by syz-executor.3/19649:
 #0: ffff8880552bc850 (&type->i_mutex_dir_key#8){++++}-{3:3}, at: inode_lock_shared include/linux/fs.h:792 [inline]
 #0: ffff8880552bc850 (&type->i_mutex_dir_key#8){++++}-{3:3}, at: open_last_lookups fs/namei.c:3177 [inline]
 #0: ffff8880552bc850 (&type->i_mutex_dir_key#8){++++}-{3:3}, at: path_openat+0x14a3/0x2730 fs/namei.c:3366
 #1: ffff8880552bcc28 (&fi->mutex){+.+.}-{3:3}, at: fuse_lock_inode+0xaf/0xe0 fs/fuse/inode.c:375

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1176 Comm: khungtaskd Not tainted 5.9.0-rc6-next-20200923-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fb lib/dump_stack.c:118
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:147 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:253 [inline]
 watchdog+0xd89/0xf30 kernel/hung_task.c:339
 kthread+0x3af/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 6674 Comm: rs:main Q:Reg Not tainted 5.9.0-rc6-next-20200923-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:find_held_lock+0xec/0x110 kernel/locking/lockdep.c:4922
Code: 00 fc ff df 4c 89 f2 48 c1 ea 03 0f b6 14 02 4c 89 f0 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 11 5b 45 89 3e 4c 89 e0 5d 41 5c <41> 5d 41 5e 41 5f c3 4c 89 f7 e8 75 95 5c 00 eb e5 e8 de 94 5c 00
RSP: 0018:ffffc9000a517d60 EFLAGS: 00000097
RAX: ffff888093356af8 RBX: 1ffff920014a2fb2 RCX: ffffc9000a517dd0
RDX: 0000000000000004 RSI: ffff888214090460 RDI: ffff888093356af8
RBP: ffff888214090460 R08: 0000000000000001 R09: ffff888093356ac8
R10: fffffbfff1769349 R11: 0000000000000000 R12: ffffffff81c19c45
R13: ffff888214090460 R14: ffffc9000a517dd0 R15: 0000000000000001
FS:  00007ff45700c700(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0f4c7c4018 CR3: 00000000a44c7000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __lock_release kernel/locking/lockdep.c:5083 [inline]
 lock_release+0x247/0x890 kernel/locking/lockdep.c:5418
 percpu_up_read include/linux/percpu-rwsem.h:99 [inline]
 __sb_end_write+0x2d/0x1b0 fs/super.c:1638
 file_end_write include/linux/fs.h:2782 [inline]
 vfs_write+0x375/0x700 fs/read_write.c:603
 ksys_write+0x12d/0x250 fs/read_write.c:648
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7ff459a501cd
Code: c2 20 00 00 75 10 b8 01 00 00 00 0f 05 48 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ae fc ff ff 48 89 04 24 b8 01 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 f7 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ff45700b590 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007ff44c023900 RCX: 00007ff459a501cd
RDX: 0000000000000525 RSI: 00007ff44c023900 RDI: 0000000000000006
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 00007ff44c023680
R13: 00007ff45700b5b0 R14: 0000556d485ab360 R15: 0000000000000525


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
