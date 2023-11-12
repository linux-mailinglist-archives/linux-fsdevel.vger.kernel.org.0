Return-Path: <linux-fsdevel+bounces-2758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 614627E8DA3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 01:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5EB31F20F8B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 00:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6C51386;
	Sun, 12 Nov 2023 00:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8QGNaM9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49747E
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Nov 2023 00:10:42 +0000 (UTC)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECA89F;
	Sat, 11 Nov 2023 16:10:41 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7b9dc244151so2799581241.1;
        Sat, 11 Nov 2023 16:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699747840; x=1700352640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2PmY5bKxAuQtkgfmS+f6yOD+CB/aAYncwj1ahrJMD8=;
        b=Q8QGNaM9hVWpfqAO0SUBHwUHbf976v3E3BKDOS5i6b4pwI5YuTkzcSEwtquwymF2eZ
         FblwYw9TkXnxjAyMmuIs38G89bzNLsp4X30CNQ6o0q3U4vrI4y1Me5dmniYWvZOq9OnD
         hhUOnaSoXmIWW9RlZo4c15fljUL6lSXqPJW6FrRyp0v/JBiUm4p8qB1LOpbAzmH+7/zg
         eCHiB3fWBmRXVlZ/3vGVHIlVaQaJlHsf+pJbCDxLMoTBFuxv8s3MoriGzamv7Efpj9W6
         ERNiUJb7yVJej/+pX1Y9WBXvtvm6ujsA/Ok7T00LKx68KG3qL11zlD/MO5TStN491zIf
         uH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699747840; x=1700352640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2PmY5bKxAuQtkgfmS+f6yOD+CB/aAYncwj1ahrJMD8=;
        b=DJAjQ6YtRbijQoMZ+ZFRgnzDzU2CVo4VGTz9BOtminYo+DchqgPpP7BUyLKHw3BqC1
         9oq5cD+MAnvTq2vkgml3RtnVnsB0det2oLW6YQ+uMl7sc7TBFNuvVIbL9Y/BWro0r0c6
         uhVSI0oYsio80hJeF4ZL96ye9AMlBxkpveUCIqK7hpdAIPtOXYH3TD4VuEuJGVb969Ul
         +cIf+ZKQ/g7kgou/9fAu46T1W9FpF9TZQV8V4GIbidN/a2Go0uKiWUDtTiOR3GjZ7f6m
         uYWmc/VvYrBITz3ao4nA4vyrkiZP3txQpwUSQnLxrve6i5vThbn6gpfZL/Bs/FZAmDG5
         pC7A==
X-Gm-Message-State: AOJu0YzmTLsVF3cWRCgp7y4F+x9TNZWtaHY4m+CdTLHz3/4AzS0Ve14/
	L7joy7ThFuGDKbpCQudOm94RHOabw2TpaMJX9snRjtkG8eI=
X-Google-Smtp-Source: AGHT+IHBUOVziRyuyoH3CzjsxdrRV1PVe1FO7k/uL5GYXARJhtihGc1mwvOKpKSwDz79z5PNPmFafqEoszP/zA7u1KE=
X-Received: by 2002:a67:f4c9:0:b0:457:ca73:83d6 with SMTP id
 s9-20020a67f4c9000000b00457ca7383d6mr3045848vsn.5.1699747839938; Sat, 11 Nov
 2023 16:10:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106173903.1734114-1-willy@infradead.org> <CAKFNMomPu2r-KCrKgM0PTfPA3xWm+BaJc3oi-_kZeGG3fMr=_A@mail.gmail.com>
