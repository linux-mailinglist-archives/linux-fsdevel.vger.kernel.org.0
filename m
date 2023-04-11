Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8F46DD375
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 08:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjDKGyP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 02:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjDKGyE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:54:04 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFB12D6B
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Apr 2023 23:53:46 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id r14-20020a5e950e000000b0074cc9aba965so4922824ioj.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Apr 2023 23:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681196026; x=1683788026;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yjfsXRlkEt9BMh+Ls8OP9AtDqH9PnXX74RZjpl1iflk=;
        b=Nfk7cnk7XU7HgDpDAce6BBcdUbqD69tcc58wqh786zHvGZpAsez+4o0xJ6C7asSZEM
         FxMiBNG94e7AQjiETgklTCP5wtjMUY8g90OacDW7toAaUuhQOsc9Z+fYvWwaQwFDsEQJ
         hZNAZ+2BuKxDs2NeXB0djAWzoO6Codds2c1OkfUwkRNu48pbY7i1dCl3oBOU5rOHV9iV
         76W31OODAgSf9gGjAYiYcdmm2gQGEW6xvLlysaVno3OxlNDy2yPptrrppMGQHfdxDt8S
         Nr2O4+uty5Q+d6M0wB7/RM/sEfGDOEZ2uiwcWo2yepDqiQ3u/8Mv9McnjpiLTn0DxMpg
         oFcw==
X-Gm-Message-State: AAQBX9dcAWlVANJvKRsFKQUZAOon0/TfTiBysLljriW9qywjv+Hbl5S5
        BjXOStscLbzxIqzgooQqgcdtPhAcPCkGuBlfjZ58uwscBBl4
X-Google-Smtp-Source: AKy350aMIDRPsi0/gD3o1b/CgK2Nz0VIcM4ypkAi64sp6tgY2HHOVM5eQVductsNrk+6/lC5p71oZ5gmdXT8UeblyQxZS52w5Gr+
MIME-Version: 1.0
X-Received: by 2002:a6b:dc13:0:b0:745:4154:b571 with SMTP id
 s19-20020a6bdc13000000b007454154b571mr5119982ioc.3.1681196026048; Mon, 10 Apr
 2023 23:53:46 -0700 (PDT)
Date:   Mon, 10 Apr 2023 23:53:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ee3a3005f909f30a@google.com>
Subject: [syzbot] [fs?] possible deadlock in sys_quotactl_fd
From:   syzbot <syzbot+aacb82fca60873422114@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    76f598ba7d8e Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13965b21c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5666fa6aca264e42
dashboard link: https://syzkaller.appspot.com/bug?extid=aacb82fca60873422114
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1f01c9748997/disk-76f598ba.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b3afb4fc86b9/vmlinux-76f598ba.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8908040d7a31/bzImage-76f598ba.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aacb82fca60873422114@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.3.0-rc5-syzkaller-00022-g76f598ba7d8e #0 Not tainted
------------------------------------------------------
syz-executor.0/17940 is trying to acquire lock:
ffff88802a89e0e0 (&type->s_umount_key#31){++++}-{3:3}, at: __do_sys_quotactl_fd fs/quota/quota.c:999 [inline]
ffff88802a89e0e0 (&type->s_umount_key#31){++++}-{3:3}, at: __se_sys_quotactl_fd+0x2fb/0x440 fs/quota/quota.c:972

but task is already holding lock:
ffff88802a89e460 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:394

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (sb_writers#4){.+.+}-{0:0}:
       lock_acquire+0x1e1/0x520 kernel/locking/lockdep.c:5669
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1477 [inline]
       sb_start_write include/linux/fs.h:1552 [inline]
       write_mmp_block+0xe5/0x930 fs/ext4/mmp.c:50
       ext4_multi_mount_protect+0x364/0x990 fs/ext4/mmp.c:343
       __ext4_remount fs/ext4/super.c:6543 [inline]
       ext4_reconfigure+0x29a8/0x3280 fs/ext4/super.c:6642
       reconfigure_super+0x3c9/0x7c0 fs/super.c:956
       vfs_fsconfig_locked fs/fsopen.c:254 [inline]
       __do_sys_fsconfig fs/fsopen.c:439 [inline]
       __se_sys_fsconfig+0xa29/0xf70 fs/fsopen.c:314
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&type->s_umount_key#31){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3098 [inline]
       check_prevs_add kernel/locking/lockdep.c:3217 [inline]
       validate_chain+0x166b/0x58e0 kernel/locking/lockdep.c:3832
       __lock_acquire+0x125b/0x1f80 kernel/locking/lockdep.c:5056
       lock_acquire+0x1e1/0x520 kernel/locking/lockdep.c:5669
       down_read+0x3d/0x50 kernel/locking/rwsem.c:1520
       __do_sys_quotactl_fd fs/quota/quota.c:999 [inline]
       __se_sys_quotactl_fd+0x2fb/0x440 fs/quota/quota.c:972
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sb_writers#4);
                               lock(&type->s_umount_key#31);
                               lock(sb_writers#4);
  lock(&type->s_umount_key#31);

 *** DEADLOCK ***

1 lock held by syz-executor.0/17940:
 #0: ffff88802a89e460 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:394

stack backtrace:
CPU: 0 PID: 17940 Comm: syz-executor.0 Not tainted 6.3.0-rc5-syzkaller-00022-g76f598ba7d8e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
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
 down_read+0x3d/0x50 kernel/locking/rwsem.c:1520
 __do_sys_quotactl_fd fs/quota/quota.c:999 [inline]
 __se_sys_quotactl_fd+0x2fb/0x440 fs/quota/quota.c:972
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f3c2aa8c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3c2b826168 EFLAGS: 00000246 ORIG_RAX: 00000000000001bb
RAX: ffffffffffffffda RBX: 00007f3c2ababf80 RCX: 00007f3c2aa8c169
RDX: ffffffffffffffff RSI: ffffffff80000601 RDI: 0000000000000003
RBP: 00007f3c2aae7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000200024c0 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd71f38adf R14: 00007f3c2b826300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
