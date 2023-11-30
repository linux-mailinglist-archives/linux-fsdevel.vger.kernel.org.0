Return-Path: <linux-fsdevel+bounces-4455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB737FF9BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 19:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98DB62815E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FEC5A0ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C21710F2
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 08:58:23 -0800 (PST)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5c6260b60b1so985330a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 08:58:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701363502; x=1701968302;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f3LgIEz551m5QS19kYMv8+Qv6JiftTimJRxKuDcn7DA=;
        b=PtyiXv4XNxVklYABsM87ihncTxEOJRs427ElqVSEViKDMOqd4DwcpMaaJdktawMqD/
         mT5T1DuiD7ctvvN5Dga6Gz6RUf/QmCh3qyAu+Os0ZXIIewXUGnan2mVGqHWWlAKs3I/3
         4/EGYy8W9CV8TGtGUpBeUu23e4r0tGBaMO6JUxaMRPHQf5LxOmNvggLrZPSs7YuBF2Hz
         8pPPXK0T30DUv8u4TLyql02wQPO/O7xgFVaAf1ingYJKHPZb/aywrJDIGMTCfg1PF7at
         3ZeXipNo+qOavcBz4jj5uJsE+YYskUyV/twPQgzcR4RcrS1Kn1wK1cO20YWwArTRqsU8
         2lGg==
X-Gm-Message-State: AOJu0YzdwuA6SJO7yQmwZFj5DkEFJpk3/7RKh08R0VPCuR80DpGRFzIn
	PFK7WCpo/nR7SiIznFSlDvWOxsVB3o+vh9Q8vRq7XPXLT5xU
X-Google-Smtp-Source: AGHT+IFVIP1QNI42yejmrgo+Sg7pC3ZOMrJUCDPNnb4bfv2evIE+5Rp6jx8LiLoY4qymhuuj0W9/CpdyfJInl8/fAcVXbA4sU+2p
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:902:ce8a:b0:1cc:29fb:f398 with SMTP id
 f10-20020a170902ce8a00b001cc29fbf398mr5447890plg.10.1701363502571; Thu, 30
 Nov 2023 08:58:22 -0800 (PST)
Date: Thu, 30 Nov 2023 08:58:22 -0800
In-Reply-To: <000000000000e6432a06046c96a5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000349d05060b618f2a@google.com>
Subject: Re: [syzbot] [fs] INFO: task hung in __fdget_pos (4)
From: syzbot <syzbot+e245f0516ee625aaa412@syzkaller.appspotmail.com>
To: brauner@kernel.org, david@fromorbit.com, djwong@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, llvm@lists.linux.dev, mjguzik@gmail.com, 
	nathan@kernel.org, ndesaulniers@google.com, nogikh@google.com, 
	syzkaller-bugs@googlegroups.com, trix@redhat.com, tytso@mit.edu, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Level: **

syzbot has found a reproducer for the following issue on:

HEAD commit:    3b47bc037bd4 Merge tag 'pinctrl-v6.7-2' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14e6bdaae80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2c74446ab4f0028
dashboard link: https://syzkaller.appspot.com/bug?extid=e245f0516ee625aaa412
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11026e54e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/43de6cde1436/disk-3b47bc03.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/24a2ba210bcf/vmlinux-3b47bc03.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a5d414ced6d5/bzImage-3b47bc03.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c28d17ae0132/mount_4.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e245f0516ee625aaa412@syzkaller.appspotmail.com

INFO: task syz-executor.0:24270 blocked for more than 143 seconds.
      Not tainted 6.7.0-rc3-syzkaller-00033-g3b47bc037bd4 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:28784 pid:24270 tgid:24259 ppid:5149   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5376 [inline]
 __schedule+0x1961/0x4ab0 kernel/sched/core.c:6688
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6778
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6835
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x6a3/0xd60 kernel/locking/mutex.c:747
 __fdget_pos+0x2b0/0x340 fs/file.c:1177
 fdget_pos include/linux/file.h:74 [inline]
 __do_sys_getdents64 fs/readdir.c:401 [inline]
 __se_sys_getdents64+0x1dc/0x4f0 fs/readdir.c:390
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fd0cec7cae9
RSP: 002b:00007fd0cfa610c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007fd0ced9c050 RCX: 00007fd0cec7cae9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007fd0cecc847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fd0ced9c050 R15: 00007ffeeda72018
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/29:
 #0: ffffffff8d92cf60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #0: ffffffff8d92cf60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #0: ffffffff8d92cf60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
2 locks held by getty/4818:
 #0: ffff88814afe20a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900031332f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b4/0x1e10 drivers/tty/n_tty.c:2201
