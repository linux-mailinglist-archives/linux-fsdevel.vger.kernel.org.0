Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76235A6F59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 23:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbiH3Vns (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 17:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbiH3Vnj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 17:43:39 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A068A7FD
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Aug 2022 14:43:29 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id l15-20020a0566022dcf00b00688e70a26deso7476528iow.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Aug 2022 14:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=hZh3KPzu6vdJmcyyc9fUNxMkq5x2+UaiRlgdtQCrWEU=;
        b=ZJQd/yEXOzQ42Ad4XR0/5BZwhOKDXNwQ/39LjLlEY7HMmr37m/B8lgm0gLoi4Oh9Vr
         X8PMTCHAPzD/qihdtHyQtjA+Z2pftWOzQSUngs3sDbwcs9aAPD1ZxLPMiLPqHNqEWRhC
         hxKiu+53v7/cIoUBvATK6JDhBencZeB6b6SJyOFNH2qdmuOzztTlmkKq7Ru/vKsde/3C
         GE2C4pRCFOlaaA4iszXaq9lFr8cD9X/EggITGWfGlZp6+1IucVAcf78y8x1NTH1N1F2i
         AKndFYhW1KHXl/lVPhHJ0ktyzI1QHgcjNLdIk8oFNnRqlSRFKYJIEMLb3uqVS1yqgoXP
         2OVQ==
X-Gm-Message-State: ACgBeo21sNrtC/xJgqJlwp0Uf0h3xHI36ztNd010vtKmas9j6v74y2bl
        k06IBOog7NfAhZnAUP7408xhJyvaOPsd2qPvgc9uE71boZAQ
X-Google-Smtp-Source: AA6agR6qi8L+tGvCcx/hZ0pVix3H6mvvJw+FlU77PhHXSRcmqs9Q+44EOhcGC+4jPeHXSc6HJjIyqoZEDVG/eFLsQJs+/YXuY4W3
MIME-Version: 1.0
X-Received: by 2002:a02:ca04:0:b0:349:f94d:5ea8 with SMTP id
 i4-20020a02ca04000000b00349f94d5ea8mr13321724jak.156.1661895808438; Tue, 30
 Aug 2022 14:43:28 -0700 (PDT)
Date:   Tue, 30 Aug 2022 14:43:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000050d56805e77c4582@google.com>
Subject: [syzbot] WARNING in writeback_single_inode
From:   syzbot <syzbot+fc721e2fe15a5aac41d1@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a41a877bc12d Merge branch 'for-next/fixes' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=178fc957080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5cea15779c42821c
dashboard link: https://syzkaller.appspot.com/bug?extid=fc721e2fe15a5aac41d1
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fc721e2fe15a5aac41d1@syzkaller.appspotmail.com

ntfs3: loop4: RAW NTFS volume: Filesystem size 0.00 Gb > volume size 0.00 Gb. Mount in read-only
------------[ cut here ]------------
WARNING: CPU: 0 PID: 24385 at fs/fs-writeback.c:1678 writeback_single_inode+0x374/0x388 fs/fs-writeback.c:1678
Modules linked in:
CPU: 0 PID: 24385 Comm: syz-executor.4 Not tainted 6.0.0-rc2-syzkaller-16455-ga41a877bc12d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : writeback_single_inode+0x374/0x388 fs/fs-writeback.c:1678
lr : writeback_single_inode+0x374/0x388 fs/fs-writeback.c:1678
sp : ffff800020d4b9c0
x29: ffff800020d4ba10 x28: ffff0000e4bc8000 x27: fffffc0003f22700
x26: 0000000000000a00 x25: 0000000000000000 x24: 0000000000000001
x23: 0000000000001000 x22: ffff800020d4ba60 x21: 0000000000000000
x20: ffff0000fd87f7b7 x19: ffff0000fd87f840 x18: 0000000000000369
x17: 0000000000000000 x16: ffff80000dbb8658 x15: ffff0000e1cc0000
x14: 0000000000000130 x13: 00000000ffffffff x12: 0000000000040000
x11: 000000000003ffff x10: ffff80001d55c000 x9 : ffff80000861f6d4
x8 : 0000000000040000 x7 : ffff80000861f3a4 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 writeback_single_inode+0x374/0x388 fs/fs-writeback.c:1678
 write_inode_now+0xb0/0xdc fs/fs-writeback.c:2723
 iput_final fs/inode.c:1735 [inline]
 iput+0x1d4/0x314 fs/inode.c:1774
 ntfs_fill_super+0xc30/0x14a4 fs/ntfs/super.c:2994
 get_tree_bdev+0x1e8/0x2a0 fs/super.c:1323
 ntfs_fs_get_tree+0x28/0x38 fs/ntfs3/super.c:1358
 vfs_get_tree+0x40/0x140 fs/super.c:1530
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x914 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2f8/0x408 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x154 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
irq event stamp: 3030
hardirqs last  enabled at (3029): [<ffff800008163d78>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1367 [inline]
hardirqs last  enabled at (3029): [<ffff800008163d78>] finish_lock_switch+0x94/0xe8 kernel/sched/core.c:4942
hardirqs last disabled at (3030): [<ffff80000bffe9cc>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (2780): [<ffff8000080102e4>] _stext+0x2e4/0x37c
softirqs last disabled at (1405): [<ffff800008104658>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
softirqs last disabled at (1405): [<ffff800008104658>] invoke_softirq+0x70/0xbc kernel/softirq.c:452
---[ end trace 0000000000000000 ]---
Unable to handle kernel paging request at virtual address 000000fd87f9e147
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000128316000
[000000fd87f9e147] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 96000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 24385 Comm: syz-executor.4 Tainted: G        W          6.0.0-rc2-syzkaller-16455-ga41a877bc12d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : xa_marked include/linux/xarray.h:420 [inline]
pc : mapping_tagged include/linux/fs.h:461 [inline]
pc : writeback_single_inode+0x228/0x388 fs/fs-writeback.c:1703
lr : writeback_single_inode+0x218/0x388 fs/fs-writeback.c:1702
sp : ffff800020d4b9c0
x29: ffff800020d4ba10 x28: ffff0000e4bc8000 x27: fffffc0003f22700
x26: 0000000000000a00 x25: 0000000000001000 x24: 0000000000000001
x23: 0000000000000001 x22: ffff800020d4ba60 x21: ffff0000fd87f88f
x20: ffff0000fd87f7b7 x19: ffff0000fd87f840 x18: 0000000000000369
x17: 0000000000000000 x16: ffff80000dbb8658 x15: ffff0000e1cc0000
x14: 0000000000000130 x13: 00000000ffffffff x12: 0000000000040000
x11: ff8080000861f578 x10: 0000000000000002 x9 : ffff0000e1cc0000
x8 : ff0000fd87f9e0ff x7 : ffff80000861f3a4 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000001 x1 : 0000000000000001 x0 : 0000000000000000
Call trace:
 xa_marked include/linux/xarray.h:420 [inline]
 mapping_tagged include/linux/fs.h:461 [inline]
 writeback_single_inode+0x228/0x388 fs/fs-writeback.c:1703
 write_inode_now+0xb0/0xdc fs/fs-writeback.c:2723
 iput_final fs/inode.c:1735 [inline]
 iput+0x1d4/0x314 fs/inode.c:1774
 ntfs_fill_super+0xc30/0x14a4 fs/ntfs/super.c:2994
 get_tree_bdev+0x1e8/0x2a0 fs/super.c:1323
 ntfs_fs_get_tree+0x28/0x38 fs/ntfs3/super.c:1358
 vfs_get_tree+0x40/0x140 fs/super.c:1530
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x914 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2f8/0x408 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x154 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
Code: 710006ff 54000281 f9401a88 2a1f03e0 (b9404917) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	710006ff 	cmp	w23, #0x1
   4:	54000281 	b.ne	0x54  // b.any
   8:	f9401a88 	ldr	x8, [x20, #48]
   c:	2a1f03e0 	mov	w0, wzr
* 10:	b9404917 	ldr	w23, [x8, #72] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
