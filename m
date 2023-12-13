Return-Path: <linux-fsdevel+bounces-5837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F48810EF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 11:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B871C209CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 10:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C6822EF9;
	Wed, 13 Dec 2023 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V44Sl9P/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD76CD0;
	Wed, 13 Dec 2023 02:52:04 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6d9d0d0e083so5466742a34.2;
        Wed, 13 Dec 2023 02:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702464724; x=1703069524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ftCfKCRq8OSmkVdhonRoEbR3cW4p8KApUvLOiMHS90=;
        b=V44Sl9P/FVL5iANVHR9HcWq+M0ix7KFOpAFm7QNp+3hlyVRqb3Su1Eix+9VcmbkoCj
         n5sRVixxAAVTTHao8fgv89+Gj/QTdYeuDR+x+QsjH/yDuv4HkOtpx1ymAz8gqZRuKSbU
         gwxjX7cGuM1RSmgLECsrX8b89tqtb+N5wumFlfqI8Iq0XXFB+iqUzBa6J3zYEVEWpt6U
         rxZqotz846LCOpuYUXs1eb7pflHhRgt8LhlrJ1rRzxQTbnRQcp5zOp/mLeLfRo4TFMYw
         ahFHIra3vHLU6USyCmbX6IxgZHF7Ks+zKKpz8f8T9WOsMCtSNe9jc+NOGT3TIUqayOKY
         /Qqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702464724; x=1703069524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ftCfKCRq8OSmkVdhonRoEbR3cW4p8KApUvLOiMHS90=;
        b=ZjBbwGLtArJvgER5LjWNDn8f5/7tYJ26GG2pT7NBHm31ITohBDBqkDBOMf8ewFwPZ9
         igTAxVe3cqilbhqv7/A1ivpbK+Et4Rod6XANfjUbpmPMSrG8Hfch7oLWcpgj/H1PAiVu
         0G/wpbvURuLlufwFUE4BT1pD6WBjJKfcWcXySilYBlODyu/xKXSxZ/pTm7KCjJDj9Wzw
         +WMkvVTuncU7M8wCe/qne/RjZCTNVBI/Ewz4eg+gxL9KSet8vPZ8VpGJ6waop1CtajuH
         TZaSyj7GSKw2QdBvLIP2XfH0BgrXCtyQfAhFGqre3d3+MGzkhH1LdFQTWK9Fdv8JT3lG
         Uvaw==
X-Gm-Message-State: AOJu0YyTkbnFkYsKwy1PXvMrw6s713htKsFD0HU3DCocp75VL7e5hSb/
	FBh5o6yQfODtoAGRuUWxwIkQjPW956CdmswYAo3psZIrceieEFz9/yY=
X-Google-Smtp-Source: AGHT+IEhOwLDdsL1rDjuQWnfr8eQYM7RQGDjEVbTdPSRFz0mGSqoBTdCANLKdT9kETk5mGKLmGtLBPCQpRILb3C6nYU=
X-Received: by 2002:a9d:7694:0:b0:6d9:eaa0:fa84 with SMTP id
 j20-20020a9d7694000000b006d9eaa0fa84mr7974349otl.10.1702464723826; Wed, 13
 Dec 2023 02:52:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABOYnLwGoNXXzvvn+YmCcjLu6ttAJGGTaN8+O_tNdPqcjHnfUA@mail.gmail.com>
 <20231213-drehen-einquartieren-56bbdda1177e@brauner>
In-Reply-To: <20231213-drehen-einquartieren-56bbdda1177e@brauner>
From: xingwei lee <xrivendell7@gmail.com>
Date: Wed, 13 Dec 2023 18:51:52 +0800
Message-ID: <CABOYnLw6eseXiPJpUf2PD5Qqqy79zMd1hTRwYOstq1MayG+5RA@mail.gmail.com>
Subject: Re: [syzbot] [gfs2] WARNING in vfs_utimes
To: Christian Brauner <brauner@kernel.org>
Cc: syzbot+0c64a8706d587f73409e@syzkaller.appspotmail.com, 
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Wed, Dec 13, 2023 at 02:35:58PM +0800, xingwei lee wrote:
> > Hello, I reproduced this bug with repro.c and repro.txt since it
> > relatively large please see
> > https://gist.github.com/xrivendell7/b3b804bbf6d8c9930b2ba22e2dfaa6e6
> >
> > Since this bug in the dashboard
> > https://syzkaller.appspot.com/bug?extid=3D0c64a8706d587f73409e use
> > kernel commit: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds=
/linux.git/log/?id=3Daed8aee11130a954356200afa3f1b8753e8a9482
> > kernel config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=
=3Ddf91a3034fe3f122
> >
> > my repro.c use the seem config and it crash report like below, and
> > it=E2=80=99s almost can make sure it the same as bug reported by syzobt=
.
>
> Uh, can you reproduce this on mainline?
> I so far fail to even with your repro.
Hi
I can still trigger my repro.c in the last mainline at HEAD: 88035e5694a8.
As I say before the crash titled is WARNING in __folio_mark_dirty not
WARNING in __folio_mark_dirty
look this crash scene:

