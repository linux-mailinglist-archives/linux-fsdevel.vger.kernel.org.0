Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BD25F1C66
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Oct 2022 15:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJANlp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Oct 2022 09:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJANln (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Oct 2022 09:41:43 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8680689838
        for <linux-fsdevel@vger.kernel.org>; Sat,  1 Oct 2022 06:41:33 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id h205-20020a6bb7d6000000b006a1e6bef9c7so4398102iof.17
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Oct 2022 06:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=XzPf5FliNF5zN9Oddbr+3SG/Le6lApNaX7XnhOg6R8I=;
        b=lkAVci+SP5i2CQuqQFiEb3RmWpLXOfP6H3kXKAXaMVjogY0/faUa9DjUc39hRkUWhB
         ca9wzs1JvQa/BpOX9PjLCgh0A15sidKHSgO38XwhFUDVVotu7331nDGHBp6FR3Fz3QpP
         MU+qmKKI+YfD9MK1cGKM5/srXMzFSWgPbtxl0djIWpE3vi4/ajiXXC2K/1kfdTGRWGKi
         /zE3Z7ts0BBElynDL1mqQdVZEBn6UlYTj/qkyxDl2XEjeGYsCWW5+aSQftFGM6BEwerS
         gqdheIU56YGZQZrEmkQj37N8OBcYTdrz1c+0k05QuoM04VFnLsQ30UpRhV2j4stbojpN
         15tg==
X-Gm-Message-State: ACrzQf1D+t94Cfgu3OBKOlZf8xLBLLKZWm5eItE1sOfekWz3homx6Ggc
        4w2V/Istb96Ju2/Uyegk44XgsfJ4mkCZL71+4mEex3+Cxj3p
X-Google-Smtp-Source: AMsMyM73R/JyAs+BRUqd9aIDRHj+iRHfqhsutQ61iNsnE2DMYss/F/Xp2TCZlNahr0f8ypyYLa4qGcn48gOtKRZtsLAzkLWAAioG
MIME-Version: 1.0
X-Received: by 2002:a02:5108:0:b0:35a:eca0:92c1 with SMTP id
 s8-20020a025108000000b0035aeca092c1mr6906569jaa.81.1664631692912; Sat, 01 Oct
 2022 06:41:32 -0700 (PDT)
Date:   Sat, 01 Oct 2022 06:41:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bcec9205e9f944c8@google.com>
Subject: [syzbot] WARNING: nested lock was not taken in evict
From:   syzbot <syzbot+91a81c5ebb1f330e5fbd@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
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

HEAD commit:    49c13ed0316d Merge tag 'soc-fixes-6.0-rc7' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16061b60880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4520785fccee9b40
dashboard link: https://syzkaller.appspot.com/bug?extid=91a81c5ebb1f330e5fbd
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+91a81c5ebb1f330e5fbd@syzkaller.appspotmail.com

==================================
WARNING: Nested lock was not taken
6.0.0-rc7-syzkaller-00068-g49c13ed0316d #0 Not tainted
----------------------------------
syz-executor.4/14643 is trying to lock:
ffff888081ac29d8 (&s->s_inode_list_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:349 [inline]
ffff888081ac29d8 (&s->s_inode_list_lock){+.+.}-{2:2}, at: inode_sb_list_del fs/inode.c:503 [inline]
ffff888081ac29d8 (&s->s_inode_list_lock){+.+.}-{2:2}, at: evict+0x161/0x620 fs/inode.c:654

but this task is not holding:
general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 1 PID: 14643 Comm: syz-executor.4 Not tainted 6.0.0-rc7-syzkaller-00068-g49c13ed0316d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
RIP: 0010:print_lock_nested_lock_not_held kernel/locking/lockdep.c:4885 [inline]
RIP: 0010:__lock_acquire+0x1112/0x1f60 kernel/locking/lockdep.c:5044
Code: 3c 30 00 48 8b 5c 24 70 74 12 48 89 df e8 c6 e9 73 00 49 be 00 00 00 00 00 fc ff df 48 8b 1b 48 83 c3 18 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 df e8 9f e9 73 00 48 8b 33 45 31 f6 48
RSP: 0018:ffffc90004cb7828 EFLAGS: 00010006
RAX: 0000000000000003 RBX: 0000000000000018 RCX: 662ac61637488d00
RDX: ffffc90014d53000 RSI: 000000000001a212 RDI: 000000000001a213
RBP: ffff888082c3a360 R08: ffffffff816d5a8d R09: ffffed1017364f14
R10: ffffed1017364f14 R11: 1ffff11017364f13 R12: ffff888082c3a5c8
R13: b934e40f1353b763 R14: dffffc0000000000 R15: ffff888082c39d80
FS:  00007fdd95b20700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2ec28000 CR3: 000000003f60a000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5666
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:349 [inline]
 inode_sb_list_del fs/inode.c:503 [inline]
 evict+0x161/0x620 fs/inode.c:654
 ntfs_fill_super+0x3c6c/0x4420 fs/ntfs3/super.c:1190
 get_tree_bdev+0x400/0x620 fs/super.c:1323
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2e3/0x3d0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fdd94a8bada
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdd95b1ff88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007fdd94a8bada
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fdd95b1ffe0
RBP: 00007fdd95b20020 R08: 00007fdd95b20020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 00007fdd95b1ffe0 R15: 0000000020003580
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:print_lock_nested_lock_not_held kernel/locking/lockdep.c:4885 [inline]
RIP: 0010:__lock_acquire+0x1112/0x1f60 kernel/locking/lockdep.c:5044
Code: 3c 30 00 48 8b 5c 24 70 74 12 48 89 df e8 c6 e9 73 00 49 be 00 00 00 00 00 fc ff df 48 8b 1b 48 83 c3 18 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 df e8 9f e9 73 00 48 8b 33 45 31 f6 48
RSP: 0018:ffffc90004cb7828 EFLAGS: 00010006
RAX: 0000000000000003 RBX: 0000000000000018 RCX: 662ac61637488d00
RDX: ffffc90014d53000 RSI: 000000000001a212 RDI: 000000000001a213
RBP: ffff888082c3a360 R08: ffffffff816d5a8d R09: ffffed1017364f14
R10: ffffed1017364f14 R11: 1ffff11017364f13 R12: ffff888082c3a5c8
R13: b934e40f1353b763 R14: dffffc0000000000 R15: ffff888082c39d80
FS:  00007fdd95b20700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2ec28000 CR3: 000000003f60a000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	3c 30                	cmp    $0x30,%al
   2:	00 48 8b             	add    %cl,-0x75(%rax)
   5:	5c                   	pop    %rsp
   6:	24 70                	and    $0x70,%al
   8:	74 12                	je     0x1c
   a:	48 89 df             	mov    %rbx,%rdi
   d:	e8 c6 e9 73 00       	callq  0x73e9d8
  12:	49 be 00 00 00 00 00 	movabs $0xdffffc0000000000,%r14
  19:	fc ff df
  1c:	48 8b 1b             	mov    (%rbx),%rbx
  1f:	48 83 c3 18          	add    $0x18,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 9f e9 73 00       	callq  0x73e9d8
  39:	48 8b 33             	mov    (%rbx),%rsi
  3c:	45 31 f6             	xor    %r14d,%r14d
  3f:	48                   	rex.W


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
