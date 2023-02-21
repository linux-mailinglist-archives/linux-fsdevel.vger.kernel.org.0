Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA6369E7D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Feb 2023 19:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjBUSp5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Feb 2023 13:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjBUSp4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:45:56 -0500
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15E5301B1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Feb 2023 10:45:50 -0800 (PST)
Received: by mail-io1-f77.google.com with SMTP id s1-20020a6bd301000000b0073e7646594aso3207226iob.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Feb 2023 10:45:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WQpqzGTBynu+rvQ/MEygyGWVr0xVOZ6kPbs3MLS8FCQ=;
        b=BzdkSdt7MOl6dzuhxJzhzZ42CeJjwVqtTVG6iFzKo9CtQLCOpvYlQ0rhBVhxmgfYhT
         f5Q2U6DxykvZ1qNkgX3Kpccz2Fi9bAToNBSzNixNsmddsZssmfTwzpTtcd6AW0Qf5XjX
         nw/g1Cyn6CKGOMRhjnM04suEmGe2sm1xkXKx4b5+m+MwZ+PYZmMJGR1Dm2W5eYYhNoD4
         rtwh5ArjyIBZMH0SQNRpH1lYb7Nsw5ODl6ooPAq1LVbl6rqg6H7Yyb81vtWKxgQ7Ckp4
         ZWtC8+BWVjw21oXHHJMz/udOI0/56uuOaW9ZQ16FqYVKCiwAcv1OJ/I3NC7XTu9bvx7i
         IQTQ==
X-Gm-Message-State: AO0yUKWc9I+9a1zaR7KDwkEC0QKe3Cwipp6UfjyRNNwpiA0v/zit9wVQ
        vrq4d2RnnQ3+JUW7s+ankPBU0j5tKvZ3cfEWpIR+ExKVn886
X-Google-Smtp-Source: AK7set/MmffHVdX5wtEIZ339V/IlKNPhhcEqZTUw4Hwz6fGkZUHg9WmqRtHRZaBmf/+BrcRqhInY+kLv0dad7EKLB3nSw8WgiCJa
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:8aa:b0:314:1659:8c10 with SMTP id
 a10-20020a056e0208aa00b0031416598c10mr1291557ilt.2.1677005150177; Tue, 21 Feb
 2023 10:45:50 -0800 (PST)
Date:   Tue, 21 Feb 2023 10:45:50 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000043527d05f53a3082@google.com>
Subject: [syzbot] [jfs?] WARNING in diFree
From:   syzbot <syzbot+acc006db65c7fd01fc4a@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2d3827b3f393 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=16b988f7480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=606ed7eeab569393
dashboard link: https://syzkaller.appspot.com/bug?extid=acc006db65c7fd01fc4a
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fd94d68ff17d/disk-2d3827b3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f304fbef0773/vmlinux-2d3827b3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/74eb318f51b0/Image-2d3827b3.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+acc006db65c7fd01fc4a@syzkaller.appspotmail.com

loop5: detected capacity change from 0 to 14901
jfs_mount: diMount failed w/rc = -5
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 0 PID: 28676 at kernel/locking/mutex.c:582 __mutex_lock_common+0x504/0xf64 kernel/locking/mutex.c:582
Modules linked in:
CPU: 0 PID: 28676 Comm: syz-executor.5 Not tainted 6.2.0-rc7-syzkaller-17907-g2d3827b3f393 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __mutex_lock_common+0x504/0xf64 kernel/locking/mutex.c:582
lr : __mutex_lock_common+0x504/0xf64 kernel/locking/mutex.c:582
sp : ffff800012f3b7b0
x29: ffff800012f3b820 x28: ffff80000eeb4000 x27: 0000000000000000
x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000002
x23: ffff800008d0521c x22: 0000000000000000 x21: 0000000000000000
x20: 0000000000000000 x19: ffff0001217888b8 x18: ffff80000bfae9bc
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000012 x12: 0000000000040000
x11: 0000000000014082 x10: ffff80001dc69000 x9 : 1b90871972769000
x8 : 1b90871972769000 x7 : 4e5241575f534b43 x6 : ffff80000bf650d4
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000000 x0 : 0000000000000028
Call trace:
 __mutex_lock_common+0x504/0xf64 kernel/locking/mutex.c:582
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
 diFree+0x9c/0xd10 fs/jfs/jfs_imap.c:885
 jfs_evict_inode+0x178/0x1f0 fs/jfs/inode.c:156
 evict+0xf0/0x338 fs/inode.c:664
 iput_final fs/inode.c:1747 [inline]
 iput+0x4d8/0x53c fs/inode.c:1773
 diFreeSpecial+0x44/0x8c fs/jfs/jfs_imap.c:548
 jfs_mount+0x3d0/0x468 fs/jfs/jfs_mount.c:203
 jfs_fill_super+0x188/0x454 fs/jfs/super.c:556
 mount_bdev+0x1b8/0x210 fs/super.c:1359
 jfs_do_mount+0x44/0x58 fs/jfs/super.c:670
 legacy_get_tree+0x30/0x74 fs/fs_context.c:610
 vfs_get_tree+0x40/0x140 fs/super.c:1489
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3145
 path_mount+0x348/0x86c fs/namespace.c:3475
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount fs/namespace.c:3674 [inline]
 __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3674
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x64/0x178 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0xbc/0x180 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x110 arch/arm64/kernel/syscall.c:193
 el0_svc+0x58/0x14c arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
