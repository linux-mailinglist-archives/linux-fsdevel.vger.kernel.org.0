Return-Path: <linux-fsdevel+bounces-2769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC7B7E8F3C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 10:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41767B209BA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 09:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3475238;
	Sun, 12 Nov 2023 09:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7DSNSxS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9724403
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Nov 2023 09:10:24 +0000 (UTC)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D552D6B;
	Sun, 12 Nov 2023 01:10:22 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a7af52ee31so40027427b3.2;
        Sun, 12 Nov 2023 01:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699780221; x=1700385021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egHeFKQAtt7Sh019RKEMUVjVuogheud9F4PPfud93+M=;
        b=A7DSNSxS7Qodw7GA9DGycElW3jek5LcZb68NWp/mvS4EeknxqHA4Jj41oanEtXC593
         N0W6a2QHRbAX510Tt5GFCp4VsZuG/bdY5GN5XAKcrD8rKrU4dkQh8X2miuG3ZHfY0rRt
         j6SxH9eyffFRVb6lpXixUOri6tK1oq4flbFnctbp0+0lO75kQ9KPrba/89pnXi+JgAdS
         LVelX7jUVTJ/Ncq14EP7xWvY3Y0aKEJirfZRVQCJBFSfl0DPSFZ2wVVcNig3r4aBlzz5
         S8M9EkbVFcfvNABIaqzregKf1lGVOaEpjffWEcGY3elaA5GBw56bi+TGY7FVpt7eUTLo
         eLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699780221; x=1700385021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egHeFKQAtt7Sh019RKEMUVjVuogheud9F4PPfud93+M=;
        b=phFVKs/mMu/Thj6rku5OYY3XUMKddCYmyCY6ht3NdYTpeEffkFmwqm9wu8ub77hbEu
         4/Z9Hp5TbLtwvt8xWauKlzM4k/3EZUAEuSYHPkYWzD7OVnsCRHvNtKRUsU4KxJxDvGfS
         Dez5NNm6pbLFLAiLtUkBgcL6k7BavFdVn+FGQzV7sLtSps/hgBTqyuyh1SkshWYPBseU
         IB5i67/3ykqnpSkcAyBeRJvtbeff+pDUf2fnrS4AHK7z9VH6yG5Lfrpj6QXyNlVstRWt
         FtgolERotqNE8Y2ofhwWLvInfU6U8XOAhfapZ/c1Dvki0L2H2Gaz9IJpdV/Xx71ET8Jh
         errQ==
X-Gm-Message-State: AOJu0Yyqn3nszi26oFxM4bU7qpNZG/khwy8KcjejdfTVH4B9b7DRBVSn
	QKMFL+Y7e31X2tOKWGjOdh/tnjp1SdxoI6n0Y4s=
X-Google-Smtp-Source: AGHT+IHEpNqYolQIdXL5GhBpNI4l0q8587yNT7L6JwFWlNJDhvibzvQ/CRtV3S0Q8PvMjIDLAauySFFD6fGsyhSYXdQ=
X-Received: by 2002:a81:6d0a:0:b0:5a7:be1a:6c32 with SMTP id
 i10-20020a816d0a000000b005a7be1a6c32mr3401677ywc.24.1699780221591; Sun, 12
 Nov 2023 01:10:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000003c31650609ecd824@google.com>
