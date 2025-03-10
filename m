Return-Path: <linux-fsdevel+bounces-43567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 492D0A58CB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 08:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7923616BFE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 07:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F0B1D63ED;
	Mon, 10 Mar 2025 07:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2q588JQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FFE1D5AAD;
	Mon, 10 Mar 2025 07:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741591309; cv=none; b=euD7EgKRupDyc6hy/J07IB7Tf8VtNYrR3fdD0b1PduIuw1GT0lQfaLa5Q3OeHVnS2anmRAX9TW/lDuBu8eJaWTRhkmcQf+/JQ7W90Qc02zk0TljonZh4yMH4Qw2keXNM0y+UxX04USSKdKeatb/XfJdF+tPsEoHcV4VK8082Hcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741591309; c=relaxed/simple;
	bh=bwzwOjpoJdTp8dStniYCS+eiqWFCsaTpoCpnmRYoBVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XTUfMnS079z3IZ9MMfJelUSFFm9AXsdxL3gNjfwjoehjE9nyBNvyLYxpptkRdGf+QQbBIbkjavremBTKzclNSBybHrKeSIzOPg9ikhiei74dkbEKQGgJaaZU4mLJUczu8nUQlVGFIkSqsf82z8ayiMHloOKjoxJccUmw0gaYUB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2q588JQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C27C4CEE5;
	Mon, 10 Mar 2025 07:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741591309;
	bh=bwzwOjpoJdTp8dStniYCS+eiqWFCsaTpoCpnmRYoBVQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G2q588JQEantEptls1igKb1mCeSfH0cMWDtWBrm35xkL9CaLjxWwxAnJPpsOe5Qft
	 gZaw/kn0KbqvcWeuy6qer3a2ZwLeywtAxbQB+z5IJc5Olwhfq0h9rLClfmIigdvEnD
	 Xoeh8nDmG8nWK0dcT+0yPwH+se0FuMRDysYq4Vx6I2MASDUwff9loljo3qXg/dutqa
	 fL95cvVm3Tc+7+HmVr29TgIuUoIuc6bzZCqFRrcdTW0/2MHaiNXurDrPVrVjXhSlf5
	 J4Y0yZwxK59Rkvzt1S6eiswe3UMv2UUg9PvifQomJbPF9lerc+0qAtlddPT6wrA0zV
	 mK2QFRvujxR2Q==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30761be8fa8so42718641fa.2;
        Mon, 10 Mar 2025 00:21:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+sjia7lDk3ELfd1/1oNb6Iu3tH9Z2avt8Bsh3xI781LuGFoYMNKZZ/l/C2paW2HaIluW6lyQGyYhnqVrD@vger.kernel.org, AJvYcCV2imihIXc3eMrJYFwAo9jgs+5DLsWX3mpSAoayFrPaIsMXd0dVZr8/Mg1CqBeY//Qz+0gLcBclQlR7RdTOwA==@vger.kernel.org, AJvYcCWdOFOs89rsP1Wnpf/RODGTFS3qwE7gWAcRER49Z19KG/x8k3/Y+P/nLMZ4YuE19XJIuGfuOO+iGCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVmnANHeuyrLkJ3L4w7OAfCxVKs1hGz2i96LEv+ezC5rffhI49
	Dqg8ECcVqtGfKEUlBgMyMc4YvYD/a3B0/6CSpu4T6dGTLLd0GRjhVOcdvJbTIezKQAw4rqaLpyj
	D2LrPy9JL8SiiDetGVCy/hWrOeO8=
X-Google-Smtp-Source: AGHT+IGge2A+fnL8sOyilyTq9nCYuH103mq7sQ/sC1+LPZhomoy5MIoKYB8jPThuj9l7/H8hSZJKNPij57l1IvvXYPA=
X-Received: by 2002:a2e:960a:0:b0:307:e498:1254 with SMTP id
 38308e7fff4ca-30bf4613baemr36896451fa.35.1741591307671; Mon, 10 Mar 2025
 00:21:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67cd0276.050a0220.14db68.006c.GAE@google.com>
In-Reply-To: <67cd0276.050a0220.14db68.006c.GAE@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 10 Mar 2025 08:21:36 +0100
X-Gmail-Original-Message-ID: <CAMj1kXER-4ErtQiU6oPWfOEsmTz8pqPOsQ3GB8EGQeHhHXS0_w@mail.gmail.com>
X-Gm-Features: AQ5f1Jp_t0I_OP6aZ1QHAnkD4_UsvVHnzfc1Q5x29HnwX01uUG60SpbDECqNSO8
Message-ID: <CAMj1kXER-4ErtQiU6oPWfOEsmTz8pqPOsQ3GB8EGQeHhHXS0_w@mail.gmail.com>
Subject: Re: [syzbot] [efi?] [fs?] possible deadlock in efivarfs_actor
To: syzbot <syzbot+019072ad24ab1d948228@syzkaller.appspotmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>
Cc: jk@ozlabs.org, linux-efi@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