irq event stamp: 32781
hardirqs last  enabled at (32781): [<ffff80000bf6aafc>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (32781): [<ffff80000bf6aafc>] _raw_spin_unlock_irqrestore+0x44/0x84 kernel/locking/spinlock.c:194
hardirqs last disabled at (32780): [<ffff80000bf6a910>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (32780): [<ffff80000bf6a910>] _raw_spin_lock_irqsave+0x2c/0x88 kernel/locking/spinlock.c:162
softirqs last  enabled at (32158): [<ffff80000801c878>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (32156): [<ffff80000801c844>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000028
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=000000015c65c000
[0000000000000028] pgd=080000016f935003, p4d=080000016f935003, pud=080000016bb6d003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 28676 Comm: syz-executor.5 Tainted: G        W          6.2.0-rc7-syzkaller-17907-g2d3827b3f393 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : diIAGRead fs/jfs/jfs_imap.c:2659 [inline]
pc : diFree+0xc0/0xd10 fs/jfs/jfs_imap.c:894
lr : diFree+0xac/0xd10 fs/jfs/jfs_imap.c:890
sp : ffff800012f3b890
x29: ffff800012f3b980 x28: ffff80000d369360 x27: 0000000000000000
x26: 0000000000000002 x25: ffff000110f3c708 x24: ffff000110f39e88
x23: ffff000110f3ca70 x22: ffff000121788000 x21: 0000000000000000
x20: ffff00012cd66b00 x19: ffff0001217888b8 x18: ffff80000bfae9bc
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000012 x12: 0000000000040000
x11: 0000000000014082 x10: ffff80000d369360 x9 : 0000000000000001
x8 : ffff0000c6889a01 x7 : 4e5241575f534b43 x6 : ffff800008d0522c
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000001000 x1 : 0000000000000002 x0 : 0000000000000000
Call trace:
 diIAGRead fs/jfs/jfs_imap.c:2662 [inline]
 diFree+0xc0/0xd10 fs/jfs/jfs_imap.c:894
 jfs_evict_inode+0x178/0x1f0 fs/jfs/inode.c:156
 evict+0xf0/0x338 fs/inode.c:664
 iput_final fs/inode.c:1747 [inline]
 iput+0x4d8/0x53c fs/inode.c:1773
 diFreeSpecial+0x44/0x8c fs/jfs/jfs_imap.c:548
 jfs_mount+0x3d0/0x468 fs/jfs/jfs_mount.c:203
 jfs_fill_super+0x188/0x454 fs/jfs/super.c:556
 mount_bdev+0x1b8/0x210 fs/super.c:1359
 jfs_do_mount+0x44/0x58 fs/jfs/super.c:670
 legacy_get_tree+0x30/0x74 fs/fs_context.c:610
 vfs_get_tree+0x40/0x140 fs/super.c:1489
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3145
 path_mount+0x348/0x86c fs/namespace.c:3475
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount fs/namespace.c:3674 [inline]
 __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3674
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x64/0x178 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0xbc/0x180 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x110 arch/arm64/kernel/syscall.c:193
 el0_svc+0x58/0x14c arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
Code: 110006a9 52820002 2a1f03e3 aa1f03e4 (f9401408) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	110006a9 	add	w9, w21, #0x1
   4:	52820002 	mov	w2, #0x1000                	// #4096
   8:	2a1f03e3 	mov	w3, wzr
   c:	aa1f03e4 	mov	x4, xzr
* 10:	f9401408 	ldr	x8, [x0, #40] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
