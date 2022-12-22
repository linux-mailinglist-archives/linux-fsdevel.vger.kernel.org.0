Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D74F654637
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 19:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbiLVSyl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 13:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235379AbiLVSyQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 13:54:16 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CA02791C
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Dec 2022 10:53:55 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id r25-20020a6bfc19000000b006e002cb217fso1064565ioh.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Dec 2022 10:53:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oa7EM5KnTqbETjvoJefmB06QiJeNz3GkW1CQR+Pg8Rg=;
        b=VtPMVz6IqAq9rcQbyujvpan1nf1wZ/IaravSfgB/VI0CkbrLZ+7DfoRO923U6qcPFI
         JtT4NSNa1/eDxWlxSF3M93FC7WREyX506njp0XrupHzse6F8ymT0CIYwm6I3WWq1Z/PY
         6KzbpMJdm1Myaa5EBsOh9jFYyGthhLbvVXAsI6hogctJn89kqk5iAS0ytEwA0kDV3lFW
         Kyv5qF8XZa/t+c1+IOIDFgAuDVQb+C8MuJkxnvnZvOYmJ+ZNzNWaGkKk3YqL/2nCixCc
         iNdKn+c/qifN82UGLX0SWr/O5WPIWG+/ZglQ6wuHBZGGx3+7W6WiIshsG+g/acaIkvYq
         g8Sg==
X-Gm-Message-State: AFqh2ko4faz4pFL23L2sRfZAsrOI9IpT9Nrqh7ZHp4s9ZC/ITUCY4LO3
        i4F9TstEcUbmA5IkQI48HvnbcPM5CFfn9CYjHmVv7Nq1/95/
X-Google-Smtp-Source: AMrXdXuXBCzoK8vNJfj7RbWtgzfqAXK5CQTE7ZPYbZ//TkkkVpOfh9c6NodZZNkMlUXrHy6rsxyvrW3n97YpYCYJ1by9sv+Co2kq
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3894:b0:38a:682a:58fc with SMTP id
 b20-20020a056638389400b0038a682a58fcmr645265jav.250.1671735235280; Thu, 22
 Dec 2022 10:53:55 -0800 (PST)
Date:   Thu, 22 Dec 2022 10:53:55 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000db858c05f06f30b0@google.com>
Subject: [syzbot] [exfat?] INFO: task hung in exfat_write_inode
From:   syzbot <syzbot+2f73ed585f115e98aee8@syzkaller.appspotmail.com>
To:     linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f9ff5644bcc0 Merge tag 'hsi-for-6.2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15a7ad1b880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c163713cf9186fe7
dashboard link: https://syzkaller.appspot.com/bug?extid=2f73ed585f115e98aee8
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d6fe00480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d2fc63880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/95eb66f6b569/disk-f9ff5644.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fb05e1a5a9de/vmlinux-f9ff5644.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e2f1f698973a/bzImage-f9ff5644.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b52ba015912a/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2f73ed585f115e98aee8@syzkaller.appspotmail.com

INFO: task kworker/u4:1:11 blocked for more than 143 seconds.
      Not tainted 6.1.0-syzkaller-13139-gf9ff5644bcc0 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:1    state:D stack:18424 pid:11    ppid:2      flags:0x00004000
Workqueue: writeback wb_workfn (flush-7:2)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0x995/0xe20 kernel/sched/core.c:6555
 schedule+0xcb/0x190 kernel/sched/core.c:6631
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6690
 __mutex_lock_common+0xe4f/0x26e0 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
 exfat_write_inode+0x65/0x110 fs/exfat/inode.c:93
 write_inode fs/fs-writeback.c:1451 [inline]
 __writeback_single_inode+0x4d6/0x670 fs/fs-writeback.c:1663
 writeback_sb_inodes+0x812/0x1050 fs/fs-writeback.c:1889
 __writeback_inodes_wb+0x11d/0x260 fs/fs-writeback.c:1960
 wb_writeback+0x440/0x7b0 fs/fs-writeback.c:2065
 wb_check_background_flush fs/fs-writeback.c:2131 [inline]
 wb_do_writeback fs/fs-writeback.c:2219 [inline]
 wb_workfn+0xb3f/0xef0 fs/fs-writeback.c:2246
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
INFO: task kworker/u4:2:34 blocked for more than 144 seconds.
      Not tainted 6.1.0-syzkaller-13139-gf9ff5644bcc0 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:2    state:D stack:17088 pid:34    ppid:2      flags:0x00004000
