Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E8178F4E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 23:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244215AbjHaV4D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 17:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbjHaV4C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 17:56:02 -0400
Received: from mail-pl1-f207.google.com (mail-pl1-f207.google.com [209.85.214.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B3111B
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 14:55:58 -0700 (PDT)
Received: by mail-pl1-f207.google.com with SMTP id d9443c01a7336-1bb29dc715bso13432425ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 14:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693518958; x=1694123758;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WlgV8wrYCLE7nM5q2YQjmftKxu1TXPg1tFkhluAyzHI=;
        b=ivm1AHL6cTvASarWwjJx2co/F8+olqAHb8h/JaFcBncuAPz/A6sRNflWoy6Ms/saV5
         4r27X9hPcCcZ5aPZInUadNde4Mqui5WaY7K4LzI3yqKGycJx+qt/aB4D44ywEDgCBxRg
         r5G7c033UaaqWPQor1nscPsuOjmcqhkouHZlTWkb0WjZQedqi3Vwo0ZBDZ148SZXS8H6
         ivCFwNJDRycCg4NR6Db3dhyJcb5R5V1YOp1DXgwEBWs3nUWl2iiRohM+zpwkD/yMJXIX
         AmvsGmNH1oUFIVu6+MiRVZQZ00Q41xJYz+RyMkBGr/2MQUAZ3U4DV64tXYVxfaMKk99m
         xACA==
X-Gm-Message-State: AOJu0YxJzE9f7FaQ2fJ68CutDGNhxacwpNQWNaU/m1xd3l84NAadhmjY
        GirAMNH0imaDZIls97kqvjobUYscqwguk2bJbaxQrdW53Y9baoPerw==
X-Google-Smtp-Source: AGHT+IEMa+7OoF8rPhRMSuOTOd+TToApfjLKNhg9gHUwCviU0tWvzFBAbQcDYmm1Ay4GzZXxEXRwq4u9ure6IfJf2IG9pgg94w+/
MIME-Version: 1.0
X-Received: by 2002:a17:902:ec88:b0:1bc:7312:78e0 with SMTP id
 x8-20020a170902ec8800b001bc731278e0mr188385plg.6.1693518958158; Thu, 31 Aug
 2023 14:55:58 -0700 (PDT)
Date:   Thu, 31 Aug 2023 14:55:58 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ebea2b06043f1b1f@google.com>
Subject: [syzbot] [reiserfs?] BUG: unable to handle kernel paging request in __raw_callee_save___kvm_vcpu_is_preempted
From:   syzbot <syzbot+1f1de29389f950944703@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b97d64c72259 Merge tag '6.6-rc-smb3-client-fixes-part1' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14b1212fa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=958c1fdc38118172
dashboard link: https://syzkaller.appspot.com/bug?extid=1f1de29389f950944703
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/99875b49c50b/disk-b97d64c7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5bcacc1a3f5b/vmlinux-b97d64c7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e2fe9c8de38a/bzImage-b97d64c7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1f1de29389f950944703@syzkaller.appspotmail.com

loop3: detected capacity change from 0 to 1024
BUG: unable to handle page fault for address: 000000078ccae8f8
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 83d20067 P4D 83d20067 PUD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 31278 Comm: syz-executor.3 Not tainted 6.5.0-syzkaller-08894-gb97d64c72259 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:__raw_callee_save___kvm_vcpu_is_preempted+0x4/0x20
Code: 21 10 01 c0 be 03 00 00 00 e8 c8 ea 36 03 bf 21 10 01 c0 be 0e 00 00 00 e9 b9 ea 36 03 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa <48> 8b 04 fd 00 e9 ca 8c 80 b8 d0 83 02 00 00 0f 95 c0 c3 66 0f 1f
RSP: 0018:ffffc90015d2f560 EFLAGS: 00010286
RAX: 1ffffffff1a3373f RBX: ffff888030204028 RCX: ffffffff816ba91d
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 00000000ffffffff
RBP: 00000000ffffffff R08: ffff88803020402f R09: 1ffff11006040805
R10: dffffc0000000000 R11: ffffed1006040806 R12: ffff88802b268014
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f5de3a856c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000078ccae8f8 CR3: 000000002f2a1000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 pv_vcpu_is_preempted arch/x86/include/asm/paravirt.h:608 [inline]
 vcpu_is_preempted arch/x86/include/asm/qspinlock.h:63 [inline]
 owner_on_cpu include/linux/sched.h:2306 [inline]
 mutex_can_spin_on_owner kernel/locking/mutex.c:409 [inline]
 mutex_optimistic_spin+0x17b/0x2b0 kernel/locking/mutex.c:452
 __mutex_lock_common+0x20a/0x2530 kernel/locking/mutex.c:607
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x1b/0x20 kernel/locking/mutex.c:799
 reiserfs_write_lock+0x7a/0xd0 fs/reiserfs/lock.c:27
 reiserfs_lookup+0x162/0x580 fs/reiserfs/namei.c:364
 lookup_open fs/namei.c:3473 [inline]
 open_last_lookups fs/namei.c:3563 [inline]
 path_openat+0x11f1/0x3180 fs/namei.c:3793
 do_filp_open+0x234/0x490 fs/namei.c:3823
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1422
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_open fs/open.c:1445 [inline]
 __se_sys_open fs/open.c:1441 [inline]
 __x64_sys_open+0x225/0x270 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5de2c7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5de3a850c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007f5de2d9bf80 RCX: 00007f5de2c7cae9
RDX: 0000000000000000 RSI: 0000000000145142 RDI: 0000000020007f80
RBP: 00007f5de2cc847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f5de2d9bf80 R15: 00007ffcdd81fee8
 </TASK>
Modules linked in:
CR2: 000000078ccae8f8
---[ end trace 0000000000000000 ]---
RIP: 0010:__raw_callee_save___kvm_vcpu_is_preempted+0x4/0x20
Code: 21 10 01 c0 be 03 00 00 00 e8 c8 ea 36 03 bf 21 10 01 c0 be 0e 00 00 00 e9 b9 ea 36 03 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa <48> 8b 04 fd 00 e9 ca 8c 80 b8 d0 83 02 00 00 0f 95 c0 c3 66 0f 1f
RSP: 0018:ffffc90015d2f560 EFLAGS: 00010286
RAX: 1ffffffff1a3373f RBX: ffff888030204028 RCX: ffffffff816ba91d
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 00000000ffffffff
RBP: 00000000ffffffff R08: ffff88803020402f R09: 1ffff11006040805
R10: dffffc0000000000 R11: ffffed1006040806 R12: ffff88802b268014
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f5de3a856c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000078ccae8f8 CR3: 000000002f2a1000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	21 10                	and    %edx,(%rax)
   2:	01 c0                	add    %eax,%eax
   4:	be 03 00 00 00       	mov    $0x3,%esi
   9:	e8 c8 ea 36 03       	call   0x336ead6
   e:	bf 21 10 01 c0       	mov    $0xc0011021,%edi
  13:	be 0e 00 00 00       	mov    $0xe,%esi
  18:	e9 b9 ea 36 03       	jmp    0x336ead6
  1d:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  24:	00 00
  26:	f3 0f 1e fa          	endbr64
* 2a:	48 8b 04 fd 00 e9 ca 	mov    -0x73351700(,%rdi,8),%rax <-- trapping instruction
  31:	8c
  32:	80 b8 d0 83 02 00 00 	cmpb   $0x0,0x283d0(%rax)
  39:	0f 95 c0             	setne  %al
  3c:	c3                   	ret
  3d:	66                   	data16
  3e:	0f                   	.byte 0xf
  3f:	1f                   	(bad)


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
