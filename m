Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B297A702D3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 14:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241846AbjEOM5e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 08:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242042AbjEOM5K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 08:57:10 -0400
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47211BC7
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 05:56:56 -0700 (PDT)
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3352698e6e6so64174425ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 05:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684155416; x=1686747416;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lBrVM5vmUfrnVSMRAOraV9dR/Tsb1O86cQHaXY5501A=;
        b=EiCRmckrEqcDfy/sNJOkNjlGKr7mwbn/IxsXAkfXZwxhAu5RuABhJJogk94/U/sSCJ
         wRUbPM4FA+GtVxSGCIkJ5o1r7qnhuY7ELbFYeese5xXzqELLq3oGT2Zv75qARjsyD4tP
         Flnw8h5wXg157SZdQLlb9/pydme+u07lnjarQavwE0qdxxwp1czbq0s8wZzNDg4d4IJ2
         vTycEtRUA6rDGAWyWG8oruEgkxXGBIhG3/2TKERBzxAoTTx9LcWmQjrwF2Y96QFJWQZP
         sOWaEMhBulJDVcmav2i9iHgyQEWyRsqKpp70s191CNQACdkmrdW0Dg7jemrUs9f0miwo
         /rQg==
X-Gm-Message-State: AC+VfDw8bUHw9BirSNQMneGsc7y+BgxETg2d8sXcd1BYKNGjARLjCUzq
        GHP6ZWMgXlyK62uB77cdqobTJIoV9BHdFF/yYEoxOvGskZ3M
X-Google-Smtp-Source: ACHHUZ5m8IV6avZoGqCM2loZguQq890l0hao/iR49SVkW2gi4/0ebSMPMvV0n4FFcSr4odiz7um92fLYH0NITCXVyBHk61eeXhPn
MIME-Version: 1.0
X-Received: by 2002:a92:d5cb:0:b0:337:41d3:4d9e with SMTP id
 d11-20020a92d5cb000000b0033741d34d9emr3477815ilq.6.1684155416194; Mon, 15 May
 2023 05:56:56 -0700 (PDT)
Date:   Mon, 15 May 2023 05:56:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005434c405fbbafdc5@google.com>
Subject: [syzbot] [nilfs?] WARNING in nilfs_segctor_do_construct (2)
From:   syzbot <syzbot+33494cd0df2ec2931851@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    9a48d6046722 x86/retbleed: Fix return thunk alignment
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=121a54ba280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=38526bf24c8d961b
dashboard link: https://syzkaller.appspot.com/bug?extid=33494cd0df2ec2931851
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1438dcc6280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124666a2280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9151d600da35/disk-9a48d604.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/895748ad0a36/vmlinux-9a48d604.xz
kernel image: https://storage.googleapis.com/syzbot-assets/826ceb18c361/bzImage-9a48d604.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/32bae60be5eb/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+33494cd0df2ec2931851@syzkaller.appspotmail.com

NILFS (loop1): nilfs_sufile_update: invalid segment number: 52
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5017 at fs/nilfs2/segment.c:1503 nilfs_segctor_collect fs/nilfs2/segment.c:1556 [inline]
WARNING: CPU: 0 PID: 5017 at fs/nilfs2/segment.c:1503 nilfs_segctor_do_construct+0x31e7/0x6d30 fs/nilfs2/segment.c:2070
Modules linked in:

CPU: 0 PID: 5017 Comm: segctord Not tainted 6.4.0-rc1-syzkaller-00133-g9a48d6046722 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/28/2023
RIP: 0010:nilfs_segctor_truncate_segments fs/nilfs2/segment.c:1503 [inline]
RIP: 0010:nilfs_segctor_collect fs/nilfs2/segment.c:1556 [inline]
RIP: 0010:nilfs_segctor_do_construct+0x31e7/0x6d30 fs/nilfs2/segment.c:2070
Code: ff df 80 3c 08 00 74 08 4c 89 ef e8 03 fb 93 fe 4d 8b 6d 00 4c 3b 6c 24 50 74 31 e8 13 2d 3c fe e9 39 ff ff ff e8 09 2d 3c fe <0f> 0b eb c3 44 89 e1 80 e1 07 80 c1 03 38 c1 0f 8c 44 ff ff ff 4c
RSP: 0018:ffffc90003b7f700 EFLAGS: 00010293

RAX: ffffffff834f3a37 RBX: 00000000ffffffea RCX: ffff888027728000
RDX: 0000000000000000 RSI: 00000000ffffffea RDI: 0000000000000000
RBP: ffffc90003b7fc30 R08: ffffffff834f39f5 R09: fffff5200076fe51
R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000010
R13: ffff888076756dc8 R14: dffffc0000000000 R15: ffff8880765d4e38
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020074000 CR3: 0000000029d7c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nilfs_segctor_construct+0x145/0x8c0 fs/nilfs2/segment.c:2404
 nilfs_segctor_thread_construct fs/nilfs2/segment.c:2512 [inline]
 nilfs_segctor_thread+0x53a/0x1140 fs/nilfs2/segment.c:2595
 kthread+0x2b8/0x350 kernel/kthread.c:379
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
