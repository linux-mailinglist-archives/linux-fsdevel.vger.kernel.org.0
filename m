Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CBF72E387
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 14:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242313AbjFMM7H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 08:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242239AbjFMM7F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:59:05 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9A910E9
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jun 2023 05:59:03 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-77ac656cae6so628360739f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jun 2023 05:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686661143; x=1689253143;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LKA8FxexwwvC70hYPurkJVa5JRkVVDHMZrRoSRIkU58=;
        b=H9FUYLx4iJl/EFKhdN5PanQevI5EYJXlblXl2AsHNDGZqr+R4En07FveqlzoTrYUd6
         6kmtaZI31VLqBSt2DQgjaQFvkI4zMkHpc5/BN32AbP9rIugIiLwXKC1UM8el8T5NW4xT
         DWsTBADy32BxdxDDoN+OUMm5P0PvHaal4ssiTKs+2DhjDaTMtKP8Xp0lERaDR6grGlSi
         7BWhvRaAl1wKtOSiTDhypPJ0Iz/0JruqfTVyunq2h7t2qoiLAR38msLR9zgiECQLtSfd
         5oue47Lpdami22xIoBKYu6BeXYxbGaYP5MLzj8wALKOj9qDVVjCCZIVw9QTE3Vmi2IZx
         JMUw==
X-Gm-Message-State: AC+VfDxIODBhkdOp/dYKdSiTLtu69uMF0KebbZGmmJo00pmYzdixc3a0
        p3/cxpLtxS2SBvDO3wHs4W+qQNXh8nq6aRMCd2UJxYLiFder
X-Google-Smtp-Source: ACHHUZ46EHDkCLoYSqQIFdGbStBLjoS/R4dSUu2J+UH18DV87WxP7VLfowGnQDZB230sLL3CkLDTmMR5BSvRnrXO9DsgsWHB5yby
MIME-Version: 1.0
X-Received: by 2002:a05:6602:696:b0:77b:26ad:ab1b with SMTP id
 dp22-20020a056602069600b0077b26adab1bmr1027579iob.4.1686661143052; Tue, 13
 Jun 2023 05:59:03 -0700 (PDT)
