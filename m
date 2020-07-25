Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2BA22D8D7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jul 2020 19:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgGYREQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jul 2020 13:04:16 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:55654 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgGYREQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jul 2020 13:04:16 -0400
Received: by mail-io1-f70.google.com with SMTP id k10so8455462ioh.22
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2020 10:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Y/HlUNrKfgID0KWgDK/w/v+LPsx39sOOmu9UIWms2Xs=;
        b=tNKYWxYoBgvBFaen4JEEdlYK4FBLbnPNbSgJt6GsiPFt1ib856y08Yi0VXJYfnZDf2
         8FSVzPsPGrGV+JOOFeH+VJCf/VVIKH8peQ9/wnXv1QtOZ/8xjMlxWWUZANqNcRQ9mRbR
         TT9w7ZnrUoG5lJT6LUv1Y7hZrpTJZ2aHx23es2g1mVpyzDFzbVHX0/zeH/oWXzOOpeDr
         UNblqb+2FZHjOWpBua3Mbxn15o+CVYxC96kAcT0kOiP6QrDow0th2rFp268KpV+JrlVP
         sXF7oiaPRoboND0Uijf+utov06ch3NALbW/G36SQGHxIQlRVjpj9fiYePYcGPhWyOzE4
         ZEUg==
X-Gm-Message-State: AOAM531bt5FWJGiJeqg/XchvBDotl/tu6GVx4ITSn4wofdQJgQw7mAn8
        TMN1BUNPRb3zJVdoth4+Alz4Q1GUVlq24fmLIjIeCawSTbqy
X-Google-Smtp-Source: ABdhPJxKhmPIerSdcjzxkII3vvJG6gsAKaAr3rQVNjq50Kjh9eVPrI75AG7oN0UfaGZrAUEzIFh0JvzLjAF5WwZz3jsRU9ER0ih4
MIME-Version: 1.0
X-Received: by 2002:a92:db01:: with SMTP id b1mr15330750iln.249.1595696655474;
 Sat, 25 Jul 2020 10:04:15 -0700 (PDT)
Date:   Sat, 25 Jul 2020 10:04:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000051a79d05ab471440@google.com>
Subject: WARNING in delete_node (2)
From:   syzbot <syzbot+6324a37c93030377021f@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    de2e69cf Add linux-next specific files for 20200721
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13645cef100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a18f913b3827a63a
dashboard link: https://syzkaller.appspot.com/bug?extid=6324a37c93030377021f
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6324a37c93030377021f@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 17410 at lib/radix-tree.c:571 delete_node+0x1e7/0x8a0 lib/radix-tree.c:571
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 17410 Comm: syz-executor.5 Not tainted 5.8.0-rc6-next-20200721-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:231
 __warn.cold+0x20/0x45 kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:545
RIP: 0010:delete_node+0x1e7/0x8a0 lib/radix-tree.c:571
Code: e2 48 c7 43 48 00 00 00 00 48 c1 ea 03 42 80 3c 2a 00 0f 85 bb 05 00 00 48 8b 55 18 49 39 d4 0f 84 8b 03 00 00 e8 e9 6c c3 fd <0f> 0b 48 c7 c6 d0 a6 b0 83 4c 89 e7 e8 b8 d7 b0 fd 4d 85 f6 0f 85
RSP: 0018:ffffc900078afd08 EFLAGS: 00010246
RAX: 0000000000040000 RBX: ffffffff89d2df00 RCX: ffffc90013fcd000
RDX: 0000000000040000 RSI: ffffffff83b0d377 RDI: ffff8880a9c90842
RBP: ffff88808a91ab40 R08: 0000000000000000 R09: ffff8880a9c90a6f
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88808a91ab58
R13: dffffc0000000000 R14: ffff8880a9c90840 R15: 000000000000000a
 __radix_tree_delete+0x190/0x370 lib/radix-tree.c:1378
 radix_tree_delete_item+0xe7/0x230 lib/radix-tree.c:1429
 mnt_free_id fs/namespace.c:131 [inline]
 cleanup_mnt+0x3db/0x500 fs/namespace.c:1140
 task_work_run+0xdd/0x190 kernel/task_work.c:135
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_usermode_loop arch/x86/entry/common.c:239 [inline]
 __prepare_exit_to_usermode+0x199/0x1c0 arch/x86/entry/common.c:269
 do_syscall_64+0x6c/0xe0 arch/x86/entry/common.c:393
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45c1f9
Code: Bad RIP value.
RSP: 002b:00007fe40341bc78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffe4 RBX: 000000000001fa40 RCX: 000000000045c1f9
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000020000080
RBP: 000000000078bf50 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000005010 R11: 0000000000000246 R12: 000000000078bf0c
R13: 00007ffc20fd1c9f R14: 00007fe40341c9c0 R15: 000000000078bf0c
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