1 lock held by syz-executor.5/5143:
3 locks held by syz-executor.0/24262:
1 lock held by syz-executor.0/24270:
 #0: ffff88807c5574c8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x2b0/0x340 fs/file.c:1177
1 lock held by syz-executor.0/24319:
2 locks held by syz-executor.1/32017:
 #0: ffff8880b983c358 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:558
 #1: ffff8880b9828808 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x441/0x770 kernel/sched/psi.c:988
1 lock held by syz-executor.1/32030:
 #0: ffff8880b983c358 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:558
2 locks held by syz-executor.4/32028:
 #0: ffff8880b983c358 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:558
 #1: ffff8880b9828808 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x441/0x770 kernel/sched/psi.c:988
2 locks held by syz-executor.3/32042:
 #0: ffff88801cfea360 (&lo->lo_mutex){+.+.}-{3:3}, at: loop_global_lock_killable drivers/block/loop.c:120 [inline]
 #0: ffff88801cfea360 (&lo->lo_mutex){+.+.}-{3:3}, at: loop_configure+0x1f9/0x1250 drivers/block/loop.c:1023
 #1: ffffe8ffffd6a108 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x3a7/0x770 kernel/sched/psi.c:976
4 locks held by syz-executor.0/32045:

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 29 Comm: khungtaskd Not tainted 6.7.0-rc3-syzkaller-00033-g3b47bc037bd4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x498/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x310 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xfaf/0xff0 kernel/hung_task.c:379
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 5138 Comm: syz-executor.1 Not tainted 6.7.0-rc3-syzkaller-00033-g3b47bc037bd4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:orc_find arch/x86/kernel/unwind_orc.c:217 [inline]
RIP: 0010:unwind_next_frame+0x271/0x29e0 arch/x86/kernel/unwind_orc.c:494
Code: 50 00 39 eb 0f 86 f7 1d 00 00 89 e8 48 8d 1c 85 08 26 20 90 48 89 d8 48 c1 e8 03 49 be 00 00 00 00 00 fc ff df 42 0f b6 04 30 <84> c0 0f 85 89 20 00 00 44 8b 3b 89 e8 ff c0 48 8d 1c 85 08 26 20
RSP: 0018:ffffc90003f3f700 EFLAGS: 00000a06
RAX: 0000000000000000 RBX: ffffffff90211d88 RCX: 00000000000a6001
RDX: ffff88801eaa3b80 RSI: 0000000000003de0 RDI: 00000000000a6000
RBP: 0000000000003de0 R08: ffffffff813db069 R09: 0000000000000000
R10: ffffc90003f3f840 R11: fffff520007e7f14 R12: ffffc90003f3f840
R13: 00000000000a6001 R14: dffffc0000000000 R15: ffffffff813de03c
FS:  0000555556748480(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f84b6775198 CR3: 00000000200ef000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 __unwind_start+0x641/0x7a0 arch/x86/kernel/unwind_orc.c:760
 unwind_start arch/x86/include/asm/unwind.h:64 [inline]
 arch_stack_walk+0xfd/0x1a0 arch/x86/kernel/stacktrace.c:24
 stack_trace_save+0x117/0x1c0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 __kasan_slab_alloc+0x66/0x70 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook+0x6c/0x3c0 mm/slab.h:763
 slab_alloc_node mm/slub.c:3478 [inline]
 slab_alloc mm/slub.c:3486 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
 kmem_cache_alloc+0x19e/0x2b0 mm/slub.c:3502
 sk_prot_alloc+0x58/0x210 net/core/sock.c:2069
 sk_alloc+0x38/0x370 net/core/sock.c:2128
 inet_create+0x652/0xe20 net/ipv4/af_inet.c:325
 __sock_create+0x48c/0x910 net/socket.c:1569
 sock_create net/socket.c:1620 [inline]
 __sys_socket_create net/socket.c:1657 [inline]
 __sys_socket+0x14f/0x3b0 net/socket.c:1704
 __do_sys_socket net/socket.c:1718 [inline]
 __se_sys_socket net/socket.c:1716 [inline]
 __x64_sys_socket+0x7a/0x90 net/socket.c:1716
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f84b667e867
Code: f0 ff ff 77 06 c3 0f 1f 44 00 00 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 b8 29 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffed1a3ed28 EFLAGS: 00000206 ORIG_RAX: 0000000000000029
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f84b667e867
RDX: 0000000000000006 RSI: 0000000000000001 RDI: 0000000000000002
RBP: 00007ffed1a3f43c R08: 00007ffed1a3ed1c R09: 00007ffed1a3f127
R10: 00007ffed1a3eda0 R11: 0000000000000206 R12: 0000000000000032
R13: 0000000000165078 R14: 0000000000165035 R15: 0000000000000008
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

