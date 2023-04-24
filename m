Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19EAC6EC67C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 08:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjDXGqv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 02:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjDXGqu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 02:46:50 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691E030D0
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Apr 2023 23:46:47 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7606d443ba6so342830339f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Apr 2023 23:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682318806; x=1684910806;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LRMi+JfSh6yZ91hofDyo0Na+ODnFcV8g+AkFtNbuPzE=;
        b=iCH2LXDziPRaj138I6YP95BWqfAEsLoODWPTnLFyOpH9ypi1ZKnUr5HzjjsonVqP5V
         GxJ+Bk1oBMi8hf+6fUi8h4N1187//H0nw0uhSriIhQAwI49yy1Gs1jctvwG/Ns4F1ziv
         Mis0+CMwTTB/owI/UieC3LeQQBr1Lx8BcsqBegdRuJAnwA97aCtAVxLkh3jiNvvwrjfW
         6ruLQIpz/g8FYrsMa9lgdMUXy3+ZD/WMZ3+xX4LIyDCdsIc4gKsXP3TIXBE56vRUip1w
         kAcJHdEDTcMoIxtx/o8M9i/mhlZVS6NN1ZxrNl3baV4aDUvlM5FNqmU1Yt6KhkfYFRMb
         uASQ==
X-Gm-Message-State: AAQBX9ekpv9L5HwZ+2dcGofwd+dxZbWpT81feB9o3qCodTbYE5pxbNWe
        R5BFysN0vq/21T2a3PmGJoNA+2pRqXCRWhNUGAhA+LBQuL7yaOasEw==
X-Google-Smtp-Source: AKy350bxcbxzCwG5NCWho4d9sXWau3tZRzplDSK+nP/4CGaoOULM3njmADhtML4wZtQv9n8pT7I1ncSMXt9TBxDYaIvghRduu4pW
MIME-Version: 1.0
X-Received: by 2002:a5d:968d:0:b0:758:3c0e:f331 with SMTP id
 m13-20020a5d968d000000b007583c0ef331mr3853525ion.4.1682318806679; Sun, 23 Apr
 2023 23:46:46 -0700 (PDT)
Date:   Sun, 23 Apr 2023 23:46:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000df076505fa0f5e84@google.com>
Subject: [syzbot] [reiserfs?] possible deadlock in chmod_common
From:   syzbot <syzbot+dc5bf13993c4b32ec0cb@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2caeeb9d4a1b Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=109cffafc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4afb87f3ec27b7fd
dashboard link: https://syzkaller.appspot.com/bug?extid=dc5bf13993c4b32ec0cb
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/187205513d6f/disk-2caeeb9d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ae84a1e0cbd0/vmlinux-2caeeb9d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0f0ff6d2e1aa/bzImage-2caeeb9d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dc5bf13993c4b32ec0cb@syzkaller.appspotmail.com