In-Reply-To: <CAKFNMomPu2r-KCrKgM0PTfPA3xWm+BaJc3oi-_kZeGG3fMr=_A@mail.gmail.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Sun, 12 Nov 2023 09:10:23 +0900
Message-ID: <CAKFNMomk6CcuaU5CbArbS0tMncz1LGNz=vLeOEx4xpmENfGWFQ@mail.gmail.com>
Subject: Re: [PATCH 00/35] nilfs2: Folio conversions
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 10:49=E2=80=AFAM Ryusuke Konishi wrote:
>
> On Tue, Nov 7, 2023 at 2:39=E2=80=AFAM Matthew Wilcox (Oracle) wrote:
> >
> > This patch series does most of the page->folio conversions needed in
> > nilfs2.  I haven't done the work to support large folios in nilfs2;
> > I don't know if that conversion will be worth the effort.  There are
> > still a few page uses left, but the infrastructure isn't quite there to
> > get rid of them yet.
> >
> > Arguably, this is two separate series; the first takes care of the file
> > paths and the second takes care of directories.  I've tried my best to
> > include large folio support in the directory code because it'll be need=
ed
> > for large block size devices.  It also tries to stay as close as possib=
le
> > to the current ext2 code (so it also includes kmap_local support).
> >
> > These patches are only compile-tested.  xfstests doesn't seem to know
> > about nilfs2.
> >
> > Matthew Wilcox (Oracle) (35):
> >   nilfs2: Add nilfs_end_folio_io()
> >   nilfs2: Convert nilfs_abort_logs to use folios
> >   nilfs2: Convert nilfs_segctor_complete_write to use folios
> >   nilfs2: Convert nilfs_forget_buffer to use a folio
> >   nilfs2: Convert to nilfs_folio_buffers_clean()
> >   nilfs2: Convert nilfs_writepage() to use a folio
> >   nilfs2: Convert nilfs_mdt_write_page() to use a folio
> >   nilfs2: Convert to nilfs_clear_folio_dirty()
> >   nilfs2: Convert to __nilfs_clear_folio_dirty()
> >   nilfs2: Convert nilfs_segctor_prepare_write to use folios
> >   nilfs2: Convert nilfs_page_mkwrite() to use a folio
> >   nilfs2: Convert nilfs_mdt_create_block to use a folio
> >   nilfs2: Convert nilfs_mdt_submit_block to use a folio
> >   nilfs2: Convert nilfs_gccache_submit_read_data to use a folio
> >   nilfs2: Convert nilfs_btnode_create_block to use a folio
> >   nilfs2: Convert nilfs_btnode_submit_block to use a folio
> >   nilfs2: Convert nilfs_btnode_delete to use a folio
> >   nilfs2: Convert nilfs_btnode_prepare_change_key to use a folio
> >   nilfs2: Convert nilfs_btnode_commit_change_key to use a folio
> >   nilfs2: Convert nilfs_btnode_abort_change_key to use a folio
> >   nilfs2: Remove page_address() from nilfs_set_link
> >   nilfs2: Remove page_address() from nilfs_add_link
> >   nilfs2: Remove page_address() from nilfs_delete_entry
> >   nilfs2: Return the mapped address from nilfs_get_page()
> >   nilfs2: Pass the mapped address to nilfs_check_page()
> >   nilfs2: Switch to kmap_local for directory handling
> >   nilfs2: Add nilfs_get_folio()
> >   nilfs2: Convert nilfs_readdir to use a folio
> >   nilfs2: Convert nilfs_find_entry to use a folio
> >   nilfs2: Convert nilfs_rename() to use folios
> >   nilfs2: Convert nilfs_add_link() to use a folio
> >   nilfs2: Convert nilfs_empty_dir() to use a folio
> >   nilfs2: Convert nilfs_make_empty() to use a folio
> >   nilfs2: Convert nilfs_prepare_chunk() and nilfs_commit_chunk() to
> >     folios
> >   nilfs2: Convert nilfs_page_bug() to nilfs_folio_bug()
> >
> >  fs/nilfs2/btnode.c  |  62 +++++------
> >  fs/nilfs2/dir.c     | 248 ++++++++++++++++++++------------------------
> >  fs/nilfs2/file.c    |  28 ++---
> >  fs/nilfs2/gcinode.c |   4 +-
> >  fs/nilfs2/inode.c   |  11 +-
> >  fs/nilfs2/mdt.c     |  23 ++--
> >  fs/nilfs2/namei.c   |  33 +++---
> >  fs/nilfs2/nilfs.h   |  20 ++--
> >  fs/nilfs2/page.c    |  93 +++++++++--------
> >  fs/nilfs2/page.h    |  12 +--
> >  fs/nilfs2/segment.c | 157 ++++++++++++++--------------
> >  11 files changed, 338 insertions(+), 353 deletions(-)
> >
> > --
> > 2.42.0
> >
>
> Matthew, thank you so much for this hard work.
> Even if full support for large folios cannot be achieved at this time
> due to limitations in the nilfs2 implementation, I appreciate that you
> are moving forward with the conversion work that should be done.
>
> I haven't reviewed each patch yet, but at least this series can be
> built without problems in my environment too, and so far it is working
> fine including GC and stress tests.
>
> I will review all the patches, but since there are so many, I will not
> add LGTM replies to each one, but will only reply to those that have
> comments (if any).
>
> Many thanks,
> Ryusuke Konishi

The following WARNING was detected during stress testing on a 32-bit VM:

