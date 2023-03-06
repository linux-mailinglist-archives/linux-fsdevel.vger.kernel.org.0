Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADEA6ACB4D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 18:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjCFRv6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 12:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjCFRvz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:51:55 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCD36C692
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Mar 2023 09:51:29 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id h1-20020a92d841000000b0031b4d3294dfso4703050ilq.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Mar 2023 09:51:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678125048;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ilKUAYLn8R2vOICi1lZq/0lhun6w59STk70s21GyZ2Q=;
        b=dc/hAqEk8p5UG4p4rliQ1GSN1lb0sbiGsKIhGbNEasr6QcClxwMJrUeq6ADzj86WW2
         B5ISBEhgg01BGu9yfmnl7k6DmfglmLy/YoJlNPnT6O9XTPk6c/K2aI1vDAwXkeUHfHKN
         t08zFl0cR9Scj3XIog56g/4Lw9p86QpSb0WGMiPG0USemFX2i9r2pJs384025tuVsiUv
         8Cv4vERVW3caNETypA2AJIIIU1Xb6hfD0YX2jQvWBprEy/HiGjOkgk8O4dnrLiDfk1jX
         0uGI4NPHWjHRh4vYJNxDSp9bmmVU0esJGHNgeQoOukkMf7NMaAP7Zn9nBdZ3orZV2gBu
         Kd8g==
X-Gm-Message-State: AO0yUKUD43zVRf617XZAYzDincyCsQR0bv++vrqq0A21rzw8s2Z3YZb7
        oG/Lf8VuXvbBuHBMgkJw0w6QbJWjXg58xsAZTxteexrYAB5A
X-Google-Smtp-Source: AK7set9hBaLu3ElRXqalmX9heSoLdNdlJNNCsqND2gr8vASXJzE77x16CX+q6knEClA5pGEvc2KJJBsqkIONLFW59lFvPxiJ4S8L
MIME-Version: 1.0
X-Received: by 2002:a5d:9490:0:b0:74e:3d27:f013 with SMTP id
 v16-20020a5d9490000000b0074e3d27f013mr564561ioj.3.1678125048517; Mon, 06 Mar
 2023 09:50:48 -0800 (PST)
Date:   Mon, 06 Mar 2023 09:50:48 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000067da6205f63eefd8@google.com>
Subject: [syzbot] [nilfs?] general protection fault in nilfs_flush_segment
From:   syzbot <syzbot+84266b9546515bac1d92@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b01fe98d34f3 Merge tag 'i2c-for-6.3-rc1-part2' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12e50d22c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dc0f7cfe5b32efe2
dashboard link: https://syzkaller.appspot.com/bug?extid=84266b9546515bac1d92
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a1d37240ef5e/disk-b01fe98d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3727e84b1762/vmlinux-b01fe98d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0d45494f57a4/bzImage-b01fe98d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+84266b9546515bac1d92@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000045: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000228-0x000000000000022f]
CPU: 0 PID: 16242 Comm: syz-executor.5 Not tainted 6.2.0-syzkaller-13534-gb01fe98d34f3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
RIP: 0010:nilfs_flush_segment+0x55/0x3d0 fs/nilfs2/segment.c:2155
Code: 06 00 00 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 5c 85 8d fe 4c 8b 3b 49 8d af 28 02 00 00 48 89 e8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 ef e8 3c 85 8d fe 4c 8b 75 00 4d 85 f6
RSP: 0018:ffffc90012a06ad8 EFLAGS: 00010202
RAX: 0000000000000045 RBX: ffff88807ce40678 RCX: 0000000000040000
RDX: ffffc9000bc59000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: 0000000000000228 R08: ffffffff8350bbe7 R09: fffffbfff209e04c
R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000002
R13: dffffc0000000000 R14: ffff888042ba34c0 R15: 0000000000000000
FS:  00007f153c7b4700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555555b70888 CR3: 00000000229d8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nilfs_writepage+0x1c5/0x220 fs/nilfs2/inode.c:201
 writeout mm/migrate.c:907 [inline]
 fallback_migrate_folio mm/migrate.c:931 [inline]
 move_to_new_folio+0x7a1/0x14d0 mm/migrate.c:981
 migrate_folio_move mm/migrate.c:1295 [inline]
 migrate_pages_batch mm/migrate.c:1827 [inline]
 migrate_pages+0x4c0b/0x6670 mm/migrate.c:1979
 compact_zone+0x2bc9/0x45a0 mm/compaction.c:2420
 compact_node+0x216/0x420 mm/compaction.c:2717
 compact_nodes mm/compaction.c:2730 [inline]
 sysctl_compaction_handler+0xab/0x150 mm/compaction.c:2774
 proc_sys_call_handler+0x545/0x8a0 fs/proc/proc_sysctl.c:604
 do_iter_write+0x6ea/0xc50 fs/read_write.c:861
 iter_file_splice_write+0x843/0xfe0 fs/splice.c:778
 do_splice_from fs/splice.c:856 [inline]
 direct_splice_actor+0xe7/0x1c0 fs/splice.c:1023
 splice_direct_to_actor+0x4c4/0xbd0 fs/splice.c:978
 do_splice_direct+0x283/0x3d0 fs/splice.c:1066
 do_sendfile+0x620/0xff0 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f153ba8c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f153c7b4168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f153bbac050 RCX: 00007f153ba8c0f9
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000009
RBP: 00007f153bae7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000264 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd8b8813cf R14: 00007f153c7b4300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:nilfs_flush_segment+0x55/0x3d0 fs/nilfs2/segment.c:2155
Code: 06 00 00 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 5c 85 8d fe 4c 8b 3b 49 8d af 28 02 00 00 48 89 e8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 ef e8 3c 85 8d fe 4c 8b 75 00 4d 85 f6
RSP: 0018:ffffc90012a06ad8 EFLAGS: 00010202
RAX: 0000000000000045 RBX: ffff88807ce40678 RCX: 0000000000040000
RDX: ffffc9000bc59000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: 0000000000000228 R08: ffffffff8350bbe7 R09: fffffbfff209e04c
R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000002
R13: dffffc0000000000 R14: ffff888042ba34c0 R15: 0000000000000000
FS:  00007f153c7b4700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002081e000 CR3: 00000000229d8000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	00 00                	add    %al,(%rax)
   2:	48 89 d8             	mov    %rbx,%rax
   5:	48 c1 e8 03          	shr    $0x3,%rax
   9:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
   e:	74 08                	je     0x18
  10:	48 89 df             	mov    %rbx,%rdi
  13:	e8 5c 85 8d fe       	callq  0xfe8d8574
  18:	4c 8b 3b             	mov    (%rbx),%r15
  1b:	49 8d af 28 02 00 00 	lea    0x228(%r15),%rbp
  22:	48 89 e8             	mov    %rbp,%rax
  25:	48 c1 e8 03          	shr    $0x3,%rax
* 29:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	48 89 ef             	mov    %rbp,%rdi
  33:	e8 3c 85 8d fe       	callq  0xfe8d8574
  38:	4c 8b 75 00          	mov    0x0(%rbp),%r14
  3c:	4d 85 f6             	test   %r14,%r14


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
