Return-Path: <linux-fsdevel+bounces-712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C417CEA6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 23:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CD59B211DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 21:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3AB41773;
	Wed, 18 Oct 2023 21:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biKRahs8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C70981A
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 21:58:30 +0000 (UTC)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA370B6;
	Wed, 18 Oct 2023 14:58:27 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d9ac31cb051so7999307276.3;
        Wed, 18 Oct 2023 14:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697666307; x=1698271107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGQCwKyIor48y9wb8o/gDwjQmrB8ZKSRAr5wAqYwfa4=;
        b=biKRahs8RDFKFG5Ex2M0aYGxkOZxYpB9MmDKw1x+LNT9OtXqFZcHT9x10xrM2T9poR
         UMzCuWmRE+YxW2TGledm7kwb+DpRY0PBoXWNfZisbFlTHc2bUjGRFJmYOhHI+ZosqnI/
         gHC/DUZ1bNZeAKLvE+X3b5WcgEt2cECikPGuTTOeLNF5I/o5yrGLyNsj7wRsobyGGqI7
         aXx8n4O880TeV7GGtPa/5oABx74NjNQF0nTIB8ch0TkujhpuSIRFKYKTbO22Ll3gke6Q
         bHS5bCE1k9yrfWP9g4f8yAb7oRs36mzi065nikxfMKez8cO/ZlUQigM2mCpDttQ7E2ex
         1kmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697666307; x=1698271107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGQCwKyIor48y9wb8o/gDwjQmrB8ZKSRAr5wAqYwfa4=;
        b=WPMqS5yX7XGTdXa1FnZlqH7Ijz6PQW56wrQZwFVGto8I3tDuKS/1cMnTD08HKJAgmw
         kFP3k7e7vZLG7q9XkoqW1bpESyx+1fIux1EqN6GnUGY6053mLj/O4kgWijo4o0Pz6w8E
         115AbGsapdwsC11MAmmYvd171+ayUFNIA1hx154GMJfuGTEqmCBqqlz7YZqV8RYY7mjs
         QJppS1a82oHnu/AjHKsc6reaVrK9NJbvGZf2hN+30LiwmPqecBhVoVWXvy2k4cEWAPUn
         Jg9veGvDqueev4YW9KEnZCfHMriY2OqfXSBfLNQD4G2vA+a5UsyG503olS1WpbRsSwi0
         QlPg==
X-Gm-Message-State: AOJu0YzeU8loJ91SoNUA4iet5dR97lAIf5KyZBd9elK7WbQ/dGH0aF8K
	z1xR5I2jhBqd23p+Pd/1KLrf0rqz3yBW/4yo4IHeRCgb
X-Google-Smtp-Source: AGHT+IE75tZCR/6ARBpU+CK0qHuCFVYNaw2D32W5H542WpcLhErh4g+iwKLp2yQtZc4YjxmYxaAuB4Vbel/AW1p8sZc=
X-Received: by 2002:a5b:a89:0:b0:d9c:a7fa:dbcb with SMTP id
 h9-20020a5b0a89000000b00d9ca7fadbcbmr601450ybq.22.1697666306986; Wed, 18 Oct
 2023 14:58:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000085670f060802a9bd@google.com> <20231018134858.e0c6445045f5f6c3954f6a62@linux-foundation.org>
 <CAOzc2pxr_Lzgbv-ddvifVdcOrA0X-2Y8Zz+WHjFWAuGu_CdZnA@mail.gmail.com>
