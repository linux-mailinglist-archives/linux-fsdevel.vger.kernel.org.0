Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCF67ADF5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 20:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbjIYS7D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 14:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbjIYS7B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 14:59:01 -0400
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB76BB8
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 11:58:53 -0700 (PDT)
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-3ae4cefe17dso3583227b6e.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 11:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695668333; x=1696273133;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CrA4A/OM44dGfP3v0DVBCp7D7UGmu2VhFiv8ESa1NJ0=;
        b=UZVs7xm5PQCLHN09NcyGWgpVbxSmGKVMD7JC3ZvGQ2Lkm2cKNbKUfe+MBFgjzQ0L7g
         UJT0lDh+4hgIp6PfgrsT/tXaQRR/V32v9Kaas+986q1IDVfH87KaD3r/RmqM12OE/uT/
         E7wfzztagx3v9PvAigyWhISehDr52JXbSI8ddn6YRsZPcQdiyViwMQ/KnZZJpWEkfBj/
         /E0Sm8vlUTY6RyoHRGxZITDPIHvTNk/N6SDcOpF+uMV6xcZExuKtw0sAqyMcmpqdi0AA
         o6ioyMFdFbjBPEZ7/bGwDqda0nSknuRmahKWjG0Pymq8eHep9N2b8NsMO1EKShjrN8nd
         SM8w==
X-Gm-Message-State: AOJu0YzGNM2X9izvargDB5dBfqI/aDCf8lyB55hedOt612zZWOx/9VzQ
        WK989o9yfdyLlbo0akTzgYQa5Nj1/XIgWFX65jeGMk0VT3Kf
X-Google-Smtp-Source: AGHT+IG9iA/nEaGxVJKwQ/ObuWIjfylPqjUywzGzabRfgSpzIf8mxyVnX4yuQhPFUhsDAcMClm0O/Kd4fxwJahjwi486sWnvuJND
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a21:b0:3a8:48fc:aaa5 with SMTP id
 bk33-20020a0568081a2100b003a848fcaaa5mr4784932oib.5.1695668333171; Mon, 25
 Sep 2023 11:58:53 -0700 (PDT)
Date:   Mon, 25 Sep 2023 11:58:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a7db220606338cf7@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_add_reserved_bytes
From:   syzbot <syzbot+53034ab3f4d670ca496b@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    42dc814987c1 Merge tag 'media/v6.6-2' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=153c42d4680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e4ca82a1bedd37e4
dashboard link: https://syzkaller.appspot.com/bug?extid=53034ab3f4d670ca496b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cb83da482fb0/disk-42dc8149.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7a37cd631377/vmlinux-42dc8149.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d1323cd7f312/bzImage-42dc8149.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+53034ab3f4d670ca496b@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5082 at fs/btrfs/space-info.h:198 btrfs_add_reserved_bytes+0x4b4/0x7b0 fs/btrfs/block-group.c:3694
Modules linked in:
CPU: 1 PID: 5082 Comm: syz-executor.2 Not tainted 6.6.0-rc2-syzkaller-00048-g42dc814987c1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
RIP: 0010:btrfs_space_info_update_bytes_may_use fs/btrfs/space-info.h:198 [inline]
RIP: 0010:btrfs_add_reserved_bytes+0x4b4/0x7b0 fs/btrfs/block-group.c:3694
Code: 5c 24 28 74 08 48 89 df e8 59 ef 32 fe 48 8b 2b 48 89 ef 48 8b 5c 24 30 48 89 de e8 16 89 d8 fd 48 39 dd 73 0b e8 fc 86 d8 fd <0f> 0b 31 ed eb 26 e8 f1 86 d8 fd 48 8b 5c 24 28 48 8b 44 24 40 42
RSP: 0018:ffffc9000421ed70 EFLAGS: 00010293
RAX: ffffffff83b58404 RBX: 0000000000001000 RCX: ffff88801cd80000
RDX: 0000000000000000 RSI: 0000000000001000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff83b583fa R09: 1ffffffff1d34cfd
R10: dffffc0000000000 R11: fffffbfff1d34cfe R12: ffff88807be76800
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000001000
FS:  0000555556b91480(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3123a06d58 CR3: 00000000821cd000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 find_free_extent+0x3aa1/0x5770 fs/btrfs/extent-tree.c:4387
 btrfs_reserve_extent+0x422/0x800 fs/btrfs/extent-tree.c:4514
 btrfs_alloc_tree_block+0x20e/0x1800 fs/btrfs/extent-tree.c:4929
 __btrfs_cow_block+0x465/0x1b00 fs/btrfs/ctree.c:546
 btrfs_cow_block+0x403/0x780 fs/btrfs/ctree.c:712
 commit_cowonly_roots+0x197/0x860 fs/btrfs/transaction.c:1299
 btrfs_commit_transaction+0xff4/0x3720 fs/btrfs/transaction.c:2435
 close_ctree+0x3dd/0xd40 fs/btrfs/disk-io.c:4356
 generic_shutdown_super+0x13a/0x2c0 fs/super.c:693
 kill_anon_super+0x3b/0x70 fs/super.c:1292
 btrfs_kill_super+0x41/0x50 fs/btrfs/super.c:2144
 deactivate_locked_super+0xa4/0x110 fs/super.c:481
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1254
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0xd9/0x100 kernel/entry/common.c:171
 exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:296
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0019a7de17
Code: b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffc591d0408 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f0019a7de17
RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007ffc591d04c0
RBP: 00007ffc591d04c0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffc591d1580
R13: 00007f0019ac73b9 R14: 00000000001f9f05 R15: 000000000000000d
 </TASK>


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