REISERFS warning (device loop2): jdm-20006 create_privroot: xattrs/ACLs enabled and couldn't find/create .reiserfs_priv. Failing mount.
======================================================
WARNING: possible circular locking dependency detected
6.3.0-rc7-syzkaller-00189-g2caeeb9d4a1b #0 Not tainted
------------------------------------------------------
syz-executor.2/13499 is trying to acquire lock:
ffff88803a019020 (&type->i_mutex_dir_key#25){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:758 [inline]
ffff88803a019020 (&type->i_mutex_dir_key#25){+.+.}-{3:3}, at: chmod_common+0x1bb/0x4c0 fs/open.c:637

but task is already holding lock:
ffff8880281c2460 (sb_writers#30){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:394

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (sb_writers#30){.+.+}-{0:0}:
       lock_acquire+0x1e1/0x520 kernel/locking/lockdep.c:5669
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1477 [inline]
       sb_start_write+0x4d/0x1c0 include/linux/fs.h:1552
       mnt_want_write_file+0x5e/0x1f0 fs/namespace.c:438
       reiserfs_ioctl+0x174/0x340 fs/reiserfs/ioctl.c:103
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (&sbi->lock){+.+.}-{3:3}:
       lock_acquire+0x1e1/0x520 kernel/locking/lockdep.c:5669
       __mutex_lock_common+0x1d8/0x2530 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x1b/0x20 kernel/locking/mutex.c:799
       reiserfs_write_lock+0x7a/0xd0 fs/reiserfs/lock.c:27
       reiserfs_lookup+0x160/0x4b0 fs/reiserfs/namei.c:364
       __lookup_slow+0x282/0x3e0 fs/namei.c:1686
       lookup_one_len+0x18b/0x2d0 fs/namei.c:2712
       reiserfs_lookup_privroot+0x89/0x1e0 fs/reiserfs/xattr.c:973
       reiserfs_fill_super+0x195b/0x2620 fs/reiserfs/super.c:2192
       mount_bdev+0x271/0x3a0 fs/super.c:1380
       legacy_get_tree+0xef/0x190 fs/fs_context.c:610
       vfs_get_tree+0x8c/0x270 fs/super.c:1510
       do_new_mount+0x28f/0xae0 fs/namespace.c:3042
       do_mount fs/namespace.c:3385 [inline]
       __do_sys_mount fs/namespace.c:3594 [inline]
       __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3571
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&type->i_mutex_dir_key#25){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3098 [inline]
       check_prevs_add kernel/locking/lockdep.c:3217 [inline]
       validate_chain+0x166b/0x58e0 kernel/locking/lockdep.c:3832
       __lock_acquire+0x125b/0x1f80 kernel/locking/lockdep.c:5056
       lock_acquire+0x1e1/0x520 kernel/locking/lockdep.c:5669
       down_write+0x3a/0x50 kernel/locking/rwsem.c:1573
       inode_lock include/linux/fs.h:758 [inline]
       chmod_common+0x1bb/0x4c0 fs/open.c:637
       vfs_fchmod fs/open.c:659 [inline]
       __do_sys_fchmod fs/open.c:668 [inline]
       __se_sys_fchmod fs/open.c:662 [inline]
       __x64_sys_fchmod+0xf0/0x150 fs/open.c:662
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  &type->i_mutex_dir_key#25 --> &sbi->lock --> sb_writers#30

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sb_writers#30);
                               lock(&sbi->lock);
                               lock(sb_writers#30);
  lock(&type->i_mutex_dir_key#25);

 *** DEADLOCK ***

1 lock held by syz-executor.2/13499:
 #0: ffff8880281c2460 (sb_writers#30){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:394

stack backtrace:
CPU: 0 PID: 13499 Comm: syz-executor.2 Not tainted 6.3.0-rc7-syzkaller-00189-g2caeeb9d4a1b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 check_noncircular+0x2fe/0x3b0 kernel/locking/lockdep.c:2178
 check_prev_add kernel/locking/lockdep.c:3098 [inline]
 check_prevs_add kernel/locking/lockdep.c:3217 [inline]
 validate_chain+0x166b/0x58e0 kernel/locking/lockdep.c:3832
 __lock_acquire+0x125b/0x1f80 kernel/locking/lockdep.c:5056
 lock_acquire+0x1e1/0x520 kernel/locking/lockdep.c:5669
 down_write+0x3a/0x50 kernel/locking/rwsem.c:1573
 inode_lock include/linux/fs.h:758 [inline]
 chmod_common+0x1bb/0x4c0 fs/open.c:637
 vfs_fchmod fs/open.c:659 [inline]
 __do_sys_fchmod fs/open.c:668 [inline]
 __se_sys_fchmod fs/open.c:662 [inline]
 __x64_sys_fchmod+0xf0/0x150 fs/open.c:662
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f94a988c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f94aa5e0168 EFLAGS: 00000246 ORIG_RAX: 000000000000005b
RAX: ffffffffffffffda RBX: 00007f94a99abf80 RCX: 00007f94a988c169
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007f94a98e7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe4c3619af R14: 00007f94aa5e0300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
