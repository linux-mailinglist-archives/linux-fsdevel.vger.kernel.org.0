Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D53F6423FC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Dec 2022 09:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbiLEICr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Dec 2022 03:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiLEICl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:02:41 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0B1BEB
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Dec 2022 00:02:38 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id a14-20020a921a0e000000b00302a8ffa8e5so11461653ila.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Dec 2022 00:02:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VtmsZ4TzVbvc+PAmTCSz21aVvlHAlNlv5FF3rqKUAr4=;
        b=ugngg+gBbHhA5NOGRC6pGKC//Ye0/ZK9qWpQ0365Z0Y2EMgZ4ckZH2HdyVxhuzs4ZD
         ayeUWL7nTWE+ax24ecqf2oEpyUHAgkWWON5PxZOr7DP6J4togmL4HyzX0HGVk8TyhzId
         +MmgHH854RE7Wk1sE6GXm/kEc4Ghjdw36c4vVe3pIODa8PE9NWcO1xwXP3WdTJolb/hz
         eiO5umUfuuK831gZk0kDS/I9dPGY5ep1x0PcXeyaFV0r/d5JfUOGVbfWC3MBEQWPcK+Y
         i2AWc49Ai4nT30tfFcscJ0HqLukChRR6ah/GGMwBYGIpn7kQYtmbALdhnyLjug9SHwTc
         iTWQ==
X-Gm-Message-State: ANoB5pm/wWrzUlOYhvKdrG9ZyL6x2RZb7KqqBZ00iXJK2gtnpNSXFbPB
        UiUFM/7z7bDj1516q5Z+Ig9BvQHE3g+zcSE/ktAYSfxU3K7p
X-Google-Smtp-Source: AA0mqf7V/dA8MWhlwORI4dDx9UkKa/09prd/RM1ilPubxhoR1OjgQvLhdCjs5ojVdxuwNo9YImwkUbv9a8Q+CVuYjt2jl0jUpYuG
MIME-Version: 1.0
X-Received: by 2002:a6b:8d09:0:b0:68b:7b1f:92b9 with SMTP id
 p9-20020a6b8d09000000b0068b7b1f92b9mr28999659iod.163.1670227357939; Mon, 05
 Dec 2022 00:02:37 -0800 (PST)
