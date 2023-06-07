Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99ADA725760
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 10:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239320AbjFGIUm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 04:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238798AbjFGIUZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:20:25 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4A5189
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 01:20:23 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-77a13410773so179120939f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jun 2023 01:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686126022; x=1688718022;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZGDkToLFGk1DNDwTbnbGDMJ2Z/I7N57HOST/ddBoKsA=;
        b=Oidpgs4Hzg5QDmtA6PsopaKuZgiiP7+98Ir1LWsFtffpHttW6Vgekd2wLY1fegtETN
         lFJZBsPNjcWfhX20UZd5bJy0dlBVFeUUbtqmo/vP7mNeXV18BF8loCqENEQFA2xpzX7Y
         mppnUw9n9MUcyoTurSEb5WtdscNtSvtY7eiLB5TQX3uS8/d4W1lnJHtPIAq8sg6pNcfT
         kJSweS9cjREEcLThrnnwTP+w+dWPkXaWwSWd3+DxRbPg8VwXuGUWM0X2k0Kc/l9Jtjcy
         J4Bcf04gCeu/WDUnDCSXVpGjeYEr4srOB5ehtAWSJ5JrGc0I100NxVPogVpWmHflwKTz
         rOLw==
X-Gm-Message-State: AC+VfDyGnm2cicEv0TvnlB6TVCDBDBwIkUl9z4H28NcFgBx/FPqojVG6
        6Ciz972xkuWfBaH2m2qgdbGKZQu5AJFkfy/ppaoqXMGQUs9tJfkUEw==
X-Google-Smtp-Source: ACHHUZ4NXM0D0aLaoAzGGeI09qKS177rQEU0i2amhGkFpzGO+a2vh8a/5qcVwh7qRH5lYclg/SDEIuImXmgeCyrAdGthgw9xI5j2
MIME-Version: 1.0
X-Received: by 2002:a02:624a:0:b0:41d:879c:fae4 with SMTP id
 d71-20020a02624a000000b0041d879cfae4mr2006339jac.1.1686126022474; Wed, 07 Jun
 2023 01:20:22 -0700 (PDT)
