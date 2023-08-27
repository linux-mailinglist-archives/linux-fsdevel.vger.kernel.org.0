Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751AD789B74
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Aug 2023 07:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjH0FKe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Aug 2023 01:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjH0FKH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Aug 2023 01:10:07 -0400
Received: from mail-pl1-f208.google.com (mail-pl1-f208.google.com [209.85.214.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E731B9
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Aug 2023 22:10:05 -0700 (PDT)
Received: by mail-pl1-f208.google.com with SMTP id d9443c01a7336-1c093862623so26480145ad.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Aug 2023 22:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693113004; x=1693717804;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N5hm0d31al3v/07YUi/1l9Fvse8OpUwbENSQL5ykQs8=;
        b=XSXeXdtWwmNIOemxB2nfUNyd7pmuPxVfLvU50R2cYEZBmKFQc/EpEbeYhU7J9pIXHc
         v/tdv9b/9siT0Xew0x/IR/pvICdvYSg54uBtnnTSdyrT4MgekomCTgFFF2nhcOv6bEzi
         fih2DvoG3Vqg9sT+Zx1fNmWytbe3MclCM9rO6zolrH8xoT07qdyrrFvnT18dEC2FwfN7
         e0zX1qcMTt/KxudxUPtpHdyjZ1t5U4HMg8U+GcQzoPYEWj78BLWygWra80mtHABCXxUr
         pr0cIQeTSwMlhIHISPqLfGe5a2oGm2DfsBalQJD/APVEnNpqmdOERGhS/mrzctsfMRHN
         hAWg==
X-Gm-Message-State: AOJu0YwX0OfZI8P5XFW5CEEeXa74CGnFNwxNJMy57JiaSphQC3U083/h
        jpU1hPP7I/gIHHMQmYB5s7h+cMlCZHeqQILCOw2o4UVZ3sJH
X-Google-Smtp-Source: AGHT+IH0hD4mO9k6jHX8DCWt0C3tc7QbQqUhRr44iyI0RxQOWFx8vRoEV1xHKjTEKb5muJrD8LQW4dWUoq7amEBdg0bWrtHkmpnV
MIME-Version: 1.0
X-Received: by 2002:a17:902:da88:b0:1ba:a36d:f82c with SMTP id
 j8-20020a170902da8800b001baa36df82cmr8144392plx.7.1693113004775; Sat, 26 Aug
 2023 22:10:04 -0700 (PDT)
Date:   Sat, 26 Aug 2023 22:10:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000036e1290603e097e0@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in btrfs_insert_delayed_dir_index
From:   syzbot <syzbot+d13490c82ad5353c779d@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    a5e505a99ca7 Merge tag 'platform-drivers-x86-v6.5-5' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c71340680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b32f62c755c3a9c
dashboard link: https://syzkaller.appspot.com/bug?extid=d13490c82ad5353c779d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c871771378a8/disk-a5e505a9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/754522af4822/vmlinux-a5e505a9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5bf8075fe538/bzImage-a5e505a9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d13490c82ad5353c779d@syzkaller.appspotmail.com

BTRFS error (device loop4): err add delayed dir index item(name: binderfs2) into the insertion tree of the delayed node(root id: 5, inode id: 257, errno: -17)
------------[ cut here ]------------
kernel BUG at fs/btrfs/delayed-inode.c:1504!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 7505 Comm: syz-executor.4 Not tainted 6.5.0-rc7-syzkaller-00022-ga5e505a99ca7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:btrfs_insert_delayed_dir_index+0xc70/0xca0 fs/btrfs/delayed-inode.c:1504
Code: 43 fe 48 8b 04 24 4c 8b 08 4c 89 f7 48 c7 c6 e0 90 4b 8b 48 8b 54 24 60 48 8b 4c 24 58 49 89 e8 53 e8 d4 c9 19 07 48 83 c4 08 <0f> 0b e8 89 45 ea fd 48 c7 c7 40 90 4b 8b 48 c7 c6 a0 90 4b 8b 48
RSP: 0018:ffffc90015a87678 EFLAGS: 00010286
RAX: 296378981ff91c00 RBX: 00000000ffffffef RCX: 1ffff92002b50ea4
RDX: ffffc90006231000 RSI: 000000000001ca7c RDI: 000000000001ca7d
RBP: 0000000000000005 R08: ffffffff816f0d3c R09: 1ffff92002b50e4c
R10: dffffc0000000000 R11: fffff52002b50e4d R12: ffff88802370a1f0
R13: 1ffff1100ea2b4a9 R14: ffff888078e7c000 R15: ffff88807c4e81f7
FS:  00007f10efdfe6c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe0f73af68 CR3: 000000007cb5e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_insert_dir_item+0x47d/0x630 fs/btrfs/dir-item.c:166
 btrfs_add_link+0x287/0xc60 fs/btrfs/inode.c:6581
 btrfs_create_new_inode+0x1b27/0x2760 fs/btrfs/inode.c:6522
 btrfs_create_common+0x1f9/0x300 fs/btrfs/inode.c:6657
 vfs_mkdir+0x29d/0x450 fs/namei.c:4117
 do_mkdirat+0x264/0x520 fs/namei.c:4140
 __do_sys_mkdirat fs/namei.c:4155 [inline]
 __se_sys_mkdirat fs/namei.c:4153 [inline]
 __x64_sys_mkdirat+0x89/0xa0 fs/namei.c:4153
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f10f127cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f10efdfe0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007f10f139bf80 RCX: 00007f10f127cae9
RDX: 00000000000001ff RSI: 0000000020000140 RDI: ffffffffffffff9c
RBP: 00007f10f12c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f10f139bf80 R15: 00007ffdc0af52a8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btrfs_insert_delayed_dir_index+0xc70/0xca0 fs/btrfs/delayed-inode.c:1504
Code: 43 fe 48 8b 04 24 4c 8b 08 4c 89 f7 48 c7 c6 e0 90 4b 8b 48 8b 54 24 60 48 8b 4c 24 58 49 89 e8 53 e8 d4 c9 19 07 48 83 c4 08 <0f> 0b e8 89 45 ea fd 48 c7 c7 40 90 4b 8b 48 c7 c6 a0 90 4b 8b 48
RSP: 0018:ffffc90015a87678 EFLAGS: 00010286
RAX: 296378981ff91c00 RBX: 00000000ffffffef RCX: 1ffff92002b50ea4
RDX: ffffc90006231000 RSI: 000000000001ca7c RDI: 000000000001ca7d
RBP: 0000000000000005 R08: ffffffff816f0d3c R09: 1ffff92002b50e4c
R10: dffffc0000000000 R11: fffff52002b50e4d R12: ffff88802370a1f0
R13: 1ffff1100ea2b4a9 R14: ffff888078e7c000 R15: ffff88807c4e81f7
FS:  00007f10efdfe6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055966fc90008 CR3: 000000007cb5e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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
