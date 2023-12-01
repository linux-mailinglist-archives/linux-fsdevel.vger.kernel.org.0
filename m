Return-Path: <linux-fsdevel+bounces-4670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C60E801902
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 01:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DFAF1C20AD6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 00:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD76D23A4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 00:40:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C18DD
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 15:57:22 -0800 (PST)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6cde4342fe9so3087657b3a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 15:57:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701475041; x=1702079841;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kjqfKH8JvaG9Z/SqXxhblf/a00V2R0Ggq3QtYOjAI8Y=;
        b=ApnWizjR29gvtpl36x6peDu5v7XLDyzjMFYcSHPGFHI/fDdny5JsowvUXK5CsQ0gmB
         ZhAyX97UZJ0ZLG2gfETtvTlu4+9RGZRk/u97X/XOjYofTqzZG3NwTLK3wPNt/BDk4aUu
         9ChvI8x/2xQSrKRlgSnko72ppTfmHzj0qq+g5wxXKvynEZOLnbT2rPaMv9P1mXTPLfDD
         +xV3YRJVW0aMjq0OSBu9zR4xFKnhhl5fcSt5ZGXtGh7DUxSx0GxuhjTY+RQKLnf6Cyy3
         /yLlRxYlr9lmkNWBHzr+LS+MORaZk3oxyYYsuHFUzkGyiFfy5tAOBQMmfMMSQUoJqIJa
         KTyg==
X-Gm-Message-State: AOJu0YzQY4aTTKB1KugRFybrSZZe2wjVQjemnyfSLwqCLJfDEXPhessB
	/ICR6MTcfHMMUkpIeDszpR57U7qAAoIO18hOwX4smGi3fxdz
X-Google-Smtp-Source: AGHT+IELM0fBx9fOf0rQ8pZ6h0rW43hS1lIsnd5aooH7E0TXVdzGupxSxTuUV88qqkRSdD+WHBQU+U9/bWwvxKjSYdKs+qchb4QP
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:1908:b0:690:d251:28b9 with SMTP id
 y8-20020a056a00190800b00690d25128b9mr6006920pfi.4.1701475041636; Fri, 01 Dec
 2023 15:57:21 -0800 (PST)
Date: Fri, 01 Dec 2023 15:57:21 -0800
In-Reply-To: <000000000000f0bfe70605025941@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000737829060b7b8775@google.com>
Subject: Re: [syzbot] [gfs2?] kernel BUG in gfs2_quota_cleanup
From: syzbot <syzbot+3b6e67ac2b646da57862@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rpeterso@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    994d5c58e50e Merge tag 'hardening-v6.7-rc4' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=165bc8d2e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2c74446ab4f0028
dashboard link: https://syzkaller.appspot.com/bug?extid=3b6e67ac2b646da57862
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1268c086e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164b3faae80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dceb288ab9b9/disk-994d5c58.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/00a42d6cc05c/vmlinux-994d5c58.xz
kernel image: https://storage.googleapis.com/syzbot-assets/039fd7f1b283/bzImage-994d5c58.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4022e7b58a1d/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3b6e67ac2b646da57862@syzkaller.appspotmail.com

gfs2: fsid=syz:syz.0: first mount done, others may mount
------------[ cut here ]------------
kernel BUG at fs/gfs2/quota.c:1508!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5060 Comm: syz-executor505 Not tainted 6.7.0-rc3-syzkaller-00134-g994d5c58e50e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:gfs2_quota_cleanup+0x6b5/0x6c0 fs/gfs2/quota.c:1508
Code: fe e9 cf fd ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c 2d fe ff ff 4c 89 ef e8 b6 19 23 fe e9 20 fe ff ff e8 ec 11 c7 fd 90 <0f> 0b e8 84 9c 4f 07 0f 1f 40 00 66 0f 1f 00 55 41 57 41 56 41 54
RSP: 0018:ffffc9000409f9e0 EFLAGS: 00010293
RAX: ffffffff83c76854 RBX: 0000000000000002 RCX: ffff888026001dc0
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: ffffc9000409fb00 R08: ffffffff83c762b0 R09: 1ffff1100fd38015
R10: dffffc0000000000 R11: ffffed100fd38016 R12: dffffc0000000000
R13: ffff88807e9c0828 R14: ffff888014693580 R15: ffff88807e9c0000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f16d1bd70f8 CR3: 0000000027199000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 gfs2_put_super+0x2e1/0x940 fs/gfs2/super.c:611
 generic_shutdown_super+0x13a/0x2c0 fs/super.c:696
 kill_block_super+0x44/0x90 fs/super.c:1667
 deactivate_locked_super+0xc1/0x130 fs/super.c:484
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1256
 task_work_run+0x24a/0x300 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa34/0x2750 kernel/exit.c:871
 do_group_exit+0x206/0x2c0 kernel/exit.c:1021
 __do_sys_exit_group kernel/exit.c:1032 [inline]
 __se_sys_exit_group kernel/exit.c:1030 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1030
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f16d1b4b789
Code: Unable to access opcode bytes at 0x7f16d1b4b75f.
RSP: 002b:00007ffcad68ef38 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f16d1b4b789
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 00007f16d1bd92d0 R08: ffffffffffffffb8 R09: 00007ffcad68f010
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f16d1bd92d0
R13: 0000000000000000 R14: 00007f16d1bda040 R15: 00007f16d1b19cc0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:gfs2_quota_cleanup+0x6b5/0x6c0 fs/gfs2/quota.c:1508
Code: fe e9 cf fd ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c 2d fe ff ff 4c 89 ef e8 b6 19 23 fe e9 20 fe ff ff e8 ec 11 c7 fd 90 <0f> 0b e8 84 9c 4f 07 0f 1f 40 00 66 0f 1f 00 55 41 57 41 56 41 54
RSP: 0018:ffffc9000409f9e0 EFLAGS: 00010293
RAX: ffffffff83c76854 RBX: 0000000000000002 RCX: ffff888026001dc0
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: ffffc9000409fb00 R08: ffffffff83c762b0 R09: 1ffff1100fd38015
R10: dffffc0000000000 R11: ffffed100fd38016 R12: dffffc0000000000
R13: ffff88807e9c0828 R14: ffff888014693580 R15: ffff88807e9c0000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f16d1bd70f8 CR3: 000000000d730000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

