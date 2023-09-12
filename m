Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B5D79CE5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 12:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbjILKeX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 06:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbjILKcY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:32:24 -0400
Received: from mail-pf1-f206.google.com (mail-pf1-f206.google.com [209.85.210.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA2110DB
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 03:30:51 -0700 (PDT)
Received: by mail-pf1-f206.google.com with SMTP id d2e1a72fcca58-68fe3d77ed8so983792b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 03:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694514651; x=1695119451;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MNvP2krJA2A9g3eAJckhj66rkgvm0XXX/AeaULrjy7E=;
        b=A51TrC9FBN502XvADbPOe6cLaWYj0+GG4vuXUXDSQ5qbgLRPVs9pi5oPT/iYPONXa/
         N5Eh6Xwr6pUcgpvxdZhydM4pASqNZnFJSDN2oLxKjZ6MO6tjnJIvJtOTgnud/oVpKW4s
         PKaOEqTMoeiMgr3R/2ywGnEfB9DTt6A3r1wc6BHOp1sB1aiD2NsvdrbKEJNuir+3sMbV
         vpTRMcYakry06MY2qtubpcsOaAwPqDewOaJzicgonsMrmOA6vN1Y6uAelF/perwaTZvW
         9GZE0H2K3nSEi512RnSWdyh0bF+LomD2eFm2gUPXeDgpkxIsVUdV+IWl+t9K7JLmAF80
         EIJQ==
X-Gm-Message-State: AOJu0Yx2Ihy6TD+/NOvJfiOlpHveaJz6LWwdvJJbxIRJwewFcJevfEP/
        /oEOZLETdtpBz31YxDVjfpd5OyW5NfMNbqKMS2HU5fzxq6x6
X-Google-Smtp-Source: AGHT+IHmvZzTGP6QquDTuhXB1msoThh2x3h8EX0RVS8XLI08TCUryRwMds4uP/a5KFp26VjGaoIlNoDH1HXJpPlF53vplqvzGSc/
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:1a4a:b0:68a:5acb:272b with SMTP id
 h10-20020a056a001a4a00b0068a5acb272bmr4849234pfv.3.1694514651232; Tue, 12 Sep
 2023 03:30:51 -0700 (PDT)
Date:   Tue, 12 Sep 2023 03:30:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da83b5060526ef9c@google.com>
Subject: [syzbot] [ntfs3?] memory leak in run_add_entry
From:   syzbot <syzbot+edcb33c666a478ec67a9@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4a0fc73da97e Merge tag 's390-6.6-2' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16dce6a4680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=52403a23b631cefc
dashboard link: https://syzkaller.appspot.com/bug?extid=edcb33c666a478ec67a9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15780480680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c8a2a4680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7e7536435862/disk-4a0fc73d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f5b10d577113/vmlinux-4a0fc73d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/430b464e2d50/bzImage-4a0fc73d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/551456fa5cb9/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+edcb33c666a478ec67a9@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810c45aa00 (size 64):
  comm "syz-executor381", pid 5019, jiffies 4294945074 (age 13.030s)
  hex dump (first 32 bytes):
    00 00 00 00 01 00 00 00 04 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff815742ee>] __do_kmalloc_node mm/slab_common.c:1022 [inline]
    [<ffffffff815742ee>] __kmalloc_node+0x4e/0x150 mm/slab_common.c:1030
    [<ffffffff81563919>] kmalloc_node include/linux/slab.h:619 [inline]
    [<ffffffff81563919>] kvmalloc_node+0x99/0x170 mm/util.c:607
    [<ffffffff81bfd949>] kvmalloc include/linux/slab.h:737 [inline]
    [<ffffffff81bfd949>] run_add_entry+0x559/0x720 fs/ntfs3/run.c:389
    [<ffffffff81bfee3c>] run_unpack+0x53c/0x620 fs/ntfs3/run.c:1021
    [<ffffffff81bfef97>] run_unpack_ex+0x77/0x320 fs/ntfs3/run.c:1060
    [<ffffffff81bee9d3>] ntfs_read_mft fs/ntfs3/inode.c:400 [inline]
    [<ffffffff81bee9d3>] ntfs_iget5+0x633/0x1a90 fs/ntfs3/inode.c:532
    [<ffffffff81bd0ee6>] ntfs_loadlog_and_replay+0x86/0x280 fs/ntfs3/fsntfs.c:297
    [<ffffffff81c022c7>] ntfs_fill_super+0x1057/0x22f0 fs/ntfs3/super.c:1222
    [<ffffffff81691a21>] get_tree_bdev+0x1b1/0x280 fs/super.c:1577
    [<ffffffff8168ecda>] vfs_get_tree+0x2a/0x130 fs/super.c:1750
    [<ffffffff816d44ef>] do_new_mount fs/namespace.c:3335 [inline]
    [<ffffffff816d44ef>] path_mount+0xc8f/0x10d0 fs/namespace.c:3662
    [<ffffffff816d50e1>] do_mount fs/namespace.c:3675 [inline]
    [<ffffffff816d50e1>] __do_sys_mount fs/namespace.c:3884 [inline]
    [<ffffffff816d50e1>] __se_sys_mount fs/namespace.c:3861 [inline]
    [<ffffffff816d50e1>] __x64_sys_mount+0x1a1/0x1f0 fs/namespace.c:3861
    [<ffffffff84b2dfa8>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b2dfa8>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888108a8b218 (size 8):
  comm "syz-executor381", pid 5019, jiffies 4294945074 (age 13.030s)
  hex dump (first 8 bytes):
    00 00 00 00 00 00 00 00                          ........
  backtrace:
    [<ffffffff8157443b>] __do_kmalloc_node mm/slab_common.c:1022 [inline]
    [<ffffffff8157443b>] __kmalloc+0x4b/0x150 mm/slab_common.c:1036
    [<ffffffff81bc99ac>] kmalloc_array include/linux/slab.h:636 [inline]
    [<ffffffff81bc99ac>] kcalloc include/linux/slab.h:667 [inline]
    [<ffffffff81bc99ac>] wnd_init+0xdc/0x140 fs/ntfs3/bitmap.c:662
    [<ffffffff81c023dd>] ntfs_fill_super+0x116d/0x22f0 fs/ntfs3/super.c:1257
    [<ffffffff81691a21>] get_tree_bdev+0x1b1/0x280 fs/super.c:1577
    [<ffffffff8168ecda>] vfs_get_tree+0x2a/0x130 fs/super.c:1750
    [<ffffffff816d44ef>] do_new_mount fs/namespace.c:3335 [inline]
    [<ffffffff816d44ef>] path_mount+0xc8f/0x10d0 fs/namespace.c:3662
    [<ffffffff816d50e1>] do_mount fs/namespace.c:3675 [inline]
    [<ffffffff816d50e1>] __do_sys_mount fs/namespace.c:3884 [inline]
    [<ffffffff816d50e1>] __se_sys_mount fs/namespace.c:3861 [inline]
    [<ffffffff816d50e1>] __x64_sys_mount+0x1a1/0x1f0 fs/namespace.c:3861
    [<ffffffff84b2dfa8>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b2dfa8>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810bda6080 (size 64):
  comm "syz-executor381", pid 5019, jiffies 4294945074 (age 13.030s)
  hex dump (first 32 bytes):
    00 00 00 00 01 00 00 00 06 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff815742ee>] __do_kmalloc_node mm/slab_common.c:1022 [inline]
    [<ffffffff815742ee>] __kmalloc_node+0x4e/0x150 mm/slab_common.c:1030
    [<ffffffff81563919>] kmalloc_node include/linux/slab.h:619 [inline]
    [<ffffffff81563919>] kvmalloc_node+0x99/0x170 mm/util.c:607
    [<ffffffff81bfd949>] kvmalloc include/linux/slab.h:737 [inline]
    [<ffffffff81bfd949>] run_add_entry+0x559/0x720 fs/ntfs3/run.c:389
    [<ffffffff81bfee3c>] run_unpack+0x53c/0x620 fs/ntfs3/run.c:1021
    [<ffffffff81bfef97>] run_unpack_ex+0x77/0x320 fs/ntfs3/run.c:1060
    [<ffffffff81bee9d3>] ntfs_read_mft fs/ntfs3/inode.c:400 [inline]
    [<ffffffff81bee9d3>] ntfs_iget5+0x633/0x1a90 fs/ntfs3/inode.c:532
    [<ffffffff81c0245d>] ntfs_fill_super+0x11ed/0x22f0 fs/ntfs3/super.c:1272
    [<ffffffff81691a21>] get_tree_bdev+0x1b1/0x280 fs/super.c:1577
    [<ffffffff8168ecda>] vfs_get_tree+0x2a/0x130 fs/super.c:1750
    [<ffffffff816d44ef>] do_new_mount fs/namespace.c:3335 [inline]
    [<ffffffff816d44ef>] path_mount+0xc8f/0x10d0 fs/namespace.c:3662
    [<ffffffff816d50e1>] do_mount fs/namespace.c:3675 [inline]
    [<ffffffff816d50e1>] __do_sys_mount fs/namespace.c:3884 [inline]
    [<ffffffff816d50e1>] __se_sys_mount fs/namespace.c:3861 [inline]
    [<ffffffff816d50e1>] __x64_sys_mount+0x1a1/0x1f0 fs/namespace.c:3861
    [<ffffffff84b2dfa8>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b2dfa8>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888108a8b4a8 (size 8):
  comm "syz-executor381", pid 5019, jiffies 4294945074 (age 13.030s)
  hex dump (first 8 bytes):
    fd 03 00 00 00 00 00 00                          ........
  backtrace:
    [<ffffffff8157443b>] __do_kmalloc_node mm/slab_common.c:1022 [inline]
    [<ffffffff8157443b>] __kmalloc+0x4b/0x150 mm/slab_common.c:1036
    [<ffffffff81bc99ac>] kmalloc_array include/linux/slab.h:636 [inline]
    [<ffffffff81bc99ac>] kcalloc include/linux/slab.h:667 [inline]
    [<ffffffff81bc99ac>] wnd_init+0xdc/0x140 fs/ntfs3/bitmap.c:662
    [<ffffffff81c02509>] ntfs_fill_super+0x1299/0x22f0 fs/ntfs3/super.c:1294
    [<ffffffff81691a21>] get_tree_bdev+0x1b1/0x280 fs/super.c:1577
    [<ffffffff8168ecda>] vfs_get_tree+0x2a/0x130 fs/super.c:1750
    [<ffffffff816d44ef>] do_new_mount fs/namespace.c:3335 [inline]
    [<ffffffff816d44ef>] path_mount+0xc8f/0x10d0 fs/namespace.c:3662
    [<ffffffff816d50e1>] do_mount fs/namespace.c:3675 [inline]
    [<ffffffff816d50e1>] __do_sys_mount fs/namespace.c:3884 [inline]
    [<ffffffff816d50e1>] __se_sys_mount fs/namespace.c:3861 [inline]
    [<ffffffff816d50e1>] __x64_sys_mount+0x1a1/0x1f0 fs/namespace.c:3861
    [<ffffffff84b2dfa8>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b2dfa8>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