[  270.894814][ T5828] ------------[ cut here ]------------
[  270.895409][ T5828] WARNING: CPU: 1 PID: 5828 at mm/highmem.c:611
kunmap_local_indexed+0xd4/0xfc
<snip>
[  270.904260][ T5828] EIP: kunmap_local_indexed+0xd4/0xfc
[  270.904940][ T5828] Code: 00 02 8b 80 5c 0e 00 00 85 c0 78 26 b8 01
00 00 00 e8 80 22 df ff 64 a1 84 29 33 c2 85 c0 74 1a e8 75 f4 df ff
5b 5e 5d c3 90 <0f> 0b eb 95 8d 74 26 00 0f 0b 8d b6 00 00 00 00 e8 13
8a 80 00 eb
[  270.907264][ T5828] EAX: 00000024 EBX: fff99000 ECX: 00068000 EDX: fff97=
000
[  270.908140][ T5828] ESI: 00000003 EDI: f6cc76c0 EBP: e353fda8 ESP: e353f=
da0
[  270.909020][ T5828] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
EFLAGS: 00010206
[  270.910043][ T5828] CR0: 80050033 CR2: b145b49c CR3: 23570000 CR4: 00350=
ed0
[  270.910927][ T5828] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000=
000
[  270.911799][ T5828] DR6: fffe0ff0 DR7: 00000400
[  270.912369][ T5828] Call Trace:
[  270.912771][ T5828]  ? show_regs+0x50/0x58
[  270.913287][ T5828]  ? kunmap_local_indexed+0xd4/0xfc
[  270.913908][ T5828]  ? __warn+0x6f/0x184
[  270.914420][ T5828]  ? kunmap_local_indexed+0xd4/0xfc
[  270.915063][ T5828]  ? report_bug+0x1b2/0x22c
[  270.915610][ T5828]  ? timers_dead_cpu+0x12b/0x268
[  270.916249][ T5828]  ? exc_overflow+0x38/0x38
[  270.916826][ T5828]  ? handle_bug+0x2a/0x48
[  270.917353][ T5828]  ? exc_invalid_op+0x1b/0x58
[  270.917929][ T5828]  ? handle_exception+0x130/0x130
[  270.918513][ T5828]  ? shrink_dentry_list+0x73/0x2bc
[  270.919121][ T5828]  ? exc_overflow+0x38/0x38
[  270.919728][ T5828]  ? kunmap_local_indexed+0xd4/0xfc
[  270.920369][ T5828]  ? exc_overflow+0x38/0x38
[  270.920913][ T5828]  ? kunmap_local_indexed+0xd4/0xfc
[  270.921545][ T5828]  nilfs_delete_entry+0xa7/0x1ec [nilfs2]
[  270.922255][ T5828]  nilfs_rename+0x359/0x374 [nilfs2]
[  270.922899][ T5828]  ? find_held_lock+0x24/0x70
[  270.923457][ T5828]  ? down_write_nested+0x6d/0xd0
[  270.924043][ T5828]  vfs_rename+0x525/0xaa8
[  270.924572][ T5828]  ? vfs_rename+0x525/0xaa8
[  270.925156][ T5828]  ? security_path_rename+0x54/0x7c
[  270.925794][ T5828]  do_renameat2+0x496/0x504
[  270.926380][ T5828]  __ia32_sys_rename+0x34/0x3c
[  270.926973][ T5828]  __do_fast_syscall_32+0x56/0xc8
[  270.927598][ T5828]  do_fast_syscall_32+0x29/0x58
[  270.928257][ T5828]  do_SYSENTER_32+0x15/0x18
[  270.928871][ T5828]  entry_SYSENTER_32+0x98/0xf1
[  270.929582][ T5828] EIP: 0xb146f579
[  270.930064][ T5828] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01
10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89
e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd
80 90 8d 76
[  270.932584][ T5828] EAX: ffffffda EBX: 03ac7650 ECX: 03ac76f0 EDX: b1456=
ff4
[  270.933446][ T5828] ESI: 02aae2c3 EDI: b14a4b80 EBP: bffd8638 ESP: bffd7=
de8
[  270.934311][ T5828] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
EFLAGS: 00000292
[  270.935245][ T5828] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...

This issue is reproducible and the result of bisect was the following patch=
:

> >   nilfs2: Switch to kmap_local for directory handling

It seems that the problem was introduced in the conversion of
"nilfs_rename() -> nilfs_delete_entry()" to kmap_local.

For the first part of this series  (PATH 01/35 - 20/35), my review is
already finished, and I believe nothing breaks existing behavior.
So I'm thinking of sending that part to the -mm tree first (on Monday
or Tuesday), but if you have any opinions, please let me know.

For the rest, I would like to continue problem analysis and review.

Thanks,
Ryusuke Konishi

