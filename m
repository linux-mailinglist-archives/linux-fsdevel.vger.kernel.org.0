Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFAB78F383
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 21:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbjHaTqN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 15:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbjHaTqM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 15:46:12 -0400
Received: from mail-pf1-f205.google.com (mail-pf1-f205.google.com [209.85.210.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70784E65
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 12:46:09 -0700 (PDT)
Received: by mail-pf1-f205.google.com with SMTP id d2e1a72fcca58-68a43131e39so1336988b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 12:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693511169; x=1694115969;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lWAXQAzkwTZxrI7dSS+oxuS6awvAMox3tiCnorlaTWM=;
        b=bqdjm3c5OmEY+Ik3b541xSwhyyRyA+iPNA97L4hoPLFMIPGHtxuYueqfseb304PHkk
         ePASwpD3OoRySg7Z7x6mBfzOh+K+MCMoHZwsyEGmhnK9um00XiJDZEuGqtyppmOryGMR
         ZuNe5MsxNpnqSZF0nPT6c3EudvSwH6TWjEXQrH6Dm+U2awqWOtYxW9NMazL6G5hThm1G
         h6m+egt+1EQ/q7YMme6qwqKGYOxY77N4C1OV3lLIFjOuCiulhgFtPLwXxZIR+4nFkDqX
         GSfms4Q46eFGqxyZX0l+UiKks1mDPcyYk9CXJ9BPJlRYzLZrsjiomCmmzb7mfZ43jmqc
         ZYzw==
X-Gm-Message-State: AOJu0YyV0hxuEYUbxQEmnDi6JMUENTK4Rivj+8kb5EOdFpOL3rfZK6Mu
        z6mNBcXtD0r5rfpUPGmUzQ1dhtKUUNFhRPNKZBlZp8yOyw1iTP8ySQ==
X-Google-Smtp-Source: AGHT+IFAhtEubMmbBcNO4lpSyM1R6UGZ7kiTDQyn1do6paRj4l7QsyRRvmRUu7+66X68Lzv/skhz5jKoycrnZ1nbPjj1tD7rKBo1
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:2d2a:b0:68c:460b:88f8 with SMTP id
 fa42-20020a056a002d2a00b0068c460b88f8mr283370pfb.1.1693511168982; Thu, 31 Aug
 2023 12:46:08 -0700 (PDT)
Date:   Thu, 31 Aug 2023 12:46:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a6862b06043d4b1d@google.com>
Subject: [syzbot] [hfs?] INFO: task hung in hfs_find_init
From:   syzbot <syzbot+dd327730db1381d8d2a2@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    626932085009 Add linux-next specific files for 20230825
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=129f740ba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a8c992a790e5073
dashboard link: https://syzkaller.appspot.com/bug?extid=dd327730db1381d8d2a2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15cbe42fa80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17eab870680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/46ec18b3c2fb/disk-62693208.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b4ea0cb78498/vmlinux-62693208.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5fb3938c7272/bzImage-62693208.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f4d93eaec6e2/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dd327730db1381d8d2a2@syzkaller.appspotmail.com

INFO: task kworker/u4:13:2908 blocked for more than 143 seconds.
      Not tainted 6.5.0-rc7-next-20230825-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:13   state:D stack:25664 pid:2908  ppid:2      flags:0x00004000
Workqueue: writeback wb_workfn (flush-7:0)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0xee1/0x59f0 kernel/sched/core.c:6695
 schedule+0xe7/0x1b0 kernel/sched/core.c:6771
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6830
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x967/0x1340 kernel/locking/mutex.c:747
 hfs_find_init+0x17f/0x220 fs/hfs/bfind.c:33
 hfs_ext_write_extent+0x18e/0x1f0 fs/hfs/extent.c:141
 hfs_write_inode+0xc4/0x9f0 fs/hfs/inode.c:431
 write_inode fs/fs-writeback.c:1456 [inline]
 __writeback_single_inode+0xa81/0xe70 fs/fs-writeback.c:1668
 writeback_sb_inodes+0x599/0x1010 fs/fs-writeback.c:1894
 __writeback_inodes_wb+0xff/0x2d0 fs/fs-writeback.c:1965
 wb_writeback+0x7f8/0xa90 fs/fs-writeback.c:2072
 wb_check_background_flush fs/fs-writeback.c:2142 [inline]
 wb_do_writeback fs/fs-writeback.c:2230 [inline]
 wb_workfn+0x874/0xfd0 fs/fs-writeback.c:2257
 process_one_work+0x887/0x15d0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8bb/0x1290 kernel/workqueue.c:2784
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
INFO: task syz-executor624:5050 blocked for more than 143 seconds.
      Not tainted 6.5.0-rc7-next-20230825-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor624 state:D stack:26944 pid:5050  ppid:5049   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0xee1/0x59f0 kernel/sched/core.c:6695
 schedule+0xe7/0x1b0 kernel/sched/core.c:6771
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6830
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x967/0x1340 kernel/locking/mutex.c:747
 hfs_find_init+0x17f/0x220 fs/hfs/bfind.c:33
 hfs_ext_read_extent+0x19c/0x9d0 fs/hfs/extent.c:200
 hfs_extend_file+0x4e0/0xb10 fs/hfs/extent.c:401
 hfs_bmap_reserve+0x29c/0x370 fs/hfs/btree.c:234
 __hfs_ext_write_extent+0x3cb/0x520 fs/hfs/extent.c:121
 __hfs_ext_cache_extent fs/hfs/extent.c:174 [inline]
 hfs_ext_read_extent+0x805/0x9d0 fs/hfs/extent.c:202
 hfs_extend_file+0x4e0/0xb10 fs/hfs/extent.c:401
 hfs_get_block+0x17f/0x820 fs/hfs/extent.c:353
 __block_write_begin_int+0x3c0/0x1470 fs/buffer.c:2107
 __block_write_begin fs/buffer.c:2157 [inline]
 block_write_begin+0xb1/0x490 fs/buffer.c:2216
 cont_write_begin+0x52f/0x730 fs/buffer.c:2573
 hfs_write_begin+0x87/0x140 fs/hfs/inode.c:58
 generic_perform_write+0x278/0x600 mm/filemap.c:3945
 __generic_file_write_iter+0x1f9/0x240 mm/filemap.c:4040
 generic_file_write_iter+0xe3/0x350 mm/filemap.c:4066
 call_write_iter include/linux/fs.h:1985 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x650/0xe40 fs/read_write.c:584
 ksys_write+0x12f/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7094b1ea59
RSP: 002b:00007ffe889a4368 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7094b1ea59
RDX: 000000000208e24b RSI: 0000000020000180 RDI: 0000000000000004
RBP: 00007f7094b925f0 R08: 00005555570c84c0 R09: 00005555570c84c0
R10: 00000000000002ba R11: 0000000000000246 R12: 00007ffe889a4390
R13: 00007ffe889a45b8 R14: 431bde82d7b634db R15: 00007f7094b6703b
 </TASK>
INFO: lockdep is turned off.
NMI backtrace for cpu 0
CPU: 0 PID: 29 Comm: khungtaskd Not tainted 6.5.0-rc7-next-20230825-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x277/0x380 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x299/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xfac/0x1230 kernel/hung_task.c:379
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 4486 Comm: klogd Not tainted 6.5.0-rc7-next-20230825-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:__sanitizer_cov_trace_const_cmp1+0x8/0x20 kernel/kcov.c:290
Code: 00 00 f3 0f 1e fa 48 8b 0c 24 48 89 f2 48 89 fe bf 06 00 00 00 e9 f8 fe ff ff 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 8b 0c 24 <40> 0f b6 d6 40 0f b6 f7 bf 01 00 00 00 e9 d6 fe ff ff 66 0f 1f 44
RSP: 0018:ffffc9000316f4a0 EFLAGS: 00000246
RAX: 0000000000000001 RBX: ffffc9000316f528 RCX: ffffffff813a6214
RDX: ffff88807d690000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffc9000316fca8
R13: 0000000000000001 R14: 0000000000000001 R15: 0000000000000001
FS:  00007faa97852380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056143bacf680 CR3: 000000007d4dd000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 deref_stack_reg arch/x86/kernel/unwind_orc.c:403 [inline]
 unwind_next_frame+0x1aa4/0x2390 arch/x86/kernel/unwind_orc.c:648
 arch_stack_walk+0xfa/0x170 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x96/0xd0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x81/0x90 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x185/0x3f0 mm/slub.c:3523
 __alloc_skb+0x287/0x330 net/core/skbuff.c:634
 alloc_skb include/linux/skbuff.h:1286 [inline]
 alloc_skb_with_frags+0xe4/0x710 net/core/skbuff.c:6299
 sock_alloc_send_pskb+0x7c8/0x950 net/core/sock.c:2794
 unix_dgram_sendmsg+0x455/0x1c30 net/unix/af_unix.c:1953
 sock_sendmsg_nosec net/socket.c:730 [inline]
 sock_sendmsg+0xd9/0x180 net/socket.c:753
 __sys_sendto+0x255/0x340 net/socket.c:2176
 __do_sys_sendto net/socket.c:2188 [inline]
 __se_sys_sendto net/socket.c:2184 [inline]
 __x64_sys_sendto+0xe0/0x1b0 net/socket.c:2184
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7faa979b49b5
Code: 8b 44 24 08 48 83 c4 28 48 98 c3 48 98 c3 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 26 45 31 c9 45 31 c0 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 7a 48 8b 15 44 c4 0c 00 f7 d8 64 89 02 48 83
RSP: 002b:00007fffe91a6858 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007faa979b49b5
RDX: 000000000000008b RSI: 000055f315610e90 RDI: 0000000000000003
RBP: 000055f31560c910 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000004000 R11: 0000000000000246 R12: 0000000000000013
R13: 00007faa97b42212 R14: 00007fffe91a6958 R15: 0000000000000000
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 2.859 msecs


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

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
