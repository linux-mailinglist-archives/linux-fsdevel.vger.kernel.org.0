Return-Path: <linux-fsdevel+bounces-2267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A87B7E4347
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 16:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BCA11C20AB7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 15:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A9B31594;
	Tue,  7 Nov 2023 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D746A30D0B
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 15:19:29 +0000 (UTC)
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEDC2128
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 07:19:29 -0800 (PST)
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-6ce26047c6eso8276261a34.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Nov 2023 07:19:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699370368; x=1699975168;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iKQjuqUDwvEAIR3G1gt2zRHidvqLLvymJETtLU9xqm0=;
        b=EUUJW5QhApcKC2ml78RkTbRHOsTLyQBioBJ07+uwEHpTjd1NaTDn1hpAIZ46UOnznX
         otDTJbu9rpKK0FCW5gc+lEFqc7HK5bgAisTT6fWEYX6RLMoeUOGHMlZOsIjJ6Jwk6+vZ
         fl0Gw5QwiIEJ/dlbXEe5NdAu+8ZYutfIaCgEujEMGq+nrMxIiLH+cAJADmDnWQVUddyG
         tviBpWl86RrWcRplEOlbEC6deFO5r3qBD2toq9CW4cgzrfEbrhEF82FrMgjqGlCW6af3
         4LbSxeCrno8sfYL6Jb3HOIIJqpYrLIK2a4v0USzXd/dmjZNXWQLi+p4PuNpXb3bl94uB
         ncCQ==
X-Gm-Message-State: AOJu0Yytzj8bQ8RZ1FBGkB6I+naNHxSBCMNPdlp8LIVvq8uCGBIeQ5a+
	K3cEZg21QmWoXCvOGInsQ5lLhTvo5Nk+8IpBjl9sGNhiaqNn
X-Google-Smtp-Source: AGHT+IH60bkKUNTwkWitRcAezeZgRtPvUAjXKw/yqv0wm4pnsPHhRLpHdRDIbiVEzYCR9hV+oJZMvnYPP+lWDK3hIMUQlVCznGN9
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:241a:b0:1ea:973:51da with SMTP id
 n26-20020a056870241a00b001ea097351damr1409134oap.0.1699370368462; Tue, 07 Nov
 2023 07:19:28 -0800 (PST)
Date: Tue, 07 Nov 2023 07:19:28 -0800
In-Reply-To: <000000000000dba36305fa0f5e27@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002775cd0609917f4f@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_put_block_group
From: syzbot <syzbot+e38c6fff39c0d7d6f121@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    be3ca57cfb77 Merge tag 'media/v6.7-1' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11163cdf680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ffa1cec3b40f3ce
dashboard link: https://syzkaller.appspot.com/bug?extid=e38c6fff39c0d7d6f121
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f3c760e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1110877f680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9e42e209afb1/disk-be3ca57c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/faad7e361a8e/vmlinux-be3ca57c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/56d812634b0d/bzImage-be3ca57c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2e2950f94580/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e38c6fff39c0d7d6f121@syzkaller.appspotmail.com

BTRFS info (device loop2): at unmount dio bytes count 45056
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5067 at fs/btrfs/block-group.c:159 btrfs_put_block_group fs/btrfs/block-group.c:159 [inline]
WARNING: CPU: 0 PID: 5067 at fs/btrfs/block-group.c:159 btrfs_put_block_group+0x2c9/0x330 fs/btrfs/block-group.c:146
Modules linked in:
CPU: 0 PID: 5067 Comm: syz-executor383 Not tainted 6.6.0-syzkaller-15029-gbe3ca57cfb77 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:btrfs_put_block_group fs/btrfs/block-group.c:159 [inline]
RIP: 0010:btrfs_put_block_group+0x2c9/0x330 fs/btrfs/block-group.c:146
Code: 48 8d b8 e0 15 00 00 e8 f5 70 01 00 e9 b8 fe ff ff e8 db ca 43 fe e9 1f fe ff ff e8 d1 ca 43 fe e9 d7 fd ff ff e8 07 da ec fd <0f> 0b e9 61 fe ff ff e8 bb ca 43 fe e9 b5 fe ff ff e8 b1 ca 43 fe
RSP: 0018:ffffc90003a1fb48 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888026356000 RCX: ffffffff839bc0d8
RDX: ffff888061868000 RSI: ffffffff839bc279 RDI: 0000000000000007
RBP: 000000000000b000 R08: 0000000000000007 R09: 0000000000000000
R10: 000000000000b000 R11: 1ffff11004f89c32 R12: ffff888060c28000
R13: 0000000000000001 R14: ffff888026356160 R15: ffff888026356000
FS:  0000555556d0c380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7172fd2100 CR3: 000000007ef04000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 btrfs_free_block_groups+0x9f5/0x13d0 fs/btrfs/block-group.c:4360
 close_ctree+0x8c4/0xdd0 fs/btrfs/disk-io.c:4389
 generic_shutdown_super+0x161/0x3c0 fs/super.c:696
 kill_anon_super+0x3a/0x60 fs/super.c:1295
 btrfs_kill_super+0x3b/0x50 fs/btrfs/super.c:2097
 deactivate_locked_super+0xbc/0x1a0 fs/super.c:484
 deactivate_super+0xde/0x100 fs/super.c:517
 cleanup_mnt+0x222/0x450 fs/namespace.c:1256
 task_work_run+0x14d/0x240 kernel/task_work.c:180
 ptrace_notify+0x10c/0x130 kernel/signal.c:2399
 ptrace_report_syscall include/linux/ptrace.h:411 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:473 [inline]
 syscall_exit_work kernel/entry/common.c:251 [inline]
 syscall_exit_to_user_mode_prepare+0x120/0x220 kernel/entry/common.c:278
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0xd/0x60 kernel/entry/common.c:296
 do_syscall_64+0x4b/0x110 arch/x86/entry/common.c:88
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f7172f56677
Code: 07 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffe85c2eed8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000020373 RCX: 00007f7172f56677
RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007ffe85c2ef90
RBP: 00007ffe85c2ef90 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000206 R12: 00007ffe85c30000
R13: 0000555556d0d6c0 R14: 431bde82d7b634db R15: 00007ffe85c30020
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

