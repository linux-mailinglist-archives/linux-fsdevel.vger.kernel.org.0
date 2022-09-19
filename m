Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AEB5BD613
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 23:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiISVEo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 17:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiISVEm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 17:04:42 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB58ECE19
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 14:04:41 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id v20-20020a6b5b14000000b0069fee36308eso364841ioh.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 14:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=xtCSZDzBZ7VocIYU5Oxk/KyGf3p9mg8GSqEMcMiDCb4=;
        b=SN6RBhUkgJlOTuMhJjUW0XoffodfUc/tRNlSSIsMVnjZmL6XapECtneDJmVRH7fTt7
         6lUvY0vaPWDbEstdHLbz2al0uRJ8a2vHZUVbXWL8mVd2SkqySC5kcfmrQanrgXZUX3St
         Ke6Gtk3r7bSo4A58dLefmly1gfJfPqFj1NIKsWZg48se9DZjX1Pk8IplwqZArLyBwyTX
         +l70J9LSZlD18oqTLS/d/mv47pBeUFZDs2wqsozg2oPQJwiKWNVouUBDeVAxFwTemGVu
         TiHirMiPjSKxIj9IrC9SKBLucY5B5FWeJwlYZRLXzYj6BVwtmZZkqlnjWaJoyzY5Eu5w
         LfIw==
X-Gm-Message-State: ACrzQf3LOQ7Dtj0sbS8uOvfx25C7vtviq8q/uFnH3q5pCbk6sHOzFZHG
        2p4fh+OB3VQi3/A4/+sdxlelK0FqRE1S5DcvgCXTFdRWUeDX
X-Google-Smtp-Source: AMsMyM7YRd13bf01gEl7pkehFtMeX4xg1J+dGlw8Lgh7catIVUGB/fR8gtNaFwknAAkGpzvhVg1YKjgvtQXz1l/5AuZNfrjcN/U6
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3421:b0:6a1:6b14:895b with SMTP id
 n33-20020a056602342100b006a16b14895bmr7618689ioz.24.1663621480995; Mon, 19
 Sep 2022 14:04:40 -0700 (PDT)
Date:   Mon, 19 Sep 2022 14:04:40 -0700
In-Reply-To: <00000000000050d56805e77c4582@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a612305e90e0f79@google.com>
Subject: Re: [syzbot] WARNING in writeback_single_inode
From:   syzbot <syzbot+fc721e2fe15a5aac41d1@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, willy@infradead.org
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    a6b443748715 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=144f0654880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=14bf9ec0df433b27
dashboard link: https://syzkaller.appspot.com/bug?extid=fc721e2fe15a5aac41d1
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17cb3628880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1778ecb0880000

Downloadable assets:
disk image: https://storage.googleapis.com/81b491dd5861/disk-a6b44374.raw.xz
vmlinux: https://storage.googleapis.com/69c979cdc99a/vmlinux-a6b44374.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fc721e2fe15a5aac41d1@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 7715 at fs/fs-writeback.c:1678 writeback_single_inode+0x374/0x388 fs/fs-writeback.c:1678
Modules linked in:
CPU: 0 PID: 7715 Comm: syz-executor169 Not tainted 6.0.0-rc4-syzkaller-17255-ga6b443748715 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : writeback_single_inode+0x374/0x388 fs/fs-writeback.c:1678
lr : writeback_single_inode+0x374/0x388 fs/fs-writeback.c:1678
sp : ffff800015f0b9c0
x29: ffff800015f0ba10 x28: ffff0000cf476000 x27: fffffc0003488dc0
x26: 0000000000000a00 x25: 0000000000000000 x24: 0000000000000001
x23: 0000000000001000 x22: ffff800015f0ba60 x21: 0000000000000000
x20: ffff0000ce87824f x19: ffff0000ce8782d8 x18: 0000000000000379
x17: ffff80000c00d6bc x16: ffff80000db78658 x15: ffff0000cf4c8000
x14: 00000000000000f0 x13: 00000000ffffffff x12: ffff0000cf4c8000
x11: ff80800008619b78 x10: 0000000000000000 x9 : ffff800008619b78
x8 : ffff0000cf4c8000 x7 : ffff800008619848 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 writeback_single_inode+0x374/0x388 fs/fs-writeback.c:1678
 write_inode_now+0xb0/0xdc fs/fs-writeback.c:2723
 iput_final fs/inode.c:1735 [inline]
 iput+0x1e4/0x324 fs/inode.c:1774
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
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
irq event stamp: 1754
hardirqs last  enabled at (1753): [<ffff800008162eec>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1367 [inline]
hardirqs last  enabled at (1753): [<ffff800008162eec>] finish_lock_switch+0x94/0xe8 kernel/sched/core.c:4942
hardirqs last disabled at (1754): [<ffff80000bfc5c8c>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (546): [<ffff8000080102e4>] _stext+0x2e4/0x37c
softirqs last disabled at (541): [<ffff800008017c48>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:79
---[ end trace 0000000000000000 ]---
Unable to handle kernel paging request at virtual address 000000ce87847947
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=00000001135a3000
[000000ce87847947] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 96000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 7715 Comm: syz-executor169 Tainted: G        W          6.0.0-rc4-syzkaller-17255-ga6b443748715 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : xa_marked include/linux/xarray.h:420 [inline]
pc : mapping_tagged include/linux/fs.h:461 [inline]
pc : writeback_single_inode+0x228/0x388 fs/fs-writeback.c:1703
lr : writeback_single_inode+0x218/0x388 fs/fs-writeback.c:1702
sp : ffff800015f0b9c0
x29: ffff800015f0ba10 x28: ffff0000cf476000 x27: fffffc0003488dc0
x26: 0000000000000a00 x25: 0000000000001000 x24: 0000000000000001
x23: 0000000000000001 x22: ffff800015f0ba60 x21: ffff0000ce878327
x20: ffff0000ce87824f x19: ffff0000ce8782d8 x18: 0000000000000379
x17: ffff80000c00d6bc x16: ffff80000db78658 x15: ffff0000cf4c8000
x14: 00000000000000f0 x13: 00000000ffffffff x12: ffff0000cf4c8000
x11: ff80800008619a1c x10: 0000000000000000 x9 : ffff0000cf4c8000
x8 : ff0000ce878478ff x7 : ffff800008619848 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000001 x1 : 0000000000000001 x0 : 0000000000000000
Call trace:
 xa_marked include/linux/xarray.h:420 [inline]
 mapping_tagged include/linux/fs.h:461 [inline]
 writeback_single_inode+0x228/0x388 fs/fs-writeback.c:1703
 write_inode_now+0xb0/0xdc fs/fs-writeback.c:2723
 iput_final fs/inode.c:1735 [inline]
 iput+0x1e4/0x324 fs/inode.c:1774
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
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
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

