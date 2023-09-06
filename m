Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E119794527
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 23:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbjIFVfW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 17:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjIFVfV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 17:35:21 -0400
Received: from mail-pl1-f207.google.com (mail-pl1-f207.google.com [209.85.214.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89C519A6
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 14:35:15 -0700 (PDT)
Received: by mail-pl1-f207.google.com with SMTP id d9443c01a7336-1c0aaf4caaaso3459665ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Sep 2023 14:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694036115; x=1694640915;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AF+QLvnv3Ner2dzu27pFKXA8E2NnGG2JZHcD6NYjSTI=;
        b=Uh1kKLoiJ6D+bMPSWPO0tH46WiHgvBojL6rfPKz6Y9qrUFFPle23wZ6uxtPdFt0y8F
         dqFkaHe4DX7tJwE4iImcZCHC2Mf68t9Kcibxezq2eCgqTINBL3Uxr2xFCvVU5yUYdBVL
         LdvnxBfXDlHxs+U+5CHoSJaZ1+5xJVRjza0fd0JhgMJjQk6XYu0I0oNcOOxz+IYBYT7t
         Q59k1DrOzy23tJOt+4N1/dGdYpjy16QEZD+81l2pJIxJOJO2Th9QrkETHEk3JHctDTf3
         v0MIdelZs8kLOXbY1S+GzG60znb6viyV7UfaQrk9fzN4z/p8izFsPoUlerzolshMrgin
         B2yg==
X-Gm-Message-State: AOJu0YyGpt90C3YonuvszzNVVOtdyPuQfnJG29yzsJZTN/vS0YIBqVED
        Q4KCFzGnQ5fNJ9c/xcK2svRfBwVkStuv+Lz6FxsXqmntz1Ca
X-Google-Smtp-Source: AGHT+IH0jSaJ5gLdKHr1IhZJSXcBBHTZfRV9OrYpfiO+gssm8XYSHAYVpdiIXR6iEoGEJCxpEXIPZwNawlIAsLKG2kfYUYmzWVXN
MIME-Version: 1.0
X-Received: by 2002:a17:902:f686:b0:1c1:f00a:64d5 with SMTP id
 l6-20020a170902f68600b001c1f00a64d5mr5936399plg.4.1694036115176; Wed, 06 Sep
 2023 14:35:15 -0700 (PDT)
Date:   Wed, 06 Sep 2023 14:35:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e1c4c10604b7849d@google.com>
Subject: [syzbot] [reiserfs?] BUG: unable to handle kernel paging request in mas_alloc_nodes
From:   syzbot <syzbot+de4269ef04437bffcaa9@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    a47fc304d2b6 Add linux-next specific files for 20230831
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1709eb67a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ecd2a74f20953b9
dashboard link: https://syzkaller.appspot.com/bug?extid=de4269ef04437bffcaa9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103ea770680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13206d04680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b2e8f4217527/disk-a47fc304.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ed6cdcc09339/vmlinux-a47fc304.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bd9b2475bf5a/bzImage-a47fc304.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2c0bbd58005c/mount_1.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=173b59afa80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14bb59afa80000
console output: https://syzkaller.appspot.com/x/log.txt?x=10bb59afa80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+de4269ef04437bffcaa9@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: 00000076000400c8
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 4494 Comm: udevd Not tainted 6.5.0-next-20230831-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:__kmem_cache_alloc_bulk mm/slub.c:3986 [inline]
RIP: 0010:kmem_cache_alloc_bulk+0x16a/0x7c0 mm/slub.c:4049
Code: 00 0f 85 1b 05 00 00 45 31 d2 4c 89 3c 24 65 48 8b 0c 25 c0 bc 03 00 4d 89 d7 48 89 4d 28 31 ed 48 89 4c 24 18 eb 2d 8b 43 28 <48> 8b 04 07 49 89 04 24 49 89 3b 0f 1f 44 00 00 4c 8b 1c 24 41 81
RSP: 0018:ffffc900031af878 EFLAGS: 00010006

RAX: 0000000000000080 RBX: ffff88801364d000 RCX: ffff88807d56bb80
RDX: 0000000000000000 RSI: ffffffff8ae925a0 RDI: 0000007600040048
RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff1d9c40a
R10: 0000000000000000 R11: ffff888073edee10 R12: ffff8880b9841830
R13: 000000000000000e R14: ffff888073edee10 R15: 0000000000000000
FS:  00007ff1acb30c80(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000076000400c8 CR3: 00000000290ce000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mt_alloc_bulk lib/maple_tree.c:165 [inline]
 mas_alloc_nodes+0x39c/0x830 lib/maple_tree.c:1271
 mas_node_count_gfp+0x105/0x130 lib/maple_tree.c:1329
 mas_node_count lib/maple_tree.c:1343 [inline]
 mas_expected_entries+0x116/0x200 lib/maple_tree.c:5577
 vma_iter_bulk_alloc include/linux/mm.h:985 [inline]
 dup_mmap+0x4f8/0x1d80 kernel/fork.c:681
 dup_mm kernel/fork.c:1686 [inline]
 copy_mm kernel/fork.c:1735 [inline]
 copy_process+0x6c11/0x7400 kernel/fork.c:2501
 kernel_clone+0xfd/0x930 kernel/fork.c:2909
 __do_sys_clone+0xba/0x100 kernel/fork.c:3052
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff1ac6fca12
Code: 41 5d 41 5e 41 5f c3 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 10 48 8b 15 e7 43 0f 00 f7 d8 64 89 02 48 83
RSP: 002b:00007fffc6413228 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 0000562ccc95ee01 RCX: 00007ff1ac6fca12
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000562ccc94b910
R10: 00007ff1acb30f50 R11: 0000000000000246 R12: 0000562ccc973450
R13: 0000000000000000 R14: 0000000000000000 R15: 0000562ccc94b910
 </TASK>
Modules linked in:
CR2: 00000076000400c8
---[ end trace 0000000000000000 ]---
RIP: 0010:__kmem_cache_alloc_bulk mm/slub.c:3986 [inline]
RIP: 0010:kmem_cache_alloc_bulk+0x16a/0x7c0 mm/slub.c:4049
Code: 00 0f 85 1b 05 00 00 45 31 d2 4c 89 3c 24 65 48 8b 0c 25 c0 bc 03 00 4d 89 d7 48 89 4d 28 31 ed 48 89 4c 24 18 eb 2d 8b 43 28 <48> 8b 04 07 49 89 04 24 49 89 3b 0f 1f 44 00 00 4c 8b 1c 24 41 81
RSP: 0018:ffffc900031af878 EFLAGS: 00010006
RAX: 0000000000000080 RBX: ffff88801364d000 RCX: ffff88807d56bb80
RDX: 0000000000000000 RSI: ffffffff8ae925a0 RDI: 0000007600040048
RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff1d9c40a
R10: 0000000000000000 R11: ffff888073edee10 R12: ffff8880b9841830
R13: 000000000000000e R14: ffff888073edee10 R15: 0000000000000000
FS:  00007ff1acb30c80(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000076000400c8 CR3: 00000000290ce000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 0f                	add    %cl,(%rdi)
   2:	85 1b                	test   %ebx,(%rbx)
   4:	05 00 00 45 31       	add    $0x31450000,%eax
   9:	d2 4c 89 3c          	rorb   %cl,0x3c(%rcx,%rcx,4)
   d:	24 65                	and    $0x65,%al
   f:	48 8b 0c 25 c0 bc 03 	mov    0x3bcc0,%rcx
  16:	00
  17:	4d 89 d7             	mov    %r10,%r15
  1a:	48 89 4d 28          	mov    %rcx,0x28(%rbp)
  1e:	31 ed                	xor    %ebp,%ebp
  20:	48 89 4c 24 18       	mov    %rcx,0x18(%rsp)
  25:	eb 2d                	jmp    0x54
  27:	8b 43 28             	mov    0x28(%rbx),%eax
* 2a:	48 8b 04 07          	mov    (%rdi,%rax,1),%rax <-- trapping instruction
  2e:	49 89 04 24          	mov    %rax,(%r12)
  32:	49 89 3b             	mov    %rdi,(%r11)
  35:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  3a:	4c 8b 1c 24          	mov    (%rsp),%r11
  3e:	41                   	rex.B
  3f:	81                   	.byte 0x81


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

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
