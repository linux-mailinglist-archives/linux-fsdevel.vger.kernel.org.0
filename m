Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810B86B109B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 19:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjCHSFo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 13:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjCHSFm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 13:05:42 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AA3C80B1
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Mar 2023 10:05:39 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id j9-20020a056e02220900b0031d93dba5a9so6597387ilf.17
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Mar 2023 10:05:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678298739;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=me7HYs213Ipoq6MCrC1Pr37gkDXXYcYAxV9Cnp8b0vE=;
        b=ozuqpD4+nrUPILgMvcGB8FGEmCf1XBPR8vKW9Sh3xGq/VO2zERFbul0kk2+4jgo8Q5
         CmSOL1sKAogMP8WAH3ib8nowVa6NXVS+iBqhqAIdFvDdtM1qOAZPMFZp++uhSPFWdFJB
         +6Dlr84xDLjhgesrcUWeHI/1R7TcfOCj/iR8lIMruc37UHtPXQyQCzkUwC01m71Zuili
         YAIUScjeZD0yVcE+B0X54nZrPHz9q3ANqBElO/wLosw2/z1IZ6tGqyP8qVtxSFxnmG1Z
         sxO41dlVaHmA7ancpREsZp+iq6Bjq1BcDAyc1MVa0iNLqmQqY3IUeMjgGSMzfSbvqw0t
         Eofw==
X-Gm-Message-State: AO0yUKXoD+VNmn2/L5Iu/sbrmJR6XNUDzkk+D2clV8Y/SQeC3rUVCXvv
        JeTwcq1sqXqoO/PPd0taiAg+Y4H6/7MNRsZPHoBJx7c1rPwdFco=
X-Google-Smtp-Source: AK7set97MX88ZCfhlBnjClo81L8cFIvrEkuIBQx1tin0r6hVRcuqpcNntqNUI4omoA79u4afh9geQB4wMbMxh7hbpfao9CoxeJ7v
MIME-Version: 1.0
X-Received: by 2002:a02:aa1c:0:b0:3b4:42bd:bec with SMTP id
 r28-20020a02aa1c000000b003b442bd0becmr9332976jam.4.1678298738930; Wed, 08 Mar
 2023 10:05:38 -0800 (PST)
Date:   Wed, 08 Mar 2023 10:05:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002940a505f66760b9@google.com>
Subject: [syzbot] [reiserfs?] divide error in flush_journal_list
From:   syzbot <syzbot+c559e4d7d61c16608cb1@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0988a0ea7919 Merge tag 'for-v6.3-part2' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10a0bee4c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f763d89e26d3d4c4
dashboard link: https://syzkaller.appspot.com/bug?extid=c559e4d7d61c16608cb1
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e0aa29e9ae74/disk-0988a0ea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6f64db0b58ef/vmlinux-0988a0ea.xz
kernel image: https://storage.googleapis.com/syzbot-assets/db391408e15d/bzImage-0988a0ea.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c559e4d7d61c16608cb1@syzkaller.appspotmail.com

divide error: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 9856 Comm: syz-executor.3 Not tainted 6.2.0-syzkaller-13467-g0988a0ea7919 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
RIP: 0010:flush_journal_list+0x1045/0x1c70 fs/reiserfs/journal.c:1592
Code: c0 0f 85 eb 0a 00 00 4f 8d 7c 3e 02 48 89 e8 48 c1 e8 03 42 0f b6 04 20 84 c0 4d 89 e6 0f 85 ee 0a 00 00 8b 0b 4c 89 f8 31 d2 <48> f7 f1 48 89 d3 43 0f b6 44 35 00 84 c0 0f 85 f2 0a 00 00 48 8b
RSP: 0018:ffffc900167a7558 EFLAGS: 00010246
RAX: 00000000000001a4 RBX: ffff88802eb1c014 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88802eb1c017 R08: ffffffff8232797b R09: ffffed100f275e0d
R10: 0000000000000000 R11: dffffc0000000001 R12: dffffc0000000000
R13: 1ffff110045e5117 R14: dffffc0000000000 R15: 00000000000001a4
FS:  00007f3a7e67f700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4ac8868000 CR3: 0000000029317000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 flush_used_journal_lists+0x1256/0x15d0 fs/reiserfs/journal.c:1829
 do_journal_end+0x39f7/0x4770
 do_journal_begin_r+0x970/0x1020
 journal_begin+0x14c/0x360 fs/reiserfs/journal.c:3255
 __commit_trans_jl fs/reiserfs/journal.c:3866 [inline]
 reiserfs_commit_for_inode+0x736/0xbe0 fs/reiserfs/journal.c:3922
 reiserfs_dir_fsync+0xcb/0x100 fs/reiserfs/dir.c:43
 vfs_fsync_range fs/sync.c:188 [inline]
 vfs_fsync fs/sync.c:202 [inline]
 do_fsync fs/sync.c:212 [inline]
 __do_sys_fdatasync fs/sync.c:225 [inline]
 __se_sys_fdatasync fs/sync.c:223 [inline]
 __x64_sys_fdatasync+0xb5/0x110 fs/sync.c:223
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f3a7d88c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3a7e67f168 EFLAGS: 00000246 ORIG_RAX: 000000000000004b
RAX: ffffffffffffffda RBX: 00007f3a7d9abf80 RCX: 00007f3a7d88c0f9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f3a7d8e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffec0b306af R14: 00007f3a7e67f300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:flush_journal_list+0x1045/0x1c70 fs/reiserfs/journal.c:1592
Code: c0 0f 85 eb 0a 00 00 4f 8d 7c 3e 02 48 89 e8 48 c1 e8 03 42 0f b6 04 20 84 c0 4d 89 e6 0f 85 ee 0a 00 00 8b 0b 4c 89 f8 31 d2 <48> f7 f1 48 89 d3 43 0f b6 44 35 00 84 c0 0f 85 f2 0a 00 00 48 8b
RSP: 0018:ffffc900167a7558 EFLAGS: 00010246
RAX: 00000000000001a4 RBX: ffff88802eb1c014 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88802eb1c017 R08: ffffffff8232797b R09: ffffed100f275e0d
R10: 0000000000000000 R11: dffffc0000000001 R12: dffffc0000000000
R13: 1ffff110045e5117 R14: dffffc0000000000 R15: 00000000000001a4
FS:  00007f3a7e67f700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f82a9f80000 CR3: 0000000029317000 CR4: 00000000003506e0
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
