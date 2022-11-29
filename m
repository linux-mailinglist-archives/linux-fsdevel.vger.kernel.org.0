Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F5163BBBE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 09:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiK2IeE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 03:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiK2Id2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:33:28 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EADD5F7E
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Nov 2022 00:32:42 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id o10-20020a056e02102a00b003006328df7bso11527661ilj.17
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Nov 2022 00:32:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KIi6iEFC+/Xq01pTTFEVs53RiBo1yF7O5fHExbihU7A=;
        b=cEqrP47KBqFpM/vyB+pt0GCto7ha0nMLUVh8qjREc9fC98NXgg7a4q0bQHHL4hIj+v
         pqt+LidJm8d3Weogpiy246UKRvPNZm1zbSb/4/THemoiYa3VJOEnSZTqKNymlQ/XwzRK
         vlwSZfGatlS7sQ35GEf3GEDM+cIJLgVV21uR1+9VRTZfiBltj81dELibK5nfn9NNuxgQ
         8EYKDG5NjQEeijdJL4wRyakN2Kw9unlxfKt0yLCwYK/U+xx1lc8xwlkeqYIfMb2r6eBU
         tEbAR9+O15RVgdWZ7WU56qXRGggSLHEDJDONaeriIL5SN6dx4uIJ6VDEPwjP42iqYLsA
         73xQ==
X-Gm-Message-State: ANoB5pkwZtFUvjZRw3+YghnVPeBChrH1bWlDe2wjx1Pt04QpSC+j2evr
        5fzPPJOBytBg6ETdRNx6FlOMTk+P5s9wlKo2+eqph9Go1aEZ
X-Google-Smtp-Source: AA0mqf50R+6KDIPXzFUYyXp/Fet3rwy4HTYrI3edSuP0n423YRXtOLU5dmwMRMv/zuCv7TmtOxNpUs9dxV+tejAgbdRXdGwyIwHL
MIME-Version: 1.0
X-Received: by 2002:a5d:8f84:0:b0:6d9:56fc:ef25 with SMTP id
 l4-20020a5d8f84000000b006d956fcef25mr16494335iol.56.1669710761928; Tue, 29
 Nov 2022 00:32:41 -0800 (PST)
Date:   Tue, 29 Nov 2022 00:32:41 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d7b6f405ee97d4a1@google.com>
Subject: [syzbot] possible deadlock in hfsplus_block_free
From:   syzbot <syzbot+8fae81a1f77bf28ef3b5@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, fmdefrancesco@gmail.com,
        ira.weiny@intel.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, slava@dubeyko.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ca57f02295f1 afs: Fix fileserver probe RTT handling
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16afa373880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
dashboard link: https://syzkaller.appspot.com/bug?extid=8fae81a1f77bf28ef3b5
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/af66f1d3a389/disk-ca57f022.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c0c7ec393108/vmlinux-ca57f022.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ea8871940eaa/bzImage-ca57f022.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8fae81a1f77bf28ef3b5@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc7-syzkaller-00012-gca57f02295f1 #0 Not tainted
------------------------------------------------------
syz-executor.3/5709 is trying to acquire lock:
ffff88807cb5b8f8 (&sbi->alloc_mutex){+.+.}-{3:3}, at: hfsplus_block_free+0xb6/0x4e0 fs/hfsplus/bitmap.c:182

