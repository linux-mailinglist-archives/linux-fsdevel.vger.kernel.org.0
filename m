Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65145BC592
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 11:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiISJin (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 05:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiISJim (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:38:42 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7001414D2F
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 02:38:41 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id d2-20020a6b7d42000000b006a1760fc2a1so9288002ioq.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 02:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=aYNZr1TPBrm6w20i5gYjOP6/MXpZsLtQYWBpTiGRct8=;
        b=3nyGs+tsW4EadBgPAuED18k3k6BXlUA+KwyVxAmT41K8jSTja2SRnqGwK3bYNpLRZf
         JpRfQ9js5z6e7frRPGMCUMhRHbHtJYJNvWYFqSt/spADUA3XSIU17BOVV9PIAhnxIlHO
         oBGSVKcawTimbuFgU9L3cyBdUcy8v7RDaUGScN6rjsTLAULHhkn5HNDfW1NQ45jpqCmw
         ifFEDxAnvLeJqih1HmRIH83KE/NBA3OEdafp4DIAd5gRgpNz5ruLVgpjwTCPICr8zFx9
         Wb2kpYplfqM6H2EvvXAlUdmAYvElkWt/zMuPRkeZ6XOf5g+ivA/j/OATSzuLnGfJejBg
         8ujA==
X-Gm-Message-State: ACrzQf1/5rmLbxKZclyVrm0rMcnv8kSQkjmZJLZyx/KTkVaONOKhMrGi
        8s586otIRJBIoRgTdWFnVjOEFUjRc0HEuwO0yllaS/f66905
X-Google-Smtp-Source: AMsMyM7HzEqOPfosAxzjSIpMd1iL4aYwIL0WtmD6u90nAUUwruIRNNqMWyltZxPuCwQ1k2SfX3oEEko6ercQzCygrk+plCKJdPNl
MIME-Version: 1.0
X-Received: by 2002:a02:9509:0:b0:349:b6cb:9745 with SMTP id
 y9-20020a029509000000b00349b6cb9745mr7844464jah.281.1663580320843; Mon, 19
 Sep 2022 02:38:40 -0700 (PDT)
Date:   Mon, 19 Sep 2022 02:38:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000014512a05e9047a38@google.com>
Subject: [syzbot] WARNING: suspicious RCU usage in evict
From:   syzbot <syzbot+45df7ccc8b5bade4f745@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
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

HEAD commit:    6879c2d3b960 Merge tag 'pinctrl-v6.0-2' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12739ff7080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98a30118ec9215e9
dashboard link: https://syzkaller.appspot.com/bug?extid=45df7ccc8b5bade4f745
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/19b2347a4079/disk-6879c2d3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/51b0418505d4/vmlinux-6879c2d3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+45df7ccc8b5bade4f745@syzkaller.appspotmail.com

loop1: detected capacity change from 0 to 4095
ntfs3: loop1: RAW NTFS volume: Filesystem size 0.00 Gb > volume size 0.00 Gb. Mount in read-only
=============================
WARNING: suspicious RCU usage
6.0.0-rc5-syzkaller-00089-g6879c2d3b960 #0 Not tainted
-----------------------------
include/trace/events/lock.h:69 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
2 locks held by syz-executor.1/7588:
 #0: ffff8880740ce0e0 (&type->s_umount_key#51/1){+.+.}-{3:3}, at: alloc_super+0x22e/0xb60 fs/super.c:228
 #1: ffff888032493df0 (&sb->s_type->i_lock_key#33){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:349 [inline]
 #1: ffff888032493df0 (&sb->s_type->i_lock_key#33){+.+.}-{2:2}, at: inode_wait_for_writeback+0x1a/0x30 fs/fs-writeback.c:1472

stack backtrace:
CPU: 0 PID: 7588 Comm: syz-executor.1 Not tainted 6.0.0-rc5-syzkaller-00089-g6879c2d3b960 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 trace_lock_release include/trace/events/lock.h:69 [inline]
 lock_release.cold+0x1f/0x4e kernel/locking/lockdep.c:5677
 __raw_spin_unlock include/linux/spinlock_api_smp.h:141 [inline]
 _raw_spin_unlock+0x12/0x40 kernel/locking/spinlock.c:186
 evict+0x2b7/0x6b0 fs/inode.c:662
 iput_final fs/inode.c:1748 [inline]
 iput.part.0+0x55d/0x810 fs/inode.c:1774
 iput+0x58/0x70 fs/inode.c:1764
 ntfs_fill_super+0x2e89/0x37f0 fs/ntfs3/super.c:1190
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
RIP: 0033:0x7f27b3c8a93a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f27b4e7ff88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f27b3c8a93a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f27b4e7ffe0
RBP: 00007f27b4e80020 R08: 00007f27b4e80020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f27b4e7ffe0 R15: 0000000020003580
 </TASK>
ntfs3: loop1: Failed to load $UpCase.


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