Workqueue: writeback wb_workfn (flush-7:1)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0x995/0xe20 kernel/sched/core.c:6555
 schedule+0xcb/0x190 kernel/sched/core.c:6631
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6690
 __mutex_lock_common+0xe4f/0x26e0 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
 exfat_write_inode+0x65/0x110 fs/exfat/inode.c:93
 write_inode fs/fs-writeback.c:1451 [inline]
 __writeback_single_inode+0x4d6/0x670 fs/fs-writeback.c:1663
 writeback_sb_inodes+0x812/0x1050 fs/fs-writeback.c:1889
 __writeback_inodes_wb+0x11d/0x260 fs/fs-writeback.c:1960
 wb_writeback+0x440/0x7b0 fs/fs-writeback.c:2065
 wb_check_background_flush fs/fs-writeback.c:2131 [inline]
 wb_do_writeback fs/fs-writeback.c:2219 [inline]
 wb_workfn+0xb3f/0xef0 fs/fs-writeback.c:2246
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
INFO: task kworker/u4:5:1065 blocked for more than 145 seconds.
      Not tainted 6.1.0-syzkaller-13139-gf9ff5644bcc0 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:5    state:D stack:22144 pid:1065  ppid:2      flags:0x00004000
Workqueue: writeback wb_workfn (flush-7:4)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0x995/0xe20 kernel/sched/core.c:6555
 schedule+0xcb/0x190 kernel/sched/core.c:6631
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6690
 __mutex_lock_common+0xe4f/0x26e0 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
 exfat_write_inode+0x65/0x110 fs/exfat/inode.c:93
 write_inode fs/fs-writeback.c:1451 [inline]
 __writeback_single_inode+0x4d6/0x670 fs/fs-writeback.c:1663
 writeback_sb_inodes+0x812/0x1050 fs/fs-writeback.c:1889
 __writeback_inodes_wb+0x11d/0x260 fs/fs-writeback.c:1960
 wb_writeback+0x440/0x7b0 fs/fs-writeback.c:2065
 wb_check_background_flush fs/fs-writeback.c:2131 [inline]
 wb_do_writeback fs/fs-writeback.c:2219 [inline]
 wb_workfn+0xb3f/0xef0 fs/fs-writeback.c:2246
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
INFO: task kworker/u4:0:5140 blocked for more than 145 seconds.
      Not tainted 6.1.0-syzkaller-13139-gf9ff5644bcc0 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:0    state:D stack:21824 pid:5140  ppid:2      flags:0x00004000
Workqueue: writeback wb_workfn (flush-7:0)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0x995/0xe20 kernel/sched/core.c:6555
 schedule+0xcb/0x190 kernel/sched/core.c:6631
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6690
 __mutex_lock_common+0xe4f/0x26e0 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
 exfat_write_inode+0x65/0x110 fs/exfat/inode.c:93
 write_inode fs/fs-writeback.c:1451 [inline]
 __writeback_single_inode+0x4d6/0x670 fs/fs-writeback.c:1663
 writeback_sb_inodes+0x812/0x1050 fs/fs-writeback.c:1889
 __writeback_inodes_wb+0x11d/0x260 fs/fs-writeback.c:1960
 wb_writeback+0x440/0x7b0 fs/fs-writeback.c:2065
 wb_check_background_flush fs/fs-writeback.c:2131 [inline]
 wb_do_writeback fs/fs-writeback.c:2219 [inline]
 wb_workfn+0xb3f/0xef0 fs/fs-writeback.c:2246
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
INFO: task kworker/u4:3:5145 blocked for more than 146 seconds.
      Not tainted 6.1.0-syzkaller-13139-gf9ff5644bcc0 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:3    state:D stack:22144 pid:5145  ppid:2      flags:0x00004000
