Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805587680C9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jul 2023 19:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjG2RkF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jul 2023 13:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjG2RkF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jul 2023 13:40:05 -0400
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E9135A7
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Jul 2023 10:40:03 -0700 (PDT)
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-6bc59b0fff5so5485206a34.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Jul 2023 10:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690652402; x=1691257202;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rjxK3XV1otPT2AJW0VPhw9tTAbXB8TE45wNHUlygPOM=;
        b=FVsFEpQAHz+QloAUvxI9a1gtLF4MCvFT0xA+Myr51/q6NTnqbGz+39qpoMcgEkc0mE
         hpKYoWw6cMeSPSolPYI6028n79F/2QdOI/9NjB1EjF5g39otcuk7vfknQnKXNgEiotoM
         eRLa72iuVq9hc2/OOqlmscxFKpqolg7KDwR0U2L6f58CiYeBuEuEIg38m6JuPa5wzv5a
         nPrRv57myNwJHAIty4qkOG6vFPvov+c2X632lTckM08hVeYpRSzuuJRxr7FYbUdFA+su
         t4HCHqzPx+1v8Q4V5OO8S5q3MLtTKcud5AZR4evZfODPeYfvlITLLnm6YHh19GB/p+8i
         2CJw==
X-Gm-Message-State: ABy/qLbalv7/e4dFfu3X85MS3sCuZYPUYG9CMVA47jlj/MdcibAvQCTd
        FVR82mllGzVVeoGBhdrtLGVARCOYMx4psDAYkFvGKCBZ4jP3
X-Google-Smtp-Source: APBJJlGSrgqXtHZN3f5gw2tH8Vy5rPREE216dDwwWzpQncvwgXnd0G7hzLrp3WUBT2hvA5+3dBeFdaI17H2xMTLNJFR12xJdWS1S
MIME-Version: 1.0
X-Received: by 2002:a9d:7f0a:0:b0:6b7:45a8:a80c with SMTP id
 j10-20020a9d7f0a000000b006b745a8a80cmr6807545otq.3.1690652402744; Sat, 29 Jul
 2023 10:40:02 -0700 (PDT)
Date:   Sat, 29 Jul 2023 10:40:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e7813b0601a3af69@google.com>
Subject: [syzbot] [fat?] INFO: task hung in exfat_sync_fs
From:   syzbot <syzbot+205c2644abdff9d3f9fc@syzkaller.appspotmail.com>
To:     linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    57012c57536f Merge tag 'net-6.5-rc4' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1675faf9a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d10d93e1ae1f229
dashboard link: https://syzkaller.appspot.com/bug?extid=205c2644abdff9d3f9fc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7336195c1d93/disk-57012c57.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e7a6562e4033/vmlinux-57012c57.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7d66531ff83b/bzImage-57012c57.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+205c2644abdff9d3f9fc@syzkaller.appspotmail.com

INFO: task syz-executor.0:13703 blocked for more than 143 seconds.
      Not tainted 6.5.0-rc3-syzkaller-00123-g57012c57536f #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:24584 pid:13703 ppid:20024  flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6710
 schedule+0xc3/0x180 kernel/sched/core.c:6786
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6845
 __mutex_lock_common+0xe33/0x2530 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x1b/0x20 kernel/locking/mutex.c:799
 exfat_sync_fs+0x6b/0x100 fs/exfat/super.c:65
 iterate_supers+0x12b/0x1e0 fs/super.c:744
 ksys_sync+0xdb/0x1c0 fs/sync.c:104
 __do_sys_sync+0xe/0x20 fs/sync.c:113
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0e7e87cb29
RSP: 002b:00007f0e7f52c0c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00007f0e7e99bf80 RCX: 00007f0e7e87cb29
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007f0e7e8c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f0e7e99bf80 R15: 00007ffc7df7aba8
 </TASK>
INFO: task syz-executor.0:13704 blocked for more than 143 seconds.
      Not tainted 6.5.0-rc3-syzkaller-00123-g57012c57536f #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:26152 pid:13704 ppid:20024  flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6710
 schedule+0xc3/0x180 kernel/sched/core.c:6786
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6845
 __mutex_lock_common+0xe33/0x2530 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x1b/0x20 kernel/locking/mutex.c:799
 exfat_sync_fs+0x6b/0x100 fs/exfat/super.c:65
 iterate_supers+0x12b/0x1e0 fs/super.c:744
 ksys_sync+0xdb/0x1c0 fs/sync.c:104
 __do_sys_sync+0xe/0x20 fs/sync.c:113
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0e7e87cb29
RSP: 002b:00007f0e7f50b0c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00007f0e7e99c050 RCX: 00007f0e7e87cb29
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007f0e7e8c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f0e7e99c050 R15: 00007ffc7df7aba8
 </TASK>