Date:   Tue, 13 Jun 2023 05:59:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000049c61505fe026632@google.com>
Subject: [syzbot] [udf?] WARNING in __udf_add_aext (2)
From:   syzbot <syzbot+e381e4c52ca8a53c3af7@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    64569520920a Merge tag 'block-6.4-2023-06-09' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=115adb1b280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4
dashboard link: https://syzkaller.appspot.com/bug?extid=e381e4c52ca8a53c3af7
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3239cb3f0553/disk-64569520.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d90e42dca619/vmlinux-64569520.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e0f88764a9f6/bzImage-64569520.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e381e4c52ca8a53c3af7@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 26092 at fs/udf/inode.c:2050 __udf_add_aext+0x550/0x6f0
Modules linked in:
CPU: 1 PID: 26092 Comm: syz-executor.1 Not tainted 6.4.0-rc5-syzkaller-00245-g64569520920a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
RIP: 0010:__udf_add_aext+0x550/0x6f0 fs/udf/inode.c:2049
Code: 4c 89 e7 e8 22 d9 e3 fe 49 8b 3c 24 4c 89 fe e8 06 c5 03 ff 31 c0 48 83 c4 30 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 f0 01 8c fe <0f> 0b e9 ed fb ff ff e8 e4 01 8c fe 0f 0b e9 5c fc ff ff e8 d8 01
RSP: 0018:ffffc900170d6b38 EFLAGS: 00010287
RAX: ffffffff82ff7db0 RBX: 1ffff92002e1ae01 RCX: 0000000000040000
RDX: ffffc90003d61000 RSI: 00000000000109da RDI: 00000000000109db
RBP: 0000000000000000 R08: ffffffff82ff7996 R09: ffffffff82ff78c6
R10: 0000000000000002 R11: ffff88807e450000 R12: ffffc900170d7000
R13: 0000000000000004 R14: dffffc0000000000 R15: ffffc900170d7008
FS:  00007f18bf12b700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200a0000 CR3: 0000000028a6f000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 udf_add_aext fs/udf/inode.c:2107 [inline]
 udf_do_extend_file+0xcb5/0x11e0 fs/udf/inode.c:592
 inode_getblk fs/udf/inode.c:822 [inline]
 udf_map_block+0x16c0/0x4ff0 fs/udf/inode.c:450
 __udf_get_block+0x126/0x410 fs/udf/inode.c:464
 __block_write_begin_int+0x548/0x1a50 fs/buffer.c:2064
 udf_page_mkwrite+0x5b0/0x960 fs/udf/file.c:69
 do_page_mkwrite+0x1a4/0x600 mm/memory.c:2931
 wp_page_shared mm/memory.c:3280 [inline]
 do_wp_page+0x501/0x3690 mm/memory.c:3362
 handle_pte_fault mm/memory.c:4964 [inline]
 __handle_mm_fault mm/memory.c:5089 [inline]
 handle_mm_fault+0x2371/0x5860 mm/memory.c:5243
 do_user_addr_fault arch/x86/mm/fault.c:1440 [inline]
 handle_page_fault arch/x86/mm/fault.c:1534 [inline]
 exc_page_fault+0x7d2/0x910 arch/x86/mm/fault.c:1590
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:rep_stos_alternative+0x40/0x80 arch/x86/lib/clear_page_64.S:96
Code: ff c7 48 ff c9 75 f6 c3 48 89 07 48 83 c7 08 83 e9 08 74 f3 83 f9 08 73 ef eb e2 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 <48> 89 07 48 89 47 08 48 89 47 10 48 89 47 18 48 89 47 20 48 89 47
RSP: 0018:ffffc900170d7af8 EFLAGS: 00050202
RAX: 0000000000000000 RBX: 00000000200a0080 RCX: 0000000000000080
RDX: 0000000000000000 RSI: ffffffff8aea9fa0 RDI: 00000000200a0000
RBP: ffffc900170d7c60 R08: dffffc0000000000 R09: fffffbfff1cabaae
R10: 0000000000000000 R11: dffffc0000000001 R12: 000000002009f080
R13: 0000000000001000 R14: ffffc900170d7d98 R15: 1ffff92002e1afb3
 __clear_user arch/x86/include/asm/uaccess_64.h:174 [inline]
 clear_user arch/x86/include/asm/uaccess_64.h:191 [inline]
 iov_iter_zero+0x1cc/0xf90 lib/iov_iter.c:851
 read_iter_zero+0x88/0x290 drivers/char/mem.c:497
 call_read_iter include/linux/fs.h:1862 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x788/0xb00 fs/read_write.c:470
 ksys_read+0x1a0/0x2c0 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f18be48c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f18bf12b168 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f18be5abf80 RCX: 00007f18be48c169
RDX: 00000000ffffff1c RSI: 0000000020000080 RDI: 0000000000000008
RBP: 00007f18be4e7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe3cfc9e9f R14: 00007f18bf12b300 R15: 0000000000022000
 </TASK>
----------------
Code disassembly (best guess):
   0:	ff c7                	inc    %edi
   2:	48 ff c9             	dec    %rcx
   5:	75 f6                	jne    0xfffffffd
   7:	c3                   	retq
   8:	48 89 07             	mov    %rax,(%rdi)
   b:	48 83 c7 08          	add    $0x8,%rdi
   f:	83 e9 08             	sub    $0x8,%ecx
  12:	74 f3                	je     0x7
  14:	83 f9 08             	cmp    $0x8,%ecx
  17:	73 ef                	jae    0x8
  19:	eb e2                	jmp    0xfffffffd
  1b:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  22:	00 00 00
  25:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
* 2a:	48 89 07             	mov    %rax,(%rdi) <-- trapping instruction
  2d:	48 89 47 08          	mov    %rax,0x8(%rdi)
  31:	48 89 47 10          	mov    %rax,0x10(%rdi)
  35:	48 89 47 18          	mov    %rax,0x18(%rdi)
  39:	48 89 47 20          	mov    %rax,0x20(%rdi)
  3d:	48                   	rex.W
  3e:	89                   	.byte 0x89
  3f:	47                   	rex.RXB


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