Workqueue: writeback wb_workfn (flush-7:3)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0x995/0xe20 kernel/sched/core.c:6555
 schedule+0xcb/0x190 kernel/sched/core.c:6631
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6690
 __mutex_lock_common+0xe4f/0x26e0 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
 exfat_write_inode+0x65/0x110 fs/exfat/inode.c:93
 write_inode fs/fs-writeback.c:1451 [inline]
 __writeback_single_inode+0x4d6/0x670 fs/fs-writeback.c:1663
 writeback_sb_inodes+0x812/0x1050 fs/fs-writeback.c:1889
 __writeback_inodes_wb+0x11d/0x260 fs/fs-writeback.c:1960
 wb_writeback+0x440/0x7b0 fs/fs-writeback.c:2065
 wb_check_background_flush fs/fs-writeback.c:2131 [inline]
 wb_do_writeback fs/fs-writeback.c:2219 [inline]
 wb_workfn+0xb3f/0xef0 fs/fs-writeback.c:2246
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
INFO: task kworker/u4:4:5146 blocked for more than 147 seconds.
      Not tainted 6.1.0-syzkaller-13139-gf9ff5644bcc0 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:4    state:D stack:22144 pid:5146  ppid:2      flags:0x00004000
Workqueue: writeback wb_workfn (flush-7:5)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0x995/0xe20 kernel/sched/core.c:6555
 schedule+0xcb/0x190 kernel/sched/core.c:6631
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6690
 __mutex_lock_common+0xe4f/0x26e0 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
 exfat_write_inode+0x65/0x110 fs/exfat/inode.c:93
 write_inode fs/fs-writeback.c:1451 [inline]
 __writeback_single_inode+0x4d6/0x670 fs/fs-writeback.c:1663
 writeback_sb_inodes+0x812/0x1050 fs/fs-writeback.c:1889
 __writeback_inodes_wb+0x11d/0x260 fs/fs-writeback.c:1960
 wb_writeback+0x440/0x7b0 fs/fs-writeback.c:2065
 wb_check_background_flush fs/fs-writeback.c:2131 [inline]
 wb_do_writeback fs/fs-writeback.c:2219 [inline]
 wb_workfn+0xb3f/0xef0 fs/fs-writeback.c:2246
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Showing all locks held in the system:
4 locks held by kworker/u4:1/11:
 #0: ffff8881451dc938 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x7f2/0xdb0
 #1: ffffc90000107d00 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x831/0xdb0 kernel/workqueue.c:2264
 #2: ffff88802bc260e0 (&type->s_umount_key#42){.+.+}-{3:3}, at: trylock_super+0x1b/0xf0 fs/super.c:415
 #3: ffff888079e060e0 (&sbi->s_lock){+.+.}-{3:3}, at: exfat_write_inode+0x65/0x110 fs/exfat/inode.c:93
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8d326e50 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x30/0xd00 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8d327650 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x30/0xd00 kernel/rcu/tasks.h:507
1 lock held by khungtaskd/28:
 #0: ffffffff8d326c80 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
4 locks held by kworker/u4:2/34:
 #0: ffff8881451dc938 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x7f2/0xdb0
 #1: ffffc90000ab7d00 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x831/0xdb0 kernel/workqueue.c:2264
 #2: ffff888022bd40e0 (&type->s_umount_key#42){.+.+}-{3:3}, at: trylock_super+0x1b/0xf0 fs/super.c:415
 #3: ffff88807a1c40e0 (&sbi->s_lock){+.+.}-{3:3}, at: exfat_write_inode+0x65/0x110 fs/exfat/inode.c:93
4 locks held by kworker/u4:5/1065:
 #0: ffff8881451dc938 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x7f2/0xdb0
 #1: ffffc900056dfd00 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x831/0xdb0 kernel/workqueue.c:2264
 #2: ffff8880756600e0 (&type->s_umount_key#42){.+.+}-{3:3}, at: trylock_super+0x1b/0xf0 fs/super.c:415
 #3: ffff88802b40c0e0 (&sbi->s_lock){+.+.}-{3:3}, at: exfat_write_inode+0x65/0x110 fs/exfat/inode.c:93
2 locks held by getty/4750:
 #0: ffff888028235098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:244
 #1: ffffc900015902f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x53b/0x1650 drivers/tty/n_tty.c:2177
