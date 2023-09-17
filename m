Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E0D7A341A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Sep 2023 09:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjIQHhX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Sep 2023 03:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbjIQHgz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Sep 2023 03:36:55 -0400
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB6519B
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Sep 2023 00:36:48 -0700 (PDT)
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-6b9ef9cd887so4737921a34.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Sep 2023 00:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694936208; x=1695541008;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bE26Pn3KszQqHBtlJf7ueSc1/XFtxhJ9RbOZVjRXo5U=;
        b=s/PbD3FdJgbPc24KiZMKB8KH0VUeIRPjKBHn+s2Seyoa62ejhWNDeO64GcV6VFTb5Y
         4R2UZeRQv0zPEmaa1853x81Z0X1UCSfcTCirAVkW5Nq5TB2GIQRlAGi71eB6KnmwWHgl
         X3S+xlTmePMvQdmgLAu/sAnG0dFPcbeh6GhUifXg19bMqdu3Ayr3u9AETprS36E4Y+B2
         ebDOjGsKdepC/Mb2tiV4ZuXUyS5tRLOdgAOmNvmIz/TxHJjXbgHcF03xsc0Yhy2HkJxx
         B6kJPHibAUxNhNbNNpTZQ+qA3Yi6hi+2bZ7658CBKwni1W78yLa5KUffxczxwJjZbXds
         UQcg==
X-Gm-Message-State: AOJu0YycLBAMxomFhkkhkZuojNmzhdleXaCPN0hFLcc1gAdjIfukmlY+
        M2qvuxSYhq5+tSLNMdkjIZKAnecXlOXHYLMfv7ohJ6kMbv+aULsLfQ==
X-Google-Smtp-Source: AGHT+IHY+QJz8l3fnNKfeWvRH3RE3SnTlWdY8U6XeSKUxgsG2xxFlvAQxe5NNxaFeIIuIbP0ycJ8h445kI25u1dhMnoh1JEszxBx
MIME-Version: 1.0
X-Received: by 2002:a05:6830:2712:b0:6b8:a385:c971 with SMTP id
 j18-20020a056830271200b006b8a385c971mr3891582otu.3.1694936208064; Sun, 17 Sep
 2023 00:36:48 -0700 (PDT)
Date:   Sun, 17 Sep 2023 00:36:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009947800605891611@google.com>
Subject: [syzbot] [hfs?] INFO: task hung in hfsplus_find_init
From:   syzbot <syzbot+a0767f147b6b55daede8@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a747acc0b752 Merge tag 'linux-kselftest-next-6.6-rc2' of g..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=164b208c680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df91a3034fe3f122
dashboard link: https://syzkaller.appspot.com/bug?extid=a0767f147b6b55daede8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16fb6508680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16473130680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b28ecb88c714/disk-a747acc0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/03dd2cd5356f/vmlinux-a747acc0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/63365d9bf980/bzImage-a747acc0.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/40cbe4c7d1f5/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a0767f147b6b55daede8@syzkaller.appspotmail.com

INFO: task kworker/u4:4:59 blocked for more than 143 seconds.
      Not tainted 6.6.0-rc1-syzkaller-00014-ga747acc0b752 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:4    state:D stack:21480 pid:59    ppid:2      flags:0x00004000