INFO: task syz-executor.0:13705 blocked for more than 144 seconds.
      Not tainted 6.5.0-rc3-syzkaller-00123-g57012c57536f #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:27336 pid:13705 ppid:20024  flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6710
 schedule+0xc3/0x180 kernel/sched/core.c:6786
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6845
 __mutex_lock_common+0xe33/0x2530 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x1b/0x20 kernel/locking/mutex.c:799
 exfat_sync_fs+0x6b/0x100 fs/exfat/super.c:65
 iterate_supers+0x12b/0x1e0 fs/super.c:744
 ksys_sync+0xdb/0x1c0 fs/sync.c:104
 __do_sys_sync+0xe/0x20 fs/sync.c:113
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0e7e87cb29
RSP: 002b:00007f0e750060c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00007f0e7e99c120 RCX: 00007f0e7e87cb29
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007f0e7e8c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f0e7e99c120 R15: 00007ffc7df7aba8
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/13:
 #0: ffffffff8d328db0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x29/0xd20 kernel/rcu/tasks.h:522
1 lock held by rcu_tasks_trace/14:
 #0: ffffffff8d329170 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x29/0xd20 kernel/rcu/tasks.h:522
1 lock held by khungtaskd/27:
 #0: ffffffff8d328be0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
2 locks held by getty/4768:
 #0: ffff88802cdfa098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900015a02f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b1/0x1dc0 drivers/tty/n_tty.c:2187
5 locks held by kworker/u4:8/6147:
 #0: ffff8880b993bf98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:558
 #1: ffff8880b99287c8 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x441/0x770 kernel/sched/psi.c:999
 #2: ffff8880b99295d8 (&base->lock){-.-.}-{2:2}, at: __mod_timer+0x692/0xf40 kernel/time/timer.c:1112
 #3: ffffffff922b52c0 (&obj_hash[i].lock){-.-.}-{2:2}, at: debug_object_activate+0x163/0x530 lib/debugobjects.c:717
 #4: ffffffff8d1da0a8 (text_mutex){+.+.}-{3:3}, at: arch_jump_label_transform_apply+0x12/0x30 arch/x86/kernel/jump_label.c:145
3 locks held by syz-executor.4/5979:
2 locks held by syz-executor.0/13703:
 #0: ffff8880797680e0 (&type->s_umount_key#49){++++}-{3:3}, at: iterate_supers+0xb0/0x1e0 fs/super.c:742
 #1: ffff88807976a0e0 (&sbi->s_lock){+.+.}-{3:3}, at: exfat_sync_fs+0x6b/0x100 fs/exfat/super.c:65
2 locks held by syz-executor.0/13704:
 #0: ffff8880797680e0 (&type->s_umount_key#49){++++}-{3:3}, at: iterate_supers+0xb0/0x1e0 fs/super.c:742
 #1: ffff88807976a0e0 (&sbi->s_lock){+.+.}-{3:3}, at: exfat_sync_fs+0x6b/0x100 fs/exfat/super.c:65
2 locks held by syz-executor.0/13705:
 #0: ffff8880797680e0 (&type->s_umount_key#49){++++}-{3:3}, at: iterate_supers+0xb0/0x1e0 fs/super.c:742
 #1: ffff88807976a0e0 (&sbi->s_lock){+.+.}-{3:3}, at: exfat_sync_fs+0x6b/0x100 fs/exfat/super.c:65
2 locks held by syz-executor.0/13946:
 #0: ffff8880797680e0 (&type->s_umount_key#49){++++}-{3:3}, at: iterate_supers+0xb0/0x1e0 fs/super.c:742
 #1: ffff88807976a0e0 (&sbi->s_lock){+.+.}-{3:3}, at: exfat_sync_fs+0x6b/0x100 fs/exfat/super.c:65
2 locks held by syz-executor.0/14038:
 #0: ffff8880797680e0 (&type->s_umount_key#49){++++}-{3:3}, at: iterate_supers+0xb0/0x1e0 fs/super.c:742
 #1: ffff88807976a0e0 (&sbi->s_lock){+.+.}-{3:3}, at: exfat_sync_fs+0x6b/0x100 fs/exfat/super.c:65
2 locks held by syz-executor.0/14039:
 #0: ffff8880797680e0 (&type->s_umount_key#49){++++}-{3:3}, at: iterate_supers+0xb0/0x1e0 fs/super.c:742
 #1: ffff88807976a0e0 (&sbi->s_lock){+.+.}-{3:3}, at: exfat_sync_fs+0x6b/0x100 fs/exfat/super.c:65
