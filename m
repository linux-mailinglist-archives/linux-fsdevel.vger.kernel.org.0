Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29EF6FC1BA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 10:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbjEII1L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 04:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbjEII0x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 04:26:53 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFEF2102
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 01:26:50 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-32b5ec09cf8so36968875ab.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 May 2023 01:26:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683620809; x=1686212809;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6gRQ+bBEPt3ONaSQSYDvf6z2/bd3vD1FUSmzfa/Tgro=;
        b=KczLNcHGsAe2aCTxsC+toj9b38Kixb77Q5iKw31jaDAqRlSi1XS0vYm0k+BCt2/3pr
         gYxQqcj3p4K4RT2D5gnix+VLee+caqHQbVALQJHa1izVWXHTci99J3h2KATU3bUOJHoa
         z/W5cCNdIB4l4fcpJw7J2NA0s6kJdGmgNL8nO51vVRBi2krWvdC1ib+9WX8w7HINLcjx
         5brHtvQ4nEPu+mOushkXlkIBk9H/r8+hmg9j2cug/giYKfOlHdbnD03cKaELGDbl5RwV
         BglClRP/ObYuvRIiX1L1eJVLsi6SkMAg1xwTcgjUWY1Q4zED6mi1MJ9C17nGMMdQWIVI
         +udQ==
X-Gm-Message-State: AC+VfDxA5eIsOkHvIJmawU/lwf3l9IMDuF7Zu3KEflc+IEjulqidnkAe
        wXCqUZo42XbngUFfpMOBnthhGUum/5AIdVvDrzzuW4bmgxIvk4k=
X-Google-Smtp-Source: ACHHUZ5ThNyKBQb9/5WAb2YAnSQdYFpyFUPbJVqIr1PvKd9nqenB2hISCe+WSKmQ7G8OSSmL5tZH5x6Eg/IEVOKswX5YdbXiyuhk
MIME-Version: 1.0
X-Received: by 2002:a92:dc11:0:b0:335:479a:8eba with SMTP id
 t17-20020a92dc11000000b00335479a8ebamr3431503iln.4.1683620809637; Tue, 09 May
 2023 01:26:49 -0700 (PDT)
Date:   Tue, 09 May 2023 01:26:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b8a1505fb3e84ac@google.com>
Subject: [syzbot] [hfs?] kernel BUG in __filemap_get_folio (2)
From:   syzbot <syzbot+8fab910f890e17016919@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3c4aa4434377 Merge tag 'ceph-for-6.4-rc1' of https://githu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=170c6870280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87f9126139666d37
dashboard link: https://syzkaller.appspot.com/bug?extid=8fab910f890e17016919
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-3c4aa443.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1c522f5ebcfe/vmlinux-3c4aa443.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b923244383b5/bzImage-3c4aa443.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8fab910f890e17016919@syzkaller.appspotmail.com

 kswapd+0x677/0xd60 mm/vmscan.c:7727
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
------------[ cut here ]------------
kernel BUG at include/linux/mm.h:996!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 2 PID: 5174 Comm: syz-executor.3 Not tainted 6.3.0-syzkaller-13091-g3c4aa4434377 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:put_page_testzero include/linux/mm.h:996 [inline]
RIP: 0010:folio_put_testzero include/linux/mm.h:1002 [inline]
RIP: 0010:folio_put include/linux/mm.h:1429 [inline]
RIP: 0010:__filemap_get_folio+0x8e2/0x990 mm/filemap.c:1937
Code: e8 b3 20 d3 ff 48 c7 c6 00 b2 56 8a 4c 89 e7 e8 d4 a6 0e 00 0f 0b e8 9d 20 d3 ff 48 c7 c6 00 b2 56 8a 4c 89 e7 e8 be a6 0e 00 <0f> 0b e8 87 20 d3 ff 4c 89 e7 49 c7 c4 f5 ff ff ff e8 f8 44 03 00
RSP: 0018:ffffc900038579a0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
RDX: ffff888016a38000 RSI: ffffffff81b13d42 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff8e7a71d7
R10: fffffbfff1cf4e3a R11: 0000000000000000 R12: ffffea00007e5b80
R13: ffff8880734a4480 R14: 0000000000000000 R15: ffffea00007e5bb4
FS:  0000000000000000(0000) GS:ffff88802c800000(0063) knlGS:00000000581dd380
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f734e1b0 CR3: 0000000071e9b000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 truncate_inode_pages_range+0x350/0xf10 mm/truncate.c:377
 hfs_evict_inode+0x1a/0x100 fs/hfs/inode.c:563
 evict+0x2ed/0x6b0 fs/inode.c:665
 iput_final fs/inode.c:1747 [inline]
 iput.part.0+0x50a/0x740 fs/inode.c:1773
 iput+0x5c/0x80 fs/inode.c:1763
 hfs_btree_close+0x282/0x390 fs/hfs/btree.c:158
 hfs_mdb_put+0xbf/0x380 fs/hfs/mdb.c:360
 generic_shutdown_super+0x158/0x480 fs/super.c:500
 kill_block_super+0xa1/0x100 fs/super.c:1407
 deactivate_locked_super+0x98/0x160 fs/super.c:331
 deactivate_super+0xb1/0xd0 fs/super.c:362
 cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1177
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 __do_fast_syscall_32+0x72/0xf0 arch/x86/entry/common.c:181
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82
RIP: 0023:0xf7fa7579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffa4afdc EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ffa4b080 RCX: 000000000000000a
RDX: 00000000f734e000 RSI: 0000000000000000 RDI: 00000000f72a2535
RBP: 00000000ffa4b080 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:put_page_testzero include/linux/mm.h:996 [inline]
RIP: 0010:folio_put_testzero include/linux/mm.h:1002 [inline]
RIP: 0010:folio_put include/linux/mm.h:1429 [inline]
RIP: 0010:__filemap_get_folio+0x8e2/0x990 mm/filemap.c:1937
Code: e8 b3 20 d3 ff 48 c7 c6 00 b2 56 8a 4c 89 e7 e8 d4 a6 0e 00 0f 0b e8 9d 20 d3 ff 48 c7 c6 00 b2 56 8a 4c 89 e7 e8 be a6 0e 00 <0f> 0b e8 87 20 d3 ff 4c 89 e7 49 c7 c4 f5 ff ff ff e8 f8 44 03 00
RSP: 0018:ffffc900038579a0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
RDX: ffff888016a38000 RSI: ffffffff81b13d42 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff8e7a71d7
R10: fffffbfff1cf4e3a R11: 0000000000000000 R12: ffffea00007e5b80
R13: ffff8880734a4480 R14: 0000000000000000 R15: ffffea00007e5bb4
FS:  0000000000000000(0000) GS:ffff88802c900000(0063) knlGS:00000000581dd380
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f737c0c4 CR3: 0000000071e9b000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	retq
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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
