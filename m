Return-Path: <linux-fsdevel+bounces-2778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C507E913E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 15:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB86B1F20EF5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 14:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7ED314286;
	Sun, 12 Nov 2023 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeLpvV77"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D97F12B8D
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Nov 2023 14:37:09 +0000 (UTC)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB22B2D57;
	Sun, 12 Nov 2023 06:37:07 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a7d9d357faso40202717b3.0;
        Sun, 12 Nov 2023 06:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699799827; x=1700404627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qiTdi6HkTOICIVjp3Fua9oyqz+hmPpvk/xv8wWPEopg=;
        b=GeLpvV77nK23Yf7hPuuS6wsb2y0nmVtS4js4yMsqu0sOOSMfcSGg1FU19gRmgeH0b1
         WQSTkximzkFwJbVhTrFNo78X3Ow2uS/ewsWipg5QcpkMPLS9c9oZRdn6LWRoSzrVZ4bW
         o/4d3xmNnZuQkLq99Vt3W8czr37LE/dK4ZGCxYrPen/0J9qz/GYr7r+uvH9IQH2G+mse
         SqD4PL5Z8cDjkvFwCcAUBekvr7BjqPbELB23NF60vUM05orDQqS21MdqJxdbGms86WE/
         R7UlaZA+Q4kbI9Kya1gjmnrTGRC3GwuNTaB1lDOCOwjlRka0s0Pd1Uvwjz0WgA4xZ/qr
         OYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699799827; x=1700404627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qiTdi6HkTOICIVjp3Fua9oyqz+hmPpvk/xv8wWPEopg=;
        b=MPTDakCumaO7J61CcD6+9owZCQRF3tk7oyo3m0KJuetl9ijovPk9E2SgjatdX4qF/T
         Cw7PXcQDPkJNsm38+o17lZpNpw1aWEdNuOTTCLoEBwtERwpRP2HD1PZMDZ3o+KN728Bt
         uPDK6mWaO1yZtpWyIY7olaFyL55DhY5gw6cswo3HnaTPSAFo/euR5k8PCZnPFEoSXlcr
         w76L9TyxXKE3wQn0lm3YxT8vea8sOYcRmtNxPOJ7RkpncVNsdx+YtKB3A4tQHHLAAoHe
         XDVFKbVWYBFPIH0cFzJaJORMl44iPyPLUCypEKtAwdA7K9oKnZa/LUYxCtfLaV6eNE5N
         G50A==
X-Gm-Message-State: AOJu0Ywshx1iwh++R2CG+bTvKnVoVTkcxg/rf5+1cPUzTVLC9f5C+tnC
	CUuyK20xhOlTOYXDWoWl+0WygcIhfSYBqu9jIZwxXxUyQqE=
X-Google-Smtp-Source: AGHT+IHAoaDasX/DpvnYeJ01kgH85R0z8fwGmKpR4z1wrKTL5sT0uA+3KuNUns2ea6+nqgSmsL5nfE+pMdqwKxzM14U=
X-Received: by 2002:a0d:d281:0:b0:5a7:be6b:41c4 with SMTP id
 u123-20020a0dd281000000b005a7be6b41c4mr4706520ywd.12.1699799826997; Sun, 12
 Nov 2023 06:37:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000003c31650609ecd824@google.com> <CAOQ4uxh3i=eLJZeNu7VWS9L7OaVVRgyX9Yqr5hx15h9dYmWaXQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxh3i=eLJZeNu7VWS9L7OaVVRgyX9Yqr5hx15h9dYmWaXQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 12 Nov 2023 16:36:55 +0200
Message-ID: <CAOQ4uxhnY+hzfCA7A2aTfVKsveR9g6Hn=FbFrjFuXs8w3sYX5Q@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] memory leak in ovl_parse_param
To: syzbot <syzbot+26eedf3631650972f17c@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2023 at 11:10=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Sun, Nov 12, 2023 at 6:18=E2=80=AFAM syzbot
> <syzbot+26eedf3631650972f17c@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    13d88ac54ddd Merge tag 'vfs-6.7.fsid' of git://git.kern=
el...
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D121cf047680=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Decfdf78a410=
c834
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D26eedf3631650=
972f17c
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for=
 Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15c7a6eb6=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13f8b787680=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/9bb27a01f17c/d=
