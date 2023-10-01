Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E8B7B47CC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Oct 2023 16:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbjJAOHy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Oct 2023 10:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjJAOHx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Oct 2023 10:07:53 -0400
Received: from mail-oa1-f77.google.com (mail-oa1-f77.google.com [209.85.160.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDBB99
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 Oct 2023 07:07:50 -0700 (PDT)
Received: by mail-oa1-f77.google.com with SMTP id 586e51a60fabf-1e12f68563cso3325946fac.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Oct 2023 07:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696169269; x=1696774069;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eX0vtL5fOhmVLH0Nu1LjGmdg5gsapNaCgl3QZSj8jEY=;
        b=OzsVc4Opa27z58+zjM/YBnPICsSUKYrcAzE1s5fXpsbgtiuA55kGoRtTNCAK17IKH+
         BS394zgTRiMi5BcFKPsTUCFHAXXiUiuSofgeCUhTNrLgLA8/eTM3YyXQUUrBVbfD8yek
         xn7M4uKHU8cCLp2WSl2zccayAbzO3YHrCEVMSnZHaZSDWfy/YC+VSz2bdyT78qNx1lzG
         GZIf3rvtDn0t9zWJgRIGfHRbadeJJXVukK7UR/DTyw1ciDuOEXSLJDYd2g2a2QcxHDtt
         rUxZ6/n3VNWepXxmSlH15xMdie6b2X1+lC5/WmtQCXatiMrfa4B0Wd8U621GQQtpxea7
         qWJg==
X-Gm-Message-State: AOJu0YyoOMdcy+MNrNrlRhbFQP77TeaLpEEZiKcW9/rdeHh4EvNntEzO
        rVoDeEjdLaIG3iCW6bcKk8CrB4mTM8isLj2qWM79UnK1WOZm
X-Google-Smtp-Source: AGHT+IHrjbC0o7FwFIb3BoFeuuKZMrHSMktNNZSSu7NoPcrQYSp2SVpEjUoCWY7cH8nvQL8iF/LX8U25w8wvZmxXr+X77RcBsn3p
MIME-Version: 1.0
X-Received: by 2002:a05:6870:988a:b0:1dd:11b8:9ce2 with SMTP id
 eg10-20020a056870988a00b001dd11b89ce2mr3744918oab.5.1696169269394; Sun, 01
 Oct 2023 07:07:49 -0700 (PDT)
Date:   Sun, 01 Oct 2023 07:07:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c801280606a82e95@google.com>
Subject: [syzbot] [jfs?] INFO: trying to register non-static key in txEnd
From:   syzbot <syzbot+ca4b16c6465dca321d40@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
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

HEAD commit:    3b517966c561 Merge tag 'dma-mapping-6.6-2023-09-30' of git..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10f60d01680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12da82ece7bf46f9
dashboard link: https://syzkaller.appspot.com/bug?extid=ca4b16c6465dca321d40
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=173cdcd6680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13451e92680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5b735d3535d1/disk-3b517966.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b97a846fc755/vmlinux-3b517966.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b9cdff2a07c0/bzImage-3b517966.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/fcc011d82db8/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ca4b16c6465dca321d40@syzkaller.appspotmail.com

WARNING: The mand mount option has been deprecated and
         and is ignored by this kernel. Remove the mand
         option from the mount to silence this warning.
=======================================================
ERROR: (device loop0): txBegin: read-only filesystem
ERROR: (device loop0): remounting filesystem as read-only
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 1 PID: 5036 Comm: syz-executor418 Not tainted 6.6.0-rc3-syzkaller-00165-g3b517966c561 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 assign_lock_key+0x234/0x270 kernel/locking/lockdep.c:976
 register_lock_class+0x28e/0x990 kernel/locking/lockdep.c:1289
 __lock_acquire+0x190/0x7f70 kernel/locking/lockdep.c:5013
 lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5753
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 __wake_up_common_lock kernel/sched/wait.c:137 [inline]
 __wake_up+0x101/0x1d0 kernel/sched/wait.c:160
 txEnd+0x8c/0x560 fs/jfs/jfs_txnmgr.c:504
 __jfs_xattr_set+0x132/0x180 fs/jfs/xattr.c:920
 __vfs_setxattr+0x460/0x4a0 fs/xattr.c:201
 __vfs_setxattr_noperm+0x12e/0x5e0 fs/xattr.c:235
 vfs_setxattr+0x221/0x420 fs/xattr.c:322
 do_setxattr fs/xattr.c:630 [inline]
 setxattr+0x25d/0x2f0 fs/xattr.c:653
 path_setxattr+0x1c0/0x2a0 fs/xattr.c:672
 __do_sys_setxattr fs/xattr.c:688 [inline]
 __se_sys_setxattr fs/xattr.c:684 [inline]
 __x64_sys_setxattr+0xbb/0xd0 fs/xattr.c:684
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8b974129c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe91f079a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f8b974129c9
RDX: 0000000000000000 RSI: 00000000200001c0 RDI: 0000000020000180
RBP: 00007f8b9745b04b R08: 0000000000000002 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffe91f07b88 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 5036 Comm: syz-executor418 Not tainted 6.6.0-rc3-syzkaller-00165-g3b517966c561 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
RIP: 0010:__wake_up_common+0x23d/0x4e0
Code: 00 49 83 c4 40 4d 39 e7 0f 84 f1 01 00 00 45 31 f6 eb 09 4d 39 e7 0f 84 e3 01 00 00 4c 89 fb 49 8d 6f e8 4c 89 f8 48 c1 e8 03 <80> 3c 10 00 74 12 48 89 df e8 85 46 7e 00 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc90003a3f778 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000003 RDI: ffffc90002631030
RBP: ffffffffffffffe8 R08: 0000000000000000 R09: ffffc90003a3f820
R10: dffffc0000000000 R11: fffff52000747ed8 R12: ffffc90002631070
R13: 1ffff92000747f04 R14: 0000000000000000 R15: 0000000000000000
FS:  0000555556b00380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f9c7d4fff0 CR3: 000000007e73b000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __wake_up_common_lock kernel/sched/wait.c:138 [inline]
 __wake_up+0x11e/0x1d0 kernel/sched/wait.c:160
 txEnd+0x8c/0x560 fs/jfs/jfs_txnmgr.c:504
 __jfs_xattr_set+0x132/0x180 fs/jfs/xattr.c:920
 __vfs_setxattr+0x460/0x4a0 fs/xattr.c:201
 __vfs_setxattr_noperm+0x12e/0x5e0 fs/xattr.c:235
 vfs_setxattr+0x221/0x420 fs/xattr.c:322
 do_setxattr fs/xattr.c:630 [inline]
 setxattr+0x25d/0x2f0 fs/xattr.c:653
 path_setxattr+0x1c0/0x2a0 fs/xattr.c:672
 __do_sys_setxattr fs/xattr.c:688 [inline]
 __se_sys_setxattr fs/xattr.c:684 [inline]
 __x64_sys_setxattr+0xbb/0xd0 fs/xattr.c:684
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8b974129c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe91f079a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f8b974129c9
RDX: 0000000000000000 RSI: 00000000200001c0 RDI: 0000000020000180
RBP: 00007f8b9745b04b R08: 0000000000000002 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffe91f07b88 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__wake_up_common+0x23d/0x4e0
Code: 00 49 83 c4 40 4d 39 e7 0f 84 f1 01 00 00 45 31 f6 eb 09 4d 39 e7 0f 84 e3 01 00 00 4c 89 fb 49 8d 6f e8 4c 89 f8 48 c1 e8 03 <80> 3c 10 00 74 12 48 89 df e8 85 46 7e 00 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc90003a3f778 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000003 RDI: ffffc90002631030
RBP: ffffffffffffffe8 R08: 0000000000000000 R09: ffffc90003a3f820
R10: dffffc0000000000 R11: fffff52000747ed8 R12: ffffc90002631070
R13: 1ffff92000747f04 R14: 0000000000000000 R15: 0000000000000000
FS:  0000555556b00380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f9c7d4fff0 CR3: 000000007e73b000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	49 83 c4 40          	add    $0x40,%r12
   4:	4d 39 e7             	cmp    %r12,%r15
   7:	0f 84 f1 01 00 00    	je     0x1fe
   d:	45 31 f6             	xor    %r14d,%r14d
  10:	eb 09                	jmp    0x1b
  12:	4d 39 e7             	cmp    %r12,%r15
  15:	0f 84 e3 01 00 00    	je     0x1fe
  1b:	4c 89 fb             	mov    %r15,%rbx
  1e:	49 8d 6f e8          	lea    -0x18(%r15),%rbp
  22:	4c 89 f8             	mov    %r15,%rax
  25:	48 c1 e8 03          	shr    $0x3,%rax
* 29:	80 3c 10 00          	cmpb   $0x0,(%rax,%rdx,1) <-- trapping instruction
  2d:	74 12                	je     0x41
  2f:	48 89 df             	mov    %rbx,%rdi
  32:	e8 85 46 7e 00       	call   0x7e46bc
  37:	48                   	rex.W
  38:	ba 00 00 00 00       	mov    $0x0,%edx
  3d:	00 fc                	add    %bh,%ah


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
