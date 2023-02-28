Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754026A60E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 22:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjB1VFe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 16:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjB1VF2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:05:28 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C63415560
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 13:05:01 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id n15-20020a92dd0f000000b00316fc5e6756so6774461ilm.23
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 13:05:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QOkx/k0GvA2d+uljSK2CrlcxxihOM+XG9a1+0aogejo=;
        b=vOF0YjZG5rqPB48Zkh6nxl6dcgMfDRPlXKzmkDwFrZp0P9+PWHQK4MCE52VqJdVix+
         UqvGpAW0FXRlkTdS7oP7n0tTl1hv19XIdR49+Wb3gxnIL31/pRoVkn60NwxAGcOmh/GE
         evAA+Rs6dyeMqScBxlUc93HZ6zodZLfyzakLtMlHZ8OXTSLjs/OEv4PPW46+0vMVYgx8
         LMHetX8dHJGBUj9YkvxKH5fNwSJCc7xwFlWDm07ZHwcCCCUjan8kbfpbVWs/uGury+4c
         d01M2+G5SwEQaI3gjSj9USHZXbU9WmIe5dELyAJ98ZHBMT8J+AdoN3fY2n+eQYPElGZo
         RnpQ==
X-Gm-Message-State: AO0yUKVGpv/cC95/apQnNDMg2CZvSAd2sHxlcWw1ra088Hvj2OE7ewkk
        7/WVczYYG4eoy1GxUohTKT/xZ/1gJ59jBQXhCicXcIjc9kWJ
X-Google-Smtp-Source: AK7set8+5axy42qlZHj/9YZ/jxWKqxFLY56j1jcsgjhMBwgru2dWW/Z/ykq7MVp/KTq7B0N9iij+k08vYn8zaogICqZPpSgzMz8K
MIME-Version: 1.0
X-Received: by 2002:a6b:ee19:0:b0:745:405d:b703 with SMTP id
 i25-20020a6bee19000000b00745405db703mr1905837ioh.3.1677618291310; Tue, 28 Feb
 2023 13:04:51 -0800 (PST)
Date:   Tue, 28 Feb 2023 13:04:51 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000052865105f5c8f2c8@google.com>
Subject: [syzbot] [ext4?] possible deadlock in jbd2_log_wait_commit
From:   syzbot <syzbot+9d16c39efb5fade84574@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
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

HEAD commit:    e492250d5252 Merge tag 'pwm/for-6.3-rc1' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1306a9acc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f763d89e26d3d4c4
dashboard link: https://syzkaller.appspot.com/bug?extid=9d16c39efb5fade84574
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2a637f17a777/disk-e492250d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a9bfdbca6f2d/vmlinux-e492250d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dc120ec8d398/bzImage-e492250d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9d16c39efb5fade84574@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.2.0-syzkaller-12944-ge492250d5252 #0 Not tainted
------------------------------------------------------
syz-executor.5/13484 is trying to acquire lock:
ffff88814c5be990 (jbd2_handle){++++}-{0:0}, at: jbd2_log_wait_commit+0x153/0x4a0 fs/jbd2/journal.c:692