Workqueue: writeback wb_workfn (flush-7:0)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6695
 schedule+0xc3/0x180 kernel/sched/core.c:6771
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6830
 __mutex_lock_common+0xe33/0x2530 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x1b/0x20 kernel/locking/mutex.c:799
 hfsplus_find_init+0x14a/0x1c0
 hfsplus_ext_read_extent fs/hfsplus/extents.c:216 [inline]
 hfsplus_file_extend+0x454/0x1b70 fs/hfsplus/extents.c:461
 hfsplus_bmap_reserve+0x105/0x4e0 fs/hfsplus/btree.c:358
 __hfsplus_ext_write_extent+0x2a4/0x5b0 fs/hfsplus/extents.c:104
 hfsplus_ext_write_extent_locked fs/hfsplus/extents.c:139 [inline]
 hfsplus_ext_write_extent+0x16a/0x1f0 fs/hfsplus/extents.c:150
 hfsplus_write_inode+0x22/0x5e0 fs/hfsplus/super.c:154
 write_inode fs/fs-writeback.c:1456 [inline]
 __writeback_single_inode+0x69b/0xfa0 fs/fs-writeback.c:1668
 writeback_sb_inodes+0x8e3/0x11d0 fs/fs-writeback.c:1894
 __writeback_inodes_wb+0x11b/0x260 fs/fs-writeback.c:1965
 wb_writeback+0x461/0xc60 fs/fs-writeback.c:2072
 wb_check_old_data_flush fs/fs-writeback.c:2176 [inline]
 wb_do_writeback fs/fs-writeback.c:2229 [inline]
 wb_workfn+0xbb5/0xff0 fs/fs-writeback.c:2257
 process_one_work+0x781/0x1130 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0xabf/0x1060 kernel/workqueue.c:2784
 kthread+0x2b8/0x350 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
INFO: lockdep is turned off.
NMI backtrace for cpu 1
CPU: 1 PID: 29 Comm: khungtaskd Not tainted 6.6.0-rc1-syzkaller-00014-ga747acc0b752 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x498/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x310 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xdf5/0xe40 kernel/hung_task.c:379
 kthread+0x2b8/0x350 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 5033 Comm: syz-executor404 Not tainted 6.6.0-rc1-syzkaller-00014-ga747acc0b752 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
RIP: 0010:dequeue_task+0x0/0x540 kernel/sched/core.c:2109
Code: c0 75 14 89 6b 68 4c 89 f7 48 89 de 44 89 fa 5b 41 5e 41 5f 5d eb 13 89 f9 80 e1 07 80 c1 03 38 c1 7c e0 e8 c2 fa 86 00 eb d9 <55> 41 57 41 56 41 55 41 54 53 50 41 89 d7 49 89 f5 48 89 fb 48 ba
RSP: 0018:ffffc90003c9f9d8 EFLAGS: 00000046
RAX: 0000000000000000 RBX: ffff88807e6e9dc0 RCX: dffffc0000000000
RDX: 0000000000000009 RSI: ffff88807e6e9dc0 RDI: ffff8880b983c300
RBP: ffffc90003c9fc08 R08: ffff88807e6e9dc7 R09: 1ffff1100fcdd3b8
R10: dffffc0000000000 R11: ffffed100fcdd3b9 R12: 0000000000002001
R13: ffffc90003c9fd98 R14: 1ffff1100fcdd3b8 R15: dffffc0000000000
FS:  00005555562d8380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001300 CR3: 000000007498d000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 deactivate_task kernel/sched/core.c:2141 [inline]
 __schedule+0x612/0x48f0 kernel/sched/core.c:6649
 schedule+0xc3/0x180 kernel/sched/core.c:6771
 do_nanosleep+0x18a/0x610 kernel/time/hrtimer.c:2047
 hrtimer_nanosleep+0x226/0x460 kernel/time/hrtimer.c:2100
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1396 [inline]
 __se_sys_clock_nanosleep+0x327/0x3b0 kernel/time/posix-timers.c:1373
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f83775a55b3
Code: 00 00 00 00 0f 1f 00 83 ff 03 74 7b 83 ff 02 b8 fa ff ff ff 49 89 ca 0f 44 f8 80 3d ee fa 03 00 00 74 14 b8 e6 00 00 00 0f 05 <f7> d8 c3 66 2e 0f 1f 84 00 00 00 00 00 48 83 ec 28 48 89 54 24 10
RSP: 002b:00007ffe226c6838 EFLAGS: 00000202 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 0000000000003ff0 RCX: 00007f83775a55b3
RDX: 00007ffe226c6850 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000000460e0 R08: 0000000000000010 R09: 00007ffe227d30b0
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffe226c68a0
R13: 00007ffe226c688c R14: 431bde82d7b634db R15: 00007f83775b503b
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.089 msecs


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