root@syzkaller:~# uname -a
Linux syzkaller 6.7.0-rc5-00042-g88035e5694a8 #3 SMP PREEMPT_DYNAMIC
Wed Dec 13 12:47:36 CST 2023 x86_64 GNU/Linux
root@syzkaller:~# ./c90
Setting up swapspace version 1, size =3D 122.1 MiB (127995904 bytes)
no label, UUID=3Dfc291aa6-a2a5-45b4-a290-1a2e1b9725f9
[   92.326728][ T8104] Adding 124996k swap on ./swap-file.  Priority:0
extents:1 across:124996k
[   92.476988][ T8133] loop0: detected capacity change from 0 to 32768
[   92.480453][ T8133] gfs2: fsid=3Dsyz:syz: Trying to join cluster
"lock_nolock", "syz:syz"
[   92.480867][ T8133] gfs2: fsid=3Dsyz:syz: Now mounting FS (format 1802).=
..
[   92.484105][ T8133] gfs2: fsid=3Dsyz:syz.0: journal 0 mapped with 14
extents in 0ms
[   92.485628][ T4549] gfs2: fsid=3Dsyz:syz.0: jid=3D0, already locked for =
use
[   92.485963][ T4549] gfs2: fsid=3Dsyz:syz.0: jid=3D0: Looking at journal.=
..
[   92.497655][ T4549] gfs2: fsid=3Dsyz:syz.0: jid=3D0: Journal head
lookup took 11ms
[   92.498197][ T4549] gfs2: fsid=3Dsyz:syz.0: jid=3D0: Done
[   92.498521][ T8133] gfs2: fsid=3Dsyz:syz.0: first mount done, others may=
 mount
