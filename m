Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CDE5BD0C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 17:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiISPWt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 11:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiISPWZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:22:25 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91836624B
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 08:21:49 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id b16-20020a5d8950000000b006891a850acfso14769372iot.19
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 08:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=pd0tQVzxCkMLVMUpFbcAA1aW6bUdg50Dfgfn+WZ9e2s=;
        b=LDVIg1usr4Is1lnbYU246y7vbm93KNeOuinmtVRgdweZiY/pXZaYRJNPINqbEu4N16
         3FICpYXqHMg2zl7esm+YVVFxFJ4S1ASIwLMr/ImpBNhjq8MdejMCmj2b73Brgul/Zmzi
         ppsL/7zZdKdn1bNlL6wFqmV2Crp/09B+rADttuexMCBPfokZaBizwReSp5fQjRnAy3Cb
         aL5lSmoHKwUVXUMdZV65JGvNYfqE1b+55FM+06cXuuaA54kKNgZSJebxHV17leW99s1C
         AIWvr0w5V6DyXsMHSD8LkB3n61IiKq0LfQFazalBHCYFM3Ih8Q2veqMFR5rnnhS5rX51
         RzWA==
X-Gm-Message-State: ACrzQf3eqkdn0b7mrnEteDsp39KNqhCGLJJxe3knPyX1DuHpStAt41tb
        GXklxgkHSsaepAH1O3wT10MC717k3pKLWd09h0KEqBDrA9wQ
X-Google-Smtp-Source: AMsMyM4XyTtZP3c2nvtSzO74XfwlMEkbieMq6fIwtdhIpezN3J3b5WBs++oYttAkNFXRbzW8pClkzTrkK9Yb4SGS9LS//w8z3Fw1
MIME-Version: 1.0
X-Received: by 2002:a02:340c:0:b0:358:4d7e:272b with SMTP id
 x12-20020a02340c000000b003584d7e272bmr8176016jae.192.1663600908935; Mon, 19
 Sep 2022 08:21:48 -0700 (PDT)
Date:   Mon, 19 Sep 2022 08:21:48 -0700
In-Reply-To: <00000000000014512a05e9047a38@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000039a90705e90945bc@google.com>
Subject: Re: [syzbot] WARNING: suspicious RCU usage in evict
From:   syzbot <syzbot+45df7ccc8b5bade4f745@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    521a547ced64 Linux 6.0-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13cd7937080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=122d7bd4fc8e0ecb
dashboard link: https://syzkaller.appspot.com/bug?extid=45df7ccc8b5bade4f745
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143df15f080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+45df7ccc8b5bade4f745@syzkaller.appspotmail.com

ntfs3: loop1: RAW NTFS volume: Filesystem size 0.00 Gb > volume size 0.00 Gb. Mount in read-only
=============================
WARNING: suspicious RCU usage
6.0.0-rc6-syzkaller #0 Not tainted
-----------------------------
include/trace/events/lock.h:69 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
2 locks held by syz-executor.1/3793:
 #0: ffff88806df000e0 (&type->s_umount_key#47/1){+.+.}-{3:3}, at: alloc_super+0x22e/0xb60 fs/super.c:228
 #1: ffff88806df009d8 (&s->s_inode_list_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:349 [inline]
 #1: ffff88806df009d8 (&s->s_inode_list_lock){+.+.}-{2:2}, at: inode_sb_list_del fs/inode.c:503 [inline]
 #1: ffff88806df009d8 (&s->s_inode_list_lock){+.+.}-{2:2}, at: evict+0x179/0x6b0 fs/inode.c:654

stack backtrace:
CPU: 1 PID: 3793 Comm: syz-executor.1 Not tainted 6.0.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 trace_lock_release include/trace/events/lock.h:69 [inline]
 lock_release.cold+0x1f/0x4e kernel/locking/lockdep.c:5677
 __raw_spin_unlock include/linux/spinlock_api_smp.h:141 [inline]
 _raw_spin_unlock+0x12/0x40 kernel/locking/spinlock.c:186
 spin_unlock include/linux/spinlock.h:389 [inline]
 inode_sb_list_del fs/inode.c:505 [inline]
 evict+0x2aa/0x6b0 fs/inode.c:654
 iput_final fs/inode.c:1748 [inline]
 iput.part.0+0x55d/0x810 fs/inode.c:1774
 iput+0x58/0x70 fs/inode.c:1764
 ntfs_fill_super+0x2309/0x37f0 fs/ntfs3/super.c:1278
 get_tree_bdev+0x440/0x760 fs/super.c:1323
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1326/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f67e5a8a93a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f67e6cb5f88 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f67e5a8a93a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f67e6cb5fe0
RBP: 00007f67e6cb6020 R08: 00007f67e6cb6020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f67e6cb5fe0 R15: 0000000020003580
 </TASK>

