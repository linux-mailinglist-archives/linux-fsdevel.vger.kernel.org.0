Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC676F1191
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Apr 2023 08:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345175AbjD1GBs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Apr 2023 02:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjD1GBp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Apr 2023 02:01:45 -0400
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00B330D5
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Apr 2023 23:01:43 -0700 (PDT)
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-32f240747cdso63141905ab.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Apr 2023 23:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682661703; x=1685253703;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RADR7osfU6tYqXb0l/8u4uv1x29ciz4ia9oQNvcCWng=;
        b=EUaxCnWsspvUMMDNPlGeVmaTN+3euDuuzf1wC00Hi7BEjxpN6xhwKki0huRQiWJMCB
         /itL0Abtm5jMgsEGBXBPSx9xLN0lsc2MVWacSYdJsL88JJFPfTV8BRHsQqS/BrcP47Kg
         3lV9NwlQnVEEw7nMtKeSbLGWCiKom3LkSyPb1DOsoQ88fww2G33QX1NftazTYmTcDfQZ
         mqDzcpauT47pLtpgTPqP19LhCJ0WNzENkU9zNaodwE9l/pCyTox6r9i0jBy9+FYYExAQ
         IHqZy6fc2p4oPxaOfn14MrKIQFwKXCPbgGXfc1eDOE3O5OuzWR88Hkxl/FqaWUqYFPjC
         8OcQ==
X-Gm-Message-State: AC+VfDzJ9a14f7w9x/CiygRwsMRPmMaLPadzC/jRp6q9HmPOybQaIuJ6
        xXGHFSQvz8Z+SSccghGm4Z6CTE1RAeJUglACJbxbBXN1EYop
X-Google-Smtp-Source: ACHHUZ7PPsw6gW2hGgmZp2GgG6jG8jLffk1LukuhkSm8fL1OoU7BVoh1vrPtriARxNK+dMdTZpNKdFt870NrItFmn0oS0JkGLKD0
MIME-Version: 1.0
X-Received: by 2002:a05:6602:701:b0:760:ee03:7e95 with SMTP id
 f1-20020a056602070100b00760ee037e95mr6500715iox.1.1682661702937; Thu, 27 Apr
 2023 23:01:42 -0700 (PDT)
Date:   Thu, 27 Apr 2023 23:01:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000014b32705fa5f3585@google.com>
Subject: [syzbot] [btrfs?] general protection fault in btrfs_orphan_cleanup
From:   syzbot <syzbot+2e15a1e4284bf8517741@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6e98b09da931 Merge tag 'net-next-6.4' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17699f80280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5b762354749a3d5d
dashboard link: https://syzkaller.appspot.com/bug?extid=2e15a1e4284bf8517741
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8ad082c4dcdf/disk-6e98b09d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/96565e4d870d/vmlinux-6e98b09d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cfcfe15601e5/bzImage-6e98b09d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2e15a1e4284bf8517741@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc000000001a: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000000d0-0x00000000000000d7]
CPU: 0 PID: 17330 Comm: syz-executor.2 Not tainted 6.3.0-syzkaller-07919-g6e98b09da931 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
RIP: 0010:iput+0x40/0x8f0 fs/inode.c:1764
Code: d6 80 92 ff 48 85 ed 0f 84 56 03 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d 9d d8 00 00 00 48 89 d9 48 c1 e9 03 48 89 4c 24 08 <80> 3c 01 00 74 08 48 89 df e8 e2 49 e9 ff 48 89 1c 24 48 8b 1b 48
RSP: 0000:ffffc90014d47a10 EFLAGS: 00010203
RAX: dffffc0000000000 RBX: 00000000000000d6 RCX: 000000000000001a
RDX: ffffc900131c3000 RSI: 000000000002326c RDI: 000000000002326d
RBP: fffffffffffffffe R08: dffffc0000000000 R09: ffffed1005547aef
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff88802d122000
R13: fffffffffffffffc R14: 00000000fffffffe R15: dffffc0000000000
FS:  00007f523909c700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4e34428000 CR3: 0000000031e52000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_orphan_cleanup+0xa55/0xcf0 fs/btrfs/inode.c:3629
 create_snapshot+0x520/0x7e0 fs/btrfs/ioctl.c:852
 btrfs_mksubvol+0x5d0/0x750 fs/btrfs/ioctl.c:994
 btrfs_mksnapshot+0xb5/0xf0 fs/btrfs/ioctl.c:1040
 __btrfs_ioctl_snap_create+0x338/0x450 fs/btrfs/ioctl.c:1293
 btrfs_ioctl_snap_create+0x136/0x190 fs/btrfs/ioctl.c:1320
 btrfs_ioctl+0xbbc/0xd40
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f523828c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f523909c168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f52383abf80 RCX: 00007f523828c169
RDX: 00000000200000c0 RSI: 0000000050009401 RDI: 0000000000000009
RBP: 00007f52382e7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe28ec0fbf R14: 00007f523909c300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:iput+0x40/0x8f0 fs/inode.c:1764
Code: d6 80 92 ff 48 85 ed 0f 84 56 03 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d 9d d8 00 00 00 48 89 d9 48 c1 e9 03 48 89 4c 24 08 <80> 3c 01 00 74 08 48 89 df e8 e2 49 e9 ff 48 89 1c 24 48 8b 1b 48
RSP: 0000:ffffc90014d47a10 EFLAGS: 00010203
RAX: dffffc0000000000 RBX: 00000000000000d6 RCX: 000000000000001a
RDX: ffffc900131c3000 RSI: 000000000002326c RDI: 000000000002326d
RBP: fffffffffffffffe R08: dffffc0000000000 R09: ffffed1005547aef
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff88802d122000
R13: fffffffffffffffc R14: 00000000fffffffe R15: dffffc0000000000
FS:  00007f523909c700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe5b93ff000 CR3: 0000000031e52000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	80 92 ff 48 85 ed 0f 	adcb   $0xf,-0x127ab701(%rdx)
   7:	84 56 03             	test   %dl,0x3(%rsi)
   a:	00 00                	add    %al,(%rax)
   c:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  13:	fc ff df
  16:	48 8d 9d d8 00 00 00 	lea    0xd8(%rbp),%rbx
  1d:	48 89 d9             	mov    %rbx,%rcx
  20:	48 c1 e9 03          	shr    $0x3,%rcx
  24:	48 89 4c 24 08       	mov    %rcx,0x8(%rsp)
* 29:	80 3c 01 00          	cmpb   $0x0,(%rcx,%rax,1) <-- trapping instruction
  2d:	74 08                	je     0x37
  2f:	48 89 df             	mov    %rbx,%rdi
  32:	e8 e2 49 e9 ff       	callq  0xffe94a19
  37:	48 89 1c 24          	mov    %rbx,(%rsp)
  3b:	48 8b 1b             	mov    (%rbx),%rbx
  3e:	48                   	rex.W


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
