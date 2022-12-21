Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB67652B6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Dec 2022 03:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiLUCXo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Dec 2022 21:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLUCXn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Dec 2022 21:23:43 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA661DDFD
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Dec 2022 18:23:41 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id n23-20020a056602341700b00689fc6dbfd6so6294298ioz.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Dec 2022 18:23:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hs3rSNXR6K5lBjc2wGv2F/YyqWcWkkkVqNbSwz8vEQ4=;
        b=Avp9IQ1Dnph7SSNo7em0p/FvLOZLfTSdTAJrCbAs+pfQOB2ZgTALRZ0eN+LmxaBO2S
         jcWzavk5l9fdtFAWW5bbj5VdZ4q7ohhZyi+B7ZQYiKOGsqVBwFiz8t44AeUSoBxxE0lU
         WFDtqQD4qY4apjkkKw+ppB+BdduQAHPdFXCE361/vT23QBaJfkz81IHftJb396ti2jdU
         MHpiNdWTQueGcMr8B6LO1uq3OeWFDCswZEGqPs5NndGP/9qe0QDYAeVvszb26SLgroUZ
         FN6DCjr24CWlg95SuS51t5Koz8CPx8bSnmLnBaPYj4XyqxGyVakFGCQaSOA6IwomArhi
         VolA==
X-Gm-Message-State: AFqh2ko3vSPv7partwttPI2kDija2sJgk/NgFH/to9Oss6BzVyT4B1My
        PQGX9sBtRowloNPMmOcaSTE5C5dedb1yiUkhEdihvXaq/eqp
X-Google-Smtp-Source: AMrXdXsbOn4l2ZBm2rIObETR6nw514b+ASXxjKS9+ZTMv4bnd9JKvdrLZx6QNPuZ/AGRXYJPdBsL7DMZdtbNYMdhtwXlS/OSSFVu
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:96b:b0:300:f452:339b with SMTP id
 q11-20020a056e02096b00b00300f452339bmr32539ilt.306.1671589421278; Tue, 20 Dec
 2022 18:23:41 -0800 (PST)
Date:   Tue, 20 Dec 2022 18:23:41 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aa6d8005f04d3d00@google.com>
Subject: [syzbot] INFO: task hung in gfs2_jhead_process_page
From:   syzbot <syzbot+b9c5afe053a08cd29468@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
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

HEAD commit:    6feb57c2fd7c Merge tag 'kbuild-v6.2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1299c1c8480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d7a4eb497766cd48
dashboard link: https://syzkaller.appspot.com/bug?extid=b9c5afe053a08cd29468
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/33b2f14d0d29/disk-6feb57c2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9dea51305066/vmlinux-6feb57c2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fe83da5bf522/bzImage-6feb57c2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b9c5afe053a08cd29468@syzkaller.appspotmail.com

INFO: task kworker/1:4:32230 blocked for more than 143 seconds.
      Not tainted 6.1.0-syzkaller-13822-g6feb57c2fd7c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:4     state:D stack:23256 pid:32230 ppid:2      flags:0x00004000
Workqueue: gfs_recovery gfs2_recover_func
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0x9d1/0xe40 kernel/sched/core.c:6555
 schedule+0xcb/0x190 kernel/sched/core.c:6631
 io_schedule+0x83/0x100 kernel/sched/core.c:8811
 folio_wait_bit_common+0x8ca/0x1390 mm/filemap.c:1297
 folio_wait_locked include/linux/pagemap.h:1021 [inline]
 gfs2_jhead_process_page+0x199/0x810 fs/gfs2/lops.c:476
 gfs2_find_jhead+0xcff/0xeb0 fs/gfs2/lops.c:594
 gfs2_recover_func+0x6e4/0x1f90 fs/gfs2/recovery.c:460
 process_one_work+0x81c/0xd10 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