In-Reply-To: <0000000000003c31650609ecd824@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 12 Nov 2023 11:10:10 +0200
Message-ID: <CAOQ4uxh3i=eLJZeNu7VWS9L7OaVVRgyX9Yqr5hx15h9dYmWaXQ@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] memory leak in ovl_parse_param
To: syzbot <syzbot+26eedf3631650972f17c@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2023 at 6:18=E2=80=AFAM syzbot
<syzbot+26eedf3631650972f17c@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    13d88ac54ddd Merge tag 'vfs-6.7.fsid' of git://git.kernel=
...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D121cf04768000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Decfdf78a410c8=
34
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D26eedf363165097=
2f17c
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15c7a6eb680=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13f8b78768000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/9bb27a01f17c/dis=
k-13d88ac5.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/fb496feed171/vmlinu=
x-13d88ac5.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/f4da22719ffa/b=
zImage-13d88ac5.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+26eedf3631650972f17c@syzkaller.appspotmail.com
>
> executing program
> BUG: memory leak
> unreferenced object 0xffff8881009b40a8 (size 8):
>   comm "syz-executor225", pid 5035, jiffies 4294944336 (age 13.730s)
>   hex dump (first 8 bytes):
>     2e 00 00 00 00 00 00 00                          ........
>   backtrace:
>     [<ffffffff8163331d>] kmemleak_alloc_recursive include/linux/kmemleak.=
h:42 [inline]
>     [<ffffffff8163331d>] slab_post_alloc_hook mm/slab.h:766 [inline]
>     [<ffffffff8163331d>] slab_alloc_node mm/slub.c:3478 [inline]
>     [<ffffffff8163331d>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:35=
17
>     [<ffffffff8157e57c>] __do_kmalloc_node mm/slab_common.c:1006 [inline]
>     [<ffffffff8157e57c>] __kmalloc_node_track_caller+0x4c/0x150 mm/slab_c=
ommon.c:1027
>     [<ffffffff8156da4c>] kstrdup+0x3c/0x70 mm/util.c:62
>     [<ffffffff81d0438a>] ovl_parse_param_lowerdir fs/overlayfs/params.c:4=
96 [inline]
>     [<ffffffff81d0438a>] ovl_parse_param+0x70a/0xc70 fs/overlayfs/params.=
c:576
>     [<ffffffff8170542b>] vfs_parse_fs_param+0xfb/0x190 fs/fs_context.c:14=
6
>     [<ffffffff81705556>] vfs_parse_fs_string+0x96/0xd0 fs/fs_context.c:18=
8
>     [<ffffffff8170566f>] vfs_parse_monolithic_sep+0xdf/0x130 fs/fs_contex=
t.c:230
>     [<ffffffff816dff08>] do_new_mount fs/namespace.c:3333 [inline]
>     [<ffffffff816dff08>] path_mount+0xc48/0x10d0 fs/namespace.c:3664
>     [<ffffffff816e0b41>] do_mount fs/namespace.c:3677 [inline]
>     [<ffffffff816e0b41>] __do_sys_mount fs/namespace.c:3886 [inline]
>     [<ffffffff816e0b41>] __se_sys_mount fs/namespace.c:3863 [inline]
>     [<ffffffff816e0b41>] __x64_sys_mount+0x1a1/0x1f0 fs/namespace.c:3863
>     [<ffffffff84b67d8f>] do_syscall_x64 arch/x86/entry/common.c:51 [inlin=
e]
>     [<ffffffff84b67d8f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c=
:82
>     [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
> BUG: memory leak
> unreferenced object 0xffff88814002d070 (size 8):
>   comm "syz-executor225", pid 5036, jiffies 4294944900 (age 8.090s)
>   hex dump (first 8 bytes):
>     2e 00 00 00 00 00 00 00                          ........
>   backtrace:
>     [<ffffffff8163331d>] kmemleak_alloc_recursive include/linux/kmemleak.=
h:42 [inline]
>     [<ffffffff8163331d>] slab_post_alloc_hook mm/slab.h:766 [inline]
>     [<ffffffff8163331d>] slab_alloc_node mm/slub.c:3478 [inline]
>     [<ffffffff8163331d>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:35=
17
>     [<ffffffff8157e57c>] __do_kmalloc_node mm/slab_common.c:1006 [inline]
>     [<ffffffff8157e57c>] __kmalloc_node_track_caller+0x4c/0x150 mm/slab_c=
ommon.c:1027
>     [<ffffffff8156da4c>] kstrdup+0x3c/0x70 mm/util.c:62
>     [<ffffffff81d0438a>] ovl_parse_param_lowerdir fs/overlayfs/params.c:4=
96 [inline]
>     [<ffffffff81d0438a>] ovl_parse_param+0x70a/0xc70 fs/overlayfs/params.=
c:576
>     [<ffffffff8170542b>] vfs_parse_fs_param+0xfb/0x190 fs/fs_context.c:14=
6
>     [<ffffffff81705556>] vfs_parse_fs_string+0x96/0xd0 fs/fs_context.c:18=
8
>     [<ffffffff8170566f>] vfs_parse_monolithic_sep+0xdf/0x130 fs/fs_contex=
t.c:230
>     [<ffffffff816dff08>] do_new_mount fs/namespace.c:3333 [inline]
>     [<ffffffff816dff08>] path_mount+0xc48/0x10d0 fs/namespace.c:3664
>     [<ffffffff816e0b41>] do_mount fs/namespace.c:3677 [inline]
>     [<ffffffff816e0b41>] __do_sys_mount fs/namespace.c:3886 [inline]
>     [<ffffffff816e0b41>] __se_sys_mount fs/namespace.c:3863 [inline]
>     [<ffffffff816e0b41>] __x64_sys_mount+0x1a1/0x1f0 fs/namespace.c:3863
>     [<ffffffff84b67d8f>] do_syscall_x64 arch/x86/entry/common.c:51 [inlin=
e]
>     [<ffffffff84b67d8f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c=
:82
>     [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
>

#syz test: https://github.com/amir73il/linux ovl-fixes