but task is already holding lock:
ffff8880189f5f88 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}, at: hfsplus_file_truncate+0x280/0xbb0 fs/hfsplus/extents.c:576

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
       hfsplus_get_block+0x3a3/0x1560 fs/hfsplus/extents.c:260
       block_read_full_folio+0x3b3/0xfa0 fs/buffer.c:2271
       filemap_read_folio+0x187/0x7d0 mm/filemap.c:2407
       do_read_cache_folio+0x2d3/0x790 mm/filemap.c:3534
       do_read_cache_page mm/filemap.c:3576 [inline]
       read_cache_page+0x56/0x270 mm/filemap.c:3585
       read_mapping_page include/linux/pagemap.h:756 [inline]
       hfsplus_block_allocate+0xf9/0x900 fs/hfsplus/bitmap.c:37
       hfsplus_file_extend+0x9d4/0x19d0 fs/hfsplus/extents.c:468
       hfsplus_get_block+0x415/0x1560 fs/hfsplus/extents.c:245
       __block_write_begin_int+0x54c/0x1a80 fs/buffer.c:1991
       __block_write_begin fs/buffer.c:2041 [inline]
       block_write_begin+0x93/0x1e0 fs/buffer.c:2102
       cont_write_begin+0x606/0x860 fs/buffer.c:2456
       hfsplus_write_begin+0x86/0xd0 fs/hfsplus/inode.c:52
       generic_perform_write+0x2e4/0x5e0 mm/filemap.c:3753
       __generic_file_write_iter+0x176/0x400 mm/filemap.c:3881
       generic_file_write_iter+0xab/0x310 mm/filemap.c:3913
       call_write_iter include/linux/fs.h:2199 [inline]
       new_sync_write fs/read_write.c:491 [inline]
       vfs_write+0x7dc/0xc50 fs/read_write.c:584
       ksys_write+0x177/0x2a0 fs/read_write.c:637
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&sbi->alloc_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
       __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
       hfsplus_block_free+0xb6/0x4e0 fs/hfsplus/bitmap.c:182
       hfsplus_free_extents+0x17f/0xad0 fs/hfsplus/extents.c:363
       hfsplus_file_truncate+0x827/0xbb0 fs/hfsplus/extents.c:591
       hfsplus_delete_inode+0x16d/0x210
       hfsplus_unlink+0x4e2/0x7d0 fs/hfsplus/dir.c:405
       vfs_unlink+0x357/0x5f0 fs/namei.c:4252
       do_unlinkat+0x484/0x940 fs/namei.c:4320
       __do_sys_unlinkat fs/namei.c:4363 [inline]
       __se_sys_unlinkat fs/namei.c:4356 [inline]
       __x64_sys_unlinkat+0xca/0xf0 fs/namei.c:4356
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&HFSPLUS_I(inode)->extents_lock);
                               lock(&sbi->alloc_mutex);
                               lock(&HFSPLUS_I(inode)->extents_lock);
  lock(&sbi->alloc_mutex);

 *** DEADLOCK ***

5 locks held by syz-executor.3/5709:
 #0: ffff88805777e460 (sb_writers#23){.+.+}-{0:0}, at: mnt_want_write+0x3b/0x80 fs/namespace.c:393
 #1: ffff8880189f5ac0 (&type->i_mutex_dir_key#18/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:791 [inline]
 #1: ffff8880189f5ac0 (&type->i_mutex_dir_key#18/1){+.+.}-{3:3}, at: do_unlinkat+0x23d/0x940 fs/namei.c:4303
 #2: ffff8880189f6180 (&sb->s_type->i_mutex_key#29){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #2: ffff8880189f6180 (&sb->s_type->i_mutex_key#29){+.+.}-{3:3}, at: vfs_unlink+0xe0/0x5f0 fs/namei.c:4241
 #3: ffff88807cb5b998 (&sbi->vh_mutex){+.+.}-{3:3}, at: hfsplus_unlink+0x135/0x7d0 fs/hfsplus/dir.c:370
 #4: ffff8880189f5f88 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}, at: hfsplus_file_truncate+0x280/0xbb0 fs/hfsplus/extents.c:576

stack backtrace:
CPU: 0 PID: 5709 Comm: syz-executor.3 Not tainted 6.1.0-rc7-syzkaller-00012-gca57f02295f1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 check_noncircular+0x2cc/0x390 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
 __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
 lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
 __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
 hfsplus_block_free+0xb6/0x4e0 fs/hfsplus/bitmap.c:182
 hfsplus_free_extents+0x17f/0xad0 fs/hfsplus/extents.c:363
 hfsplus_file_truncate+0x827/0xbb0 fs/hfsplus/extents.c:591
 hfsplus_delete_inode+0x16d/0x210
 hfsplus_unlink+0x4e2/0x7d0 fs/hfsplus/dir.c:405
 vfs_unlink+0x357/0x5f0 fs/namei.c:4252
 do_unlinkat+0x484/0x940 fs/namei.c:4320
 __do_sys_unlinkat fs/namei.c:4363 [inline]
 __se_sys_unlinkat fs/namei.c:4356 [inline]
 __x64_sys_unlinkat+0xca/0xf0 fs/namei.c:4356
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7feeca28c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007feecafb5168 EFLAGS: 00000246 ORIG_RAX: 0000000000000107
RAX: ffffffffffffffda RBX: 00007feeca3abf80 RCX: 00007feeca28c0d9
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000005
RBP: 00007feeca2e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffeb5f149df R14: 00007feecafb5300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