isk-13d88ac5.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/fb496feed171/vmli=
nux-13d88ac5.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/f4da22719ffa=
/bzImage-13d88ac5.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+26eedf3631650972f17c@syzkaller.appspotmail.com
> >
> > executing program
> > BUG: memory leak
> > unreferenced object 0xffff8881009b40a8 (size 8):
> >   comm "syz-executor225", pid 5035, jiffies 4294944336 (age 13.730s)
> >   hex dump (first 8 bytes):
> >     2e 00 00 00 00 00 00 00                          ........
> >   backtrace:
> >     [<ffffffff8163331d>] kmemleak_alloc_recursive include/linux/kmemlea=
k.h:42 [inline]
> >     [<ffffffff8163331d>] slab_post_alloc_hook mm/slab.h:766 [inline]
> >     [<ffffffff8163331d>] slab_alloc_node mm/slub.c:3478 [inline]
> >     [<ffffffff8163331d>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:=
3517
> >     [<ffffffff8157e57c>] __do_kmalloc_node mm/slab_common.c:1006 [inlin=
e]
> >     [<ffffffff8157e57c>] __kmalloc_node_track_caller+0x4c/0x150 mm/slab=
_common.c:1027
> >     [<ffffffff8156da4c>] kstrdup+0x3c/0x70 mm/util.c:62
> >     [<ffffffff81d0438a>] ovl_parse_param_lowerdir fs/overlayfs/params.c=
:496 [inline]
> >     [<ffffffff81d0438a>] ovl_parse_param+0x70a/0xc70 fs/overlayfs/param=
s.c:576
> >     [<ffffffff8170542b>] vfs_parse_fs_param+0xfb/0x190 fs/fs_context.c:=
146
> >     [<ffffffff81705556>] vfs_parse_fs_string+0x96/0xd0 fs/fs_context.c:=
188
> >     [<ffffffff8170566f>] vfs_parse_monolithic_sep+0xdf/0x130 fs/fs_cont=
ext.c:230
> >     [<ffffffff816dff08>] do_new_mount fs/namespace.c:3333 [inline]
> >     [<ffffffff816dff08>] path_mount+0xc48/0x10d0 fs/namespace.c:3664
> >     [<ffffffff816e0b41>] do_mount fs/namespace.c:3677 [inline]
> >     [<ffffffff816e0b41>] __do_sys_mount fs/namespace.c:3886 [inline]
> >     [<ffffffff816e0b41>] __se_sys_mount fs/namespace.c:3863 [inline]
> >     [<ffffffff816e0b41>] __x64_sys_mount+0x1a1/0x1f0 fs/namespace.c:386=
3
> >     [<ffffffff84b67d8f>] do_syscall_x64 arch/x86/entry/common.c:51 [inl=
ine]
> >     [<ffffffff84b67d8f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common=
.c:82
> >     [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b
> >
> > BUG: memory leak
> > unreferenced object 0xffff88814002d070 (size 8):
> >   comm "syz-executor225", pid 5036, jiffies 4294944900 (age 8.090s)
> >   hex dump (first 8 bytes):
> >     2e 00 00 00 00 00 00 00                          ........
> >   backtrace:
> >     [<ffffffff8163331d>] kmemleak_alloc_recursive include/linux/kmemlea=
k.h:42 [inline]
> >     [<ffffffff8163331d>] slab_post_alloc_hook mm/slab.h:766 [inline]
> >     [<ffffffff8163331d>] slab_alloc_node mm/slub.c:3478 [inline]
> >     [<ffffffff8163331d>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:=
3517
> >     [<ffffffff8157e57c>] __do_kmalloc_node mm/slab_common.c:1006 [inlin=
e]
> >     [<ffffffff8157e57c>] __kmalloc_node_track_caller+0x4c/0x150 mm/slab=
_common.c:1027
> >     [<ffffffff8156da4c>] kstrdup+0x3c/0x70 mm/util.c:62
> >     [<ffffffff81d0438a>] ovl_parse_param_lowerdir fs/overlayfs/params.c=
:496 [inline]
> >     [<ffffffff81d0438a>] ovl_parse_param+0x70a/0xc70 fs/overlayfs/param=
s.c:576
> >     [<ffffffff8170542b>] vfs_parse_fs_param+0xfb/0x190 fs/fs_context.c:=
146
> >     [<ffffffff81705556>] vfs_parse_fs_string+0x96/0xd0 fs/fs_context.c:=
188
> >     [<ffffffff8170566f>] vfs_parse_monolithic_sep+0xdf/0x130 fs/fs_cont=
ext.c:230
> >     [<ffffffff816dff08>] do_new_mount fs/namespace.c:3333 [inline]
> >     [<ffffffff816dff08>] path_mount+0xc48/0x10d0 fs/namespace.c:3664
> >     [<ffffffff816e0b41>] do_mount fs/namespace.c:3677 [inline]
> >     [<ffffffff816e0b41>] __do_sys_mount fs/namespace.c:3886 [inline]
> >     [<ffffffff816e0b41>] __se_sys_mount fs/namespace.c:3863 [inline]
> >     [<ffffffff816e0b41>] __x64_sys_mount+0x1a1/0x1f0 fs/namespace.c:386=
3
> >     [<ffffffff84b67d8f>] do_syscall_x64 arch/x86/entry/common.c:51 [inl=
ine]
> >     [<ffffffff84b67d8f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common=
.c:82
> >     [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b
> >
> >
>
> #syz test: https://github.com/amir73il/linux ovl-fixes

Please test take #2:
#syz test: https://github.com/amir73il/linux ovl-fixes

