Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AA651E2CC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 May 2022 02:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445086AbiEGArP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 20:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240551AbiEGArN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 20:47:13 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407D268FB0
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 17:43:29 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id g16-20020a05660226d000b00638d8e1828bso5939196ioo.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 May 2022 17:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=wtCDZkDN98E3s8Rvyi9bK72R59V9hYQDZojLjD5untI=;
        b=3tgrKnepP8h77wLTHmlXLW03OqS7rU/16fD71HAWjoOJDtiKm2mCUHqgTVsMKfxRIp
         95IT3td+tzAV7sm2qOQ6QPTPSEO0Adx3spJHB8l436d3e6esYUMGGetXnofdaF1MosC6
         UTHCJJvgrnCcbZ5Xl0zodMv23Ncb2od45t4vPAO8BT4IxrWxZb2aCur0sJ3gk8ZT0woH
         QXdvy+pPdveu9wAcIFfWQ4ypawO/sAV9RWByelR7yM/kItDSK+YMi+bJfurnsJl0n+yE
         +phgHMiDVPL5IZ2o/K2r1nNHVAPE0gPQMr0JFtD0EXwZOtGZVlynGiyUBOl+ZehRR+uX
         lBUQ==
X-Gm-Message-State: AOAM531oXh29JUzxY/j89PfwLYpajioq0UFnHyBLDeycFRs2G+M7dnzf
        8Xt/ny74DibMUQpGc1Hl0oXB2SfuI8jDbUAo4G+20EAffT2S
X-Google-Smtp-Source: ABdhPJyjfMOjMyn7ymWcotFpM29cYX2Dn5+dz5A+IVemgkprDI41py6g/HZdPT4fQovzazny9Su46/ABuJwCk5OWffH43TY8Q71D
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c44:b0:2cf:1faa:7044 with SMTP id
 d4-20020a056e021c4400b002cf1faa7044mr2294686ilg.221.1651884208649; Fri, 06
 May 2022 17:43:28 -0700 (PDT)
Date:   Fri, 06 May 2022 17:43:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000777b8605de614360@google.com>
Subject: [syzbot] WARNING: suspicious RCU usage in write_inode_now
From:   syzbot <syzbot+8c4c9140d0ef91aaad3f@syzkaller.appspotmail.com>
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

HEAD commit:    4b97bac0756a Merge tag 'for-5.18-rc5-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=155ed341f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f179a672dc8535fc
dashboard link: https://syzkaller.appspot.com/bug?extid=8c4c9140d0ef91aaad3f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8c4c9140d0ef91aaad3f@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
5.18.0-rc5-syzkaller-00163-g4b97bac0756a #0 Not tainted
-----------------------------
kernel/sched/core.c:9701 Illegal context switch in RCU-bh read-side critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
1 lock held by syz-executor.3/10437:
 #0: ffff88801afc60e0 (&type->s_umount_key#86/1){+.+.}-{3:3}, at: alloc_super+0x1dd/0xa80 fs/super.c:228

stack backtrace:
CPU: 0 PID: 10437 Comm: syz-executor.3 Not tainted 5.18.0-rc5-syzkaller-00163-g4b97bac0756a #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 __might_resched+0x235/0x2c0 kernel/sched/core.c:9701
 write_inode_now+0x14a/0x1d0 fs/fs-writeback.c:2696
 iput_final fs/inode.c:1731 [inline]
 iput.part.0+0x460/0x820 fs/inode.c:1770
 iput+0x58/0x70 fs/inode.c:1760
 ntfs_fill_super+0x2e08/0x37b0 fs/ntfs3/super.c:1178
 get_tree_bdev+0x440/0x760 fs/super.c:1292
 vfs_get_tree+0x89/0x2f0 fs/super.c:1497
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f1ac9a8a61a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1acacb4f88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f1ac9a8a61a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f1acacb4fe0
RBP: 00007f1acacb5020 R08: 00007f1acacb5020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f1acacb4fe0 R15: 000000002007c6a0
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