2 locks held by syz-executor.0/14040:
 #0: ffff8880797680e0 (&type->s_umount_key#49){++++}-{3:3}, at: iterate_supers+0xb0/0x1e0 fs/super.c:742
 #1: ffff88807976a0e0 (&sbi->s_lock){+.+.}-{3:3}, at: exfat_sync_fs+0x6b/0x100 fs/exfat/super.c:65
2 locks held by dhcpcd/14047:
 #0: ffff88803d73e130 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1708 [inline]
 #0: ffff88803d73e130 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0x32/0xc10 net/packet/af_packet.c:3202
 #1: ffffffff8d32e278 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:293 [inline]
 #1: ffffffff8d32e278 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x3a3/0x890 kernel/rcu/tree_exp.h:992

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 27 Comm: khungtaskd Not tainted 6.5.0-rc3-syzkaller-00123-g57012c57536f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x498/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x187/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xec2/0xf00 kernel/hung_task.c:379
 kthread+0x2b8/0x350 kernel/kthread.c:389
 ret_from_fork+0x2e/0x60 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:296
RIP: 0000:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 4453 Comm: syslogd Not tainted 6.5.0-rc3-syzkaller-00123-g57012c57536f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
RIP: 0010:memset_orig+0x33/0xac arch/x86/lib/memset_64.S:67
Code: b6 ce 48 b8 01 01 01 01 01 01 01 01 48 0f af c1 41 89 f9 41 83 e1 07 75 6c 48 89 d1 48 c1 e9 06 74 35 0f 1f 44 00 00 48 ff c9 <48> 89 07 48 89 47 08 48 89 47 10 48 89 47 18 48 89 47 20 48 89 47
RSP: 0018:ffffc90005697418 EFLAGS: 00000247
RAX: 0000000000000000 RBX: ffff88807e278000 RCX: 0000000000000000
RDX: 0000000000000060 RSI: 0000000000000000 RDI: ffffc90005697480
RBP: dffffc0000000000 R08: ffffc900056974df R09: 0000000000000000
R10: ffffc90005697480 R11: fffff52000ad2e9c R12: 0000000000000000
R13: ffffffff817a0b80 R14: ffffc90005697480 R15: 0000000000000000
FS:  00007f0dc2ea9380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005611df817600 CR3: 0000000028c84000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 __unwind_start+0x36/0x720 arch/x86/kernel/unwind_orc.c:688
 unwind_start arch/x86/include/asm/unwind.h:64 [inline]
 arch_stack_walk+0xdf/0x140 arch/x86/kernel/stacktrace.c:24
 stack_trace_save+0x117/0x1c0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1792 [inline]
 slab_free_freelist_hook mm/slub.c:1818 [inline]
 slab_free mm/slub.c:3801 [inline]
 __kmem_cache_free+0x25f/0x3b0 mm/slub.c:3814
 skb_kfree_head net/core/skbuff.c:894 [inline]
 skb_free_head net/core/skbuff.c:906 [inline]
 skb_release_data+0x660/0x850 net/core/skbuff.c:936
 skb_release_all net/core/skbuff.c:1002 [inline]
 __kfree_skb net/core/skbuff.c:1016 [inline]
 consume_skb+0xb3/0x150 net/core/skbuff.c:1232
 __unix_dgram_recvmsg+0xcb7/0x1260 net/unix/af_unix.c:2442
 sock_recvmsg_nosec net/socket.c:1020 [inline]
 sock_recvmsg net/socket.c:1041 [inline]
 sock_read_iter+0x3ab/0x500 net/socket.c:1107
 call_read_iter include/linux/fs.h:1865 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x795/0xb00 fs/read_write.c:470
 ksys_read+0x1a0/0x2c0 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0dc2ffdb6a
Code: 00 3d 00 00 41 00 75 0d 50 48 8d 3d 2d 08 0a 00 e8 ea 7d 01 00 31 c0 e9 07 ff ff ff 64 8b 04 25 18 00 00 00 85 c0 75 1b 0f 05 <48> 3d 00 f0 ff ff 76 6c 48 8b 15 8f a2 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffc321f7068 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f0dc2ffdb6a
RDX: 00000000000000ff RSI: 0000558a4fb90950 RDI: 0000000000000000
RBP: 0000558a4fb90910 R08: 0000000000000001 R09: 0000000000000000
R10: 00007f0dc319c3a3 R11: 0000000000000246 R12: 0000558a4fb9099d
R13: 0000558a4fb90950 R14: 0000000000000000 R15: 00007f0dc31daa80
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
