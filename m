Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CC97484C2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 15:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjGENRx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 09:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjGENRu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:17:50 -0400
Received: from mail-pj1-f80.google.com (mail-pj1-f80.google.com [209.85.216.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32127171B
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jul 2023 06:17:48 -0700 (PDT)
Received: by mail-pj1-f80.google.com with SMTP id 98e67ed59e1d1-262dc0bab18so7206638a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jul 2023 06:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688563067; x=1691155067;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XMajTkowJsizouXtvFiRDI55jqUuxOiG4yKIlHBEILk=;
        b=XrxjaEtUIf0fDp67WhJjB4VbLXhG0ryylPgr7a32Lg+YQ9zx/ztZAN/zReEeewngMr
         nK317ApEjDtw7X745/gt4wuMaQN2Vm3JR2CgR3jnPzeNexFDeZ4E1PgGok2b3fFDSsXD
         9aDURgvb58EgUKGnsqjqGgOyKFcLdaqS+Hb8ckESNIO/plJyGfk72JOA/2iY2E+SiAwc
         06i5v7KPfs0syWT3WYYIEmUfF/fTjeAlTB/bT/6ELz/OErtAGA5Q2p6+iENrZo7UitY+
         OieheYcyvU46UpEURxJiI5vucU7sFOtD52Y8dyIC99kMOsh5mujBm3ixVDeHkui3ZcH3
         E0JA==
X-Gm-Message-State: ABy/qLbYQoFmw7TMjpZNEY2fl/1wns/m0YYKAryoIx11+Nt4Inbzmf8l
        Dc/u8e3pxXROxcuwRtUxkxmepN0PQcB5K2PBkcGg+N0cbnFU
X-Google-Smtp-Source: APBJJlEXz+9gRs1vHTl8cubIh/+e224hEIn4RS66JfXa5HSDfoq8vEwgnnR9TO2e9uwcus/bR6oTUqLCELIxmR7KarQN/eL//qyo
MIME-Version: 1.0
X-Received: by 2002:a17:90a:d802:b0:262:e394:f054 with SMTP id
 a2-20020a17090ad80200b00262e394f054mr12072605pjv.2.1688563067764; Wed, 05 Jul
 2023 06:17:47 -0700 (PDT)
Date:   Wed, 05 Jul 2023 06:17:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d5c89a05ffbd39dd@google.com>
Subject: [syzbot] [btrfs?] inconsistent lock state in btrfs_run_delayed_iputs
From:   syzbot <syzbot+da501a04be5ff533b102@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a507db1d8fdc Merge tag '6.5-rc-smb3-client-fixes-part1' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17aaac40a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f27fb02fc20d955
dashboard link: https://syzkaller.appspot.com/bug?extid=da501a04be5ff533b102
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-a507db1d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e3b240f6b5a8/vmlinux-a507db1d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b78f45d88875/bzImage-a507db1d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+da501a04be5ff533b102@syzkaller.appspotmail.com

================================
WARNING: inconsistent lock state
6.4.0-syzkaller-09904-ga507db1d8fdc #0 Not tainted
--------------------------------
inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
btrfs-cleaner/16079 [HC0[0]:SC0[0]:HE1:SE1] takes:
ffff888107804d20 (&fs_info->delayed_iput_lock){+.?.}-{2:2}, at: spin_lock include/linux/spinlock.h:350 [inline]
ffff888107804d20 (&fs_info->delayed_iput_lock){+.?.}-{2:2}, at: btrfs_run_delayed_iputs+0x28/0xe0 fs/btrfs/inode.c:3523
{IN-SOFTIRQ-W} state was registered at:
  lock_acquire kernel/locking/lockdep.c:5761 [inline]
  lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5726
  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
  spin_lock include/linux/spinlock.h:350 [inline]
  btrfs_add_delayed_iput+0x128/0x390 fs/btrfs/inode.c:3490
  btrfs_put_ordered_extent fs/btrfs/ordered-data.c:559 [inline]
  btrfs_put_ordered_extent+0x2f6/0x610 fs/btrfs/ordered-data.c:547
  __btrfs_bio_end_io fs/btrfs/bio.c:118 [inline]
  __btrfs_bio_end_io+0x136/0x180 fs/btrfs/bio.c:112
  btrfs_orig_bbio_end_io+0x86/0x2b0 fs/btrfs/bio.c:163
  btrfs_simple_end_io+0x105/0x380 fs/btrfs/bio.c:378
  bio_endio+0x589/0x690 block/bio.c:1617
  req_bio_endio block/blk-mq.c:766 [inline]
  blk_update_request+0x5c5/0x1620 block/blk-mq.c:911
  blk_mq_end_request+0x59/0x680 block/blk-mq.c:1032
  lo_complete_rq+0x1c6/0x280 drivers/block/loop.c:370
  blk_complete_reqs+0xb3/0xf0 block/blk-mq.c:1110
  __do_softirq+0x1d4/0x905 kernel/softirq.c:553
  run_ksoftirqd kernel/softirq.c:921 [inline]
  run_ksoftirqd+0x31/0x60 kernel/softirq.c:913
  smpboot_thread_fn+0x659/0x9e0 kernel/smpboot.c:164
  kthread+0x344/0x440 kernel/kthread.c:389
  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
irq event stamp: 39
hardirqs last  enabled at (39): [<ffffffff81d5ebc4>] __do_kmem_cache_free mm/slab.c:3558 [inline]
hardirqs last  enabled at (39): [<ffffffff81d5ebc4>] kmem_cache_free mm/slab.c:3582 [inline]
hardirqs last  enabled at (39): [<ffffffff81d5ebc4>] kmem_cache_free+0x244/0x370 mm/slab.c:3575
hardirqs last disabled at (38): [<ffffffff81d5eb5e>] __do_kmem_cache_free mm/slab.c:3553 [inline]
hardirqs last disabled at (38): [<ffffffff81d5eb5e>] kmem_cache_free mm/slab.c:3582 [inline]
hardirqs last disabled at (38): [<ffffffff81d5eb5e>] kmem_cache_free+0x1de/0x370 mm/slab.c:3575
softirqs last  enabled at (0): [<ffffffff814ac99f>] copy_process+0x227f/0x75c0 kernel/fork.c:2448
softirqs last disabled at (0): [<0000000000000000>] 0x0

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&fs_info->delayed_iput_lock);
  <Interrupt>
    lock(&fs_info->delayed_iput_lock);

 *** DEADLOCK ***

1 lock held by btrfs-cleaner/16079:
 #0: ffff888107804860 (&fs_info->cleaner_mutex){+.+.}-{3:3}, at: cleaner_kthread+0x103/0x4b0 fs/btrfs/disk-io.c:1463

stack backtrace:
CPU: 3 PID: 16079 Comm: btrfs-cleaner Not tainted 6.4.0-syzkaller-09904-ga507db1d8fdc #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_usage_bug kernel/locking/lockdep.c:3978 [inline]
 valid_state kernel/locking/lockdep.c:4020 [inline]
 mark_lock_irq kernel/locking/lockdep.c:4223 [inline]
 mark_lock.part.0+0x1102/0x1960 kernel/locking/lockdep.c:4685
 mark_lock kernel/locking/lockdep.c:4649 [inline]
 mark_usage kernel/locking/lockdep.c:4598 [inline]
 __lock_acquire+0x8e4/0x5e20 kernel/locking/lockdep.c:5098
 lock_acquire kernel/locking/lockdep.c:5761 [inline]
 lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5726
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:350 [inline]
 btrfs_run_delayed_iputs+0x28/0xe0 fs/btrfs/inode.c:3523
 cleaner_kthread+0x2e5/0x4b0 fs/btrfs/disk-io.c:1478
 kthread+0x344/0x440 kernel/kthread.c:389
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
