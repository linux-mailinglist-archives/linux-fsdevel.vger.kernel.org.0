Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F17C79DBAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 00:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbjILWK6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 18:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbjILWK5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 18:10:57 -0400
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB76110E9
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 15:10:53 -0700 (PDT)
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-573534fa5efso6078053eaf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 15:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694556653; x=1695161453;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bg4x9Ei5cShEmm+xrzB6bN3O2q48k7uN+pXjT1so+no=;
        b=P7NDJOKs3DaJWga1iutTCp59L8jt0TI4sr+Ng1oyS/qO6oeLjO1v5bC9L/PYrkoMV5
         jLbh78sICi9WkmJ4sZfycJRvL13d8DHbGjVjtLz7ycFNMp1OioFlDt+9+JjGYSfd4CA+
         x6+Vdxw7yRbqSecHgYdywyGhUxwTNwxe/hCYvlqAosjGgXXeu1zokEpp7Bahrb0SwLWG
         zz4mlZDckIeYIi74Bdf42ODE+8d1cnn8yUImWVqe9BY01Dvfpv9VGj/hzDb0LOOhLyuV
         uQnZVUUrl2CBS2Bf4KiYDTqWjx382JfJT4W7XxMK1DDcKYQ0aI/ds5igRMPQJq7cTNN8
         uqpg==
X-Gm-Message-State: AOJu0YwP7rX5W3HR0RfHIDdUcksllCAXFil+EBUVWrjRwmSOJG3spm5s
        55+DTYF9kry5+7QlCZRwjY/C1tt2h+cV8AQJSfciWSpMk3tW
X-Google-Smtp-Source: AGHT+IFg+PVOt0CyCuS8Og9h7oyEP00/P9KCv24WE/6Jna3eu60DuKJl5t6UFxNPuoS7NKeFVj+hjBOqjKQNkHUnAkzNaOZ13aCf
MIME-Version: 1.0
X-Received: by 2002:a05:6870:989d:b0:1c8:bec5:59c4 with SMTP id
 eg29-20020a056870989d00b001c8bec559c4mr234519oab.1.1694556653078; Tue, 12 Sep
 2023 15:10:53 -0700 (PDT)
