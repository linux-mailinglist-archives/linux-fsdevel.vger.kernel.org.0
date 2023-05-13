Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20C170153B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 May 2023 10:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjEMIUs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 May 2023 04:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEMIUr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 May 2023 04:20:47 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAB84EFA
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 May 2023 01:20:45 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-76c65f950a8so333334239f.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 May 2023 01:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683966045; x=1686558045;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NHsT8aQgofiZEPogCxeuyef7jD7ovpRr7WF45e4OLqo=;
        b=F9b7Js0hqFb07OvxyZF/R2iDsKQVNuKf/vplnzy5PDfpr9XtdE+Ky7ypwDbiTtvaYH
         WVwxdQc09Sram0owbAoVpKYNP1rGKuw+MZfsfAAcdTH1xAEjOp00RWxAzpPX/ug8XUJq
         bVx+z2g58/pJalwecTBBWdz6S0yqeSbNbOUf8Z4hZH/gaTwv0cj8Li8ZuIHJhqXUNckv
         cAGoinevHQudH8iy3kn7QApHeMFwo3qDNjy94EGfJ6CPd5IK9/H4bGQvoVOVzz0P+3Gd
         doo08L7mjpCAzu2zOSFzrS9Id4r7WXr4fcjOsxV7tnjIl2C3ABp3SbNV1LgCpdclpu/m
         HSKw==
X-Gm-Message-State: AC+VfDzdDvRPYOuiPfIz9cP0DRubpuk56XUp8lIO8ddH2kjkRm0uQcF8
        mMvNz6iXkbvlyNzLQlmR9G5C7uc9749ae8SwITwXzG60GeSI
X-Google-Smtp-Source: ACHHUZ4Enq8/ALFZVBHlfZlnhINFRKjOwYgQUHx8KWNaqHXGkJk3PiK03BjwybbZxfQT8C6sV95PHkXToxi1rLc/IHqb3OMoMuzF
MIME-Version: 1.0
X-Received: by 2002:a02:9387:0:b0:416:7d6c:5e3c with SMTP id
 z7-20020a029387000000b004167d6c5e3cmr7518342jah.1.1683966044840; Sat, 13 May
 2023 01:20:44 -0700 (PDT)
Date:   Sat, 13 May 2023 01:20:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eaae1e05fb8ee573@google.com>
Subject: [syzbot] [ntfs3?] WARNING in __virt_to_phys (2)
From:   syzbot <syzbot+8ca7991ee615756ac1c7@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    14f8db1c0f9a Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=163d9c98280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a837a8ba7e88bb45
dashboard link: https://syzkaller.appspot.com/bug?extid=8ca7991ee615756ac1c7
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11001b7a280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=131f2e32280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ad6ce516eed3/disk-14f8db1c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1f38c2cc7667/vmlinux-14f8db1c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d795115eee39/Image-14f8db1c.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f4b6924b0bd8/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8ca7991ee615756ac1c7@syzkaller.appspotmail.com

