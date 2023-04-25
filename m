Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDC16EE610
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 18:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbjDYQtI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 12:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234701AbjDYQtH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:49:07 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A13161B7
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Apr 2023 09:49:02 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-76359b8d29dso956655239f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Apr 2023 09:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682441342; x=1685033342;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mvlu2S6IOj0P66TUGmZILlb9E1nqtEeM3M9ymLjgqa0=;
        b=AKTVZE+604AsJyvE08oWBnlhz1YkkDt13W0J12/k7EyqV1NA0E7c2pGlLpuf/hTmJj
         Tv/plcTi+GMoWhgp1xL74dZcL2mls1rRL16Kcph5uGx2RPOCS+h2smq2huoOPu+QXwfE
         //tLmolMMtUxcbx+2tGlr7A57pTAniD6j3frSTuQyUrQG6FQc74oZN9LiHkaoXbU/Uek
         X3M1tD5GeetB2PDekgljOhIbKK2yOZg0KEGb8zH9mafj1z0hUKGd0KiHGxgskvIWvF2k
         df20fGK+X1p/NfZBQfOeiiF3cQRcTJOTLzMPS0uwDqJmss2E/nbM5A31p2Y2pkE4v/00
         I/WA==
X-Gm-Message-State: AAQBX9dDhOtiwZOJECDclWY7QiSNJbK9zJeLUaKhhApRlyTETcWH529G
        pexq2xZioJCGphw2tz0vSa3FGIVrYuLpnvO4JRG8MCAZ2+G/
X-Google-Smtp-Source: AKy350b+GZPyDeJcZB0TQ5O5WE7vay9NPoF6gobFS/+212QAsO0QFx6Pr3opvz59pXBSW+RUWoYoLJf2arXpwRJmoAtf75RDaf/I
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3285:b0:761:22af:1e3f with SMTP id
 d5-20020a056602328500b0076122af1e3fmr7113021ioz.3.1682441341846; Tue, 25 Apr
 2023 09:49:01 -0700 (PDT)
Date:   Tue, 25 Apr 2023 09:49:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000894c7e05fa2be628@google.com>
Subject: [syzbot] [ntfs3?] WARNING in evict
From:   syzbot <syzbot+6310a7df6baca255f9cc@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2af3e53a4dc0 Merge tag 'drm-fixes-2023-04-21' of git://ano..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12f3bf57c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4afb87f3ec27b7fd
dashboard link: https://syzkaller.appspot.com/bug?extid=6310a7df6baca255f9cc
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/845f21360f64/disk-2af3e53a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3b9925dc3504/vmlinux-2af3e53a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/021758261c12/bzImage-2af3e53a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6310a7df6baca255f9cc@syzkaller.appspotmail.com

loop5: detected capacity change from 0 to 4096
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 4955 at kernel/locking/lockdep.c:232 hlock_class kernel/locking/lockdep.c:232 [inline]
WARNING: CPU: 0 PID: 4955 at kernel/locking/lockdep.c:232 mark_lock+0x14c/0x340 kernel/locking/lockdep.c:4613
Modules linked in:
CPU: 0 PID: 4955 Comm: syz-executor.5 Not tainted 6.3.0-rc7-syzkaller-00152-g2af3e53a4dc0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
RIP: 0010:hlock_class kernel/locking/lockdep.c:232 [inline]
RIP: 0010:mark_lock+0x14c/0x340 kernel/locking/lockdep.c:4613
Code: 03 42 0f b6 04 28 84 c0 0f 85 d2 01 00 00 83 3d 01 fd e8 0c 00 75 9d 48 c7 c7 40 7c ea 8a 48 c7 c6 e0 7e ea 8a e8 14 fb e7 ff <0f> 0b eb 86 e8 7b 47 ff ff 85 c0 0f 84 33 01 00 00 45 89 f6 4c 89
RSP: 0000:ffffc90005487778 EFLAGS: 00010046
RAX: 15fb29a09693de00 RBX: 0000000000001b00 RCX: 0000000000040000
RDX: ffffc9000e3ef000 RSI: 0000000000007ab5 RDI: 0000000000007ab6
RBP: 0000000000000002 R08: ffffffff81528022 R09: ffffed101730515b
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff888046b9c4b0
R13: dffffc0000000000 R14: 0000000000000004 R15: ffff888046b9c4df
FS:  00007f42a5e55700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7ddc767000 CR3: 0000000053d39000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mark_usage kernel/locking/lockdep.c:4544 [inline]
 __lock_acquire+0xc0d/0x1f80 kernel/locking/lockdep.c:5010
 lock_acquire+0x1e1/0x520 kernel/locking/lockdep.c:5669
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:350 [inline]
 inode_sb_list_del fs/inode.c:503 [inline]
 evict+0x161/0x620 fs/inode.c:654
 ntfs_fill_super+0x3ffc/0x47f0 fs/ntfs3/super.c:1239
 get_tree_bdev+0x402/0x620 fs/super.c:1303
 vfs_get_tree+0x8c/0x270 fs/super.c:1510
 do_new_mount+0x28f/0xae0 fs/namespace.c:3042
 do_mount fs/namespace.c:3385 [inline]
 __do_sys_mount fs/namespace.c:3594 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3571
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f42a508d69a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f42a5e54f88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 000000000001f6cc RCX: 00007f42a508d69a
RDX: 000000002001f700 RSI: 000000002001f740 RDI: 00007f42a5e54fe0
RBP: 00007f42a5e55020 R08: 00007f42a5e55020 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 000000002001f700
R13: 000000002001f740 R14: 00007f42a5e54fe0 R15: 000000002001f780
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
