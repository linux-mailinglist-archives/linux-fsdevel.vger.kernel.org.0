Return-Path: <linux-fsdevel+bounces-3330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D54C7F352A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 18:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9002A1F22890
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 17:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AF720DCC;
	Tue, 21 Nov 2023 17:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTHKPD2M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0BD18C;
	Tue, 21 Nov 2023 09:43:57 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-58ce6824bfcso595526eaf.0;
        Tue, 21 Nov 2023 09:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700588637; x=1701193437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWyXOXKr9RHMq2zMZZYEmL2+ypZpINmcZ9+zDeBrSng=;
        b=fTHKPD2MPMj03ca1HW/Z4xrqwGAlZ2PONeoYBtunu/MRueCF3Yp/k7TiuMBq60TOsw
         m+aTme4fRg2xR2NbubbkjuR7fBgNFGqI7d+p178cv3Y+02CKjQp0KN3hH5sKTXg/ti1j
         djqzVMhwuaWCZY1qw3ahxfZ8NBkBqEsBvepnxZjXdzw2gMvv+birn2f3u4fYWI0FPmvf
         gLdRJXj/3rhRTwQSJkGuLUapx5uo1lzbb73lm2GiTTUFMcoArBVL1hHp08HcGhh7IFSP
         dAx4DwHgSYdP6nvjrO+HObPepCgaymvmzMAEd3bGP0DpCGEdAFZsTCd7oKqbTKJDBgTL
         Cmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700588637; x=1701193437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWyXOXKr9RHMq2zMZZYEmL2+ypZpINmcZ9+zDeBrSng=;
        b=v7z+mhKh2SGJ6f+J7qjHm+06rqz0MVdm2kbvokHfecu7/bRp6EZQ63guoLmcSJgF9a
         AHcEFYMLq2DPM/MfJtFnBuSqs3etKsPcOzxZz1FGwsgEGTR+G9hGW8HwsxVGfPWLnvYH
         i5G9hEPvX4VjebMj5O1cor31lDnKu86At4juBLTnvLKGStoclDB6/5bHH3arxY9YKpHo
         JMxdr6xvtKQ4WbWOsIiA5qN+laI2iGo8ZxytX67dBMutYYwk2mduZ1cgcTyyZDh9SL1u
         xCZQfPtaqspLWUV57YrcWKAH4EJeMfHXTnk1+XSHeKRw1gsn9Z4i1yK5BYbeb8LHvSap
         N8WQ==
X-Gm-Message-State: AOJu0YwVjMeDhU8fPM+jmHVU198xVpW1FwxioilY8V620fZzZxWpsBfN
	abWL65MQkeMHBlMvYZAzdoFFa8g9gCsTMiUNGP0m50YvFu8=
X-Google-Smtp-Source: AGHT+IG0BEE+1COFkEY1Cas0V3XR58noBAX+GVLnBtT+dpIvup9iQpGveteTqLMXA3+SnM/Fox+62EV61fsgPFul0ew=
X-Received: by 2002:a05:6358:7057:b0:16d:bd39:46a with SMTP id
 23-20020a056358705700b0016dbd39046amr8584253rwp.14.1700588637056; Tue, 21 Nov
 2023 09:43:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106173903.1734114-1-willy@infradead.org> <CAKFNMomPu2r-KCrKgM0PTfPA3xWm+BaJc3oi-_kZeGG3fMr=_A@mail.gmail.com>
 <CAKFNMomk6CcuaU5CbArbS0tMncz1LGNz=vLeOEx4xpmENfGWFQ@mail.gmail.com>