ntfs3: loop0: Different NTFS' sector size (4096) and media sector size (512)
------------[ cut here ]------------
virt_to_phys used for non-linear address: 000000005d09f686 (0xdead4ead00000000)
WARNING: CPU: 1 PID: 5926 at arch/arm64/mm/physaddr.c:15 __virt_to_phys+0x84/0x9c arch/arm64/mm/physaddr.c:17
Modules linked in:
CPU: 1 PID: 5926 Comm: syz-executor863 Not tainted 6.3.0-rc7-syzkaller-g14f8db1c0f9a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __virt_to_phys+0x84/0x9c arch/arm64/mm/physaddr.c:17
lr : __virt_to_phys+0x80/0x9c arch/arm64/mm/physaddr.c:12
sp : ffff80001e4a74e0
x29: ffff80001e4a74e0 x28: 1fffe0001bd60433 x27: dfff800000000000
x26: 1fffe0001bd60431 x25: dfff800000000000 x24: ffff8000127d6740
x23: ffff8000096bf414 x22: ffff0000deb020a8 x21: 0000000000040000
x20: deae4ead00000000 x19: dead4ead00000000 x18: ffff80001e4a6e20
x17: 6564783028203638 x16: ffff80001236e294 x15: 0000000000000002
x14: 0000000000000000 x13: 0000000000000001 x12: 0000000000000001
x11: 0000000000000000 x10: 0000000000000000 x9 : 787ed45d7a14e900
x8 : ffff800015755000 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80001e4a6dd8 x4 : ffff800015e4ccc0 x3 : ffff800008584230
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000000
Call trace:
 __virt_to_phys+0x84/0x9c arch/arm64/mm/physaddr.c:17
 virt_to_folio include/linux/mm.h:1057 [inline]
 kfree+0x7c/0x19c mm/slab_common.c:1011
 kvfree+0x40/0x50 mm/util.c:649
 run_close fs/ntfs3/ntfs_fs.h:946 [inline]
 indx_clear+0x44/0x94 fs/ntfs3/index.c:859
 ni_clear+0x248/0x4f0 fs/ntfs3/frecord.c:121
 ntfs_evict_inode+0x90/0xc8 fs/ntfs3/inode.c:1779
 evict+0x260/0x68c fs/inode.c:665
 iput_final fs/inode.c:1748 [inline]
 iput+0x734/0x818 fs/inode.c:1774
 ntfs_loadlog_and_replay+0x248/0x448 fs/ntfs3/fsntfs.c:325
 ntfs_fill_super+0x1f7c/0x3b9c fs/ntfs3/super.c:1053
 get_tree_bdev+0x360/0x54c fs/super.c:1303
 ntfs_fs_get_tree+0x28/0x38 fs/ntfs3/super.c:1408
 vfs_get_tree+0x90/0x274 fs/super.c:1510
 do_new_mount+0x25c/0x8c8 fs/namespace.c:3042
 path_mount+0x590/0xe04 fs/namespace.c:3372
 do_mount fs/namespace.c:3385 [inline]
 __do_sys_mount fs/namespace.c:3594 [inline]
 __se_sys_mount fs/namespace.c:3571 [inline]
 __arm64_sys_mount+0x45c/0x594 fs/namespace.c:3571
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x4c/0x15c arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
irq event stamp: 24636
hardirqs last  enabled at (24635): [<ffff8000083416f0>] __up_console_sem+0x60/0xb4 kernel/printk/printk.c:345
hardirqs last disabled at (24636): [<ffff800012369e90>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:405
softirqs last  enabled at (24444): [<ffff800008020c1c>] softirq_handle_end kernel/softirq.c:414 [inline]
softirqs last  enabled at (24444): [<ffff800008020c1c>] __do_softirq+0xac0/0xd54 kernel/softirq.c:600
softirqs last disabled at (24433): [<ffff80000802a658>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:80
---[ end trace 0000000000000000 ]---
Unable to handle kernel paging request at virtual address 007ab33ab96b8008
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
[007ab33ab96b8008] address between user and kernel address ranges
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 5926 Comm: syz-executor863 Tainted: G        W          6.3.0-rc7-syzkaller-g14f8db1c0f9a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : _compound_head include/linux/page-flags.h:251 [inline]
pc : virt_to_folio include/linux/mm.h:1059 [inline]
pc : kfree+0x90/0x19c mm/slab_common.c:1011
lr : virt_to_folio include/linux/mm.h:1057 [inline]
lr : kfree+0x7c/0x19c mm/slab_common.c:1011
sp : ffff80001e4a7500
x29: ffff80001e4a7500 x28: 1fffe0001bd60433 x27: dfff800000000000
x26: 1fffe0001bd60431 x25: dfff800000000000 x24: ffff8000127d6740
x23: ffff8000096bf414 x22: ffff0000deb020a8 x21: 0000000000040000
x20: ffff8000087e5650 x19: dead4ead00000000 x18: ffff80001e4a6e20
x17: 6564783028203638 x16: ffff80001236e294 x15: 0000000000000002
x14: 0000000000000000 x13: 0000000000000001 x12: 0000000000000001
x11: 0000000000000000 x10: 0000000000000000 x9 : 037ab73ab96b8000
x8 : fffffc0000000000 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80001e4a6dd8 x4 : ffff800015e4ccc0 x3 : ffff800008584230
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 037ab33ab96b8000
Call trace:
 virt_to_folio include/linux/mm.h:1057 [inline]
 kfree+0x90/0x19c mm/slab_common.c:1011
 kvfree+0x40/0x50 mm/util.c:649
 run_close fs/ntfs3/ntfs_fs.h:946 [inline]
 indx_clear+0x44/0x94 fs/ntfs3/index.c:859
 ni_clear+0x248/0x4f0 fs/ntfs3/frecord.c:121
 ntfs_evict_inode+0x90/0xc8 fs/ntfs3/inode.c:1779
 evict+0x260/0x68c fs/inode.c:665
 iput_final fs/inode.c:1748 [inline]
 iput+0x734/0x818 fs/inode.c:1774
 ntfs_loadlog_and_replay+0x248/0x448 fs/ntfs3/fsntfs.c:325
 ntfs_fill_super+0x1f7c/0x3b9c fs/ntfs3/super.c:1053
 get_tree_bdev+0x360/0x54c fs/super.c:1303
 ntfs_fs_get_tree+0x28/0x38 fs/ntfs3/super.c:1408
 vfs_get_tree+0x90/0x274 fs/super.c:1510
 do_new_mount+0x25c/0x8c8 fs/namespace.c:3042
 path_mount+0x590/0xe04 fs/namespace.c:3372
 do_mount fs/namespace.c:3385 [inline]
 __do_sys_mount fs/namespace.c:3594 [inline]
 __se_sys_mount fs/namespace.c:3571 [inline]
 __arm64_sys_mount+0x45c/0x594 fs/namespace.c:3571
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x4c/0x15c arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
Code: b25657e8 927acd29 cb151929 8b080120 (f9400408) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	b25657e8 	mov	x8, #0xfffffc0000000000    	// #-4398046511104
   4:	927acd29 	and	x9, x9, #0x3ffffffffffffc0
   8:	cb151929 	sub	x9, x9, x21, lsl #6
   c:	8b080120 	add	x0, x9, x8
* 10:	f9400408 	ldr	x8, [x0, #8] <-- trapping instruction


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

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
