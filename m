Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1A46DD376
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 08:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjDKGyQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 02:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjDKGyE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:54:04 -0400
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4E430D5
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Apr 2023 23:53:46 -0700 (PDT)
Received: by mail-il1-f207.google.com with SMTP id u6-20020a926006000000b003232594207dso5510392ilb.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Apr 2023 23:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681196026; x=1683788026;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jI0t9CKpLEy7cRn9Iv23vial1fs2NkaigNh4cR6XeE4=;
        b=lGk38e18SkhZmaBXwhsau1g+RZ9R9GOH+fgPSj5o2v1lgVyl8814sz/Fgt+WgGdNlw
         otOgfTypwBCHKFW4qkytIsesuqAAnb8fRX3xLuE//I2SwEo1jB+LDuSUQf5rU4pJpVzr
         tCAgPsBJNGsK6nxkXAkTCSzV7JJXq/Wp+RvKT2p4CBkHZ8EypJaQHl6i+lbFAUFPELfe
         Outlz5M6MbNyVRSwdzQDAfOuJtw1e+4m1P8RRR5zEF9TVmNDUDUMpgSB1JMOqFUt0J5O
         cIpqM+SRSm92Yh1D2elDHVqdV7Gqw791+RCHULFzdro9/4Sfqj08oKQOuCjDDDHJXllH
         cqDg==
X-Gm-Message-State: AAQBX9dyX2bnlonXwXAtIHalCd31BMR9CfOz5yTK9yz9H+AITaH6kmCB
        Amf+6N3IhHWZB9MTk0nGIapThsaXlsQ0qsFWv3MDgZ5wOeIO
X-Google-Smtp-Source: AKy350ZLKKG6NjcZn5zksCALbm7zJZYFGl7+MNLVp2vZLVu6k/onk9MJi94z8Jn5oc8DwKBhuI3AEmI4gntQiobkXYbGKIAgLtsp
MIME-Version: 1.0
X-Received: by 2002:a6b:a1a:0:b0:758:cc6f:32f4 with SMTP id
 z26-20020a6b0a1a000000b00758cc6f32f4mr5115978ioi.4.1681196026262; Mon, 10 Apr
 2023 23:53:46 -0700 (PDT)
Date:   Mon, 10 Apr 2023 23:53:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f1a9d205f909f327@google.com>
Subject: [syzbot] [fs?] possible deadlock in quotactl_fd
From:   syzbot <syzbot+cdcd444e4d3a256ada13@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0d3eb744aed4 Merge tag 'urgent-rcu.2023.04.07a' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11798e4bc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c21559e740385326
dashboard link: https://syzkaller.appspot.com/bug?extid=cdcd444e4d3a256ada13
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a02928003efa/disk-0d3eb744.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7839447005a4/vmlinux-0d3eb744.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d26ab3184148/bzImage-0d3eb744.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cdcd444e4d3a256ada13@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.3.0-rc6-syzkaller-00016-g0d3eb744aed4 #0 Not tainted
------------------------------------------------------
syz-executor.3/11858 is trying to acquire lock:
ffff88802a3bc0e0 (&type->s_umount_key#31){++++}-{3:3}, at: __do_sys_quotactl_fd+0x174/0x3f0 fs/quota/quota.c:997

but task is already holding lock:
ffff88802a3bc460 (sb_writers#4){.+.+}-{0:0}, at: __do_sys_quotactl_fd+0xd3/0x3f0 fs/quota/quota.c:990

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (sb_writers#4){.+.+}-{0:0}:
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

-> #0 (&type->s_umount_key#31){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3098 [inline]
       check_prevs_add kernel/locking/lockdep.c:3217 [inline]
       validate_chain kernel/locking/lockdep.c:3832 [inline]
       __lock_acquire+0x2ec7/0x5d40 kernel/locking/lockdep.c:5056
       lock_acquire kernel/locking/lockdep.c:5669 [inline]
       lock_acquire+0x1af/0x520 kernel/locking/lockdep.c:5634
       down_write+0x92/0x200 kernel/locking/rwsem.c:1573
       __do_sys_quotactl_fd+0x174/0x3f0 fs/quota/quota.c:997
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
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

1 lock held by syz-executor.3/11858:
 #0: ffff88802a3bc460 (sb_writers#4){.+.+}-{0:0}, at: __do_sys_quotactl_fd+0xd3/0x3f0 fs/quota/quota.c:990

stack backtrace:
CPU: 0 PID: 11858 Comm: syz-executor.3 Not tainted 6.3.0-rc6-syzkaller-00016-g0d3eb744aed4 #0
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
 down_write+0x92/0x200 kernel/locking/rwsem.c:1573
 __do_sys_quotactl_fd+0x174/0x3f0 fs/quota/quota.c:997
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f81d2e8c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f81d3b29168 EFLAGS: 00000246 ORIG_RAX: 00000000000001bb
RAX: ffffffffffffffda RBX: 00007f81d2fabf80 RCX: 00007f81d2e8c169
RDX: 0000000000000000 RSI: ffffffff80000300 RDI: 0000000000000003
RBP: 00007f81d2ee7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffeeb18d7f R14: 00007f81d3b29300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
