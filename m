Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8E779C453
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 05:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237460AbjILDnG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 23:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237121AbjILDnG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:43:06 -0400
Received: from mail-pj1-f80.google.com (mail-pj1-f80.google.com [209.85.216.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8A69E
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 20:43:02 -0700 (PDT)
Received: by mail-pj1-f80.google.com with SMTP id 98e67ed59e1d1-273f8487f53so3688391a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 20:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694490182; x=1695094982;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C1Z8XaEzEErA4t9ccKvJI1SaXs5GeSYflnkUaHxK3fM=;
        b=slCtBYPjm6hL8E1lljFIXIrCoJbza0nH+F2exikNS1HJGigKy5B8WaNWMxprD6sVXt
         sd+RBzT1M7VxmJyyiB2Fl8f5YIQlVYgMNU+E1H7tmFd2bUHqpJV1s8uzgu1WuYEgsAe/
         1zfHKOS7P/3F6syAdbaKzdWUETbvlxpcjHshQWoFn4GU8L+ytZxVn1vxOJh4kptdoi0R
         6OgX3pbErQGdT9rxZU3Htflc4zNLpJx8iy8YWR9dVF2/rRY8NrsBQ3un15jzPNO1j+za
         fo1D3KU+B90q1177fYsBhvBl6lNA0hYm2swyo8UTPqXPYULPr7KB+553xxiFObdIA+Mc
         pV8A==
X-Gm-Message-State: AOJu0YzpXB5Afw/RW6aaXVRZAua8sMjXmS4rbLp8cvWRluKblGyNwTyd
        vzmjaVtOi37U5XnMsXNjq+2qqxA2xQAiT5iMJ0eTbdYK31D+
X-Google-Smtp-Source: AGHT+IFV1MpjXWTFM6PQWGQpq6o04FfCM7qa0W3bYRNe+bZzisdqgsH5Bz3nltJOTPLCeZ9HTv1nLqMB7RpvYvkUxnDJf/3IV++e
MIME-Version: 1.0
X-Received: by 2002:a17:90a:8f03:b0:271:de78:ad5f with SMTP id
 g3-20020a17090a8f0300b00271de78ad5fmr2913908pjo.7.1694490182071; Mon, 11 Sep
 2023 20:43:02 -0700 (PDT)
Date:   Mon, 11 Sep 2023 20:43:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060be2d0605213d34@google.com>
Subject: [syzbot] [ntfs3?] memory leak in wnd_init
From:   syzbot <syzbot+9ccdd15480e9d9833822@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=159a5bafa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=52403a23b631cefc
dashboard link: https://syzkaller.appspot.com/bug?extid=9ccdd15480e9d9833822
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1428f558680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159c2494680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7e7536435862/disk-4a0fc73d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f5b10d577113/vmlinux-4a0fc73d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/430b464e2d50/bzImage-4a0fc73d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/25cbc30b9bc2/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9ccdd15480e9d9833822@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff8881092d8120 (size 8):
  comm "syz-executor271", pid 5017, jiffies 4294942948 (age 12.860s)
  hex dump (first 8 bytes):
    65 00 00 00 00 00 00 00                          e.......
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
unreferenced object 0xffff88810bf880c0 (size 64):
  comm "syz-executor271", pid 5017, jiffies 4294942948 (age 12.860s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 81 f8 0b 81 88 ff ff  ................
    00 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81bc7ddc>] wnd_add_free_ext+0x6c/0x860 fs/ntfs3/bitmap.c:337
    [<ffffffff81bc9640>] wnd_rescan+0x370/0x600 fs/ntfs3/bitmap.c:597
    [<ffffffff81bc99c2>] wnd_init+0xf2/0x140 fs/ntfs3/bitmap.c:666
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
unreferenced object 0xffff88810bf88100 (size 64):
  comm "syz-executor271", pid 5017, jiffies 4294942948 (age 12.860s)
  hex dump (first 32 bytes):
    c0 80 f8 0b 81 88 ff ff 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 21 00 00 00 00 00 00 00  ........!.......
  backtrace:
    [<ffffffff81bc7ddc>] wnd_add_free_ext+0x6c/0x860 fs/ntfs3/bitmap.c:337
    [<ffffffff81bc9775>] wnd_rescan+0x4a5/0x600 fs/ntfs3/bitmap.c:621
    [<ffffffff81bc99c2>] wnd_init+0xf2/0x140 fs/ntfs3/bitmap.c:666
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
unreferenced object 0xffff88810a1d8b40 (size 64):
  comm "syz-executor271", pid 5017, jiffies 4294942948 (age 12.860s)
  hex dump (first 32 bytes):
    00 00 00 00 01 00 00 00 47 00 00 00 00 00 00 00  ........G.......
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
unreferenced object 0xffff8881092d8468 (size 8):
  comm "syz-executor271", pid 5017, jiffies 4294942948 (age 12.860s)
  hex dump (first 8 bytes):
    0f 01 00 00 00 00 00 00                          ........
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
