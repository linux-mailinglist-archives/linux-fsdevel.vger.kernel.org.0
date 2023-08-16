Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3913A77D854
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 04:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241226AbjHPCSY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 22:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241283AbjHPCSM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 22:18:12 -0400
Received: from mail-pl1-f206.google.com (mail-pl1-f206.google.com [209.85.214.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02FD212F
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 19:17:53 -0700 (PDT)
Received: by mail-pl1-f206.google.com with SMTP id d9443c01a7336-1bdbd0a7929so51001145ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 19:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692152273; x=1692757073;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X1uA/aWqWfQQStzLak2n/ZM3Onur8CIAEdPF1VtgWpg=;
        b=kxrgodpUKANyKsfZtidEKuZA1Ii6YTfOTGMP8NG7N3jpW5ls+946LxBrM3omtbnA0T
         5uBk7PZxXzEeGoworMYU+Hivnw7PYvCsXxNZWwN2mbbSnkwT1FHf2QWKtXL9f8Tvjpa+
         HgsquiJNZUHdpFVYXoEN1juEnKmJfG4LGGdBMt7HJHU9EBihgMT+PEj9d30cg75DIvvQ
         iMCIUf1RMNCOh5sNcZqTdTgVO6ei0+CG6AOkvPqB/a2f1F83VPf8S2ybgyahjfXXFohH
         N1PY7ii2EzVvoHq9b2WvZi5Uzyw0Kq3kQcIQDomq2z14btMupLfFzZMOv5zB7vnNS/Jg
         dPvQ==
X-Gm-Message-State: AOJu0YzTxlKQ782PBItOWsf+t/I/ISzwwzzbRqL50UjMEox35CZ6r4R6
        EI2BNwe5DPaWcWZdRWEKJ3ASQgryYDrhc5WFHL5jv0ABuJQN
X-Google-Smtp-Source: AGHT+IHu4UHeL0j053E/P8XFSlVdjgzsz6kM4pt+NYnBY5oPhox6ysb1cFKGQRsvXxHZ/KGdNzMLVdA/WiOm037V12sXcxZoyAVW
MIME-Version: 1.0
X-Received: by 2002:a17:902:da88:b0:1b8:a555:7615 with SMTP id
 j8-20020a170902da8800b001b8a5557615mr224890plx.9.1692152273063; Tue, 15 Aug
 2023 19:17:53 -0700 (PDT)
Date:   Tue, 15 Aug 2023 19:17:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002455cc060300e766@google.com>
Subject: [syzbot] [block?] [hfs?] general protection fault in blk_stat_add
From:   syzbot <syzbot+a6eebfd633f0f4630a40@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    21ef7b1e17d0 Add linux-next specific files for 20230809
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1475a7a5a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28e9e38cc16e8f0
dashboard link: https://syzkaller.appspot.com/bug?extid=a6eebfd633f0f4630a40
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1489cffda80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13bd2969a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e961d9a9b52d/disk-21ef7b1e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f5c9bb17b02c/vmlinux-21ef7b1e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ebef5bdf7465/bzImage-21ef7b1e.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/3565b37f1a37/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1273906ba80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1173906ba80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1673906ba80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a6eebfd633f0f4630a40@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 1 PID: 22 Comm: ksoftirqd/1 Not tainted 6.5.0-rc5-next-20230809-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:hlist_unhashed_lockless include/linux/list.h:963 [inline]
RIP: 0010:timer_pending include/linux/timer.h:168 [inline]
RIP: 0010:blk_stat_is_active block/blk-stat.h:133 [inline]
RIP: 0010:blk_stat_add+0x168/0x4f0 block/blk-stat.c:66
Code: 48 bd 00 00 00 00 00 fc ff df 4d 63 f6 4a 8d 04 f5 00 8a 3b 8c 48 89 44 24 08 e8 73 09 7f fd 48 8d 7b 18 48 89 f8 48 c1 e8 03 <80> 3c 28 00 0f 85 ca 02 00 00 48 8b 43 18 48 85 c0 0f 84 0d 01 00
RSP: 0018:ffffc900001c7d10 EFLAGS: 00010206
RAX: 0000000000000003 RBX: 0000000000000000 RCX: 0000000000000100
RDX: ffff888017643b80 RSI: ffffffff8408be0d RDI: 0000000000000018
RBP: dffffc0000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000022000
R13: 00000000000195cc R14: 0000000000000001 R15: ffff88801c78d690
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555562206f8 CR3: 000000001be4a000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __blk_mq_end_request_acct block/blk-mq.c:1013 [inline]
 __blk_mq_end_request block/blk-mq.c:1022 [inline]
 blk_mq_end_request+0x2fd/0x3c0 block/blk-mq.c:1038
 lo_complete_rq+0x1c4/0x270 drivers/block/loop.c:370
 blk_complete_reqs+0xb2/0xf0 block/blk-mq.c:1114
 __do_softirq+0x218/0x965 kernel/softirq.c:553
 run_ksoftirqd kernel/softirq.c:921 [inline]
 run_ksoftirqd+0x31/0x60 kernel/softirq.c:913
 smpboot_thread_fn+0x67d/0xa00 kernel/smpboot.c:164
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:hlist_unhashed_lockless include/linux/list.h:963 [inline]
RIP: 0010:timer_pending include/linux/timer.h:168 [inline]
RIP: 0010:blk_stat_is_active block/blk-stat.h:133 [inline]
RIP: 0010:blk_stat_add+0x168/0x4f0 block/blk-stat.c:66
Code: 48 bd 00 00 00 00 00 fc ff df 4d 63 f6 4a 8d 04 f5 00 8a 3b 8c 48 89 44 24 08 e8 73 09 7f fd 48 8d 7b 18 48 89 f8 48 c1 e8 03 <80> 3c 28 00 0f 85 ca 02 00 00 48 8b 43 18 48 85 c0 0f 84 0d 01 00
RSP: 0018:ffffc900001c7d10 EFLAGS: 00010206

RAX: 0000000000000003 RBX: 0000000000000000 RCX: 0000000000000100
RDX: ffff888017643b80 RSI: ffffffff8408be0d RDI: 0000000000000018
RBP: dffffc0000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000022000
R13: 00000000000195cc R14: 0000000000000001 R15: ffff88801c78d690
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555562206f8 CR3: 000000001be4a000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%rbp
   7:	fc ff df
   a:	4d 63 f6             	movslq %r14d,%r14
   d:	4a 8d 04 f5 00 8a 3b 	lea    -0x73c47600(,%r14,8),%rax
  14:	8c
  15:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  1a:	e8 73 09 7f fd       	call   0xfd7f0992
  1f:	48 8d 7b 18          	lea    0x18(%rbx),%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1) <-- trapping instruction
  2e:	0f 85 ca 02 00 00    	jne    0x2fe
  34:	48 8b 43 18          	mov    0x18(%rbx),%rax
  38:	48 85 c0             	test   %rax,%rax
  3b:	0f                   	.byte 0xf
  3c:	84                   	.byte 0x84
  3d:	0d                   	.byte 0xd
  3e:	01 00                	add    %eax,(%rax)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
