Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E607159E919
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 19:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbiHWRTH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 13:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbiHWRSo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:18:44 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD20AB1AD
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Aug 2022 06:47:31 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id i14-20020a5d934e000000b006892db5bcd4so7541330ioo.22
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Aug 2022 06:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=yuI0gBoDdaG1ukpIkwbYoyRmusXsLyM9T6V2Av2ljrw=;
        b=2+6v36YJ4LuVILh/QrgXSs9qNVXWCzAWQGsm3J3o0PAhspEAIazdIfGrGs8/DwWbVy
         SgoKsNq8f8T/IJ8/dvSiYGdOPq1gp336Wyyi7nEaPdDVzt06bLJLJthyfhl1HeBtt0cl
         mzl26glbaVlCA0UfSlj25QzM6jciqxEovgXzEcbJgFsYA6SzcGJZgPREaXHALQbbj0aS
         UT51oAInjxB4NgWYG/QoO2NArbgmTjsGNQTTGDqnhwoSflv7scoM8KDyryGAyXTTzeZQ
         kQr4N/TJPFgcNFbZyEXOEtRpVndf10ApbDJycBNNO0C+4ik9RUWub7atzKXbYUbkAgK+
         WOOg==
X-Gm-Message-State: ACgBeo1PP7foIszd8plmLRWgi/pU11Axu8oz0yLMmI4MLsTl3x8oPA3F
        BNWiJml6bOjKnE5F6Q2eCeq9ZFGeR2KRqGFSbyZs1o2lG2Ib
X-Google-Smtp-Source: AA6agR4ZHFxxt6GyWBMRbWHfprqC2ix/u+r4pl2sB4gpYjjaZ+jRzaJvsXMmQExDLyyUfzGgTdlNUkKwHpoFhVWu64PLUcEbAoF9
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2504:b0:343:38c9:eb27 with SMTP id
 v4-20020a056638250400b0034338c9eb27mr12178230jat.92.1661262451186; Tue, 23
 Aug 2022 06:47:31 -0700 (PDT)
Date:   Tue, 23 Aug 2022 06:47:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000048207505e6e8ced7@google.com>
Subject: [syzbot] BUG: sleeping function called from invalid context in check_noncircular
From:   syzbot <syzbot+d709b1e8ea3167a1f513@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        viro@zeniv.linux.org.uk
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

HEAD commit:    8755ae45a9e8 Add linux-next specific files for 20220819
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16960ab5080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ead6107a3bbe3c62
dashboard link: https://syzkaller.appspot.com/bug?extid=d709b1e8ea3167a1f513
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d709b1e8ea3167a1f513@syzkaller.appspotmail.com

CPU: 1 PID: 5779 Comm: syz-executor.5 Not tainted 6.0.0-rc1-next-20220819-syzkaller #0
BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1521
in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 5779, name: syz-executor.5
preempt_count: 0, expected: 0
RCU nest depth: 0, expected: 0
5 locks held by syz-executor.5/5779:
 #0: ffff8880173565e8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe3/0x100 fs/file.c:1036
 #1: ffff888021202460 (sb_writers#10){.+.+}-{0:0}, at: ksys_write+0x127/0x250 fs/read_write.c:631
 #2: ffff8880245aec88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x28c/0x610 fs/kernfs/file.c:345
 #3: ffff88807d20a748 (kn->active#223){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2b0/0x610 fs/kernfs/file.c:346
 #4: ffffffff8c0780a8 (oom_lock){+.+.}-{3:3}, at: mem_cgroup_out_of_memory+0x8d/0x270 mm/memcontrol.c:1642
irq event stamp: 4106
hardirqs last  enabled at (4105): [<ffffffff816756cd>] call_rcu+0x2dd/0x790 kernel/rcu/tree.c:2828
hardirqs last disabled at (4106): [<ffffffff894c1738>] dump_stack_lvl+0x2e/0x134 lib/dump_stack.c:139
softirqs last  enabled at (4084): [<ffffffff81491a33>] invoke_softirq kernel/softirq.c:445 [inline]
softirqs last  enabled at (4084): [<ffffffff81491a33>] __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
softirqs last disabled at (4063): [<ffffffff81491a33>] invoke_softirq kernel/softirq.c:445 [inline]
softirqs last disabled at (4063): [<ffffffff81491a33>] __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
CPU: 1 PID: 5779 Comm: syz-executor.5 Not tainted 6.0.0-rc1-next-20220819-syzkaller #0