[   92.546508][ T8107] ------------[ cut here ]------------
[   92.546835][ T8107] WARNING: CPU: 2 PID: 8107 at
include/linux/backing-dev.h:255 __folio_mark_dirty+0x936/0x1120
[   92.547304][ T8107] Modules linked in:
[   92.547483][ T8107] CPU: 2 PID: 8107 Comm: c90 Not tainted
6.7.0-rc5-00042-g88035e5694a8 #3
[   92.547848][ T8107] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   92.548297][ T8107] RIP: 0010:__folio_mark_dirty+0x936/0x1120
[   92.548558][ T8107] Code: f8 ff ff e8 5c 72 c8 ff 0f 0b e9 c9 f8 ff
ff 31 ff e8 4e 72 c8 ff 4c 89 f7 48 8b 74 24 20 e8 b1 15 2f 00 eb 9d
e8 3a 72 c8 ff <0f> 0b e9 27 fb ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f
8c dc f8 ff
[   92.549390][ T8107] RSP: 0018:ffffc9001389fa00 EFLAGS: 00010093
[   92.549660][ T8107] RAX: ffffffff81c92f96 RBX: 0000000000000000
RCX: ffff888153fe9e80
[   92.550009][ T8107] RDX: 0000000000000000 RSI: 0000000000000000
RDI: 0000000000000000
[   92.550357][ T8107] RBP: ffff888148d91fb8 R08: ffffffff81c92ab5
R09: 1ffff110291b23f7
[   92.550704][ T8107] R10: dffffc0000000000 R11: ffffed10291b23f8
R12: 0000000000000001
[   92.551053][ T8107] R13: ffff888148d91e40 R14: ffffea00052ec2c0
R15: 1ffff110291b23f7
[   92.551400][ T8107] FS:  0000000001cbb3c0(0000)
GS:ffff8880b9900000(0000) knlGS:0000000000000000
[   92.551790][ T8107] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   92.552089][ T8107] CR2: 0000000001cc4738 CR3: 0000000154470000
CR4: 0000000000750ef0
[   92.552452][ T8107] PKRU: 55555554
[   92.552621][ T8107] Call Trace:
[   92.552778][ T8107]  <TASK>
[   92.552919][ T8107]  ? __warn+0x16a/0x4c0
[   92.553125][ T8107]  ? __folio_mark_dirty+0x936/0x1120
[   92.553376][ T8107]  ? report_bug+0x2ca/0x520
[   92.553603][ T8107]  ? __folio_mark_dirty+0x936/0x1120
[   92.553854][ T8107]  ? handle_bug+0x3d/0x70
[   92.554062][ T8107]  ? exc_invalid_op+0x1a/0x50
[   92.554285][ T8107]  ? asm_exc_invalid_op+0x1a/0x20
[   92.554532][ T8107]  ? __folio_mark_dirty+0x455/0x1120
[   92.554778][ T8107]  ? __folio_mark_dirty+0x936/0x1120
[   92.555027][ T8107]  ? __folio_mark_dirty+0x936/0x1120
[   92.555279][ T8107]  mark_buffer_dirty+0x2ab/0x520
[   92.555520][ T8107]  gfs2_unpin+0x142/0xad0
[   92.555732][ T8107]  ? log_pull_tail+0x87/0x390
[   92.555956][ T8107]  buf_lo_after_commit+0x157/0x1b0
[   92.556199][ T8107]  ? buf_lo_before_commit+0xf0/0xf0
[   92.556443][ T8107]  gfs2_log_flush+0x1f45/0x26a0
[   92.556671][ T8107]  ? print_irqtrace_events+0x220/0x220
[   92.556938][ T8107]  ? gfs2_ail_empty_tr+0x320/0x320
[   92.557178][ T8107]  ? rcu_force_quiescent_state+0x230/0x230
[   92.557453][ T8107]  ? radix_tree_delete_item+0x2fd/0x420
[   92.557714][ T8107]  gfs2_kill_sb+0x60/0x340
[   92.557924][ T8107]  ? shrinker_free+0x2d8/0x3e0
[   92.558150][ T8107]  deactivate_locked_super+0xc8/0x140
[   92.558407][ T8107]  cleanup_mnt+0x444/0x4e0
[   92.558618][ T8107]  ? _raw_spin_unlock_irq+0x23/0x50
[   92.558868][ T8107]  task_work_run+0x257/0x310
[   92.559091][ T8107]  ? task_work_cancel+0x2c0/0x2c0
[   92.559330][ T8107]  ? exit_to_user_mode_loop+0x39/0x100
[   92.559588][ T8107]  exit_to_user_mode_loop+0xde/0x100
[   92.559837][ T8107]  exit_to_user_mode_prepare+0xb1/0x140
[   92.560098][ T8107]  syscall_exit_to_user_mode+0x64/0x280
[   92.560367][ T8107]  do_syscall_64+0x50/0x110
[   92.560582][ T8107]  entry_SYSCALL_64_after_hwframe+0x63/0x6b
[   92.560859][ T8107] RIP: 0033:0x43f117
[   92.561047][ T8107] Code: 09 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84
00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6
00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8
64 89 02 b8
[   92.561908][ T8107] RSP: 002b:00007fff2befd8e8 EFLAGS: 00000206
ORIG_RAX: 00000000000000a6
[   92.562290][ T8107] RAX: 0000000000000000 RBX: 00007fff2befec28
RCX: 000000000043f117
[   92.562650][ T8107] RDX: 0000000000000000 RSI: 000000000000000a
RDI: 00007fff2befd990
[   92.563010][ T8107] RBP: 00007fff2befe9d0 R08: 0000000000000000
R09: 0000000000000000
[   92.563367][ T8107] R10: 00000000ffffffff R11: 0000000000000206
R12: 0000000000000001
[   92.563719][ T8107] R13: 00007fff2befec18 R14: 0000000000000001
R15: 0000000000000001
[   92.564078][ T8107]  </TASK>
[   92.564220][ T8107] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[   92.564542][ T8107] CPU: 2 PID: 8107 Comm: c90 Not tainted
6.7.0-rc5-00042-g88035e5694a8 #3
[   92.564919][ T8107] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   92.565374][ T8107] Call Trace:
[   92.565528][ T8107]  <TASK>
[   92.565665][ T8107]  dump_stack_lvl+0x1f4/0x2f0
[   92.565885][ T8107]  ? nf_tcp_handle_invalid+0x680/0x680
[   92.566135][ T8107]  ? panic+0x880/0x880
[   92.566331][ T8107]  ? vscnprintf+0x64/0x90
[   92.566532][ T8107]  panic+0x35a/0x880
[   92.566717][ T8107]  ? __warn+0x179/0x4c0
[   92.566911][ T8107]  ? __memcpy_flushcache+0x2d0/0x2d0
[   92.567163][ T8107]  __warn+0x32e/0x4c0
[   92.567349][ T8107]  ? __folio_mark_dirty+0x936/0x1120
[   92.567592][ T8107]  report_bug+0x2ca/0x520
[   92.567793][ T8107]  ? __folio_mark_dirty+0x936/0x1120
[   92.568037][ T8107]  handle_bug+0x3d/0x70
[   92.568231][ T8107]  exc_invalid_op+0x1a/0x50
[   92.568440][ T8107]  asm_exc_invalid_op+0x1a/0x20
[   92.568664][ T8107] RIP: 0010:__folio_mark_dirty+0x936/0x1120
[   92.568930][ T8107] Code: f8 ff ff e8 5c 72 c8 ff 0f 0b e9 c9 f8 ff
ff 31 ff e8 4e 72 c8 ff 4c 89 f7 48 8b 74 24 20 e8 b1 15 2f 00 eb 9d
e8 3a 72 c8 ff <0f> 0b e9 27 fb ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f
8c dc f8 ff
[   92.569771][ T8107] RSP: 0018:ffffc9001389fa00 EFLAGS: 00010093
[   92.570047][ T8107] RAX: ffffffff81c92f96 RBX: 0000000000000000
RCX: ffff888153fe9e80
[   92.570406][ T8107] RDX: 0000000000000000 RSI: 0000000000000000
RDI: 0000000000000000
[   92.570764][ T8107] RBP: ffff888148d91fb8 R08: ffffffff81c92ab5
R09: 1ffff110291b23f7
[   92.571122][ T8107] R10: dffffc0000000000 R11: ffffed10291b23f8
R12: 0000000000000001
[   92.571481][ T8107] R13: ffff888148d91e40 R14: ffffea00052ec2c0
R15: 1ffff110291b23f7
[   92.571844][ T8107]  ? __folio_mark_dirty+0x455/0x1120
[   92.572091][ T8107]  ? __folio_mark_dirty+0x936/0x1120
[   92.572346][ T8107]  mark_buffer_dirty+0x2ab/0x520
[   92.572581][ T8107]  gfs2_unpin+0x142/0xad0
[   92.572785][ T8107]  ? log_pull_tail+0x87/0x390
[   92.573010][ T8107]  buf_lo_after_commit+0x157/0x1b0
[   92.573249][ T8107]  ? buf_lo_before_commit+0xf0/0xf0
[   92.573493][ T8107]  gfs2_log_flush+0x1f45/0x26a0
[   92.573721][ T8107]  ? print_irqtrace_events+0x220/0x220
[   92.573982][ T8107]  ? gfs2_ail_empty_tr+0x320/0x320
[   92.574222][ T8107]  ? rcu_force_quiescent_state+0x230/0x230
[   92.574494][ T8107]  ? radix_tree_delete_item+0x2fd/0x420
[   92.574754][ T8107]  gfs2_kill_sb+0x60/0x340
[   92.574965][ T8107]  ? shrinker_free+0x2d8/0x3e0
[   92.575191][ T8107]  deactivate_locked_super+0xc8/0x140
[   92.575444][ T8107]  cleanup_mnt+0x444/0x4e0
[   92.575654][ T8107]  ? _raw_spin_unlock_irq+0x23/0x50
[   92.575898][ T8107]  task_work_run+0x257/0x310
[   92.576118][ T8107]  ? task_work_cancel+0x2c0/0x2c0
[   92.576363][ T8107]  ? exit_to_user_mode_loop+0x39/0x100
[   92.576620][ T8107]  exit_to_user_mode_loop+0xde/0x100
[   92.576871][ T8107]  exit_to_user_mode_prepare+0xb1/0x140
[   92.577129][ T8107]  syscall_exit_to_user_mode+0x64/0x280
[   92.577390][ T8107]  do_syscall_64+0x50/0x110
[   92.577604][ T8107]  entry_SYSCALL_64_after_hwframe+0x63/0x6b
[   92.577879][ T8107] RIP: 0033:0x43f117
[   92.578062][ T8107] Code: 09 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84
00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6
00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8
64 89 02 b8
[   92.578920][ T8107] RSP: 002b:00007fff2befd8e8 EFLAGS: 00000206
ORIG_RAX: 00000000000000a6
[   92.579299][ T8107] RAX: 0000000000000000 RBX: 00007fff2befec28
RCX: 000000000043f117
[   92.579655][ T8107] RDX: 0000000000000000 RSI: 000000000000000a
RDI: 00007fff2befd990
[   92.580014][ T8107] RBP: 00007fff2befe9d0 R08: 0000000000000000
R09: 0000000000000000
[   92.580375][ T8107] R10: 00000000ffffffff R11: 0000000000000206
R12: 0000000000000001
[   92.580732][ T8107] R13: 00007fff2befec18 R14: 0000000000000001
R15: 0000000000000001
[   92.581097][ T8107]  </TASK>
[   92.581318][ T8107] Kernel Offset: disabled
[   92.581592][ T8107] Rebooting in 86400 seconds..

Please check again.

Thanks!
Best regards
xingwei Lee.