Date:   Mon, 05 Dec 2022 00:02:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005d418205ef101cae@google.com>
Subject: [syzbot] WARNING: locking bug in hfsplus_delete_cat
From:   syzbot <syzbot+95214da0d40d4ec44f1c@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    e3cb714fb489 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10dd1dbd880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec7118319bfb771e
dashboard link: https://syzkaller.appspot.com/bug?extid=95214da0d40d4ec44f1c
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/832eb1866f2c/disk-e3cb714f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5fd572b7d96d/vmlinux-e3cb714f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/34c82908beda/Image-e3cb714f.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+95214da0d40d4ec44f1c@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(!test_bit(class_idx, lock_classes_in_use))
WARNING: CPU: 1 PID: 17591 at kernel/locking/lockdep.c:5025 __lock_acquire+0x2758/0x3084
Modules linked in:
CPU: 1 PID: 17591 Comm: syz-executor.3 Not tainted 6.1.0-rc7-syzkaller-33097-ge3cb714fb489 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __lock_acquire+0x2758/0x3084
lr : __lock_acquire+0x2754/0x3084 kernel/locking/lockdep.c:5025
sp : ffff80001697b610
x29: ffff80001697b6f0 x28: 0000000000000003 x27: ffff00011ec3cf38
x26: ffff00011ec3d920 x25: ffff00011ec3d940 x24: ffff00011ec3d940
x23: 00000000000000c0 x22: 0000000000000001 x21: 0000000000000000
x20: ffff00011ec3cec0 x19: 555555555554015a x18: fffffffffffffff8
x17: ffff80000dda8198 x16: 0000000000000001 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000012 x12: ffff80000d93b650
x11: ff808000081c4d64 x10: 0000000000000000 x9 : 3906fb84f6442900
x8 : 3906fb84f6442900 x7 : 4e5241575f534b43 x6 : ffff80000c091044
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000001 x0 : 0000000000000000
Call trace:
 __lock_acquire+0x2758/0x3084
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x54/0x6c kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:350 [inline]
 hfsplus_delete_cat+0x1fc/0x4a0 fs/hfsplus/catalog.c:395
 hfsplus_fill_super+0x828/0x864 fs/hfsplus/super.c:576
 mount_bdev+0x1b8/0x210 fs/super.c:1401
 hfsplus_mount+0x44/0x58 fs/hfsplus/super.c:641
 legacy_get_tree+0x30/0x74 fs/fs_context.c:610
 vfs_get_tree+0x40/0x140 fs/super.c:1531
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x890 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
irq event stamp: 4491
hardirqs last  enabled at (4491): [<ffff80000c0960d4>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (4491): [<ffff80000c0960d4>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (4490): [<ffff80000c095f10>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (4490): [<ffff80000c095f10>] _raw_spin_lock_irqsave+0xa4/0xb4 kernel/locking/spinlock.c:162
softirqs last  enabled at (4068): [<ffff8000080102e4>] _stext+0x2e4/0x37c
softirqs last disabled at (4033): [<ffff800008017c88>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:80
---[ end trace 0000000000000000 ]---
Unable to handle kernel paging request at virtual address ffff80000d2e2c80
Mem abort info:
  ESR = 0x0000000096000047
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x07: level 3 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000047
  CM = 0, WnR = 1
swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000001c54dc000
[ffff80000d2e2c80] pgd=100000023ffff003, p4d=100000023ffff003, pud=100000023fffe003, pmd=100000023fffa003, pte=0000000000000000
Internal error: Oops: 0000000096000047 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 17591 Comm: syz-executor.3 Tainted: G        W          6.1.0-rc7-syzkaller-33097-ge3cb714fb489 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : queued_spin_lock_slowpath+0x198/0x394 kernel/locking/qspinlock.c:474
lr : queued_spin_lock_slowpath+0x114/0x394 kernel/locking/qspinlock.c:405
sp : ffff80001697b780
x29: ffff80001697b780 x28: ffff00011ec3cec0 x27: 000000000000000a
x26: ffff00011f8bd400 x25: ffff00011b6c87b8 x24: ffff0001fefefc80
x23: 0000000000000000 x22: ffff80000d37d050 x21: ffff80000d2e2c80
x20: 0000000000000001 x19: ffff00011b6c8770 x18: fffffffffffffff8
x17: ffff80000dda8198 x16: 0000000000000001 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000001b6c x12: 0000000000000000
x11: ffff80000d2e2c80 x10: 0000000000080000 x9 : ffff0001fefefc88
x8 : ffff0001fefefc80 x7 : 4e5241575f534b43 x6 : ffff80000c091044
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000001 x1 : ffff80000ce8920b x0 : 0000000000000001
Call trace:
 decode_tail kernel/locking/qspinlock.c:131 [inline]
 queued_spin_lock_slowpath+0x198/0x394 kernel/locking/qspinlock.c:471
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x10c/0x110 kernel/locking/spinlock_debug.c:115
 __raw_spin_lock include/linux/spinlock_api_smp.h:134 [inline]
 _raw_spin_lock+0x5c/0x6c kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:350 [inline]
 hfsplus_delete_cat+0x1fc/0x4a0 fs/hfsplus/catalog.c:395
 hfsplus_fill_super+0x828/0x864 fs/hfsplus/super.c:576
 mount_bdev+0x1b8/0x210 fs/super.c:1401
 hfsplus_mount+0x44/0x58 fs/hfsplus/super.c:641
 legacy_get_tree+0x30/0x74 fs/fs_context.c:610
 vfs_get_tree+0x40/0x140 fs/super.c:1531
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x890 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Code: 8b2c4ecc f85f818c 1200056b 8b2b52ab (f82b6988) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	8b2c4ecc 	add	x12, x22, w12, uxtw #3
   4:	f85f818c 	ldur	x12, [x12, #-8]
   8:	1200056b 	and	w11, w11, #0x3
   c:	8b2b52ab 	add	x11, x21, w11, uxtw #4
* 10:	f82b6988 	str	x8, [x12, x11] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