INFO: task syz-executor.2:10841 blocked for more than 143 seconds.
      Not tainted 6.1.0-syzkaller-13822-g6feb57c2fd7c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:24264 pid:10841 ppid:5101   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0x9d1/0xe40 kernel/sched/core.c:6555
 schedule+0xcb/0x190 kernel/sched/core.c:6631
 bit_wait+0xe/0xc0 kernel/sched/wait_bit.c:199
 __wait_on_bit+0xb5/0x170 kernel/sched/wait_bit.c:49
 out_of_line_wait_on_bit+0x1d4/0x250 kernel/sched/wait_bit.c:64
 wait_on_bit include/linux/wait_bit.h:76 [inline]
 gfs2_recover_journal+0xda/0x120 fs/gfs2/recovery.c:577
 init_journal+0x1905/0x2310 fs/gfs2/ops_fstype.c:835
 init_inodes+0xdc/0x340 fs/gfs2/ops_fstype.c:889
 gfs2_fill_super+0x1be3/0x2710 fs/gfs2/ops_fstype.c:1247
 get_tree_bdev+0x400/0x620 fs/super.c:1282
 gfs2_get_tree+0x50/0x210 fs/gfs2/ops_fstype.c:1330
 vfs_get_tree+0x88/0x270 fs/super.c:1489
 do_new_mount+0x289/0xad0 fs/namespace.c:3145
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount+0x2e3/0x3d0 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f1d5788d60a
RSP: 002b:00007f1d585ebf88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00000000000211de RCX: 00007f1d5788d60a
RDX: 0000000020021180 RSI: 00000000200211c0 RDI: 00007f1d585ebfe0
RBP: 00007f1d585ec020 R08: 00007f1d585ec020 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020021180
R13: 00000000200211c0 R14: 00007f1d585ebfe0 R15: 0000000020000180
 </TASK>

Showing all locks held in the system:
2 locks held by kworker/u4:1/11:
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8d523910 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x30/0xd00 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8d524110 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x30/0xd00 kernel/rcu/tasks.h:507
1 lock held by khungtaskd/27:
 #0: ffffffff8d523740 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
1 lock held by udevd/4424:
2 locks held by getty/4739:
 #0: ffff88814a00f098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:244
 #1: ffffc900015a02f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6e8/0x1e50 drivers/tty/n_tty.c:2177
5 locks held by syz-executor.5/5117:
2 locks held by kworker/1:4/32230:
 #0: ffff8880189b6938 ((wq_completion)gfs_recovery){+.+.}-{0:0}, at: process_one_work+0x796/0xd10 kernel/workqueue.c:2262
 #1: ffffc9000a38fd00 ((work_completion)(&jd->jd_work)){+.+.}-{0:0}, at: process_one_work+0x7d0/0xd10 kernel/workqueue.c:2264
1 lock held by syz-executor.2/10841:
 #0: ffff8880aea960e0 (&type->s_umount_key#51/1){+.+.}-{3:3}, at: alloc_super+0x212/0x920 fs/super.c:228
7 locks held by syz-executor.1/14829:
 #0: ffffffff8d3ff680 (console_lock){+.+.}-{0:0}, at: do_fb_ioctl+0x64d/0x8f0 drivers/video/fbdev/core/fbmem.c:1120
 #1: ffff88801e874078 (&fb_info->lock){+.+.}-{3:3}, at: lock_fb_info include/linux/fb.h:636 [inline]
 #1: ffff88801e874078 (&fb_info->lock){+.+.}-{3:3}, at: do_fb_ioctl+0x663/0x8f0 drivers/video/fbdev/core/fbmem.c:1121
 #2: ffff88801e879278 (&helper->lock){+.+.}-{3:3}, at: drm_fb_helper_pan_display+0xb3/0xbf0 drivers/gpu/drm/drm_fb_helper.c:1710
 #3: ffff88801e23c1b0 (&dev->master_mutex){+.+.}-{3:3}, at: drm_master_internal_acquire+0x1c/0x70 drivers/gpu/drm/drm_auth.c:457
 #4: ffff88801e879098 (&client->modeset_mutex){+.+.}-{3:3}, at: drm_client_modeset_commit_locked+0x4c/0x540 drivers/gpu/drm/drm_client_modeset.c:1150
 #5: ffffc9000a77f6d0 (crtc_ww_class_acquire){+.+.}-{0:0}, at: drm_client_modeset_commit_atomic+0xd1/0x840 drivers/gpu/drm/drm_client_modeset.c:988
 #6: ffff888145e0f8b0 (crtc_ww_class_mutex){+.+.}-{3:3}, at: modeset_lock+0x2b1/0x640 drivers/gpu/drm/drm_modeset_lock.c:314
