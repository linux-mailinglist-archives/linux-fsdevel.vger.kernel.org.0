Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390756DB56B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Apr 2023 22:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjDGUmn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Apr 2023 16:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjDGUml (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Apr 2023 16:42:41 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1908F
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Apr 2023 13:42:39 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id d204-20020a6bb4d5000000b00758cfdd36c3so26426172iof.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Apr 2023 13:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680900159; x=1683492159;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gQByD6ZheusKw4EUPL21I5e6W15h+91cn8nxJKCDnUQ=;
        b=ba+etWT/lWmhkZyZDGDSQZanGSmMufNnefqUdq5UvxW1t2bbGl3oDrSixrG+NZZJS+
         t5aXYB4O8a5d95xo1C2SKDqCJeY6R3WFnqAgFhoUzL+lXQEBYrZOz6uSul6pfislU8nB
         C1W5MTT2jyPo2H6tXxGkmHZnvBq7COGb6mLjB6I8Z5PNZInXOPgK6BGSdYhBZOwpxTku
         1scpqjQAUpPTbsvTtHVaQPwS8psmGkbEOniY11z7cH2URBkDyj8wahzqnulZ2AYL4DId
         1EkCSbwlUkPGGc2TPvdpORNU+JEClxqSNho2BAXzyOb9oSJ6d4+1GeXvctHKk6o5YQAm
         uDXA==
X-Gm-Message-State: AAQBX9e4PMybstU7FPAaEX3ovM+5UT8mTJn0mH7HSjQAzURDMUU1dW/e
        PHjNp9TrEVvY5btqLszleYsFhSOEoIPIy5KEwHrIGbUCZS0O
X-Google-Smtp-Source: AKy350ae+AUWLw4Mw5OZ5Dy4N02Ue1UkxOTTZAl5a+SgyBcLUo5wADk9Sfadd1r+b3mdAKf9kNhV0Mr44Q1jE5AaJugcyS1BFgHA
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1808:b0:752:fc52:a200 with SMTP id
 t8-20020a056602180800b00752fc52a200mr1644029ioh.2.1680900159001; Fri, 07 Apr
 2023 13:42:39 -0700 (PDT)
Date:   Fri, 07 Apr 2023 13:42:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e15c0905f8c5101b@google.com>
Subject: [syzbot] [ext4?] possible deadlock in ext4_multi_mount_protect
From:   syzbot <syzbot+6b7df7d5506b32467149@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f2afccfefe7b Merge tag 'net-6.3-rc6-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10094d79c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d3500b143c204867
dashboard link: https://syzkaller.appspot.com/bug?extid=6b7df7d5506b32467149
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a183ba13acb3/disk-f2afccfe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ffdb9ee4cb62/vmlinux-f2afccfe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8e8bbb25f0c1/bzImage-f2afccfe.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6b7df7d5506b32467149@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.3.0-rc5-syzkaller-00137-gf2afccfefe7b #0 Not tainted
------------------------------------------------------
syz-executor.3/27708 is trying to acquire lock:
ffff888065700460 (sb_writers#4){.+.+}-{0:0}, at: ext4_multi_mount_protect+0x50d/0xac0 fs/ext4/mmp.c:343

but task is already holding lock:
ffff8880657000e0 (&type->s_umount_key#31){++++}-{3:3}, at: vfs_fsconfig_locked fs/fsopen.c:253 [inline]
ffff8880657000e0 (&type->s_umount_key#31){++++}-{3:3}, at: __do_sys_fsconfig+0xa30/0xc20 fs/fsopen.c:439

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&type->s_umount_key#31){++++}-{3:3}:
       down_read+0x3d/0x50 kernel/locking/rwsem.c:1520
       __do_sys_quotactl_fd+0x27e/0x3f0 fs/quota/quota.c:999
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (sb_writers#4){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3098 [inline]
       check_prevs_add kernel/locking/lockdep.c:3217 [inline]
       validate_chain kernel/locking/lockdep.c:3832 [inline]
       __lock_acquire+0x2ec7/0x5d40 kernel/locking/lockdep.c:5056
       lock_acquire kernel/locking/lockdep.c:5669 [inline]
       lock_acquire+0x1af/0x520 kernel/locking/lockdep.c:5634
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1477 [inline]
       sb_start_write include/linux/fs.h:1552 [inline]
       write_mmp_block+0xc4/0x820 fs/ext4/mmp.c:50
       ext4_multi_mount_protect+0x50d/0xac0 fs/ext4/mmp.c:343
       __ext4_remount fs/ext4/super.c:6543 [inline]
       ext4_reconfigure+0x242b/0x2b60 fs/ext4/super.c:6642
       reconfigure_super+0x40c/0xa30 fs/super.c:956
       vfs_fsconfig_locked fs/fsopen.c:254 [inline]
       __do_sys_fsconfig+0xa3a/0xc20 fs/fsopen.c:439
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&type->s_umount_key#31);
                               lock(sb_writers#4);
                               lock(&type->s_umount_key#31);
  lock(sb_writers#4);

 *** DEADLOCK ***

2 locks held by syz-executor.3/27708:
 #0: ffff888078129070 (&fc->uapi_mutex){+.+.}-{3:3}, at: __do_sys_fsconfig+0x521/0xc20 fs/fsopen.c:437
 #1: ffff8880657000e0 (&type->s_umount_key#31){++++}-{3:3}, at: vfs_fsconfig_locked fs/fsopen.c:253 [inline]
 #1: ffff8880657000e0 (&type->s_umount_key#31){++++}-{3:3}, at: __do_sys_fsconfig+0xa30/0xc20 fs/fsopen.c:439

stack backtrace:
CPU: 0 PID: 27708 Comm: syz-executor.3 Not tainted 6.3.0-rc5-syzkaller-00137-gf2afccfefe7b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2178
 check_prev_add kernel/locking/lockdep.c:3098 [inline]
 check_prevs_add kernel/locking/lockdep.c:3217 [inline]
 validate_chain kernel/locking/lockdep.c:3832 [inline]
 __lock_acquire+0x2ec7/0x5d40 kernel/locking/lockdep.c:5056
 lock_acquire kernel/locking/lockdep.c:5669 [inline]
 lock_acquire+0x1af/0x520 kernel/locking/lockdep.c:5634
 percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
 __sb_start_write include/linux/fs.h:1477 [inline]
 sb_start_write include/linux/fs.h:1552 [inline]
 write_mmp_block+0xc4/0x820 fs/ext4/mmp.c:50
 ext4_multi_mount_protect+0x50d/0xac0 fs/ext4/mmp.c:343
 __ext4_remount fs/ext4/super.c:6543 [inline]
 ext4_reconfigure+0x242b/0x2b60 fs/ext4/super.c:6642
 reconfigure_super+0x40c/0xa30 fs/super.c:956
 vfs_fsconfig_locked fs/fsopen.c:254 [inline]
 __do_sys_fsconfig+0xa3a/0xc20 fs/fsopen.c:439
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4a4d08c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4a4dd13168 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
RAX: ffffffffffffffda RBX: 00007f4a4d1ac050 RCX: 00007f4a4d08c169
RDX: 0000000000000000 RSI: 0000000000000007 RDI: 0000000000000004
RBP: 00007f4a4d0e7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc3d17db8f R14: 00007f4a4dd13300 R15: 0000000000022000
 </TASK>
EXT4-fs (loop3): re-mounted 00000000-0000-0000-0000-000000000000. Quota mode: writeback.


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