======================================================
WARNING: possible circular locking dependency detected
6.0.0-rc1-next-20220819-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.5/5779 is trying to acquire lock:
ffff88807b920828 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_read_lock_killable include/linux/mmap_lock.h:126 [inline]
ffff88807b920828 (&mm->mmap_lock#2){++++}-{3:3}, at: __access_remote_vm+0xac/0x6f0 mm/memory.c:5461

but task is already holding lock:
ffffffff8c0780a8 (oom_lock){+.+.}-{3:3}, at: mem_cgroup_out_of_memory+0x8d/0x270 mm/memcontrol.c:1642

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (oom_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x12f/0x1350 kernel/locking/mutex.c:747
       mem_cgroup_out_of_memory+0x8d/0x270 mm/memcontrol.c:1642
       mem_cgroup_oom mm/memcontrol.c:1882 [inline]
       try_charge_memcg+0xf13/0x1300 mm/memcontrol.c:2675
       try_charge mm/memcontrol.c:2769 [inline]
       charge_memcg+0x31/0x320 mm/memcontrol.c:6816
       __mem_cgroup_charge+0x27/0x90 mm/memcontrol.c:6837
       mem_cgroup_charge include/linux/memcontrol.h:696 [inline]
       wp_page_copy+0x27c/0x1b60 mm/memory.c:3122
       do_wp_page+0x1d1/0x1910 mm/memory.c:3393
       handle_pte_fault mm/memory.c:4926 [inline]
       __handle_mm_fault+0x184b/0x3a90 mm/memory.c:5050
       handle_mm_fault+0x1c8/0x780 mm/memory.c:5171
       do_user_addr_fault+0x475/0x1210 arch/x86/mm/fault.c:1399
       handle_page_fault arch/x86/mm/fault.c:1490 [inline]
       exc_page_fault+0x94/0x170 arch/x86/mm/fault.c:1546
       asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570

-> #0 (&mm->mmap_lock#2){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain kernel/locking/lockdep.c:3829 [inline]
       __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5053
       lock_acquire kernel/locking/lockdep.c:5666 [inline]
       lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
       down_read_killable+0x9b/0x490 kernel/locking/rwsem.c:1522
       mmap_read_lock_killable include/linux/mmap_lock.h:126 [inline]
       __access_remote_vm+0xac/0x6f0 mm/memory.c:5461
       get_mm_cmdline.part.0+0x217/0x620 fs/proc/base.c:299
       get_mm_cmdline fs/proc/base.c:367 [inline]
       get_task_cmdline_kernel+0x1d9/0x220 fs/proc/base.c:367
       dump_stack_print_cmdline.part.0+0x82/0x150 lib/dump_stack.c:61
       dump_stack_print_cmdline lib/dump_stack.c:89 [inline]
       dump_stack_print_info+0x185/0x190 lib/dump_stack.c:97
       __dump_stack lib/dump_stack.c:121 [inline]
       dump_stack_lvl+0xc1/0x134 lib/dump_stack.c:140
       __might_resched.cold+0x222/0x26b kernel/sched/core.c:9896
       down_read_killable+0x75/0x490 kernel/locking/rwsem.c:1521
       mmap_read_lock_killable include/linux/mmap_lock.h:126 [inline]
       __access_remote_vm+0xac/0x6f0 mm/memory.c:5461
       get_mm_cmdline.part.0+0x217/0x620 fs/proc/base.c:299
       get_mm_cmdline fs/proc/base.c:367 [inline]
       get_task_cmdline_kernel+0x1d9/0x220 fs/proc/base.c:367
       dump_stack_print_cmdline.part.0+0x82/0x150 lib/dump_stack.c:61
       dump_stack_print_cmdline lib/dump_stack.c:89 [inline]
       dump_stack_print_info+0x185/0x190 lib/dump_stack.c:97
       __dump_stack lib/dump_stack.c:121 [inline]
       dump_stack_lvl+0xc1/0x134 lib/dump_stack.c:140
       dump_header+0x10b/0x7f9 mm/oom_kill.c:460
       oom_kill_process.cold+0x10/0x15 mm/oom_kill.c:1036
       out_of_memory+0x358/0x14a0 mm/oom_kill.c:1174
       mem_cgroup_out_of_memory+0x206/0x270 mm/memcontrol.c:1652
       memory_max_write+0x2f5/0x3c0 mm/memcontrol.c:6392
       cgroup_file_write+0x1de/0x770 kernel/cgroup/cgroup.c:3930
       kernfs_fop_write_iter+0x3f8/0x610 fs/kernfs/file.c:354
       call_write_iter include/linux/fs.h:2188 [inline]
       new_sync_write fs/read_write.c:491 [inline]
       vfs_write+0x9e9/0xdd0 fs/read_write.c:578
       ksys_write+0x127/0x250 fs/read_write.c:631
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(oom_lock);
                               lock(&mm->mmap_lock#2);
                               lock(oom_lock);
  lock(&mm->mmap_lock#2);

 *** DEADLOCK ***

5 locks held by syz-executor.5/5779:
 #0: ffff8880173565e8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe3/0x100 fs/file.c:1036
 #1: ffff888021202460 (sb_writers#10){.+.+}-{0:0}, at: ksys_write+0x127/0x250 fs/read_write.c:631
 #2: ffff8880245aec88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x28c/0x610 fs/kernfs/file.c:345
 #3: ffff88807d20a748 (kn->active#223){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2b0/0x610 fs/kernfs/file.c:346
 #4: ffffffff8c0780a8 (oom_lock){+.+.}-{3:3}, at: mem_cgroup_out_of_memory+0x8d/0x270 mm/memcontrol.c:1642

stack backtrace:
CPU: 1 PID: 5779 Comm: syz-executor.5 Not tainted 6.0.0-rc1-next-20220819-syzkaller #0
syz-executor.5[5779] cmdline: /root/syz-executor.5 exec
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:122 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:140
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3095 [inline]
 check_prevs_add kernel/locking/lockdep.c:3214 [inline]
 validate_chain kernel/locking/lockdep.c:3829 [inline]
 __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5053
 lock_acquire kernel/locking/lockdep.c:5666 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
 down_read_killable+0x9b/0x490 kernel/locking/rwsem.c:1522
 mmap_read_lock_killable include/linux/mmap_lock.h:126 [inline]
 __access_remote_vm+0xac/0x6f0 mm/memory.c:5461
 get_mm_cmdline.part.0+0x217/0x620 fs/proc/base.c:299
 get_mm_cmdline fs/proc/base.c:367 [inline]
 get_task_cmdline_kernel+0x1d9/0x220 fs/proc/base.c:367
 dump_stack_print_cmdline.part.0+0x82/0x150 lib/dump_stack.c:61
 dump_stack_print_cmdline lib/dump_stack.c:89 [inline]
 dump_stack_print_info+0x185/0x190 lib/dump_stack.c:97
 __dump_stack lib/dump_stack.c:121 [inline]
 dump_stack_lvl+0xc1/0x134 lib/dump_stack.c:140
 __might_resched.cold+0x222/0x26b kernel/sched/core.c:9896
 down_read_killable+0x75/0x490 kernel/locking/rwsem.c:1521
 mmap_read_lock_killable include/linux/mmap_lock.h:126 [inline]
 __access_remote_vm+0xac/0x6f0 mm/memory.c:5461
 get_mm_cmdline.part.0+0x217/0x620 fs/proc/base.c:299
 get_mm_cmdline fs/proc/base.c:367 [inline]
 get_task_cmdline_kernel+0x1d9/0x220 fs/proc/base.c:367
 dump_stack_print_cmdline.part.0+0x82/0x150 lib/dump_stack.c:61
 dump_stack_print_cmdline lib/dump_stack.c:89 [inline]
 dump_stack_print_info+0x185/0x190 lib/dump_stack.c:97
 __dump_stack lib/dump_stack.c:121 [inline]
 dump_stack_lvl+0xc1/0x134 lib/dump_stack.c:140
 dump_header+0x10b/0x7f9 mm/oom_kill.c:460
 oom_kill_process.cold+0x10/0x15 mm/oom_kill.c:1036
 out_of_memory+0x358/0x14a0 mm/oom_kill.c:1174
 mem_cgroup_out_of_memory+0x206/0x270 mm/memcontrol.c:1652
 memory_max_write+0x2f5/0x3c0 mm/memcontrol.c:6392
 cgroup_file_write+0x1de/0x770 kernel/cgroup/cgroup.c:3930
 kernfs_fop_write_iter+0x3f8/0x610 fs/kernfs/file.c:354
 call_write_iter include/linux/fs.h:2188 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x9e9/0xdd0 fs/read_write.c:578
 ksys_write+0x127/0x250 fs/read_write.c:631
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f47db689279
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f47dc719168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f47db79bf80 RCX: 00007f47db689279
RDX: 0000000000000012 RSI: 0000000020000080 RDI: 0000000000000006
RBP: 00007f47db6e3189 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffce4a733f R14: 00007f47dc719300 R15: 0000000000022000
 </TASK>
BUG: sleeping function called from invalid context at mm/gup.c:1215
in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 5779, name: syz-executor.5
preempt_count: 0, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
irq event stamp: 4106
hardirqs last  enabled at (4105): [<ffffffff816756cd>] call_rcu+0x2dd/0x790 kernel/rcu/tree.c:2828
hardirqs last disabled at (4106): [<ffffffff894c1738>] dump_stack_lvl+0x2e/0x134 lib/dump_stack.c:139
softirqs last  enabled at (4084): [<ffffffff81491a33>] invoke_softirq kernel/softirq.c:445 [inline]
softirqs last  enabled at (4084): [<ffffffff81491a33>] __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
softirqs last disabled at (4063): [<ffffffff81491a33>] invoke_softirq kernel/softirq.c:445 [inline]
softirqs last disabled at (4063): [<ffffffff81491a33>] __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
CPU: 1 PID: 5779 Comm: syz-executor.5 Not tainted 6.0.0-rc1-next-20220819-syzkaller #0
syz-executor.5[5779] cmdline: /root/syz-executor.5 exec
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:122 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:140
 __might_resched.cold+0x222/0x26b kernel/sched/core.c:9896
 __get_user_pages+0x451/0xfd0 mm/gup.c:1215
 __get_user_pages_locked mm/gup.c:1423 [inline]
 __get_user_pages_remote+0x18f/0x830 mm/gup.c:2133
 get_user_pages_remote+0x84/0xc0 mm/gup.c:2206
 __access_remote_vm+0x275/0x6f0 mm/memory.c:5470
 get_mm_cmdline.part.0+0x217/0x620 fs/proc/base.c:299
 get_mm_cmdline fs/proc/base.c:367 [inline]
 get_task_cmdline_kernel+0x1d9/0x220 fs/proc/base.c:367
 dump_stack_print_cmdline.part.0+0x82/0x150 lib/dump_stack.c:61
 dump_stack_print_cmdline lib/dump_stack.c:89 [inline]
 dump_stack_print_info+0x185/0x190 lib/dump_stack.c:97
 __dump_stack lib/dump_stack.c:121 [inline]
 dump_stack_lvl+0xc1/0x134 lib/dump_stack.c:140
 __might_resched.cold+0x222/0x26b kernel/sched/core.c:9896
 down_read_killable+0x75/0x490 kernel/locking/rwsem.c:1521
 mmap_read_lock_killable include/linux/mmap_lock.h:126 [inline]
 __access_remote_vm+0xac/0x6f0 mm/memory.c:5461
 get_mm_cmdline.part.0+0x217/0x620 fs/proc/base.c:299
 get_mm_cmdline fs/proc/base.c:367 [inline]
 get_task_cmdline_kernel+0x1d9/0x220 fs/proc/base.c:367
 dump_stack_print_cmdline.part.0+0x82/0x150 lib/dump_stack.c:61
 dump_stack_print_cmdline lib/dump_stack.c:89 [inline]
 dump_stack_print_info+0x185/0x190 lib/dump_stack.c:97
 __dump_stack lib/dump_stack.c:121 [inline]
 dump_stack_lvl+0xc1/0x134 lib/dump_stack.c:140
 dump_header+0x10b/0x7f9 mm/oom_kill.c:460
 oom_kill_process.cold+0x10/0x15 mm/oom_kill.c:1036
 out_of_memory+0x358/0x14a0 mm/oom_kill.c:1174
 mem_cgroup_out_of_memory+0x206/0x270 mm/memcontrol.c:1652
 memory_max_write+0x2f5/0x3c0 mm/memcontrol.c:6392
 cgroup_file_write+0x1de/0x770 kernel/cgroup/cgroup.c:3930
 kernfs_fop_write_iter+0x3f8/0x610 fs/kernfs/file.c:354
 call_write_iter include/linux/fs.h:2188 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x9e9/0xdd0 fs/read_write.c:578
 ksys_write+0x127/0x250 fs/read_write.c:631
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f47db689279
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f47dc719168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f47db79bf80 RCX: 00007f47db689279
RDX: 0000000000000012 RSI: 0000000020000080 RDI: 0000000000000006
RBP: 00007f47db6e3189 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffce4a733f R14: 00007f47dc719300 R15: 0000000000022000
 </TASK>
syz-executor.5[5779] cmdline: /root/syz-executor.5 exec
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:122 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:140
 __might_resched.cold+0x222/0x26b kernel/sched/core.c:9896
 down_read_killable+0x75/0x490 kernel/locking/rwsem.c:1521
 mmap_read_lock_killable include/linux/mmap_lock.h:126 [inline]
 __access_remote_vm+0xac/0x6f0 mm/memory.c:5461
 get_mm_cmdline.part.0+0x217/0x620 fs/proc/base.c:299
 get_mm_cmdline fs/proc/base.c:367 [inline]
 get_task_cmdline_kernel+0x1d9/0x220 fs/proc/base.c:367
 dump_stack_print_cmdline.part.0+0x82/0x150 lib/dump_stack.c:61
 dump_stack_print_cmdline lib/dump_stack.c:89 [inline]
 dump_stack_print_info+0x185/0x190 lib/dump_stack.c:97
 __dump_stack lib/dump_stack.c:121 [inline]
 dump_stack_lvl+0xc1/0x134 lib/dump_stack.c:140
 dump_header+0x10b/0x7f9 mm/oom_kill.c:460
 oom_kill_process.cold+0x10/0x15 mm/oom_kill.c:1036
 out_of_memory+0x358/0x14a0 mm/oom_kill.c:1174
 mem_cgroup_out_of_memory+0x206/0x270 mm/memcontrol.c:1652
 memory_max_write+0x2f5/0x3c0 mm/memcontrol.c:6392
 cgroup_file_write+0x1de/0x770 kernel/cgroup/cgroup.c:3930
 kernfs_fop_write_iter+0x3f8/0x610 fs/kernfs/file.c:354
 call_write_iter include/linux/fs.h:2188 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x9e9/0xdd0 fs/read_write.c:578
 ksys_write+0x127/0x250 fs/read_write.c:631
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f47db689279
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f47dc719168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f47db79bf80 RCX: 00007f47db689279
RDX: 0000000000000012 RSI: 0000000020000080 RDI: 0000000000000006
RBP: 00007f47db6e3189 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffce4a733f R14: 00007f47dc719300 R15: 0000000000022000
 </TASK>
syz-executor.5[5779] cmdline: /root/syz-executor.5 exec
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:122 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:140
 dump_header+0x10b/0x7f9 mm/oom_kill.c:460
 oom_kill_process.cold+0x10/0x15 mm/oom_kill.c:1036
 out_of_memory+0x358/0x14a0 mm/oom_kill.c:1174
 mem_cgroup_out_of_memory+0x206/0x270 mm/memcontrol.c:1652
 memory_max_write+0x2f5/0x3c0 mm/memcontrol.c:6392
 cgroup_file_write+0x1de/0x770 kernel/cgroup/cgroup.c:3930
 kernfs_fop_write_iter+0x3f8/0x610 fs/kernfs/file.c:354
 call_write_iter include/linux/fs.h:2188 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x9e9/0xdd0 fs/read_write.c:578
 ksys_write+0x127/0x250 fs/read_write.c:631
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f47db689279
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f47dc719168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f47db79bf80 RCX: 00007f47db689279
RDX: 0000000000000012 RSI: 0000000020000080 RDI: 0000000000000006
RBP: 00007f47db6e3189 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffce4a733f R14: 00007f47dc719300 R15: 0000000000022000
 </TASK>
memory: usage 432kB, limit 0kB, failcnt 27
swap: usage 0kB, limit 9007199254740988kB, failcnt 0
Memory cgroup stats for /syz1:
anon 122880
file 57344
kernel 262144
kernel_stack 65536
pagetables 81920
percpu 0
sock 0
vmalloc 0
shmem 36864
zswap 0
zswapped 0
file_mapped 36864
file_dirty 4096
file_writeback 0
swapcached 0
anon_thp 0
file_thp 0
shmem_thp 0
inactive_anon 139264
active_anon 20480
inactive_file 12288
active_file 8192
unevictable 0
slab_reclaimable 12008
slab_unreclaimable 76488
slab 88496
oom-kill:constraint=CONSTRAINT_MEMCG,nodemask=(null),cpuset=syz5,mems_allowed=0-1,oom_memcg=/syz1,task_memcg=/syz1,task=syz-executor.1,pid=3746,uid=0
Memory cgroup out of memory: Killed process 3746 (syz-executor.1) total-vm:50536kB, anon-rss:392kB, file-rss:9072kB, shmem-rss:4kB, UID:0 pgtables:72kB oom_score_adj:0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
