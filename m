Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FB655E7F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 18:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347058AbiF1N7m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 09:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347078AbiF1N7d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:59:33 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EABF3616C
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 06:59:32 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id y22-20020a056602215600b00673b11a9cd5so7186694ioy.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 06:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=E2+U8OF/pog3csJphrWthsovGMahCgllDrlHPc5pF+w=;
        b=IWddoJTVkES0Bhfu+qriSsr9ulom6+rX7Q2rxjZN5u03Tu3hVE2uY71ZzzXcWTmAz2
         wa4hgTmo8jTzpfp+myjglpFoPN6J2A68Nonvz+TYELVCqLlTZ0ZoQkh81SxYC/wQeWgk
         0ZEz7hgtHDr3wj9XC9VOn2Y2mFvaeM9Y2LctU/k6uZ6nM5QEJ4CpH419s5QiyDIe1hlK
         s2CZ/heX9nhoGqb1hZWIs7HDoNNPE+zf0Mx9NYyRLupBH49PRXQLs0tc81K0wHOOoeIo
         RSFViWgfbiu/yBLqHEKNLRliCBAqN1Mdm8JijSV/uJlMIxJBvS3wBFetE1KEKKZwrgIX
         +56Q==
X-Gm-Message-State: AJIora+1sS8eQZp5u0iEj/DoAuwiqzdVhEeDX9xE1u1g0qMLI1WLMITn
        He0VOMk6sEwr+aAPMsoQgjJfgYF0aOxDYcR/qkQOY5k3otk9
X-Google-Smtp-Source: AGRyM1usDYMoOgbHdXwfX/aASldGIsoLJZUtyK0Cn/IpSgEyJQ1sw6h4/0c+yih+RoA+BVib0DQ3a34wcC3aTwsn9wbbIagTSib5
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1483:b0:33c:b70d:49ce with SMTP id
 j3-20020a056638148300b0033cb70d49cemr2477588jak.274.1656424771885; Tue, 28
 Jun 2022 06:59:31 -0700 (PDT)
Date:   Tue, 28 Jun 2022 06:59:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000201fb205e2827215@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in writeback_single_inode
From:   syzbot <syzbot+0b42ea2ab0439e55e88a@syzkaller.appspotmail.com>
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

HEAD commit:    08897940f458 Add linux-next specific files for 20220623
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14e5f0d4080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fb185a52c6ad0a8e
dashboard link: https://syzkaller.appspot.com/bug?extid=0b42ea2ab0439e55e88a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0b42ea2ab0439e55e88a@syzkaller.appspotmail.com

ntfs3: loop3: RAW NTFS volume: Filesystem size 0.00 Gb > volume size 0.00 Gb. Mount in read-only
ntfs3: loop3: failed to read volume at offset 0x101000
ntfs3: loop3: failed to read volume at offset 0x101000
ntfs3: loop3: failed to read volume at offset 0x101000
ntfs3: loop3: failed to read volume at offset 0x101000
ntfs3: loop3: failed to read volume at offset 0x102000
ntfs3: loop3: failed to read volume at offset 0x103000
ntfs3: loop3: failed to read volume at offset 0x105000
ntfs3: loop3: failed to read volume at offset 0x109000
BUG: unable to handle page fault for address: ffffffffffffff89
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD ba8f067 P4D ba8f067 PUD ba91067 PMD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 20039 Comm: syz-executor.3 Not tainted 5.19.0-rc3-next-20220623-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
RIP: 0010:_raw_spin_lock+0x29/0x40 kernel/locking/spinlock.c:154
Code: cc 55 48 89 fd bf 01 00 00 00 e8 a2 10 d3 f7 45 31 c9 41 b8 01 00 00 00 31 c9 ff 74 24 08 48 8d 7d 18 31 d2 31 f6 e8 76 61 df <f7> 48 89 ef 58 5d e9 dc d6 df f7 66 66 2e 0f 1f 84 00 00 00 00 00
RSP: 0018:ffffc900122879e8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 1ffff92002450f49 RCX: ffffffff815e31ae
RDX: 1ffff11009570c41 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffff88807259e2b8 R08: 0000000000000000 R09: ffffffff906a9a8f
R10: fffffbfff20d5351 R11: 0000000000000001 R12: ffffc90012287a78
R13: ffff88807259e438 R14: ffff88807259e2b8 R15: ffff88807259e308
FS:  00007fc865f22700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffff89 CR3: 000000001f931000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 spin_lock include/linux/spinlock.h:360 [inline]
 writeback_single_inode+0x2f/0x4c0 fs/fs-writeback.c:1677
 write_inode_now+0x16a/0x1e0 fs/fs-writeback.c:2724
 iput_final fs/inode.c:1735 [inline]
 iput.part.0+0x460/0x820 fs/inode.c:1774
 iput+0x58/0x70 fs/inode.c:1764
 ntfs_fill_super+0x2284/0x3730 fs/ntfs3/super.c:1271
 get_tree_bdev+0x4a2/0x7e0 fs/super.c:1294
 vfs_get_tree+0x89/0x2f0 fs/super.c:1501
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7fc864e8a63a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc865f21f88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007fc864e8a63a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fc865f21fe0
RBP: 00007fc865f22020 R08: 00007fc865f22020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000
R13: 0000000020000100 R14: 00007fc865f21fe0 R15: 000000002007a980
 </TASK>
Modules linked in:
CR2: ffffffffffffff89
---[ end trace 0000000000000000 ]---
RIP: 0010:__raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
RIP: 0010:_raw_spin_lock+0x29/0x40 kernel/locking/spinlock.c:154
Code: cc 55 48 89 fd bf 01 00 00 00 e8 a2 10 d3 f7 45 31 c9 41 b8 01 00 00 00 31 c9 ff 74 24 08 48 8d 7d 18 31 d2 31 f6 e8 76 61 df <f7> 48 89 ef 58 5d e9 dc d6 df f7 66 66 2e 0f 1f 84 00 00 00 00 00
RSP: 0018:ffffc900122879e8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 1ffff92002450f49 RCX: ffffffff815e31ae
RDX: 1ffff11009570c41 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffff88807259e2b8 R08: 0000000000000000 R09: ffffffff906a9a8f
R10: fffffbfff20d5351 R11: 0000000000000001 R12: ffffc90012287a78
R13: ffff88807259e438 R14: ffff88807259e2b8 R15: ffff88807259e308
FS:  00007fc865f22700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffff89 CR3: 000000001f931000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
