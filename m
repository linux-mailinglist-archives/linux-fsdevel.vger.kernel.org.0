Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDE670D26D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 05:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjEWDeD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 23:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjEWDeA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 23:34:00 -0400
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F065791
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 20:33:58 -0700 (PDT)
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3383a6782b7so6117665ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 20:33:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684812838; x=1687404838;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ew2lbnvVtTJcYzL2OHkcolDBvnCfboyk+1IyIPWJe5o=;
        b=YsKXTEaFmSDU9x4scmwDL1FAx7/uqz9pvYfJrFqlnGiXC7HAb7rQu0NZmLAF0dZ6GR
         iFN0Sy9owSRabyMFBoXbU1Y9We9bh7f9ndnqzrZWUIHPy2twGtOCu8y20ssM2cdhpYFx
         nVxIpiaPqg6FFVqr4/vCbXHmBChAx8DmUepnaoF1y4VBWt4Pxo03yEJFfqLDzXFQzESV
         fM8oYGLKV58Vj54BNF174UUnSbFMVq84V4hoi4YoFTo+MEfTY3xkgJza25/1sTNfOgBI
         kjUIjYlrrZ8Bmx+ruWw+zHOJzzHAhnAYUosdNG5ZQI3II2wOIKTl8yBW8/dzDCRKnevR
         3PyA==
X-Gm-Message-State: AC+VfDzoWk5424LeWOyYzCdVDi/E+SynKdITUUrtGp4F7J+r8gLS9Tec
        HpL0BjvkUikB0uIyTHFNvpfdSVXcJXZYSf4ECOceTfekRRiOSRlqYg==
X-Google-Smtp-Source: ACHHUZ7d1J25YUxa9fcOweo8cjpErRTWFlSnItnm/ASLvTkp7kSHFsxFejGy3sBKTFUjc9DQBdNleLcamH0Yv3gqKpRRvedCxruc
MIME-Version: 1.0
X-Received: by 2002:a92:dc89:0:b0:338:66d7:5ce8 with SMTP id
 c9-20020a92dc89000000b0033866d75ce8mr7130784iln.1.1684812838337; Mon, 22 May
 2023 20:33:58 -0700 (PDT)
Date:   Mon, 22 May 2023 20:33:58 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be039005fc540ed7@google.com>
Subject: [syzbot] [reiserfs?] INFO: task hung in flush_old_commits
From:   syzbot <syzbot+0a684c061589dcc30e51@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f1fcbaa18b28 Linux 6.4-rc2
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=16a6382e280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3dc1cdd68141cdc3
dashboard link: https://syzkaller.appspot.com/bug?extid=0a684c061589dcc30e51
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=163079f9280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1239f37e280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f9e1748cceea/disk-f1fcbaa1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6dea99343621/vmlinux-f1fcbaa1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f5a93f86012d/Image-f1fcbaa1.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f87acf2fade6/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0a684c061589dcc30e51@syzkaller.appspotmail.com

INFO: task kworker/0:2:1599 blocked for more than 143 seconds.
      Not tainted 6.4.0-rc2-syzkaller-gf1fcbaa18b28 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:2     state:D stack:0     pid:1599  ppid:2      flags:0x00000008
Workqueue: events_long flush_old_commits
Call trace:
 __switch_to+0x320/0x754 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5343 [inline]
 __schedule+0x1368/0x23b8 kernel/sched/core.c:6669
 schedule+0xc4/0x170 kernel/sched/core.c:6745
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6804
 __mutex_lock_common+0xbd8/0x21a0 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:799
 reiserfs_write_lock+0x7c/0xe8 fs/reiserfs/lock.c:27
 reiserfs_sync_fs fs/reiserfs/super.c:76 [inline]
 flush_old_commits+0x1b0/0x2b8 fs/reiserfs/super.c:111
 process_one_work+0x788/0x12d4 kernel/workqueue.c:2405
 worker_thread+0x8e0/0xfe8 kernel/workqueue.c:2552
 kthread+0x288/0x310 kernel/kthread.c:379
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:870

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/13:
 #0: 
ffff8000160810d0
 (
rcu_tasks.tasks_gp_mutex
){+.+.}-{3:3}
, at: rcu_tasks_one_gp+0x44/0xcf4 kernel/rcu/tasks.h:518
1 lock held by rcu_tasks_trace/14:
 #0: 
ffff800016081490
 (
rcu_tasks_trace.tasks_gp_mutex
){+.+.}-{3:3}
, at: rcu_tasks_one_gp+0x44/0xcf4 kernel/rcu/tasks.h:518
1 lock held by khungtaskd/28:
 #0: 
ffff800016080f00
 (
rcu_read_lock
){....}-{1:2}
, at: rcu_lock_acquire+0xc/0x44 include/linux/rcupdate.h:326
4 locks held by kworker/0:2/1599:
 #0: 
ffff0000c0021538
 (
(wq_completion)events_long
){+.+.}-{0:0}
, at: process_one_work+0x664/0x12d4 kernel/workqueue.c:2378
 #1: 
ffff800022d77c20
 (
(work_completion)(&(&sbi->old_work)->work)
){+.+.}-{0:0}
, at: process_one_work+0x6a8/0x12d4 kernel/workqueue.c:2380
 #2: 
ffff0000df14e0e0
 (
&type->s_umount_key
#40
){++++}-{3:3}
, at: flush_old_commits+0xcc/0x2b8 fs/reiserfs/super.c:97
 #3: 
ffff0000c5d07090
 (
&sbi->lock
){+.+.}-{3:3}
, at: reiserfs_write_lock+0x7c/0xe8 fs/reiserfs/lock.c:27
2 locks held by getty/5732:
 #0: 
ffff0000d4c6f098
 (
&tty->ldisc_sem
){++++}-{0:0}
, at: ldsem_down_read+0x3c/0x4c drivers/tty/tty_ldsem.c:340
 #1: 
ffff80001ae302f0
 (
&ldata->atomic_read_lock
){+.+.}-{3:3}
, at: n_tty_read+0x414/0x1210 drivers/tty/n_tty.c:2176
7 locks held by syz-executor247/6003:

=============================================



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

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
