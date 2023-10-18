Return-Path: <linux-fsdevel+bounces-709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2967CE9FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 23:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE3421C20D7A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 21:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C915F1641E;
	Wed, 18 Oct 2023 21:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fpbej7yv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557514291E
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 21:31:16 +0000 (UTC)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951D59B;
	Wed, 18 Oct 2023 14:31:11 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d9ac9573274so8155682276.0;
        Wed, 18 Oct 2023 14:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697664671; x=1698269471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVV9GXKQ+N2qix8ALbC2Bb+IYqanWuQiRGi4P2zW/dQ=;
        b=Fpbej7yvqvVLUVs9AdvP3uatyKtstAncjRQkhx9PLd1IqA0gbua+52sJoqP/SJtIG8
         GdQ7mUvozRlRfavJ1cmG/BTfdzAH5Dj2unLzuXsNpdatV9U36Kv6Y6n9KMrbw7K6iQSV
         nD7CDrPXvE46pOT+yz8ydsmR2TkS/Hg0aNjjZxKFTsYj6KuOXQiFE6tjp7VA0J1ens0d
         v1BZ3v/ZJSJ1sIZv4Mp1WsmTXFumQ2ASNPz+s6A/ZbTZcwuYYzO2GD4rIozIym7K+4Iu
         Vk3R8Z8FD3L2mLmtw7/tR4OSwRVfp4GCyCuSVjxHZBkQqF01saeDqr/gwMP4nyq09vhw
         eGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697664671; x=1698269471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVV9GXKQ+N2qix8ALbC2Bb+IYqanWuQiRGi4P2zW/dQ=;
        b=IMgJ9FjnMaj4+VVM2B5U+N4ZPYy7/SG9uqaOd2/flzj+5gAyqIDzO5GsUHwooseZyy
         6UbeceRic0zYRjX1Jl/zGey0HgeoGu8v1PcruptM08OoGQ1E6tbpevHiHOg5qtU1q9b5
         M0WLb2i+mVb/gSrV1x4obSkxniR5drtSXfPz+zoFyTOKXiLJQvb1ULvarghX+98JgjJx
         QzaYVkxFFkjLEudVyfUVciQf8RjSVOeZMWI+N6u71CrMEv1kOfaCPfwhKuxEKcsHFj10
         gyZkR+Tg27T7ZXWLXQ23iP8vHRk93qo4Wbavu8uenGcOegp3tDdG0Rwly3TtK1KkINsd
         qB3g==
X-Gm-Message-State: AOJu0YyYAtqXs9ZOIYw3iiO0waWGDNB3S4Y2PhTKO7U9IMlSRRZjjUaX
	BudwJ/3K+tppUnmZ3y6Ym2RH+/be2qsOHLfkdwU=
X-Google-Smtp-Source: AGHT+IGBKNb83HmO9xOIkZ+1W9AKH7k/4bolm/iWgmyRR57YGXN5rYVAZ2QOTHznIt8x1XiLwSlHK3MeeGZkQ95vYmA=
X-Received: by 2002:a25:8f90:0:b0:d9b:90bf:e74b with SMTP id
 u16-20020a258f90000000b00d9b90bfe74bmr612637ybl.7.1697664670622; Wed, 18 Oct
 2023 14:31:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000085670f060802a9bd@google.com> <20231018134858.e0c6445045f5f6c3954f6a62@linux-foundation.org>
In-Reply-To: <20231018134858.e0c6445045f5f6c3954f6a62@linux-foundation.org>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Wed, 18 Oct 2023 14:30:59 -0700
Message-ID: <CAOzc2pxr_Lzgbv-ddvifVdcOrA0X-2Y8Zz+WHjFWAuGu_CdZnA@mail.gmail.com>
Subject: Re: [syzbot] [mm?] [fs?] general protection fault in folio_flags
To: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+1e2648076cadf48ad9a1@syzkaller.appspotmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 1:49=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 18 Oct 2023 12:29:47 -0700 syzbot <syzbot+1e2648076cadf48ad9a1@sy=
zkaller.appspotmail.com> wrote:
>
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    2dac75696c6d Add linux-next specific files for 20231018
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D13858275680=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6f8545e1ef7=
a2b66
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D1e2648076cadf=
48ad9a1
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for=
 Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D17543ee56=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D101f5fe5680=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/2375f16ed327/d=
