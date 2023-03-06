Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBB56ABE41
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 12:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjCFLfF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 06:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjCFLez (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:34:55 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3C62914F
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Mar 2023 03:34:41 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id k13-20020a5d9d4d000000b0074caed3a2d2so5250091iok.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Mar 2023 03:34:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678102480;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=17Dz9Ruv/MYVyKXHhXrpgoZn4eBXU8+tzjuriYTNuzU=;
        b=Zy4X8sJvRAlAoKsCMJp+aQ+wlvpCOMqM19Xab84qSq9GKsJgd6ajxepbCfZhsUfnqC
         oaiTenYEdj9vPmK9S6/0vF+54W/R5DrgBwcX/g66zWtIt48A3RI35OduYxjlNEmVCu9+
         9mlrEAhyv4mPhbkhPFuNKttsYNMitNlCKpE0rST5cxOT1dRISD0p+t3AOX1FwQhnUQiW
         GvFU605ttrTbAVEzM/JzOfdqsJcdDGIkrSPznTdWO2+YqbswE6qikq1c75T2C9u7BsKY
         9XI/gjeWoBv3LYOos1xZbdc5OJe+1KL/DVIjXdP3wRrT+BrAmP9qld8skgwKs1tlkjDw
         +UnQ==
X-Gm-Message-State: AO0yUKV/7fO6GmgoKJXogAUgYAMgRK9nzHHUt9OdtQy/ixIaLyG5/cl9
        0SWtfDMeFbIKpIUyTOzrpmVBeOglEJ89szPrI5thG76LegtH
X-Google-Smtp-Source: AK7set9/C3Frj30giZZlIhko8CoxbZuRoPIbktq/RMaOe9uVXj6it65eMq/u2l2KC10Nn1dI0hUxiP71oqu84VgTY9aexvqX/LKU
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:11ac:b0:315:8d25:1eaf with SMTP id
 12-20020a056e0211ac00b003158d251eafmr5272028ilj.4.1678102480770; Mon, 06 Mar
 2023 03:34:40 -0800 (PST)
Date:   Mon, 06 Mar 2023 03:34:40 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000435c6905f639ae8e@google.com>
Subject: [syzbot] [ext4?] WARNING: bad unlock balance in ext4_rename2
From:   syzbot <syzbot+0c73d1d8b952c5f3d714@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
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

HEAD commit:    0988a0ea7919 Merge tag 'for-v6.3-part2' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=146f3638c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f763d89e26d3d4c4
dashboard link: https://syzkaller.appspot.com/bug?extid=0c73d1d8b952c5f3d714
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e0aa29e9ae74/disk-0988a0ea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6f64db0b58ef/vmlinux-0988a0ea.xz
kernel image: https://storage.googleapis.com/syzbot-assets/db391408e15d/bzImage-0988a0ea.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0c73d1d8b952c5f3d714@syzkaller.appspotmail.com

EXT4-fs (loop3): warning: checktime reached, running e2fsck is recommended
EXT4-fs (loop3): mounted filesystem 00000000-0000-0000-0000-000000000000 without journal. Quota mode: none.
=====================================
WARNING: bad unlock balance detected!
6.2.0-syzkaller-13467-g0988a0ea7919 #0 Not tainted
-------------------------------------
syz-executor.3/8027 is trying to release lock (&type->i_mutex_dir_key) at:
[<ffffffff82448753>] inode_unlock include/linux/fs.h:763 [inline]
[<ffffffff82448753>] ext4_rename fs/ext4/namei.c:4017 [inline]
[<ffffffff82448753>] ext4_rename2+0x3d03/0x4410 fs/ext4/namei.c:4193
but there are no more locks to release!

other info that might help us debug this:
2 locks held by syz-executor.3/8027:
 #0: ffff888026e42460 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:394
 #1: ffff888034ec0e08 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: lock_rename+0x186/0x1a0

stack backtrace:
CPU: 0 PID: 8027 Comm: syz-executor.3 Not tainted 6.2.0-syzkaller-13467-g0988a0ea7919 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_unlock_imbalance_bug+0x252/0x2c0 kernel/locking/lockdep.c:5109
 __lock_release kernel/locking/lockdep.c:5346 [inline]
 lock_release+0x63c/0xab0 kernel/locking/lockdep.c:5689
 up_write+0x79/0x580 kernel/locking/rwsem.c:1625
 inode_unlock include/linux/fs.h:763 [inline]
 ext4_rename fs/ext4/namei.c:4017 [inline]
 ext4_rename2+0x3d03/0x4410 fs/ext4/namei.c:4193
 vfs_rename+0xb1b/0xfa0 fs/namei.c:4772
 do_renameat2+0xb9b/0x13c0 fs/namei.c:4923
 __do_sys_rename fs/namei.c:4969 [inline]
 __se_sys_rename fs/namei.c:4967 [inline]
 __x64_sys_rename+0x86/0x90 fs/namei.c:4967
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f6ffe68c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6fff35c168 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007f6ffe7abf80 RCX: 00007f6ffe68c0f9
RDX: 0000000000000000 RSI: 0000000020000180 RDI: 00000000200000c0
RBP: 00007f6ffe6e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd65e8771f R14: 00007f6fff35c300 R15: 0000000000022000
 </TASK>
------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x0, magic = 0xffff888034c0abb0, owner = 0x0, curr 0xffff88802bd9ba80, list empty
WARNING: CPU: 0 PID: 8027 at kernel/locking/rwsem.c:1370 __up_write kernel/locking/rwsem.c:1369 [inline]
WARNING: CPU: 0 PID: 8027 at kernel/locking/rwsem.c:1370 up_write+0x4f4/0x580 kernel/locking/rwsem.c:1626
Modules linked in:
CPU: 0 PID: 8027 Comm: syz-executor.3 Not tainted 6.2.0-syzkaller-13467-g0988a0ea7919 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
RIP: 0010:__up_write kernel/locking/rwsem.c:1369 [inline]
RIP: 0010:up_write+0x4f4/0x580 kernel/locking/rwsem.c:1626
Code: 48 c7 c7 a0 7e 0a 8b 48 c7 c6 40 81 0a 8b 48 8b 54 24 28 48 8b 4c 24 18 4d 89 e0 4c 8b 4c 24 30 53 e8 60 58 e8 ff 48 83 c4 08 <0f> 0b e9 75 fd ff ff 48 c7 c1 68 a0 74 8e 80 e1 07 80 c1 03 38 c1
RSP: 0018:ffffc90015fc7680 EFLAGS: 00010292
RAX: 0c10b1842f27c000 RBX: ffffffff8b0a7f80 RCX: 0000000000040000
RDX: ffffc9000c513000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: ffffc90015fc7750 R08: ffffffff8153a8b2 R09: fffff52002bf8e49
R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000000
R13: ffff888034c0abb0 R14: 1ffff92002bf8ed8 R15: dffffc0000000000
FS:  00007f6fff35c700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056388d3a46b0 CR3: 000000002bc04000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 inode_unlock include/linux/fs.h:763 [inline]
 ext4_rename fs/ext4/namei.c:4017 [inline]
 ext4_rename2+0x3d03/0x4410 fs/ext4/namei.c:4193
 vfs_rename+0xb1b/0xfa0 fs/namei.c:4772
 do_renameat2+0xb9b/0x13c0 fs/namei.c:4923
 __do_sys_rename fs/namei.c:4969 [inline]
 __se_sys_rename fs/namei.c:4967 [inline]
 __x64_sys_rename+0x86/0x90 fs/namei.c:4967
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f6ffe68c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6fff35c168 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007f6ffe7abf80 RCX: 00007f6ffe68c0f9
RDX: 0000000000000000 RSI: 0000000020000180 RDI: 00000000200000c0
RBP: 00007f6ffe6e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd65e8771f R14: 00007f6fff35c300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