6 locks held by syz-executor402/5133:
6 locks held by syz-executor402/5134:
6 locks held by syz-executor402/5135:
6 locks held by syz-executor402/5136:
6 locks held by syz-executor402/5137:
6 locks held by syz-executor402/5138:
4 locks held by kworker/u4:0/5140:
 #0: ffff8881451dc938 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x7f2/0xdb0
 #1: ffffc90003effd00 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x831/0xdb0 kernel/workqueue.c:2264
 #2: ffff8880756620e0 (&type->s_umount_key#42){.+.+}-{3:3}, at: trylock_super+0x1b/0xf0 fs/super.c:415
 #3: ffff88807f4ae0e0 (&sbi->s_lock){+.+.}-{3:3}, at: exfat_write_inode+0x65/0x110 fs/exfat/inode.c:93
4 locks held by kworker/u4:3/5145:
 #0: ffff8881451dc938 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x7f2/0xdb0
 #1: ffffc90003f1fd00 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x831/0xdb0 kernel/workqueue.c:2264
 #2: ffff8880757220e0 (&type->s_umount_key#42){.+.+}-{3:3}, at: trylock_super+0x1b/0xf0 fs/super.c:415
 #3: ffff88802b6100e0 (&sbi->s_lock){+.+.}-{3:3}, at: exfat_write_inode+0x65/0x110 fs/exfat/inode.c:93
4 locks held by kworker/u4:4/5146:
 #0: ffff8881451dc938 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x7f2/0xdb0
 #1: ffffc90003f3fd00 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x831/0xdb0 kernel/workqueue.c:2264
 #2: ffff88802bda60e0 (&type->s_umount_key#42){.+.+}-{3:3}, at: trylock_super+0x1b/0xf0 fs/super.c:415
 #3: ffff88807bd960e0 (&sbi->s_lock){+.+.}-{3:3}, at: exfat_write_inode+0x65/0x110 fs/exfat/inode.c:93

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 28 Comm: khungtaskd Not tainted 6.1.0-syzkaller-13139-gf9ff5644bcc0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x46f/0x4f0 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1ba/0x420 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:220 [inline]
 watchdog+0xcd5/0xd20 kernel/hung_task.c:377
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 5133 Comm: syz-executor402 Not tainted 6.1.0-syzkaller-13139-gf9ff5644bcc0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:is_valid_cluster fs/exfat/exfat_fs.h:413 [inline]
RIP: 0010:exfat_clear_bitmap+0x85/0x5b0 fs/exfat/balloc.c:171
Code: e8 30 e2 84 ff 4c 8b 3b bf 01 00 00 00 44 89 e6 e8 40 4a 2f ff 41 83 fc 01 0f 86 cb 01 00 00 49 8d 5f 08 48 89 d8 48 c1 e8 03 <42> 8a 04 28 84 c0 0f 85 78 03 00 00 8b 1b 89 df 44 89 e6 e8 93 47
RSP: 0018:ffffc90003b1f838 EFLAGS: 00000a02
RAX: 1ffff1100fe95c01 RBX: ffff88807f4ae008 RCX: 0000000000000000
RDX: ffff88801f718000 RSI: 000000003c2e4184 RDI: 0000000000000001
RBP: ffff888075662000 R08: ffffffff825c8fa0 R09: ffffed100e7265b4
R10: ffffed100e7265b4 R11: 1ffff1100e7265b3 R12: 000000003c2e4184
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff88807f4ae000
FS:  000055555561c300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d87a197600 CR3: 000000007e2a5000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __exfat_free_cluster+0x470/0x9c0 fs/exfat/fatent.c:192
 exfat_free_cluster+0x73/0xc0 fs/exfat/fatent.c:232
 __exfat_truncate+0x67e/0x980 fs/exfat/file.c:184
 exfat_evict_inode+0xce/0x270 fs/exfat/inode.c:624
 evict+0x2a4/0x620 fs/inode.c:664
 __dentry_kill+0x3b1/0x5b0 fs/dcache.c:607
 dentry_kill+0xbb/0x290
 dput+0x1f3/0x410 fs/dcache.c:913
 do_renameat2+0xabf/0x12d0 fs/namei.c:4932
 __do_sys_rename fs/namei.c:4976 [inline]
 __se_sys_rename fs/namei.c:4974 [inline]
 __x64_sys_rename+0x82/0x90 fs/namei.c:4974
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe1e540ea79
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff21223158 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe1e540ea79
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000020000040
RBP: 0000000000000000 R08: 00007fff21223180 R09: 00007fff21223180
R10: 00007fff21223030 R11: 0000000000000246 R12: 00007fe1e53cd890
R13: 00007fff212231b0 R14: 00007fff21223190 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
