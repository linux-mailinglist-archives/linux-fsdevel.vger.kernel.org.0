Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB16865664F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Dec 2022 02:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbiL0A7u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Dec 2022 19:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiL0A7t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Dec 2022 19:59:49 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C752425E8
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Dec 2022 16:59:47 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id o10-20020a056e02102a00b003006328df7bso7849523ilj.17
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Dec 2022 16:59:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=46X/1ebZ09bWORLFjyXEMURdLbgiW/4n8efT0Ulsrdw=;
        b=pbSKTLGHo8gamwkfWED3zq/6CEe87c8sxFzMRZxqYJkPWxaD78PnqoiHPpIEZIoFSo
         HxKH7mGhVZF6Z/MLdhTpvBQ0TlveLvQ58JgDg4t1fJs6X4Hmq+efdyenLSXNrdgsrkwN
         cdtTT7s+66DKY8wdzE2MjyIKoslUWjbw5YHd4We0OIVQGfIBE1kg5KrmeFtyiIFZ7T0h
         87uJRiRd6Y/wwWD+ko13uY0TvZtKj05qtVq10aQWHnzKCpDiRTn/uLr37LeRsghnH+1+
         RXML/kKAhhvnH0o0IvJ8X1He0jeJNb9ISb22zJ1XZcbGmfNrhg6ri51nUTsYnt3zNurw
         14+w==
X-Gm-Message-State: AFqh2kpKJE24teahk4jEHvdC5IjytMgcVjg/dL3EWDHxWkovgLsnFfV2
        9W4bYhqkMjSynyfgwTlogegM951ZUZoxJqHaKngwB1FTGBET
X-Google-Smtp-Source: AMrXdXtlb+kQZADtnNW+zvhlZ/SPh+L9NqMiqjcM7ct7d004hnxBpJ552on4ZJbQLwT9KqqnMte32zyfOBWLjovIkhBeYgZ8Eoi7
MIME-Version: 1.0
X-Received: by 2002:a92:c047:0:b0:30c:6e9:253b with SMTP id
 o7-20020a92c047000000b0030c06e9253bmr348834ilf.97.1672102787153; Mon, 26 Dec
 2022 16:59:47 -0800 (PST)
Date:   Mon, 26 Dec 2022 16:59:47 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a806c405f0c4c45b@google.com>
Subject: [syzbot] [hfs?] possible deadlock in hfs_find_init (2)
From:   syzbot <syzbot+e390d66dda462b51fde1@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
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

HEAD commit:    51094a24b85e Merge tag 'hardening-v6.2-rc1-fixes' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15e0dc54480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e2d7bfa2d6d5a76
dashboard link: https://syzkaller.appspot.com/bug?extid=e390d66dda462b51fde1
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a26f3769fdfb/disk-51094a24.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5decc3ae71d7/vmlinux-51094a24.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dd2ac18a5b04/bzImage-51094a24.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e390d66dda462b51fde1@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.1.0-syzkaller-14587-g51094a24b85e #0 Not tainted
------------------------------------------------------
syz-executor.5/14715 is trying to acquire lock:
ffff8880470440b0
 (&tree->tree_lock
/1){+.+.}-{3:3}
, at: hfs_find_init+0x167/0x1e0