isk-2dac7569.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/c80aee6e2e6c/vmli=
nux-2dac7569.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/664dc23b738d=
/bzImage-2dac7569.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+1e2648076cadf48ad9a1@syzkaller.appspotmail.com
>
> Thanks.
>
> > general protection fault, probably for non-canonical address 0xdffffc00=
00000000: 0000 [#1] PREEMPT SMP KASA
> > KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> > CPU: 1 PID: 5710 Comm: syz-executor155 Not tainted 6.6.0-rc6-next-20231=
018-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 09/06/2023
> > RIP: 0010:PageTail include/linux/page-flags.h:286 [inline]
> > RIP: 0010:folio_flags.constprop.0+0x21/0x150 include/linux/page-flags.h=
:313
> > Code: 84 00 00 00 00 00 0f 1f 00 41 54 55 53 48 89 fb e8 14 2f a4 ff 48=
 8d 7b 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 =
0f 85 00 01 00 00 48 8b 6b 08 31 ff 83 e5 01 48 89 ee
> > RSP: 0018:ffffc90004367968 EFLAGS: 00010247
> > RAX: dffffc0000000000 RBX: fffffffffffffffe RCX: ffffffff81b7e126
> > RDX: 0000000000000000 RSI: ffffffff81e49d1c RDI: 0000000000000006
> > RBP: 0000000020200000 R08: 0000000000000005 R09: 0000000000000000
> > R10: 0000000000000000 R11: 1ffffffff1976fb9 R12: ffff88801675b900
> > R13: ffff888025f9f680 R14: fffffffffffffffe R15: 1ffff9200086cf3d
> > FS:  00007f2f2a17c6c0(0000) GS:ffff8880b9900000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f2f2a17cd58 CR3: 000000001bfa0000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  folio_test_head include/linux/page-flags.h:790 [inline]
> >  folio_test_large include/linux/page-flags.h:811 [inline]
> >  folio_order include/linux/mm.h:1079 [inline]
> >  collapse_pte_mapped_thp+0x42d/0x13b0 mm/khugepaged.c:1512
>
> Vishal, could you please take a look?

Yes of course. This looks to be caused by filemap_lock_folio()
returning an ERR_PTR() which wasn't an issue prior as
find_lock_page()/pagecache_get_page() was checking that
before returning a page.

#syz test: https://github.com/VMoola/kernel.git
34d60af8cb66d6f582c1aeade01689e94e8a0092


> >  madvise_collapse+0x875/0xaf0 mm/khugepaged.c:2761
> >  madvise_vma_behavior+0x1fe/0x1d00 mm/madvise.c:1086
> >  madvise_walk_vmas+0x1cf/0x2c0 mm/madvise.c:1260
> >  do_madvise+0x333/0x660 mm/madvise.c:1440
> >  __do_sys_madvise mm/madvise.c:1453 [inline]
> >  __se_sys_madvise mm/madvise.c:1451 [inline]
> >  __x64_sys_madvise+0xaa/0x110 mm/madvise.c:1451
> >  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> >  do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
> >  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> > RIP: 0033:0x7f2f2a1dc7a9
> > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 1a 00 00 90 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f2f2a17c238 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
> > RAX: ffffffffffffffda RBX: 00007f2f2a266318 RCX: 00007f2f2a1dc7a9
> > RDX: 0000000000000019 RSI: 000000000060005f RDI: 0000000020000000
> > RBP: 00007f2f2a266310 R08: 00007ffe616d77f7 R09: 00007f2f2a17c6c0
> > R10: 0000000000000000 R11: 0000000000000246 R12: b635773f07ebbeef
> > R13: 000000000000006e R14: 00007ffe616d7710 R15: 00007ffe616d77f8
> >
> > ...
> >