(cc James)

On Sun, 9 Mar 2025 at 03:52, syzbot
<syzbot+019072ad24ab1d948228@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    e056da87c780 Merge remote-tracking branch 'will/for-next/p..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=14ce9c64580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d6b7e15dc5b5e776
> dashboard link: https://syzkaller.appspot.com/bug?extid=019072ad24ab1d948228
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111ed7a0580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b97c64580000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/3d8b1b7cc4c0/disk-e056da87.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b84c04cff235/vmlinux-e056da87.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2ae4d0525881/Image-e056da87.gz.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+019072ad24ab1d948228@syzkaller.appspotmail.com
>
> efivarfs: resyncing variable state
> ============================================
> WARNING: possible recursive locking detected
> 6.14.0-rc4-syzkaller-ge056da87c780 #0 Not tainted
> --------------------------------------------
> syz-executor772/6443 is trying to acquire lock:
> ffff0000c6826558 (&sb->s_type->i_mutex_key#16){++++}-{4:4}, at: inode_lock include/linux/fs.h:877 [inline]
> ffff0000c6826558 (&sb->s_type->i_mutex_key#16){++++}-{4:4}, at: efivarfs_actor+0x1b8/0x2b8 fs/efivarfs/super.c:422
>
> but task is already holding lock:
> ffff0000c6c7a558 (&sb->s_type->i_mutex_key#16){++++}-{4:4}, at: iterate_dir+0x3b4/0x5f4 fs/readdir.c:101
>
> other info that might help us debug this:
>  Possible unsafe locking scenario:
>
>        CPU0
>        ----
>   lock(&sb->s_type->i_mutex_key#16);
>   lock(&sb->s_type->i_mutex_key#16);
>
>  *** DEADLOCK ***
>
>  May be due to missing lock nesting notation
>
> 3 locks held by syz-executor772/6443:
>  #0: ffff80008fc57208 (system_transition_mutex){+.+.}-{4:4}, at: lock_system_sleep+0x68/0xc0 kernel/power/main.c:56
>  #1: ffff80008fc75d70 ((pm_chain_head).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain+0x58/0xa0 kernel/notifier.c:379
>  #2: ffff0000c6c7a558 (&sb->s_type->i_mutex_key#16){++++}-{4:4}, at: iterate_dir+0x3b4/0x5f4 fs/readdir.c:101
>
> stack backtrace:
> CPU: 0 UID: 0 PID: 6443 Comm: syz-executor772 Not tainted 6.14.0-rc4-syzkaller-ge056da87c780 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
> Call trace:
>  show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:120
>  dump_stack+0x1c/0x28 lib/dump_stack.c:129
>  print_deadlock_bug+0x4e8/0x668 kernel/locking/lockdep.c:3039
>  check_deadlock kernel/locking/lockdep.c:3091 [inline]
>  validate_chain kernel/locking/lockdep.c:3893 [inline]
>  __lock_acquire+0x6240/0x7904 kernel/locking/lockdep.c:5228
>  lock_acquire+0x23c/0x724 kernel/locking/lockdep.c:5851
>  down_write+0x50/0xc0 kernel/locking/rwsem.c:1577
>  inode_lock include/linux/fs.h:877 [inline]
>  efivarfs_actor+0x1b8/0x2b8 fs/efivarfs/super.c:422
>  dir_emit include/linux/fs.h:3849 [inline]
>  dcache_readdir+0x2dc/0x4e8 fs/libfs.c:209
>  iterate_dir+0x46c/0x5f4 fs/readdir.c:108
>  efivarfs_pm_notify+0x2f4/0x350 fs/efivarfs/super.c:517
>  notifier_call_chain+0x1c4/0x550 kernel/notifier.c:85
>  blocking_notifier_call_chain+0x70/0xa0 kernel/notifier.c:380
>  pm_notifier_call_chain+0x2c/0x3c kernel/power/main.c:109
>  snapshot_release+0x128/0x1b8 kernel/power/user.c:125
>  __fput+0x340/0x760 fs/file_table.c:464
>  ____fput+0x20/0x30 fs/file_table.c:492
>  task_work_run+0x230/0x2e0 kernel/task_work.c:227
>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>  do_notify_resume+0x178/0x1f4 arch/arm64/kernel/entry-common.c:151
>  exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
>  exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
>  el0_svc+0xac/0x168 arch/arm64/kernel/entry-common.c:745
>  el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