Date:   Tue, 12 Sep 2023 15:10:53 -0700
In-Reply-To: <0000000000004f34d705ffbc2604@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005bd097060530b758@google.com>
Subject: Re: [syzbot] [overlayfs?] general protection fault in d_path
From:   syzbot <syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, brauner@kernel.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        syzkaller-bugs@googlegroups.com, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    a747acc0b752 Merge tag 'linux-kselftest-next-6.6-rc2' of g..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11c82308680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df91a3034fe3f122
dashboard link: https://syzkaller.appspot.com/bug?extid=a67fc5321ffb4b311c98
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1671b694680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ec94d8680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b28ecb88c714/disk-a747acc0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/03dd2cd5356f/vmlinux-a747acc0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/63365d9bf980/bzImage-a747acc0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000009: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000048-0x000000000000004f]
CPU: 0 PID: 5030 Comm: syz-executor173 Not tainted 6.6.0-rc1-syzkaller-00014-ga747acc0b752 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
RIP: 0010:__seqprop_spinlock_sequence include/linux/seqlock.h:275 [inline]
RIP: 0010:get_fs_root_rcu fs/d_path.c:244 [inline]
RIP: 0010:d_path+0x2f0/0x6e0 fs/d_path.c:286
Code: 30 00 74 08 48 89 df e8 be 20 e1 ff 4c 8b 23 4d 8d 6c 24 48 49 81 c4 88 00 00 00 4c 89 eb 48 c1 eb 03 4c 89 ef e8 00 1e 00 00 <42> 0f b6 04 33 84 c0 0f 85 89 00 00 00 45 8b 7d 00 44 89 fe 83 e6
RSP: 0018:ffffc90003a7eee0 EFLAGS: 00010246
RAX: 7e73051ae5315e00 RBX: 0000000000000009 RCX: ffff88807da73b80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003a7eff0 R08: ffffffff82068d08 R09: 1ffffffff1d34ccd
R10: dffffc0000000000 R11: fffffbfff1d34cce R12: 0000000000000088
R13: 0000000000000048 R14: dffffc0000000000 R15: ffff8880206d8000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f351862ebb8 CR3: 00000000276a7000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 audit_log_d_path+0xd3/0x310 kernel/audit.c:2138
 dump_common_audit_data security/lsm_audit.c:224 [inline]
 common_lsm_audit+0x7cf/0x1a90 security/lsm_audit.c:458
 smack_log+0x421/0x540 security/smack/smack_access.c:383
 smk_tskacc+0x2ff/0x360 security/smack/smack_access.c:253
 smack_inode_getattr+0x203/0x270 security/smack/smack_lsm.c:1271
 security_inode_getattr+0xd3/0x120 security/security.c:2153
 vfs_getattr+0x2a/0x3a0 fs/stat.c:206
 ovl_getattr+0x1b1/0xf70 fs/overlayfs/inode.c:174
 ima_check_last_writer security/integrity/ima/ima_main.c:171 [inline]
 ima_file_free+0x26e/0x4b0 security/integrity/ima/ima_main.c:203
 __fput+0x36a/0x910 fs/file_table.c:378
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x68f/0x2290 kernel/exit.c:874
 do_group_exit+0x206/0x2c0 kernel/exit.c:1024
 get_signal+0x175d/0x1840 kernel/signal.c:2892
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop+0x6a/0x100 kernel/entry/common.c:168
 exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:296
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f35185d8529
Code: Unable to access opcode bytes at 0x7f35185d84ff.
RSP: 002b:00007f3518599218 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: 0000000000000001 RBX: 00007f3518662308 RCX: 00007f35185d8529
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007f351866230c
RBP: 00007f3518662300 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f351862f064
R13: 0031656c69662f2e R14: 6e6f3d7865646e69 R15: 0079616c7265766f
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__seqprop_spinlock_sequence include/linux/seqlock.h:275 [inline]
RIP: 0010:get_fs_root_rcu fs/d_path.c:244 [inline]
RIP: 0010:d_path+0x2f0/0x6e0 fs/d_path.c:286
Code: 30 00 74 08 48 89 df e8 be 20 e1 ff 4c 8b 23 4d 8d 6c 24 48 49 81 c4 88 00 00 00 4c 89 eb 48 c1 eb 03 4c 89 ef e8 00 1e 00 00 <42> 0f b6 04 33 84 c0 0f 85 89 00 00 00 45 8b 7d 00 44 89 fe 83 e6
RSP: 0018:ffffc90003a7eee0 EFLAGS: 00010246
RAX: 7e73051ae5315e00 RBX: 0000000000000009 RCX: ffff88807da73b80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003a7eff0 R08: ffffffff82068d08 R09: 1ffffffff1d34ccd
R10: dffffc0000000000 R11: fffffbfff1d34cce R12: 0000000000000088
R13: 0000000000000048 R14: dffffc0000000000 R15: ffff8880206d8000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f351862ebb8 CR3: 000000007e769000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	30 00                	xor    %al,(%rax)
   2:	74 08                	je     0xc
   4:	48 89 df             	mov    %rbx,%rdi
   7:	e8 be 20 e1 ff       	call   0xffe120ca
   c:	4c 8b 23             	mov    (%rbx),%r12
   f:	4d 8d 6c 24 48       	lea    0x48(%r12),%r13
  14:	49 81 c4 88 00 00 00 	add    $0x88,%r12
  1b:	4c 89 eb             	mov    %r13,%rbx
  1e:	48 c1 eb 03          	shr    $0x3,%rbx
  22:	4c 89 ef             	mov    %r13,%rdi
  25:	e8 00 1e 00 00       	call   0x1e2a
* 2a:	42 0f b6 04 33       	movzbl (%rbx,%r14,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 89 00 00 00    	jne    0xc0
  37:	45 8b 7d 00          	mov    0x0(%r13),%r15d
  3b:	44 89 fe             	mov    %r15d,%esi
  3e:	83                   	.byte 0x83
  3f:	e6                   	.byte 0xe6


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
