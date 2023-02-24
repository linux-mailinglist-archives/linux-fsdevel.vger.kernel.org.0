Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CCA6A1A83
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Feb 2023 11:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjBXKn5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 05:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjBXKnM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:43:12 -0500
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCC212BE0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 02:42:47 -0800 (PST)
Received: by mail-il1-f208.google.com with SMTP id f8-20020a056e0212a800b00317170581e6so430100ilr.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 02:42:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wu/tOnCc7ZTPiYWfykiutPtgVaJumHoVSI6tLhsDKBM=;
        b=XMMnMQUC/u/FCUMkMzd9VdTnGdcWjlnQvRqplbzialef2xWmbjrcdFBszG3G2mVI0R
         EPoeO0KyeRB9irgYP9/8Gbzzdt5ecU9NcvWX1OIZ8njVuyL/hw9sj4cMuphyRb0Sb63Y
         cb/GJ05ZWLnAfjlppEk1DKWAey3tURKUGWfqoHsb9rGDdN2vQeViWTIBtAhU7z3/RVc3
         wtIvUZeDXPKL1mDTKYyP7fVPHWt0WTXHsi1o/WKwmx2rozCqqKvJAl9oRcFx5ICIOBir
         9BnaJDbHfrfQrZ1oKngGKT8r7u6Kxxt+VxL6zpRd9jDKSbbaitnXDS3HGEtj9pR0P1Vy
         Jtmg==
X-Gm-Message-State: AO0yUKWvpvcQ7kOVIPxuya9nxVZKwM4zW0fdZljMFDWgJjOXMkzr220y
        N7e+PSkdGTkglP7WXESY1GvETUE3U9+xvUDUiRRmjALQ4UQG
X-Google-Smtp-Source: AK7set/PMjmBTNfCWO+rEXugqmZ9mpJ1oFG9AgOcYhTmpgZnU/gej4pJOb6rhWhFSb6mIRdhn40OIVMsWvZBJqNVLSXhGR1e9Vrk
MIME-Version: 1.0
X-Received: by 2002:a92:5408:0:b0:317:b01:229 with SMTP id i8-20020a925408000000b003170b010229mr596832ilb.2.1677235366868;
 Fri, 24 Feb 2023 02:42:46 -0800 (PST)
Date:   Fri, 24 Feb 2023 02:42:46 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003f3d9a05f56fcac5@google.com>
Subject: [syzbot] [kernfs?] WARNING: suspicious RCU usage in mas_start
From:   syzbot <syzbot+d79e205d463e603f47ff@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tj@kernel.org
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

HEAD commit:    d2980d8d8265 Merge tag 'mm-nonmm-stable-2023-02-20-15-29' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16c7f944c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=471a946f0dd5764c
dashboard link: https://syzkaller.appspot.com/bug?extid=d79e205d463e603f47ff
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/65a5040f9f8c/disk-d2980d8d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e7593e5fe23f/vmlinux-d2980d8d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9714acfee895/bzImage-d2980d8d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d79e205d463e603f47ff@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
6.2.0-syzkaller-09238-gd2980d8d8265 #0 Not tainted
-----------------------------
lib/maple_tree.c:856 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
6 locks held by syz-executor.0/11715:
 #0: ffff888073bc0368 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x254/0x2f0 fs/file.c:1046
 #1: ffff888027ec2460 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x26d/0xbb0 fs/read_write.c:580
 #2: ffff888073909888 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x1eb/0x4f0 fs/kernfs/file.c:325
 #3: ffff88801782d3a8 (kn->active#64){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20f/0x4f0 fs/kernfs/file.c:326
 #4: ffffffff8d014968 (ksm_thread_mutex){+.+.}-{3:3}, at: run_store+0x122/0xb10 mm/ksm.c:2953
 #5: ffff88807b136d98 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 #5: ffff88807b136d98 (&mm->mmap_lock){++++}-{3:3}, at: unmerge_and_remove_all_rmap_items mm/ksm.c:990 [inline]
 #5: ffff88807b136d98 (&mm->mmap_lock){++++}-{3:3}, at: run_store+0x2db/0xb10 mm/ksm.c:2959

stack backtrace:
CPU: 1 PID: 11715 Comm: syz-executor.0 Not tainted 6.2.0-syzkaller-09238-gd2980d8d8265 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/16/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 lockdep_rcu_suspicious+0x220/0x340 kernel/locking/lockdep.c:6599
 mas_root lib/maple_tree.c:856 [inline]
 mas_start+0x2c1/0x440 lib/maple_tree.c:1357
 mas_state_walk lib/maple_tree.c:3838 [inline]
 mas_walk+0x33/0x180 lib/maple_tree.c:5052
 mas_find+0x1e9/0x240 lib/maple_tree.c:6030
 vma_next include/linux/mm.h:745 [inline]
 unmerge_and_remove_all_rmap_items mm/ksm.c:991 [inline]
 run_store+0x2f9/0xb10 mm/ksm.c:2959
 kernfs_fop_write_iter+0x3a6/0x4f0 fs/kernfs/file.c:334
 call_write_iter include/linux/fs.h:1851 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x7b2/0xbb0 fs/read_write.c:584
 ksys_write+0x1a0/0x2c0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f498d08c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f498dec9168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f498d1abf80 RCX: 00007f498d08c0f9
RDX: 0000000000000002 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00007f498d0e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe961b822f R14: 00007f498dec9300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