In-Reply-To: <CAOzc2pxr_Lzgbv-ddvifVdcOrA0X-2Y8Zz+WHjFWAuGu_CdZnA@mail.gmail.com>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Wed, 18 Oct 2023 14:58:16 -0700
Message-ID: <CAOzc2pwADGHzVgsKV_L+tvYcpYr5U3VHx=QiyZVeKagfNcVc2g@mail.gmail.com>
Subject: Re: [syzbot] [mm?] [fs?] general protection fault in folio_flags
To: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+1e2648076cadf48ad9a1@syzkaller.appspotmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 2:30=E2=80=AFPM Vishal Moola <vishal.moola@gmail.co=
m> wrote:
>
> On Wed, Oct 18, 2023 at 1:49=E2=80=AFPM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
> >
> > On Wed, 18 Oct 2023 12:29:47 -0700 syzbot <syzbot+1e2648076cadf48ad9a1@=
syzkaller.appspotmail.com> wrote:
> >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    2dac75696c6d Add linux-next specific files for 202310=
18
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D138582756=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6f8545e1e=
f7a2b66
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D1e2648076ca=
df48ad9a1
> > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils f=
or Debian) 2.40
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D17543ee=
5680000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D101f5fe56=
80000
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/2375f16ed327=
/disk-2dac7569.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/c80aee6e2e6c/vm=
linux-2dac7569.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/664dc23b73=
8d/bzImage-2dac7569.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+1e2648076cadf48ad9a1@syzkaller.appspotmail.com
> >
> > Thanks.
> >
> > > general protection fault, probably for non-canonical address 0xdffffc=
0000000000: 0000 [#1] PREEMPT SMP KASA
> > > KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007=
]
> > > CPU: 1 PID: 5710 Comm: syz-executor155 Not tainted 6.6.0-rc6-next-202=
31018-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 09/06/2023
> > > RIP: 0010:PageTail include/linux/page-flags.h:286 [inline]
> > > RIP: 0010:folio_flags.constprop.0+0x21/0x150 include/linux/page-flags=
.h:313
> > > Code: 84 00 00 00 00 00 0f 1f 00 41 54 55 53 48 89 fb e8 14 2f a4 ff =
48 8d 7b 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 0=
0 0f 85 00 01 00 00 48 8b 6b 08 31 ff 83 e5 01 48 89 ee
> > > RSP: 0018:ffffc90004367968 EFLAGS: 00010247
> > > RAX: dffffc0000000000 RBX: fffffffffffffffe RCX: ffffffff81b7e126
> > > RDX: 0000000000000000 RSI: ffffffff81e49d1c RDI: 0000000000000006
> > > RBP: 0000000020200000 R08: 0000000000000005 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 1ffffffff1976fb9 R12: ffff88801675b900
> > > R13: ffff888025f9f680 R14: fffffffffffffffe R15: 1ffff9200086cf3d
> > > FS:  00007f2f2a17c6c0(0000) GS:ffff8880b9900000(0000) knlGS:000000000=
0000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00007f2f2a17cd58 CR3: 000000001bfa0000 CR4: 00000000003506f0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  <TASK>
> > >  folio_test_head include/linux/page-flags.h:790 [inline]
> > >  folio_test_large include/linux/page-flags.h:811 [inline]
> > >  folio_order include/linux/mm.h:1079 [inline]
> > >  collapse_pte_mapped_thp+0x42d/0x13b0 mm/khugepaged.c:1512
> >
> > Vishal, could you please take a look?
>
> Yes of course. This looks to be caused by filemap_lock_folio()
> returning an ERR_PTR() which wasn't an issue prior as
> find_lock_page()/pagecache_get_page() was checking that
> before returning a page.
>
> #syz test: https://github.com/VMoola/kernel.git
> 34d60af8cb66d6f582c1aeade01689e94e8a0092

Ignore this one, I misinterpreted the syzbot syntax

>
> > >  madvise_collapse+0x875/0xaf0 mm/khugepaged.c:2761
> > >  madvise_vma_behavior+0x1fe/0x1d00 mm/madvise.c:1086
> > >  madvise_walk_vmas+0x1cf/0x2c0 mm/madvise.c:1260
> > >  do_madvise+0x333/0x660 mm/madvise.c:1440
> > >  __do_sys_madvise mm/madvise.c:1453 [inline]
> > >  __se_sys_madvise mm/madvise.c:1451 [inline]
> > >  __x64_sys_madvise+0xaa/0x110 mm/madvise.c:1451
> > >  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> > >  do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
> > >  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> > > RIP: 0033:0x7f2f2a1dc7a9
> > > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 1a 00 00 90 48 89 f8 48 =
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f=
0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> > > RSP: 002b:00007f2f2a17c238 EFLAGS: 00000246 ORIG_RAX: 000000000000001=
c
> > > RAX: ffffffffffffffda RBX: 00007f2f2a266318 RCX: 00007f2f2a1dc7a9
> > > RDX: 0000000000000019 RSI: 000000000060005f RDI: 0000000020000000
> > > RBP: 00007f2f2a266310 R08: 00007ffe616d77f7 R09: 00007f2f2a17c6c0
> > > R10: 0000000000000000 R11: 0000000000000246 R12: b635773f07ebbeef
> > > R13: 000000000000006e R14: 00007ffe616d7710 R15: 00007ffe616d77f8
> > >
> > > ...
> > >

