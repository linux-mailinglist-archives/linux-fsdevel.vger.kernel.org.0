Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF997B5DC6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 01:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjJBXjF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 19:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236823AbjJBXjF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 19:39:05 -0400
Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17861B7
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 16:39:01 -0700 (PDT)
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-3af5b5d7ecbso438155b6e.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Oct 2023 16:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696289940; x=1696894740;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4RnMJuCs04fOKcyQhL2Fu4D0apXhz9m3anqYenCpY8E=;
        b=mXj5kjv/sVIzhrpFs1UyKfmlvoZfNUeUW/iHkuhaodMqRe3xMw3Yp3RMgaiLtJPWNl
         A0tAJF5heagaiSEgzFPq9YgR4hTLS7hpr0PDJA7nIrmirLFL2VALnzNovI0MdARDhLpx
         ANvw79VnFNgvKeGCNkwufKmnrXah0mVMlTAVeQPRKIu6nl1OEFOf63w+Fp4hdFTfMjyT
         6cJqxfDVFxNPbt+L4XwsDMMW9P3g7MJNIH+zsRGhRBMarJ8bJNams+DoH8KXJxnMI8wG
         I+kPh7tk7ZFYIonjdqbUYQ6TTy1hRbGfT37PH9FdfRcrHr6O8i2ckB+Ccd/fhDyheupJ
         9KFA==
X-Gm-Message-State: AOJu0YwW9tkJ/f1cG258Q9NdiDVEE6VydP246rom+hTGM+2dDL5XdT4e
        nNLQrXIzBweTnigec6ztv5G0GESDjKnISufM28z7/Q5duF67
X-Google-Smtp-Source: AGHT+IGWiTzZ4GchszPer7X0aTrnRgOwJnQyP0ynygslwtGs047JgllcUYQlVAFYG2PIyEY4rfVpigkSVcGT5z2ObHVdx/K79C4u
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1894:b0:3ab:8526:c222 with SMTP id
 bi20-20020a056808189400b003ab8526c222mr6450539oib.8.1696289940493; Mon, 02
 Oct 2023 16:39:00 -0700 (PDT)
Date:   Mon, 02 Oct 2023 16:39:00 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000056dad80606c447e0@google.com>
Subject: [syzbot] [overlayfs?] general protection fault in ovl_encode_real_fh
From:   syzbot <syzbot+2208f82282740c1c8915@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8a749fd1a872 Linux 6.6-rc4
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=154d1e92680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57da1ac039c4c78a
dashboard link: https://syzkaller.appspot.com/bug?extid=2208f82282740c1c8915
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14877eb2680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b701f6680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fffd72e2263d/disk-8a749fd1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0645b67d82dc/vmlinux-8a749fd1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/135b10b98a67/bzImage-8a749fd1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2208f82282740c1c8915@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc000000001c: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000000e0-0x00000000000000e7]
CPU: 1 PID: 5028 Comm: syz-executor194 Not tainted 6.6.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
RIP: 0010:ovl_encode_real_fh+0x87/0x400 fs/overlayfs/copy_up.c:380
Code: 20 49 c1 ee 03 48 b8 f1 f1 f1 f1 04 f3 f3 f3 49 89 04 1e e8 1b e5 8b fe 48 89 d9 49 8d 9c 24 e0 00 00 00 48 89 d8 48 c1 e8 03 <80> 3c 08 00 74 12 48 89 df e8 0b 61 e6 fe 48 b9 00 00 00 00 00 fc
RSP: 0018:ffffc900039efc80 EFLAGS: 00010202
RAX: 000000000000001c RBX: 00000000000000e0 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8880132ab500
RBP: ffffc900039efd30 R08: ffffffff8302916f R09: 1ffff1100ed51471
R10: dffffc0000000000 R11: ffffed100ed51472 R12: 0000000000000000
R13: ffff8880132ab500 R14: 1ffff9200073df94 R15: ffff888078f34758
FS:  0000555556705380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001000 CR3: 000000001bfb2000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ovl_dentry_to_fid fs/overlayfs/export.c:240 [inline]
 ovl_encode_fh+0x2ac/0xc70 fs/overlayfs/export.c:275
 exportfs_encode_inode_fh fs/exportfs/expfs.c:407 [inline]
 exportfs_encode_fh+0x195/0x490 fs/exportfs/expfs.c:438
 do_sys_name_to_handle fs/fhandle.c:52 [inline]
 __do_sys_name_to_handle_at fs/fhandle.c:116 [inline]
 __se_sys_name_to_handle_at+0x3ad/0x730 fs/fhandle.c:98
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f37d63e4429
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd5eea5b98 EFLAGS: 00000246 ORIG_RAX: 000000000000012f
RAX: ffffffffffffffda RBX: 00007ffd5eea5d68 RCX: 00007f37d63e4429
RDX: 0000000020000300 RSI: 0000000020000240 RDI: 0000000000000003
RBP: 00007f37d6457610 R08: 0000000000001600 R09: 00007ffd5eea5d68
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffd5eea5d58 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ovl_encode_real_fh+0x87/0x400 fs/overlayfs/copy_up.c:380
Code: 20 49 c1 ee 03 48 b8 f1 f1 f1 f1 04 f3 f3 f3 49 89 04 1e e8 1b e5 8b fe 48 89 d9 49 8d 9c 24 e0 00 00 00 48 89 d8 48 c1 e8 03 <80> 3c 08 00 74 12 48 89 df e8 0b 61 e6 fe 48 b9 00 00 00 00 00 fc
RSP: 0018:ffffc900039efc80 EFLAGS: 00010202
RAX: 000000000000001c RBX: 00000000000000e0 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8880132ab500
RBP: ffffc900039efd30 R08: ffffffff8302916f R09: 1ffff1100ed51471
R10: dffffc0000000000 R11: ffffed100ed51472 R12: 0000000000000000
R13: ffff8880132ab500 R14: 1ffff9200073df94 R15: ffff888078f34758
FS:  0000555556705380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001000 CR3: 000000001bfb2000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	20 49 c1             	and    %cl,-0x3f(%rcx)
   3:	ee                   	out    %al,(%dx)
   4:	03 48 b8             	add    -0x48(%rax),%ecx
   7:	f1                   	int1
   8:	f1                   	int1
   9:	f1                   	int1
   a:	f1                   	int1
   b:	04 f3                	add    $0xf3,%al
   d:	f3 f3 49 89 04 1e    	repz xrelease mov %rax,(%r14,%rbx,1)
  13:	e8 1b e5 8b fe       	call   0xfe8be533
  18:	48 89 d9             	mov    %rbx,%rcx
  1b:	49 8d 9c 24 e0 00 00 	lea    0xe0(%r12),%rbx
  22:	00
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1) <-- trapping instruction
  2e:	74 12                	je     0x42
  30:	48 89 df             	mov    %rbx,%rdi
  33:	e8 0b 61 e6 fe       	call   0xfee66143
  38:	48                   	rex.W
  39:	b9 00 00 00 00       	mov    $0x0,%ecx
  3e:	00 fc                	add    %bh,%ah


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

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
