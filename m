Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4F47751D6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 06:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjHIEPD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 00:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjHIEPC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 00:15:02 -0400
Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C522A19A1
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Aug 2023 21:15:01 -0700 (PDT)
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-3a5ad6088f8so11354742b6e.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Aug 2023 21:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691554501; x=1692159301;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FoC+ZHK/Ul0zUz/gPO+LgSvXGBeamDhZjMv6kjqJlv0=;
        b=Wd7ejVhGS1OQZOyvlf5oyNERcP6GZcZWLcTZ8qKPUCDrvxUkhGuTE2nu8ytddFYtLY
         mVbQsbLdFCg8mJKACWNa94duDBRbD6woO1u0QKTYrOj3unZnIEVm9DoNtcbtn5GDkNs1
         1gN5D9UKShqShBakcZVRFcdbR5c8sHq2gD3Ldti7LosF+hK+4Yi4LRKFASqIxta65W93
         iSQb5xu4M5NZS6Tag/ICoaQb+/7GhsZALmtpLA2gnrwaOwqUDRy67s14E3HYMHagZHNs
         AJ/gOJZ7Ri4BZoiOv0AebG8xSfwLNEtvvGxcTvwNBGOakks+jvONyuryb8kU86dXcOf9
         nzjQ==
X-Gm-Message-State: AOJu0YwNwZaHD65UwqTfphjjQrqFhR8LZEdOagYhy3veKKI/Tc98hq3f
        9j/KD6ftCdi9oScF/mzOUwoaW4wGbXETQwBp62dyqgyzTZZ4
X-Google-Smtp-Source: AGHT+IE6SQO4Zp8MUQQnAcglW5Mq2oa+Ullg76DaCVffi2y85gWpT/v/GiHVg1+24DczZ8vpPW4iyIwgLsSUbKaq7ubMxnU8aQwm
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1292:b0:3a7:4878:233d with SMTP id
 a18-20020a056808129200b003a74878233dmr1014400oiw.0.1691554501128; Tue, 08 Aug
 2023 21:15:01 -0700 (PDT)
Date:   Tue, 08 Aug 2023 21:15:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000287928060275b914@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in update_inline_extent_backref
From:   syzbot <syzbot+c128866d4c63fd09a097@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e6fda526d9db Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13056635a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e3d5175079af5a4
dashboard link: https://syzkaller.appspot.com/bug?extid=c128866d4c63fd09a097
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/97a696eca453/disk-e6fda526.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d4053dfcc8c4/vmlinux-e6fda526.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5e22f1544aca/bzImage-e6fda526.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c128866d4c63fd09a097@syzkaller.appspotmail.com

   btrfs_ioctl_balance+0x496/0x7c0 fs/btrfs/ioctl.c:3604
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:870 [inline]
   __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:856
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x63/0xcd
------------[ cut here ]------------
kernel BUG at fs/btrfs/extent-tree.c:1125!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 21577 Comm: syz-executor.3 Not tainted 6.5.0-rc4-syzkaller-00211-ge6fda526d9db #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
RIP: 0010:update_inline_extent_backref+0x530/0x5d0 fs/btrfs/extent-tree.c:1125
Code: a7 5d fe e9 9e fc ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 11 ff ff ff 48 89 df e8 6a a7 5d fe e9 04 ff ff ff e8 30 da 04 fe <0f> 0b e8 29 da 04 fe 4c 89 e7 e8 71 80 00 00 4c 89 e3 49 8d 7c 24
RSP: 0018:ffffc9000bee6fc8 EFLAGS: 00010246
RAX: ffffffff8386cd50 RBX: 0000000000000002 RCX: 0000000000040000
RDX: ffffc900113d3000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: 00000000000000b2 R08: ffffffff8386cb53 R09: ffffffff8386ca4a
R10: 0000000000000004 R11: ffff88803763bb80 R12: 00000000fffffffe
R13: 0000000000000001 R14: ffff88801e544000 R15: 0000000000000f3e
FS:  00007ffb6820e6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8f6ded71e5 CR3: 000000003561e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 remove_extent_backref fs/btrfs/extent-tree.c:1193 [inline]
 __btrfs_free_extent+0x1329/0x3250 fs/btrfs/extent-tree.c:3116
 run_delayed_data_ref fs/btrfs/extent-tree.c:1532 [inline]
 run_one_delayed_ref fs/btrfs/extent-tree.c:1706 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1948 [inline]
 __btrfs_run_delayed_refs+0x108d/0x3f90 fs/btrfs/extent-tree.c:2009
 btrfs_run_delayed_refs+0x140/0x480 fs/btrfs/extent-tree.c:2121
 btrfs_commit_transaction+0x495/0x2ff0 fs/btrfs/transaction.c:2163
 relocate_block_group+0xb7d/0xcd0 fs/btrfs/relocation.c:3763
 btrfs_relocate_block_group+0x7ab/0xd70 fs/btrfs/relocation.c:4087
 btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3283
 __btrfs_balance+0x1b06/0x2690 fs/btrfs/volumes.c:4018
 btrfs_balance+0xbd8/0x10d0 fs/btrfs/volumes.c:4395
 btrfs_ioctl_balance+0x496/0x7c0 fs/btrfs/ioctl.c:3604
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ffb6747cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffb6820e0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffb6759c1f0 RCX: 00007ffb6747cae9
RDX: 00000000200003c0 RSI: 00000000c4009420 RDI: 0000000000000009
RBP: 00007ffb674c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007ffb6759c1f0 R15: 00007ffeafbe6508
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:update_inline_extent_backref+0x530/0x5d0 fs/btrfs/extent-tree.c:1125
Code: a7 5d fe e9 9e fc ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 11 ff ff ff 48 89 df e8 6a a7 5d fe e9 04 ff ff ff e8 30 da 04 fe <0f> 0b e8 29 da 04 fe 4c 89 e7 e8 71 80 00 00 4c 89 e3 49 8d 7c 24
RSP: 0018:ffffc9000bee6fc8 EFLAGS: 00010246
RAX: ffffffff8386cd50 RBX: 0000000000000002 RCX: 0000000000040000
RDX: ffffc900113d3000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: 00000000000000b2 R08: ffffffff8386cb53 R09: ffffffff8386ca4a
R10: 0000000000000004 R11: ffff88803763bb80 R12: 00000000fffffffe
R13: 0000000000000001 R14: ffff88801e544000 R15: 0000000000000f3e
FS:  00007ffb6820e6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8f6ded71e5 CR3: 000000003561e000 CR4: 00000000003506e0
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

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
