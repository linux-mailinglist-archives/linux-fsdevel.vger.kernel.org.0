Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933BD7941CD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 19:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242231AbjIFRBy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 13:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjIFRBw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 13:01:52 -0400
Received: from mail-pj1-f77.google.com (mail-pj1-f77.google.com [209.85.216.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9F51BB
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 10:01:47 -0700 (PDT)
Received: by mail-pj1-f77.google.com with SMTP id 98e67ed59e1d1-271cf74f2a2so29757a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Sep 2023 10:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694019707; x=1694624507;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wO/DMOQixrOzirrtBiz08hwa7r6rT457sDUykE4i+6s=;
        b=ESfUlk/kt+PzYlNspASvyB3oL9BWvZnnO46UjdHJs6ZvJ7A+qWX8xCbm+DqqFDT+/D
         gUlGqmBbqnWqJQ6PXac6NsucsfXbRapDNYk29YO4Bh5U7ufQvBS+sfFsTQD15N6QsETR
         EoFmA0wvjLc3Eiwehnsx0SNafm7tuNCnUV4yM7JiGoaPje+43kw1kXVnSwGISPm9ur0n
         Rk4AdJXiwpDy+tKcp/9B5cQnD8i0qFDyxcpJNktLWnfyymIXQRdWNGAbvlLfTNJ7/mCu
         ecLjAY/Hsj3/h6UnE9G2z3rckYhTj/zUKBgkXAy5EMx2O9NGJswURxe19TuQ2DovBmPZ
         BH+Q==
X-Gm-Message-State: AOJu0YyPcP5sQXF/StyowtARomVbh2kWQqeYkbGoD8UOSIPiqwN7wOxy
        YANyXgX4SGbMqLMSEprTZHo4yZQxPvqaqA/nnyKs9xcZ26WlUDCMrA==
X-Google-Smtp-Source: AGHT+IGglEblvwtvK3A8mamDtUWf14NKi2KDnm+oupK+T4Xc2355iTpBXThgPOc6NI7ptecX8WTqjy1ny7KMaooTH6Xs3+0zfXnn
MIME-Version: 1.0
X-Received: by 2002:a17:90b:150:b0:26d:87c:c831 with SMTP id
 em16-20020a17090b015000b0026d087cc831mr3952003pjb.6.1694019706882; Wed, 06
 Sep 2023 10:01:46 -0700 (PDT)
Date:   Wed, 06 Sep 2023 10:01:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000df10660604b3b2e1@google.com>
Subject: [syzbot] [reiserfs?] divide error in flush_journal_list (2)
From:   syzbot <syzbot+b933ce9cda6c5c8ac3f4@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0468be89b3fa Merge tag 'iommu-updates-v6.6' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16bfd224680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d78b3780d210e21
dashboard link: https://syzkaller.appspot.com/bug?extid=b933ce9cda6c5c8ac3f4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f3914b539822/disk-0468be89.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6128b0644784/vmlinux-0468be89.xz
kernel image: https://storage.googleapis.com/syzbot-assets/349d98668c3a/bzImage-0468be89.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b933ce9cda6c5c8ac3f4@syzkaller.appspotmail.com

divide error: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 6731 Comm: syz-executor.2 Not tainted 6.5.0-syzkaller-10885-g0468be89b3fa #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:flush_journal_list+0x1045/0x1c70 fs/reiserfs/journal.c:1592
Code: c0 0f 85 eb 0a 00 00 4f 8d 7c 3e 02 48 89 e8 48 c1 e8 03 42 0f b6 04 20 84 c0 4d 89 e6 0f 85 ee 0a 00 00 8b 0b 4c 89 f8 31 d2 <48> f7 f1 48 89 d3 43 0f b6 44 35 00 84 c0 0f 85 f2 0a 00 00 48 8b
RSP: 0018:ffffc9001605f1f8 EFLAGS: 00010246
RAX: 00000000000000bd RBX: ffff888038e84014 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff888038e84017 R08: ffffffff8236f8fb R09: 1ffff11007cd8e63
R10: dffffc0000000000 R11: ffffed1007cd8e64 R12: dffffc0000000000
R13: 1ffff11010333c97 R14: dffffc0000000000 R15: 00000000000000bd
FS:  00007f4d273776c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055555597d978 CR3: 000000007d829000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 flush_used_journal_lists+0x1256/0x15d0 fs/reiserfs/journal.c:1829
 do_journal_end+0x39fb/0x4780
 do_journal_begin_r+0x970/0x1020
 journal_begin+0x14c/0x360 fs/reiserfs/journal.c:3260
 reiserfs_fill_super+0x1853/0x2620 fs/reiserfs/super.c:2104
 mount_bdev+0x237/0x300 fs/super.c:1629
 legacy_get_tree+0xef/0x190 fs/fs_context.c:638
 vfs_get_tree+0x8c/0x280 fs/super.c:1750
 do_new_mount+0x28f/0xae0 fs/namespace.c:3335
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4d2667e1ea
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4d27376ee8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f4d27376f80 RCX: 00007f4d2667e1ea
RDX: 00000000200000c0 RSI: 0000000020000040 RDI: 00007f4d27376f40
RBP: 00000000200000c0 R08: 00007f4d27376f80 R09: 0000000000008000
R10: 0000000000008000 R11: 0000000000000202 R12: 0000000020000040
R13: 00007f4d27376f40 R14: 0000000000001126 R15: 0000000020000300
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:flush_journal_list+0x1045/0x1c70 fs/reiserfs/journal.c:1592
Code: c0 0f 85 eb 0a 00 00 4f 8d 7c 3e 02 48 89 e8 48 c1 e8 03 42 0f b6 04 20 84 c0 4d 89 e6 0f 85 ee 0a 00 00 8b 0b 4c 89 f8 31 d2 <48> f7 f1 48 89 d3 43 0f b6 44 35 00 84 c0 0f 85 f2 0a 00 00 48 8b
RSP: 0018:ffffc9001605f1f8 EFLAGS: 00010246
RAX: 00000000000000bd RBX: ffff888038e84014 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff888038e84017 R08: ffffffff8236f8fb R09: 1ffff11007cd8e63
R10: dffffc0000000000 R11: ffffed1007cd8e64 R12: dffffc0000000000
R13: 1ffff11010333c97 R14: dffffc0000000000 R15: 00000000000000bd
FS:  00007f4d273776c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200016c0 CR3: 000000007d829000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	c0 0f 85             	rorb   $0x85,(%rdi)
   3:	eb 0a                	jmp    0xf
   5:	00 00                	add    %al,(%rax)
   7:	4f 8d 7c 3e 02       	lea    0x2(%r14,%r15,1),%r15
   c:	48 89 e8             	mov    %rbp,%rax
   f:	48 c1 e8 03          	shr    $0x3,%rax
  13:	42 0f b6 04 20       	movzbl (%rax,%r12,1),%eax
  18:	84 c0                	test   %al,%al
  1a:	4d 89 e6             	mov    %r12,%r14
  1d:	0f 85 ee 0a 00 00    	jne    0xb11
  23:	8b 0b                	mov    (%rbx),%ecx
  25:	4c 89 f8             	mov    %r15,%rax
  28:	31 d2                	xor    %edx,%edx
* 2a:	48 f7 f1             	div    %rcx <-- trapping instruction
  2d:	48 89 d3             	mov    %rdx,%rbx
  30:	43 0f b6 44 35 00    	movzbl 0x0(%r13,%r14,1),%eax
  36:	84 c0                	test   %al,%al
  38:	0f 85 f2 0a 00 00    	jne    0xb30
  3e:	48                   	rex.W
  3f:	8b                   	.byte 0x8b


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