but task is already holding lock:
ffff888032243628 (&type->i_mutex_dir_key#3/4){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:793 [inline]
ffff888032243628 (&type->i_mutex_dir_key#3/4){+.+.}-{3:3}, at: ext4_rename fs/ext4/namei.c:3879 [inline]
ffff888032243628 (&type->i_mutex_dir_key#3/4){+.+.}-{3:3}, at: ext4_rename2+0x2633/0x4410 fs/ext4/namei.c:4193

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&type->i_mutex_dir_key#3/4){+.+.}-{3:3}:
       lock_acquire+0x23e/0x630 kernel/locking/lockdep.c:5669
       down_write_nested+0x3d/0x50 kernel/locking/rwsem.c:1689
       inode_lock_nested include/linux/fs.h:793 [inline]
       ext4_rename fs/ext4/namei.c:3879 [inline]
       ext4_rename2+0x2633/0x4410 fs/ext4/namei.c:4193
       vfs_rename+0xb1b/0xfa0 fs/namei.c:4772
       do_renameat2+0xb9b/0x13c0 fs/namei.c:4923
       __do_sys_renameat2 fs/namei.c:4956 [inline]
       __se_sys_renameat2 fs/namei.c:4953 [inline]
       __x64_sys_renameat2+0xd2/0xe0 fs/namei.c:4953
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (jbd2_handle){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3098 [inline]
       check_prevs_add kernel/locking/lockdep.c:3217 [inline]
       validate_chain+0x166b/0x58e0 kernel/locking/lockdep.c:3832
       __lock_acquire+0x125b/0x1f80 kernel/locking/lockdep.c:5056
       lock_acquire+0x23e/0x630 kernel/locking/lockdep.c:5669
       jbd2_log_wait_commit+0x173/0x4a0 fs/jbd2/journal.c:692
       jbd2_journal_stop+0x95b/0xf50 fs/jbd2/transaction.c:1959
       __ext4_journal_stop+0xfc/0x1a0 fs/ext4/ext4_jbd2.c:133
       ext4_rename fs/ext4/namei.c:4014 [inline]
       ext4_rename2+0x3c40/0x4410 fs/ext4/namei.c:4193
       vfs_rename+0xb1b/0xfa0 fs/namei.c:4772
       do_renameat2+0xb9b/0x13c0 fs/namei.c:4923
       __do_sys_renameat2 fs/namei.c:4956 [inline]
       __se_sys_renameat2 fs/namei.c:4953 [inline]
       __x64_sys_renameat2+0xd2/0xe0 fs/namei.c:4953
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&type->i_mutex_dir_key#3/4);
                               lock(jbd2_handle);
                               lock(&type->i_mutex_dir_key#3/4);
  lock(jbd2_handle);

 *** DEADLOCK ***

3 locks held by syz-executor.5/13484:
 #0: ffff88814c5ba460 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:394
 #1: ffff8880764b5440 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: lock_rename+0x186/0x1a0
 #2: ffff888032243628 (&type->i_mutex_dir_key#3/4){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:793 [inline]
 #2: ffff888032243628 (&type->i_mutex_dir_key#3/4){+.+.}-{3:3}, at: ext4_rename fs/ext4/namei.c:3879 [inline]
 #2: ffff888032243628 (&type->i_mutex_dir_key#3/4){+.+.}-{3:3}, at: ext4_rename2+0x2633/0x4410 fs/ext4/namei.c:4193

stack backtrace:
CPU: 0 PID: 13484 Comm: syz-executor.5 Not tainted 6.2.0-syzkaller-12944-ge492250d5252 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/16/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 check_noncircular+0x2fe/0x3b0 kernel/locking/lockdep.c:2178
 check_prev_add kernel/locking/lockdep.c:3098 [inline]
 check_prevs_add kernel/locking/lockdep.c:3217 [inline]
 validate_chain+0x166b/0x58e0 kernel/locking/lockdep.c:3832
 __lock_acquire+0x125b/0x1f80 kernel/locking/lockdep.c:5056
 lock_acquire+0x23e/0x630 kernel/locking/lockdep.c:5669
 jbd2_log_wait_commit+0x173/0x4a0 fs/jbd2/journal.c:692
 jbd2_journal_stop+0x95b/0xf50 fs/jbd2/transaction.c:1959
 __ext4_journal_stop+0xfc/0x1a0 fs/ext4/ext4_jbd2.c:133
 ext4_rename fs/ext4/namei.c:4014 [inline]
 ext4_rename2+0x3c40/0x4410 fs/ext4/namei.c:4193
 vfs_rename+0xb1b/0xfa0 fs/namei.c:4772
 do_renameat2+0xb9b/0x13c0 fs/namei.c:4923
 __do_sys_renameat2 fs/namei.c:4956 [inline]
 __se_sys_renameat2 fs/namei.c:4953 [inline]
 __x64_sys_renameat2+0xd2/0xe0 fs/namei.c:4953
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd61e08c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd61ee4f168 EFLAGS: 00000246 ORIG_RAX: 000000000000013c
RAX: ffffffffffffffda RBX: 00007fd61e1abf80 RCX: 00007fd61e08c0f9
RDX: 0000000000000003 RSI: 0000000020005780 RDI: 0000000000000004
RBP: 00007fd61e0e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000200016c0 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffc899a5ef R14: 00007fd61ee4f300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
