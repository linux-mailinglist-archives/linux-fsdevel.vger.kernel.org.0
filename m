Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D3435D790
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 07:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344605AbhDMFzo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 01:55:44 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:56395 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhDMFzn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 01:55:43 -0400
Received: by mail-io1-f69.google.com with SMTP id j6so5214034iog.23
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Apr 2021 22:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3UvEYXwfzE96WskXPc41XH3OXkDOqDJ6GKvKrcqu/Uw=;
        b=cd1tlER60eSHhLYBeCbQgjg1byfCXZHGfSCZVJnrWj4N3kEYI4z5dTd0lQh39LzMeL
         KB+tzWwjOU37h8N2+ZWq9drBV5ytLyOhPXV7B/UlboV6iAMes7YnFjR/6qbHakGVK8lE
         sFnCmlTnJ3wN/Br2njX7QT7AC1eOi9KH4nicDXUXq435+PYVeoeHhsBKqWBPc1WsUsCX
         4Ge4pZxcKRgNz8H+/Vz8Fm09ptp/4rfhSatouB3QeJcLchLqnsIwea7Uz6uVd23ccSrH
         h6pat2tar5vuu7vnIaybTGsTIF1/iXKvMUvUXUbYHXEM0UBDCum2NLzZOwzeZMTWjaFY
         65ow==
X-Gm-Message-State: AOAM533a6NJtBYUJ8sXU1C9X6qPQdiRAKJxVv9g+Mjxn8jLlgEVaKVgs
        OwVCDeDXRtrs4eawHjCqA/hrmX+MnKGxrlXnpxfuB/5Q4b8K
X-Google-Smtp-Source: ABdhPJzkvywe8nghQGlyW4KyrKYQ+oCi7WuYn+97neCZjGlZhKBc5vJmJINRUieCiGsObIsYjsCptSjzWm0fekO8ZFO+5MzzIyRX
MIME-Version: 1.0
X-Received: by 2002:a05:6602:73c:: with SMTP id g28mr14502869iox.47.1618293322621;
 Mon, 12 Apr 2021 22:55:22 -0700 (PDT)
Date:   Mon, 12 Apr 2021 22:55:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a324c305bfd446c0@google.com>
Subject: [syzbot] BUG: unable to handle kernel NULL pointer dereference in
 __lookup_slow (2)
From:   syzbot <syzbot+11c49ce9d4e7896f3406@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d93a0d43 Merge tag 'block-5.12-2021-04-02' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16519431d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=71a75beb62b62a34
dashboard link: https://syzkaller.appspot.com/bug?extid=11c49ce9d4e7896f3406
compiler:       Debian clang version 11.0.1-2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+11c49ce9d4e7896f3406@syzkaller.appspotmail.com

REISERFS (device loop4): Using r5 hash to sort names
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 6bb82067 P4D 6bb82067 PUD 6bb81067 PMD 0 
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 11072 Comm: syz-executor.4 Not tainted 5.12.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:0x0
Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
RSP: 0018:ffffc90008f8fa20 EFLAGS: 00010246
RAX: 1ffffffff13872e8 RBX: dffffc0000000000 RCX: 0000000000040000
RDX: 0000000000000000 RSI: ffff88802e9d9490 RDI: ffff88807f140190
RBP: ffffffff89c39740 R08: ffffffff81c9d4de R09: fffffbfff200a946
R10: fffffbfff200a946 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88807f140190 R14: 1ffff11005d3b292 R15: ffff88802e9d9490
FS:  00007f894af88700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000006bb83000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __lookup_slow+0x240/0x370 fs/namei.c:1626
 lookup_one_len+0x10e/0x200 fs/namei.c:2649
 reiserfs_lookup_privroot+0x85/0x1e0 fs/reiserfs/xattr.c:980
 reiserfs_fill_super+0x2a69/0x3160 fs/reiserfs/super.c:2176
 mount_bdev+0x26c/0x3a0 fs/super.c:1367
 legacy_get_tree+0xea/0x180 fs/fs_context.c:592
 vfs_get_tree+0x86/0x270 fs/super.c:1497
 do_new_mount fs/namespace.c:2903 [inline]
 path_mount+0x188a/0x29a0 fs/namespace.c:3233
 do_mount fs/namespace.c:3246 [inline]
 __do_sys_mount fs/namespace.c:3454 [inline]
 __se_sys_mount+0x28c/0x320 fs/namespace.c:3431
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x46797a
Code: 48 c7 c2 bc ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f894af87fa8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 000000000046797a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f894af88000
RBP: 00007f894af88040 R08: 00007f894af88040 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f894af88000 R15: 0000000020011500
Modules linked in:
CR2: 0000000000000000
---[ end trace a1b8dbb111baf993 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
RSP: 0018:ffffc90008f8fa20 EFLAGS: 00010246
RAX: 1ffffffff13872e8 RBX: dffffc0000000000 RCX: 0000000000040000
RDX: 0000000000000000 RSI: ffff88802e9d9490 RDI: ffff88807f140190
RBP: ffffffff89c39740 R08: ffffffff81c9d4de R09: fffffbfff200a946
R10: fffffbfff200a946 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88807f140190 R14: 1ffff11005d3b292 R15: ffff88802e9d9490
FS:  00007f894af88700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000006bb83000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
