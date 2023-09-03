Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5720C790AB9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Sep 2023 06:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbjICELj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Sep 2023 00:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjICELi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Sep 2023 00:11:38 -0400
Received: from mail-pl1-f206.google.com (mail-pl1-f206.google.com [209.85.214.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60466CD6
        for <linux-fsdevel@vger.kernel.org>; Sat,  2 Sep 2023 21:11:35 -0700 (PDT)
Received: by mail-pl1-f206.google.com with SMTP id d9443c01a7336-1bf703dd21fso3088325ad.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Sep 2023 21:11:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693714295; x=1694319095;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xhL0JQKKTSEeZe1XyeQsp1u/R3+IwtRNPtAShwBhWms=;
        b=AJqg7TgmHc8UzHMe5en13fbgHPK5W72mIdfOj7u455ERBBL6nnVFav5MuceEKx77gg
         h2H6KsAQ6doEOTe5bXX1yWmnBLmicPeWPOhK1QyXyFm7TH06UMJls58Acr3BzwMGIFiY
         oJTWHDkGuEF51r+o0g4sQu7ONPfdr/EO9k4Ppy+dbfZ/JS+wDYQkGxlgeImjlrViTnM/
         AofD3SndZRehW8fnrqoWuChrK0Mz59GRC/DDGljf+zhwk/hcxS54el7tEBwDVBuYNBnD
         1JHq3IrhDyhy317SxPBAPZec5qJ14X7exG8lpJWaRhcsER0Pt/VhV2OXT7Z69FN+rcuu
         VdNw==
X-Gm-Message-State: AOJu0YxJLG+jy8QqqFU1kKK2b+18NifmNPmH3namqxJNdeWa0sJATiEe
        YtNWbUtxyhYQ39T/P4sUbO1F2xKBYabsNWa+4Hi0JMIFloBn
X-Google-Smtp-Source: AGHT+IE67z5CMlYiOP1dRd0hXSvt/GN8IHEdXcCS2abyfxF0uLmyr1GlissWcIkK3Wakq5XJIqZHWGrTOg9Cb4smTPqXjy1vCvTz
MIME-Version: 1.0
X-Received: by 2002:a17:902:dacb:b0:1b8:929f:1990 with SMTP id
 q11-20020a170902dacb00b001b8929f1990mr2360767plx.6.1693714294913; Sat, 02 Sep
 2023 21:11:34 -0700 (PDT)
Date:   Sat, 02 Sep 2023 21:11:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e6432a06046c96a5@google.com>
Subject: [syzbot] [xfs?] INFO: task hung in __fdget_pos (4)
From:   syzbot <syzbot+e245f0516ee625aaa412@syzkaller.appspotmail.com>
To:     brauner@kernel.org, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b97d64c72259 Merge tag '6.6-rc-smb3-client-fixes-part1' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14136d8fa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=958c1fdc38118172
dashboard link: https://syzkaller.appspot.com/bug?extid=e245f0516ee625aaa412
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/99875b49c50b/disk-b97d64c7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5bcacc1a3f5b/vmlinux-b97d64c7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e2fe9c8de38a/bzImage-b97d64c7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e245f0516ee625aaa412@syzkaller.appspotmail.com

INFO: task syz-executor.0:19830 blocked for more than 143 seconds.
      Not tainted 6.5.0-syzkaller-08894-gb97d64c72259 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:26480 pid:19830 ppid:5057   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6695
 schedule+0xc3/0x180 kernel/sched/core.c:6771
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6830
 __mutex_lock_common+0xe33/0x2530 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x1b/0x20 kernel/locking/mutex.c:799
 __fdget_pos+0x2b0/0x340 fs/file.c:1064
 fdget_pos include/linux/file.h:74 [inline]
 ksys_write+0x82/0x2c0 fs/read_write.c:628
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f61ad07cae9
RSP: 002b:00007f61abbfe0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f61ad19c050 RCX: 00007f61ad07cae9
RDX: 0000000000000090 RSI: 0000000020000200 RDI: 0000000000000005
RBP: 00007f61ad0c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f61ad19c050 R15: 00007ffc19e49218
 </TASK>
INFO: task syz-executor.0:19835 blocked for more than 143 seconds.
      Not tainted 6.5.0-syzkaller-08894-gb97d64c72259 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:29552 pid:19835 ppid:5057   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6695
 schedule+0xc3/0x180 kernel/sched/core.c:6771
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6830
 rwsem_down_read_slowpath+0x5f4/0x950 kernel/locking/rwsem.c:1086
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0x9c/0x2f0 kernel/locking/rwsem.c:1522
 inode_lock_shared include/linux/fs.h:812 [inline]
 lookup_slow+0x45/0x70 fs/namei.c:1709
 walk_component+0x2d0/0x400 fs/namei.c:2001
 lookup_last fs/namei.c:2458 [inline]
 path_lookupat+0x16f/0x450 fs/namei.c:2482
 filename_lookup+0x255/0x610 fs/namei.c:2511
 user_path_at_empty+0x44/0x180 fs/namei.c:2910
 user_path_at include/linux/namei.h:57 [inline]
 __do_sys_chdir fs/open.c:551 [inline]
 __se_sys_chdir+0xbf/0x220 fs/open.c:545
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f61ad07cae9
RSP: 002b:00007f61a37fd0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000050
RAX: ffffffffffffffda RBX: 00007f61ad19c120 RCX: 00007f61ad07cae9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000040
RBP: 00007f61ad0c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f61ad19c120 R15: 00007ffc19e49218
 </TASK>
INFO: task syz-executor.0:19836 blocked for more than 144 seconds.
      Not tainted 6.5.0-syzkaller-08894-gb97d64c72259 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:29104 pid:19836 ppid:5057   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x1873/0x48f0 kernel/sched/core.c:6695
 schedule+0xc3/0x180 kernel/sched/core.c:6771
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6830
 rwsem_down_read_slowpath+0x5f4/0x950 kernel/locking/rwsem.c:1086
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0x9c/0x2f0 kernel/locking/rwsem.c:1522
 inode_lock_shared include/linux/fs.h:812 [inline]
 open_last_lookups fs/namei.c:3562 [inline]
 path_openat+0x7b3/0x3180 fs/namei.c:3793
 do_filp_open+0x234/0x490 fs/namei.c:3823
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1422
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_open fs/open.c:1445 [inline]
 __se_sys_open fs/open.c:1441 [inline]
 __x64_sys_open+0x225/0x270 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f61ad07cae9
RSP: 002b:00007f61a35dc0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007f61ad19c1f0 RCX: 00007f61ad07cae9
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 00000000200001c0
RBP: 00007f61ad0c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f61ad19c1f0 R15: 00007ffc19e49218
 </TASK>
INFO: lockdep is turned off.
NMI backtrace for cpu 0
CPU: 0 PID: 28 Comm: khungtaskd Not tainted 6.5.0-syzkaller-08894-gb97d64c72259 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
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
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 21301 Comm: syz-executor.1 Not tainted 6.5.0-syzkaller-08894-gb97d64c72259 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:clear_page_erms+0xb/0x10 arch/x86/lib/clear_page_64.S:50
Code: 48 89 47 20 48 89 47 28 48 89 47 30 48 89 47 38 48 8d 7f 40 75 d9 90 c3 0f 1f 80 00 00 00 00 f3 0f 1e fa b9 00 10 00 00 31 c0 <f3> aa c3 66 90 f3 0f 1e fa 48 83 f9 40 73 36 83 f9 08 73 0f 85 c9
RSP: 0018:ffffc900031ef8b8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000004c0
RDX: ffff888042e98000 RSI: 0000000000000001 RDI: ffff888042e98b40
RBP: ffffc900031efb70 R08: ffffea00010ba637 R09: 0000000000000000
R10: ffffed10085d3000 R11: fffff940002174c7 R12: 0000000000000001
R13: 0000000000000001 R14: ffffea00010ba600 R15: 0000000000000000
FS:  00005555556b5480(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f561ff9c018 CR3: 00000000289f1000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 clear_page arch/x86/include/asm/page_64.h:53 [inline]
 clear_highpage_kasan_tagged include/linux/highmem.h:248 [inline]
 kernel_init_pages mm/page_alloc.c:1071 [inline]
 post_alloc_hook+0xf8/0x210 mm/page_alloc.c:1534
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0x31ec/0x3370 mm/page_alloc.c:3183
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4439
 vm_area_alloc_pages mm/vmalloc.c:3063 [inline]
 __vmalloc_area_node mm/vmalloc.c:3139 [inline]
 __vmalloc_node_range+0x9a3/0x1490 mm/vmalloc.c:3320
 vmalloc_user+0x74/0x80 mm/vmalloc.c:3474
 kcov_ioctl+0x59/0x630 kernel/kcov.c:704
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff00647c84b
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:00007ffe6712be40 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007ff00647c84b
RDX: 0000000000040000 RSI: ffffffff80086301 RDI: 00000000000000d9
RBP: 00007ff00659c0e8 R08: 00000000000000d8 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe6712c578
R13: 0000000000000003 R14: 00007ff00659c0e8 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
