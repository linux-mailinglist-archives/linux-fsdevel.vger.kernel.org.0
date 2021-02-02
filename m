Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01BD730B8A6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 08:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhBBHdC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 02:33:02 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:55214 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhBBHdA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 02:33:00 -0500
Received: by mail-il1-f198.google.com with SMTP id s4so5919420ilt.21
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Feb 2021 23:32:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=yEspMoGKMDuEEGSpdgz0FaL0GKC/NspiboJRr5zloY4=;
        b=gpZZ3vi3Sd7oZF77tekGzEprOOZr3bmJHXqNgWMJW6/mbishvyxEBkE/x5p2KjfoYM
         RYswq2iV/hwvl103aCTGg7JvWji0A/dPlwzrtFnWWlOF5/ygs+u0M+Stb9yq3gx3VYL6
         3ooANJUy6FlS/fqR0qta5dI2zs/R2/q1cHGtJwqvF5oLXsD8bXR3hjg0l+WYPz3M86wj
         9218PkIWO8yO8kTdr0AItu9GzI4fEVT0/I2O992Q97N34Qbi8H9N7+s9dBXMK1oxqRSK
         DiYNRDLBjqdm4VzqlpEfpboHid0bZCrnBa3coP4rnCDECJmQKat3D+v2zFLRO4RimCA6
         5sEw==
X-Gm-Message-State: AOAM5313bYbewAgmd9SlQ0OejZSopZ6HVoIAVHrHlURG2yhoFjMBTxeV
        Lw4eWVeT6VlGN+vNRoOfCJSJw1QwIl+CU9Y9MLxp5NyAmejM
X-Google-Smtp-Source: ABdhPJw0ABknIZcjmWqfmFc8vxwHhusveS85e+Bq0Y/H0YQpQqNAseSgn9pii8y8Cj8Sj6uh56kPbgCZ9TcNWB2S/NkkfYwke/v+
MIME-Version: 1.0
X-Received: by 2002:a5d:8887:: with SMTP id d7mr15283961ioo.151.1612251139885;
 Mon, 01 Feb 2021 23:32:19 -0800 (PST)
Date:   Mon, 01 Feb 2021 23:32:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b503905ba5578a6@google.com>
Subject: general protection fault in invalidate_bdev
From:   syzbot <syzbot+d65b0638dd3d123794f2@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d03154e8 Add linux-next specific files for 20210128
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1088091cd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6953ffb584722a1
dashboard link: https://syzkaller.appspot.com/bug?extid=d65b0638dd3d123794f2
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d65b0638dd3d123794f2@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
CPU: 0 PID: 30787 Comm: syz-executor.3 Not tainted 5.11.0-rc5-next-20210128-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:invalidate_bdev+0x1f/0xd0 fs/block_dev.c:92
Code: ff 66 2e 0f 1f 84 00 00 00 00 00 55 53 48 89 fb e8 16 29 a0 ff 48 8d 7b 28 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 93 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b
RSP: 0018:ffffc90017c07848 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc9000f244000
RDX: 0000000000000005 RSI: ffffffff81d2ec3a RDI: 0000000000000028
RBP: ffff888073ecc000 R08: 0000000000000000 R09: ffffffff8b2146c3
R10: fffffbfff16428d8 R11: 0000000000000000 R12: ffff888076c38cc0
R13: 0000000000000001 R14: 0000000000000001 R15: ffff888028720000
FS:  00007fe9ef641700(0000) GS:ffff8880b9e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb745112db8 CR3: 000000008b834000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 open_ctree+0xab3/0x4060 fs/btrfs/disk-io.c:3086
 btrfs_fill_super fs/btrfs/super.c:1356 [inline]
 btrfs_mount_root.cold+0x14/0x165 fs/btrfs/super.c:1723
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1497
 fc_mount fs/namespace.c:993 [inline]
 vfs_kern_mount.part.0+0xd3/0x170 fs/namespace.c:1023
 vfs_kern_mount+0x3c/0x60 fs/namespace.c:1010
 btrfs_mount+0x234/0xa20 fs/btrfs/super.c:1783
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1497
 do_new_mount fs/namespace.c:2903 [inline]
 path_mount+0x132a/0x1f90 fs/namespace.c:3233
 do_mount fs/namespace.c:3246 [inline]
 __do_sys_mount fs/namespace.c:3454 [inline]
 __se_sys_mount fs/namespace.c:3431 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3431
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x460c6a
Code: b8 a6 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 ad 89 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 8a 89 fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007fe9ef640a78 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fe9ef640b10 RCX: 0000000000460c6a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fe9ef640ad0
RBP: 00007fe9ef640ad0 R08: 00007fe9ef640b10 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 0000000020000200 R15: 0000000020003d00
Modules linked in:
---[ end trace 44edaf4ec7942bd8 ]---
RIP: 0010:invalidate_bdev+0x1f/0xd0 fs/block_dev.c:92
Code: ff 66 2e 0f 1f 84 00 00 00 00 00 55 53 48 89 fb e8 16 29 a0 ff 48 8d 7b 28 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 93 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b
RSP: 0018:ffffc90017c07848 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc9000f244000
RDX: 0000000000000005 RSI: ffffffff81d2ec3a RDI: 0000000000000028
RBP: ffff888073ecc000 R08: 0000000000000000 R09: ffffffff8b2146c3
R10: fffffbfff16428d8 R11: 0000000000000000 R12: ffff888076c38cc0
R13: 0000000000000001 R14: 0000000000000001 R15: ffff888028720000
FS:  00007fe9ef641700(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdfaea9138 CR3: 000000008b834000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