but task is already holding lock:
ffff88804170c1f8
 (&HFS_I(tree->inode)->extents_lock
){+.+.}-{3:3}
, at: hfs_extend_file+0xde/0x1420 fs/hfs/extent.c:397

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1
 (&HFS_I(tree->inode)->extents_lock
){+.+.}-{3:3}
:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
       hfs_extend_file+0xde/0x1420 fs/hfs/extent.c:397
       hfs_bmap_reserve+0xfa/0x410 fs/hfs/btree.c:234
       __hfs_ext_write_extent+0x1ea/0x460 fs/hfs/extent.c:121
       __hfs_ext_cache_extent+0x67/0x980 fs/hfs/extent.c:174
       hfs_ext_read_extent fs/hfs/extent.c:202 [inline]
       hfs_extend_file+0x323/0x1420 fs/hfs/extent.c:401
       hfs_get_block+0x3fc/0xbb0 fs/hfs/extent.c:353
       __block_write_begin_int+0x54c/0x1a80 fs/buffer.c:1991
       __block_write_begin fs/buffer.c:2041 [inline]
       block_write_begin+0x93/0x1e0 fs/buffer.c:2102
       cont_write_begin+0x606/0x860 fs/buffer.c:2456
       hfs_write_begin+0x86/0xd0 fs/hfs/inode.c:58
       cont_expand_zero fs/buffer.c:2383 [inline]
       cont_write_begin+0x2cf/0x860 fs/buffer.c:2446
       hfs_write_begin+0x86/0xd0 fs/hfs/inode.c:58
       generic_perform_write+0x2e4/0x5e0 mm/filemap.c:3772
       __generic_file_write_iter+0x176/0x400 mm/filemap.c:3900
       generic_file_write_iter+0xab/0x310 mm/filemap.c:3932
       do_iter_write+0x6c2/0xc20 fs/read_write.c:861
       vfs_writev fs/read_write.c:934 [inline]
       do_pwritev+0x200/0x350 fs/read_write.c:1031
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (
&tree->tree_lock
/1){+.+.}-{3:3}
:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
       __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
       hfs_find_init+0x167/0x1e0
       hfs_ext_read_extent fs/hfs/extent.c:200 [inline]
       hfs_extend_file+0x2f8/0x1420 fs/hfs/extent.c:401
       hfs_bmap_reserve+0xfa/0x410 fs/hfs/btree.c:234
       hfs_cat_create+0x1b5/0x8a0 fs/hfs/catalog.c:104
       hfs_create+0x62/0xd0 fs/hfs/dir.c:202
       lookup_open fs/namei.c:3413 [inline]
       open_last_lookups fs/namei.c:3481 [inline]
       path_openat+0x12ac/0x2dd0 fs/namei.c:3711
       do_filp_open+0x264/0x4f0 fs/namei.c:3741
       do_sys_openat2+0x124/0x4e0 fs/open.c:1310
       do_sys_open fs/open.c:1326 [inline]
       __do_sys_open fs/open.c:1334 [inline]
       __se_sys_open fs/open.c:1330 [inline]
       __x64_sys_open+0x221/0x270 fs/open.c:1330
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&HFS_I(tree->inode)->extents_lock);
                               lock(&tree->tree_lock/1);
                               lock(&HFS_I(tree->inode)->extents_lock);
  lock(&tree->tree_lock/1);

 *** DEADLOCK ***

4 locks held by syz-executor.5/14715:
 #0: ffff88802c73a460 (sb_writers#19){.+.+}-{0:0}, at: mnt_want_write+0x3b/0x80 fs/namespace.c:508
 #1: ffff88804170bd28 (&type->i_mutex_dir_key#11){++++}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff88804170bd28 (&type->i_mutex_dir_key#11){++++}-{3:3}, at: open_last_lookups fs/namei.c:3478 [inline]
 #1: ffff88804170bd28 (&type->i_mutex_dir_key#11){++++}-{3:3}, at: path_openat+0x7b9/0x2dd0 fs/namei.c:3711
 #2: ffff88802a7440b0 (&tree->tree_lock){+.+.}-{3:3}, at: hfs_find_init+0x167/0x1e0
 #3: ffff88804170c1f8 (&HFS_I(tree->inode)->extents_lock){+.+.}-{3:3}, at: hfs_extend_file+0xde/0x1420 fs/hfs/extent.c:397

stack backtrace:
CPU: 0 PID: 14715 Comm: syz-executor.5 Not tainted 6.1.0-syzkaller-14587-g51094a24b85e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 check_noncircular+0x2cc/0x390 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
 __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
 lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
 __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
 hfs_find_init+0x167/0x1e0
 hfs_ext_read_extent fs/hfs/extent.c:200 [inline]
 hfs_extend_file+0x2f8/0x1420 fs/hfs/extent.c:401
 hfs_bmap_reserve+0xfa/0x410 fs/hfs/btree.c:234
 hfs_cat_create+0x1b5/0x8a0 fs/hfs/catalog.c:104
 hfs_create+0x62/0xd0 fs/hfs/dir.c:202
 lookup_open fs/namei.c:3413 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x12ac/0x2dd0 fs/namei.c:3711
 do_filp_open+0x264/0x4f0 fs/namei.c:3741
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_open fs/open.c:1334 [inline]
 __se_sys_open fs/open.c:1330 [inline]
 __x64_sys_open+0x221/0x270 fs/open.c:1330
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc71f08c0a9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc71fe9b168 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007fc71f1ac050 RCX: 00007fc71f08c0a9
RDX: 0000000000000000 RSI: 000000000014d27e RDI: 0000000020000180
RBP: 00007fc71f0e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd5d3e729f R14: 00007fc71fe9b300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
