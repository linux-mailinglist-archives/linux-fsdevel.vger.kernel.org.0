Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D366A4612
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 16:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjB0PaC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 10:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjB0PaB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:30:01 -0500
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A7DBB9C
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 07:29:47 -0800 (PST)
Received: by mail-io1-f77.google.com with SMTP id n42-20020a056602342a00b0074cde755b99so2962407ioz.16
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 07:29:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=45UKrYAmhULhqBRHtvhzoeRUXcZg3+p7AA2JXXqD7AE=;
        b=ifGBttjFapMGBqAW1IOSobUDJsAyfg6u0ORa0khZHjT2i2++DrK4RHMOnC83IsgXIz
         xVhAKtSKI2S8ppkH3g5N2aIXunB7vwolEVxkZ5zNfMytCGGl2EmNPuFq6IPhpjOsp75x
         QXgRqJSF6247obwed92Q74gTVZPrU9S7AtE+814qDpTXmLNjl/2DlGbT75ec7Z4hZhos
         k7laUzhbR8JCliqnRNKstG6chd70iUJV3i4zzRBQ0AgX/eQPTuXF6+mEdmpDfHPZs07h
         FsjdPM7G/mALp0BkPZlFe1y5PnQ9PdP3XejawDWbPOQQSime+v2h2iKDjVOUMaPc6cUb
         V1gg==
X-Gm-Message-State: AO0yUKXwkWjQbhJD5ssFbSZ4znnJwwQRtopHdB3qu7IoloSjTWggu7I+
        l3O2nUQswh/Fsj2RE1Bt8ulgumgkSVu8MoIremEz83ROU9WT
X-Google-Smtp-Source: AK7set+fH0wK863xbwHQ9iT0INQrGloPXCuNwPOIO6vhbXdmnBKHORgrzHH0aIt6fxBBGXyLnzpCCbzVnGxu/B/OBOBRTe+eHgR4
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e0f:b0:317:50bb:ee2a with SMTP id
 g15-20020a056e021e0f00b0031750bbee2amr2486912ila.1.1677511787046; Mon, 27 Feb
 2023 07:29:47 -0800 (PST)
Date:   Mon, 27 Feb 2023 07:29:47 -0800
In-Reply-To: <0000000000003f3d9a05f56fcac5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002c756405f5b026c7@google.com>
Subject: Re: [syzbot] [kernfs?] WARNING: suspicious RCU usage in mas_start
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    f3a2439f20d9 Merge tag 'rproc-v6.3' of git://git.kernel.or..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10a7dea8c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd442ddf29eaca0c
dashboard link: https://syzkaller.appspot.com/bug?extid=d79e205d463e603f47ff
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12cfaf1cc80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149edbf0c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5892d3595732/disk-f3a2439f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b634456815c8/vmlinux-f3a2439f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d6d82681f2ca/bzImage-f3a2439f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d79e205d463e603f47ff@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
6.2.0-syzkaller-12485-gf3a2439f20d9 #0 Not tainted
-----------------------------
lib/maple_tree.c:856 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
5 locks held by syz-executor322/5095:
 #0: ffff88802d3aa460 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x26d/0xbb0 fs/read_write.c:580
 #1: ffff888023176c88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x1eb/0x4f0 fs/kernfs/file.c:325
 #2: ffff8881451a7490 (kn->active#47){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20f/0x4f0 fs/kernfs/file.c:326
 #3: ffffffff8d214988 (ksm_thread_mutex){+.+.}-{3:3}, at: run_store+0x122/0xb10 mm/ksm.c:2953
 #4: ffff888025e8c998 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 #4: ffff888025e8c998 (&mm->mmap_lock){++++}-{3:3}, at: unmerge_and_remove_all_rmap_items mm/ksm.c:990 [inline]
 #4: ffff888025e8c998 (&mm->mmap_lock){++++}-{3:3}, at: run_store+0x2db/0xb10 mm/ksm.c:2959

stack backtrace:
CPU: 0 PID: 5095 Comm: syz-executor322 Not tainted 6.2.0-syzkaller-12485-gf3a2439f20d9 #0
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
RIP: 0033:0x7fe864e99e49
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc685fb328 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000000f4240 RCX: 00007fe864e99e49
RDX: 0000000000000002 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000246 R12: 000000000000d884
R13: 00007ffc685fb33c R14: 00007ffc685fb350 R15: 00007ffc685fb340
 </TASK>

