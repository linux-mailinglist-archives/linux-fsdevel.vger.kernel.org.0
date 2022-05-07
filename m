Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E73051E50E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 May 2022 09:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445970AbiEGHNL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 May 2022 03:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445858AbiEGHNJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 May 2022 03:13:09 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A457C5EBED
        for <linux-fsdevel@vger.kernel.org>; Sat,  7 May 2022 00:09:23 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id i66-20020a6bb845000000b00657bac76fb4so6408084iof.15
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 May 2022 00:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/RjqXkVDmSnEe7KcfYtOgh/hY0eudwR3OTDGNYh8rWI=;
        b=wjBVm79T8iqdtlXRwYha325l0MMYJZ8iavz8nWeMAnOuSs+dzquxzlMrhUokoBVJ6l
         F2u115vlAo6YjSxcEBZHSygJYJ2pBegXGvJCckow+tZm8+rnYSCLUYm3rlG5qYPAiTHZ
         e4MFDBdv8Ni40DYaEngz3JeLxJDAxg84bEb7yPnKSd8Y5ialIZWjrH4RVKDwjo/oil4Z
         jTiyAb0gQCmZcXpj1NWfi77XH20CLYIY2RCbNq9HpEdvK7YZyMRMJVgYgaTNc7uT+4j8
         jWl8yU/9+bLriPF8Ve1nrShDK/NK+xNfKqH5UMb2j8uLa3mymYRRtDzvZgqziP44hsVj
         Q0iw==
X-Gm-Message-State: AOAM530dbUUScGJ0JEvAY5xr+swDC/rD6ThhIyJ/Vc9iWFv7+MXYFSCf
        t1eKD//88qBuTfdUN6WEIS7C0kC0WHr+HLCst013TcVU14Kz
X-Google-Smtp-Source: ABdhPJyD5vhriW0DL0FybaB3cEdkB4wuT4GlUYh3xnFl/+8kWp5S1XYJRqauY2rD0crFe0Etz6IMsZKLRijiBeuKdACT4U9rsSFJ
MIME-Version: 1.0
X-Received: by 2002:a5d:8d94:0:b0:652:f6f0:6330 with SMTP id
 b20-20020a5d8d94000000b00652f6f06330mr2866737ioj.199.1651907363056; Sat, 07
 May 2022 00:09:23 -0700 (PDT)
Date:   Sat, 07 May 2022 00:09:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000093b39105de66a7a7@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in inode_wait_for_writeback
From:   syzbot <syzbot+8fbf154f6ae28029c757@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
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

HEAD commit:    4b97bac0756a Merge tag 'for-5.18-rc5-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1265a2bcf00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=331feb185f8828e0
dashboard link: https://syzkaller.appspot.com/bug?extid=8fbf154f6ae28029c757
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8fbf154f6ae28029c757@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: 0000000065d375c1
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 7cc07067 P4D 7cc07067 PUD 0 
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 6611 Comm: syz-executor.5 Not tainted 5.18.0-rc5-syzkaller-00163-g4b97bac0756a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:lock_is_held include/linux/lockdep.h:283 [inline]
RIP: 0010:rcu_read_lock_sched_held+0x39/0x70 kernel/rcu/update.c:125
Code: 75 06 44 89 e0 41 5c c3 e8 24 8c 00 00 84 c0 74 41 e8 8b a8 00 00 84 c0 74 38 be ff ff ff ff 48 c7 c7 20 20 d8 8b e8 c6 a1 09 <08> 85 c0 75 d3 65 8b 05 cb c1 9e 7e a9 ff ff ff 7f 75 c5 9c 41 5c
RSP: 0018:ffffc9000545f9e0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 1ffff92000a8bf40 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000000 R09: ffffffff8db92257
R10: fffffbfff1b7244a R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: ffff88806a792f30 R15: 0000000000000000
FS:  00007f66a8337700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000065d375c1 CR3: 000000007d8c7000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 trace_lock_acquire include/trace/events/lock.h:13 [inline]
 lock_acquire+0x442/0x510 kernel/locking/lockdep.c:5612
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:349 [inline]
 inode_wait_for_writeback+0x1a/0x30 fs/fs-writeback.c:1466
 evict+0x2b7/0x6b0 fs/inode.c:661
 iput_final fs/inode.c:1744 [inline]
 iput.part.0+0x562/0x820 fs/inode.c:1770
 iput+0x58/0x70 fs/inode.c:1760
 ntfs_fill_super+0x2e08/0x37b0 fs/ntfs3/super.c:1178
 get_tree_bdev+0x440/0x760 fs/super.c:1292
 vfs_get_tree+0x89/0x2f0 fs/super.c:1497
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f66a728a61a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f66a8336f88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f66a728a61a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f66a8336fe0
RBP: 00007f66a8337020 R08: 00007f66a8337020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f66a8336fe0 R15: 000000002007c6a0
 </TASK>
Modules linked in:
CR2: 0000000065d375c1
---[ end trace 0000000000000000 ]---
RIP: 0010:lock_is_held include/linux/lockdep.h:283 [inline]
RIP: 0010:rcu_read_lock_sched_held+0x39/0x70 kernel/rcu/update.c:125
Code: 75 06 44 89 e0 41 5c c3 e8 24 8c 00 00 84 c0 74 41 e8 8b a8 00 00 84 c0 74 38 be ff ff ff ff 48 c7 c7 20 20 d8 8b e8 c6 a1 09 <08> 85 c0 75 d3 65 8b 05 cb c1 9e 7e a9 ff ff ff 7f 75 c5 9c 41 5c
RSP: 0018:ffffc9000545f9e0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 1ffff92000a8bf40 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000000 R09: ffffffff8db92257
R10: fffffbfff1b7244a R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: ffff88806a792f30 R15: 0000000000000000
FS:  00007f66a8337700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000065d375c1 CR3: 000000007d8c7000 CR4: 0000000000350ef0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