In-Reply-To: <CAKFNMomk6CcuaU5CbArbS0tMncz1LGNz=vLeOEx4xpmENfGWFQ@mail.gmail.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Wed, 22 Nov 2023 02:43:40 +0900
Message-ID: <CAKFNMo=5jjwHZgyUF26pvQM=7e6+ADK7s_BKULMT123C_1YXug@mail.gmail.com>
Subject: Re: [PATCH 00/35] nilfs2: Folio conversions
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2023 at 9:10=E2=80=AFAM Ryusuke Konishi wrote:
>
> On Tue, Nov 7, 2023 at 10:49=E2=80=AFAM Ryusuke Konishi wrote:
> >
> > On Tue, Nov 7, 2023 at 2:39=E2=80=AFAM Matthew Wilcox (Oracle) wrote:
> > >
> > > This patch series does most of the page->folio conversions needed in
> > > nilfs2.  I haven't done the work to support large folios in nilfs2;
> > > I don't know if that conversion will be worth the effort.  There are
> > > still a few page uses left, but the infrastructure isn't quite there =
to
> > > get rid of them yet.
> > >
> > > Arguably, this is two separate series; the first takes care of the fi=
le
> > > paths and the second takes care of directories.  I've tried my best t=
o
> > > include large folio support in the directory code because it'll be ne=
eded
> > > for large block size devices.  It also tries to stay as close as poss=
ible
> > > to the current ext2 code (so it also includes kmap_local support).
> > >
> > > These patches are only compile-tested.  xfstests doesn't seem to know
> > > about nilfs2.
> > >
> > > Matthew Wilcox (Oracle) (35):
> > >   nilfs2: Add nilfs_end_folio_io()
> > >   nilfs2: Convert nilfs_abort_logs to use folios
> > >   nilfs2: Convert nilfs_segctor_complete_write to use folios
> > >   nilfs2: Convert nilfs_forget_buffer to use a folio
> > >   nilfs2: Convert to nilfs_folio_buffers_clean()
> > >   nilfs2: Convert nilfs_writepage() to use a folio
> > >   nilfs2: Convert nilfs_mdt_write_page() to use a folio
> > >   nilfs2: Convert to nilfs_clear_folio_dirty()
> > >   nilfs2: Convert to __nilfs_clear_folio_dirty()
> > >   nilfs2: Convert nilfs_segctor_prepare_write to use folios
> > >   nilfs2: Convert nilfs_page_mkwrite() to use a folio
> > >   nilfs2: Convert nilfs_mdt_create_block to use a folio
> > >   nilfs2: Convert nilfs_mdt_submit_block to use a folio
> > >   nilfs2: Convert nilfs_gccache_submit_read_data to use a folio
> > >   nilfs2: Convert nilfs_btnode_create_block to use a folio
> > >   nilfs2: Convert nilfs_btnode_submit_block to use a folio
> > >   nilfs2: Convert nilfs_btnode_delete to use a folio
> > >   nilfs2: Convert nilfs_btnode_prepare_change_key to use a folio
> > >   nilfs2: Convert nilfs_btnode_commit_change_key to use a folio
> > >   nilfs2: Convert nilfs_btnode_abort_change_key to use a folio
> > >   nilfs2: Remove page_address() from nilfs_set_link
> > >   nilfs2: Remove page_address() from nilfs_add_link
> > >   nilfs2: Remove page_address() from nilfs_delete_entry
> > >   nilfs2: Return the mapped address from nilfs_get_page()
> > >   nilfs2: Pass the mapped address to nilfs_check_page()
> > >   nilfs2: Switch to kmap_local for directory handling
> > >   nilfs2: Add nilfs_get_folio()
> > >   nilfs2: Convert nilfs_readdir to use a folio
> > >   nilfs2: Convert nilfs_find_entry to use a folio
> > >   nilfs2: Convert nilfs_rename() to use folios
> > >   nilfs2: Convert nilfs_add_link() to use a folio
> > >   nilfs2: Convert nilfs_empty_dir() to use a folio
> > >   nilfs2: Convert nilfs_make_empty() to use a folio
> > >   nilfs2: Convert nilfs_prepare_chunk() and nilfs_commit_chunk() to
> > >     folios
> > >   nilfs2: Convert nilfs_page_bug() to nilfs_folio_bug()
> > >
> > >  fs/nilfs2/btnode.c  |  62 +++++------
> > >  fs/nilfs2/dir.c     | 248 ++++++++++++++++++++----------------------=
--
> > >  fs/nilfs2/file.c    |  28 ++---
> > >  fs/nilfs2/gcinode.c |   4 +-
> > >  fs/nilfs2/inode.c   |  11 +-
> > >  fs/nilfs2/mdt.c     |  23 ++--
> > >  fs/nilfs2/namei.c   |  33 +++---
> > >  fs/nilfs2/nilfs.h   |  20 ++--
> > >  fs/nilfs2/page.c    |  93 +++++++++--------
> > >  fs/nilfs2/page.h    |  12 +--
> > >  fs/nilfs2/segment.c | 157 ++++++++++++++--------------
> > >  11 files changed, 338 insertions(+), 353 deletions(-)
> > >
> > > --
> > > 2.42.0
> > >
> >
> > Matthew, thank you so much for this hard work.
> > Even if full support for large folios cannot be achieved at this time
> > due to limitations in the nilfs2 implementation, I appreciate that you
> > are moving forward with the conversion work that should be done.
> >
> > I haven't reviewed each patch yet, but at least this series can be
> > built without problems in my environment too, and so far it is working
> > fine including GC and stress tests.
> >
> > I will review all the patches, but since there are so many, I will not
> > add LGTM replies to each one, but will only reply to those that have
> > comments (if any).
> >
> > Many thanks,
> > Ryusuke Konishi
>
> The following WARNING was detected during stress testing on a 32-bit VM:
>
> [  270.894814][ T5828] ------------[ cut here ]------------
> [  270.895409][ T5828] WARNING: CPU: 1 PID: 5828 at mm/highmem.c:611
> kunmap_local_indexed+0xd4/0xfc
> <snip>
> [  270.904260][ T5828] EIP: kunmap_local_indexed+0xd4/0xfc
> [  270.904940][ T5828] Code: 00 02 8b 80 5c 0e 00 00 85 c0 78 26 b8 01
> 00 00 00 e8 80 22 df ff 64 a1 84 29 33 c2 85 c0 74 1a e8 75 f4 df ff
> 5b 5e 5d c3 90 <0f> 0b eb 95 8d 74 26 00 0f 0b 8d b6 00 00 00 00 e8 13
> 8a 80 00 eb
> [  270.907264][ T5828] EAX: 00000024 EBX: fff99000 ECX: 00068000 EDX: fff=
97000
> [  270.908140][ T5828] ESI: 00000003 EDI: f6cc76c0 EBP: e353fda8 ESP: e35=
3fda0
> [  270.909020][ T5828] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
> EFLAGS: 00010206
> [  270.910043][ T5828] CR0: 80050033 CR2: b145b49c CR3: 23570000 CR4: 003=
50ed0
> [  270.910927][ T5828] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 000=
00000
> [  270.911799][ T5828] DR6: fffe0ff0 DR7: 00000400
> [  270.912369][ T5828] Call Trace:
> [  270.912771][ T5828]  ? show_regs+0x50/0x58
> [  270.913287][ T5828]  ? kunmap_local_indexed+0xd4/0xfc
> [  270.913908][ T5828]  ? __warn+0x6f/0x184
> [  270.914420][ T5828]  ? kunmap_local_indexed+0xd4/0xfc
> [  270.915063][ T5828]  ? report_bug+0x1b2/0x22c
> [  270.915610][ T5828]  ? timers_dead_cpu+0x12b/0x268
> [  270.916249][ T5828]  ? exc_overflow+0x38/0x38
> [  270.916826][ T5828]  ? handle_bug+0x2a/0x48
> [  270.917353][ T5828]  ? exc_invalid_op+0x1b/0x58
> [  270.917929][ T5828]  ? handle_exception+0x130/0x130
> [  270.918513][ T5828]  ? shrink_dentry_list+0x73/0x2bc
> [  270.919121][ T5828]  ? exc_overflow+0x38/0x38
> [  270.919728][ T5828]  ? kunmap_local_indexed+0xd4/0xfc
> [  270.920369][ T5828]  ? exc_overflow+0x38/0x38
> [  270.920913][ T5828]  ? kunmap_local_indexed+0xd4/0xfc
> [  270.921545][ T5828]  nilfs_delete_entry+0xa7/0x1ec [nilfs2]
> [  270.922255][ T5828]  nilfs_rename+0x359/0x374 [nilfs2]
> [  270.922899][ T5828]  ? find_held_lock+0x24/0x70
> [  270.923457][ T5828]  ? down_write_nested+0x6d/0xd0
> [  270.924043][ T5828]  vfs_rename+0x525/0xaa8
> [  270.924572][ T5828]  ? vfs_rename+0x525/0xaa8
> [  270.925156][ T5828]  ? security_path_rename+0x54/0x7c
> [  270.925794][ T5828]  do_renameat2+0x496/0x504
> [  270.926380][ T5828]  __ia32_sys_rename+0x34/0x3c
> [  270.926973][ T5828]  __do_fast_syscall_32+0x56/0xc8
> [  270.927598][ T5828]  do_fast_syscall_32+0x29/0x58
> [  270.928257][ T5828]  do_SYSENTER_32+0x15/0x18
> [  270.928871][ T5828]  entry_SYSENTER_32+0x98/0xf1
> [  270.929582][ T5828] EIP: 0xb146f579
> [  270.930064][ T5828] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01
> 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89
> e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd
> 80 90 8d 76
> [  270.932584][ T5828] EAX: ffffffda EBX: 03ac7650 ECX: 03ac76f0 EDX: b14=
56ff4
> [  270.933446][ T5828] ESI: 02aae2c3 EDI: b14a4b80 EBP: bffd8638 ESP: bff=
d7de8
> [  270.934311][ T5828] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
> EFLAGS: 00000292
> [  270.935245][ T5828] Kernel panic - not syncing: kernel: panic_on_warn =
set ...
>
> This issue is reproducible and the result of bisect was the following pat=
ch:
>
> > >   nilfs2: Switch to kmap_local for directory handling
>
> It seems that the problem was introduced in the conversion of
> "nilfs_rename() -> nilfs_delete_entry()" to kmap_local.
>
> For the first part of this series  (PATH 01/35 - 20/35), my review is
> already finished, and I believe nothing breaks existing behavior.
> So I'm thinking of sending that part to the -mm tree first (on Monday
> or Tuesday), but if you have any opinions, please let me know.
>
> For the rest, I would like to continue problem analysis and review.
>
> Thanks,
> Ryusuke Konishi

The cause of this issue was that in the current implementation of the
rename function, there was a hidden part where the use of kmap-kunmap
pairs for two pages was not nested.

Other than that, there were no problems with the second half of the
patchset in the review, so I would like to insert a preparation patch
to resolve the order reversal of kunmap (more precisely,
nilfs_put_page) calls, so that they can be converted directly to
unmap_and_put_page (and then to folio_release_kmap) calls, and send
the remaining patches together to the mm tree with only minor
adjustments.

Regards,
Ryusuke Konishi