Date:   Wed, 07 Jun 2023 01:20:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009dc57505fd85ceb9@google.com>
Subject: [syzbot] [reiserfs?] general protection fault in rcu_core (2)
From:   syzbot <syzbot+b23c4c9d3d228ba328d7@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    f8dba31b0a82 Merge tag 'asym-keys-fix-for-linus-v6.4-rc5' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=121b80dd280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c980bfe8b399968
dashboard link: https://syzkaller.appspot.com/bug?extid=b23c4c9d3d228ba328d7
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1680f7d1280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12fad50d280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0aac0833aa9d/disk-f8dba31b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/06f1060b83c8/vmlinux-f8dba31b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8450975febdf/bzImage-f8dba31b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f17b197e6309/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b23c4c9d3d228ba328d7@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 737b3067 P4D 737b3067 PUD 737b2067 PMD 0 
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 4991 Comm: syz-executor264 Not tainted 6.4.0-rc5-syzkaller-00002-gf8dba31b0a82 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc90000007e58 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8880b983d4c0 RCX: 611bc496b427aee7
RDX: 1ffff110059278c8 RSI: 0000000000000100 RDI: ffff888077a3ef00
RBP: 0000000000000001 R08: ffffffff816f1181 R09: ffffffff91529d1f
R10: fffffbfff22a53a3 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff888077a3ef00 R14: ffffc90000007ed8 R15: 0000000000000000
FS:  000055555682c3c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 00000000737b9000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 rcu_do_batch kernel/rcu/tree.c:2115 [inline]
 rcu_core+0x806/0x1ad0 kernel/rcu/tree.c:2377
 __do_softirq+0x1d4/0x905 kernel/softirq.c:571
 invoke_softirq kernel/softirq.c:445 [inline]
 __irq_exit_rcu+0x114/0x190 kernel/softirq.c:650
 irq_exit_rcu+0x9/0x20 kernel/softirq.c:662
 sysvec_apic_timer_interrupt+0x97/0xc0 arch/x86/kernel/apic/apic.c:1106
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:memmove+0x43/0x1b0 arch/x86/lib/memmove_64.S:66
Code: 00 00 48 83 fa 20 0f 82 01 01 00 00 0f 1f 44 00 00 48 81 fa a8 02 00 00 72 05 40 38 fe 74 48 48 83 ea 20 48 83 ea 20 4c 8b 1e <4c> 8b 56 08 4c 8b 4e 10 4c 8b 46 18 48 8d 76 20 4c 89 1f 4c 89 57
RSP: 0018:ffffc90003afef90 EFLAGS: 00000282
RAX: ffff88807500e030 RBX: 0000000000000000 RCX: 0000000000000000
RDX: fffffffff9b0ee85 RSI: ffff88807b500040 RDI: ffff88807b4ff070
RBP: dffffc0000000000 R08: 0000000034365f36 R09: 38782f34365f3638
R10: 782f736c742f3436 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000fd0 R14: ffff88807500e0a8 R15: 0000000000000006
 leaf_paste_in_buffer+0x270/0xc30 fs/reiserfs/lbalance.c:1017
 balance_leaf_new_nodes_paste_whole fs/reiserfs/do_balan.c:1171 [inline]
 balance_leaf_new_nodes_paste fs/reiserfs/do_balan.c:1215 [inline]
 balance_leaf_new_nodes fs/reiserfs/do_balan.c:1246 [inline]
 balance_leaf+0x29c5/0xddc0 fs/reiserfs/do_balan.c:1450
 do_balance+0x319/0x810 fs/reiserfs/do_balan.c:1888
 reiserfs_paste_into_item+0x74b/0x8d0 fs/reiserfs/stree.c:2157
 reiserfs_get_block+0x165c/0x4100 fs/reiserfs/inode.c:1069
 __block_write_begin_int+0x3bd/0x14b0 fs/buffer.c:2064
 reiserfs_write_begin+0x36e/0xa60 fs/reiserfs/inode.c:2773
 generic_cont_expand_simple+0x117/0x1f0 fs/buffer.c:2425
 reiserfs_setattr+0x395/0x1370 fs/reiserfs/inode.c:3303
 notify_change+0xb2c/0x1180 fs/attr.c:483
 do_truncate+0x143/0x200 fs/open.c:66
 do_sys_ftruncate+0x53a/0x770 fs/open.c:194
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f987e211279
Code: Unable to access opcode bytes at 0x7f987e21124f.
RSP: 002b:00007ffc67526118 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
RAX: ffffffffffffffda RBX: 00007ffc67526158 RCX: 00007f987e211279
RDX: 00007f987e211279 RSI: 0000000002007fff RDI: 0000000000000004
RBP: 00007ffc67526150 R08: aaaaaaaaaaaa0102 R09: aaaaaaaaaaaa0102
R10: aaaaaaaaaaaa0102 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f987e2876dc R14: 0000000000000003 R15: 0000000000000001
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc90000007e58 EFLAGS: 00010246

RAX: 0000000000000000 RBX: ffff8880b983d4c0 RCX: 611bc496b427aee7
RDX: 1ffff110059278c8 RSI: 0000000000000100 RDI: ffff888077a3ef00
RBP: 0000000000000001 R08: ffffffff816f1181 R09: ffffffff91529d1f
R10: fffffbfff22a53a3 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff888077a3ef00 R14: ffffc90000007ed8 R15: 0000000000000000
FS:  000055555682c3c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 00000000737b9000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	48 83 fa 20          	cmp    $0x20,%rdx
   6:	0f 82 01 01 00 00    	jb     0x10d
   c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  11:	48 81 fa a8 02 00 00 	cmp    $0x2a8,%rdx
  18:	72 05                	jb     0x1f
  1a:	40 38 fe             	cmp    %dil,%sil
  1d:	74 48                	je     0x67
  1f:	48 83 ea 20          	sub    $0x20,%rdx
  23:	48 83 ea 20          	sub    $0x20,%rdx
  27:	4c 8b 1e             	mov    (%rsi),%r11
* 2a:	4c 8b 56 08          	mov    0x8(%rsi),%r10 <-- trapping instruction
  2e:	4c 8b 4e 10          	mov    0x10(%rsi),%r9
  32:	4c 8b 46 18          	mov    0x18(%rsi),%r8
  36:	48 8d 76 20          	lea    0x20(%rsi),%rsi
  3a:	4c 89 1f             	mov    %r11,(%rdi)
  3d:	4c                   	rex.WR
  3e:	89                   	.byte 0x89
  3f:	57                   	push   %rdi


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