2 locks held by syz-executor.4/14828:
6 locks held by syz-executor.0/14827:
 #0: ffff88808f015c68 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x242/0x2e0 fs/file.c:1046
 #1: ffff88802ad50460 (sb_writers#10){.+.+}-{0:0}, at: vfs_writev fs/read_write.c:933 [inline]
 #1: ffff88802ad50460 (sb_writers#10){.+.+}-{0:0}, at: do_writev+0x266/0x470 fs/read_write.c:977
 #2: ffff888021125088 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x1f3/0x500 fs/kernfs/file.c:325
 #3: ffffffff8d54b368 (cgroup_mutex){+.+.}-{3:3}, at: cgroup_kn_lock_live+0xe4/0x280 kernel/cgroup/cgroup.c:1673
 #4: ffffffff8d3c1030 (cpu_hotplug_lock){++++}-{0:0}, at: cgroup_attach_lock kernel/cgroup/cgroup.c:2435 [inline]
 #4: ffffffff8d3c1030 (cpu_hotplug_lock){++++}-{0:0}, at: cgroup_procs_write_start+0x196/0x600 kernel/cgroup/cgroup.c:2939
 #5: ffffffff8d54b550 (cgroup_threadgroup_rwsem){++++}-{0:0}, at: cgroup_attach_lock kernel/cgroup/cgroup.c:2437 [inline]
 #5: ffffffff8d54b550 (cgroup_threadgroup_rwsem){++++}-{0:0}, at: cgroup_procs_write_start+0x1ab/0x600 kernel/cgroup/cgroup.c:2939
3 locks held by syz-executor.2/14831:

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 27 Comm: khungtaskd Not tainted 6.1.0-syzkaller-13822-g6feb57c2fd7c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2d0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x4e3/0x560 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x19b/0x3e0 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:220 [inline]
 watchdog+0xcd5/0xd20 kernel/hung_task.c:377
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 5117 Comm: syz-executor.5 Not tainted 6.1.0-syzkaller-13822-g6feb57c2fd7c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:entry_SYSCALL_64_after_hwframe+0x59/0xcd
Code: 45 31 e4 45 31 ed 45 31 f6 45 31 ff 48 89 e7 48 63 f0 66 90 b9 48 00 00 00 65 48 8b 14 25 10 6f 02 00 89 d0 48 c1 ea 20 0f 30 <0f> 1f 44 00 00 e8 49 e3 e4 ff 0f 1f 44 00 00 48 8b 4c 24 58 4c 8b
RSP: 0018:ffffc9000451ff58 EFLAGS: 00000046
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000048
RDX: 0000000000000000 RSI: 0000000000000057 RDI: ffffc9000451ff58
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00005555568b2400(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffeeaf24f78 CR3: 0000000084c5d000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
RIP: 0033:0x7f4949e8ba47
Code: 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 57 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeeaf251d8 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4949e8ba47
RDX: 00007ffeeaf25210 RSI: 00007ffeeaf25210 RDI: 00007ffeeaf252a0
RBP: 00007ffeeaf252a0 R08: 0000000000000001 R09: 00007ffeeaf25070
R10: 00005555568b38e3 R11: 0000000000000206 R12: 00007f4949ee6b24
R13: 00007ffeeaf26360 R14: 00005555568b3810 R15: 00007ffeeaf263a0
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
