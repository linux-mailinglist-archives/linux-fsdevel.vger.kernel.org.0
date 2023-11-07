Return-Path: <linux-fsdevel+bounces-2203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5517E32B2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 02:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFEC41C209DC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 01:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843D71C15;
	Tue,  7 Nov 2023 01:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nown/HDC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDE1186E
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 01:49:28 +0000 (UTC)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F421B2;
	Mon,  6 Nov 2023 17:49:26 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7ba170ac211so1595168241.2;
        Mon, 06 Nov 2023 17:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699321766; x=1699926566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEvHVlz5FZ+Vrwqvud+W5ugn/aWblBnKjZHLCBoRvEw=;
        b=Nown/HDCAvUQ4y3qwRxutrWo4mw/dPASmmmEMjeX4yIYHcTjaI9fYIcNpB9pKEMbSi
         Xk2ZTTtFRVTqLr4VWv2QRDax6F02n5eQtSnOwNUdfVRWmcKfhaK4iwy8urWvaX8EsvTM
         Y+HpmG7ZtcaZPBtd+H9rlCyRTmRJxOHV6cxMzO3uChMGNjM/4Mtw9EMYPLvVyYYjeRGL
         Q1o8/lmJqhhr4GwRsYC0hus/dBO0PHLt2/yxWIRlB26EuhHEwGa9drDmUOaSnX2F9yP+
         eb4Rl6k9tntuMrGfa2CWl6c632JbIqo8kTprmO5tCGZoHL1WBD7kGR2mSHPGMZkUb/4h
         UgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699321766; x=1699926566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEvHVlz5FZ+Vrwqvud+W5ugn/aWblBnKjZHLCBoRvEw=;
        b=O+FH2h9AUWhHESa+KYXKt7vTzjZOjhbrJy6QncAZqPy8EppyPfi2toqQJRr7uGvHl/
         a3W9KI4XTPMGMPEELZss0I6R9UF6m/2OYNrRHLjO/1BiJumxCbtQ/skyUHaghNGc1W5i
         TrudQSmogzr1tKd3s/6w0kODg8hELrMm4eZ3e8yEvzTWSTYWZDEQ3s9xdVK44pWB/yO+
         7QzkFOWeQ1A88ZDEKI/G1Fkqvh9ii9/GTPZItf5V5bisUWFTGxBp4o+5TUpCbQlELBlR
         Ba1S+ayCuKY7UY/Ear9gdXcEOFetHcsdbhyEH6+Uh/V8bg7Dd7h9IENYWcfPy5U83KA3
         yl+g==
X-Gm-Message-State: AOJu0YwNCZyQxL4oQhvH7GX7DgaqEQCyxPznEmaz/cWtH1IdpJasd932
	kWWlVVYMKjelKqsktswMFRx0jNr3Supc6KJoWfu+J3Sm56s=
X-Google-Smtp-Source: AGHT+IGw4K9VbrWFYrbWq2a6eskRYfUcJVBBDQSby1euaLZTooyGWbgQnsQzsflIivYr+M5T0DiJgunEfhukYF/+p5M=
X-Received: by 2002:a05:6102:1047:b0:45d:a8b4:2ce9 with SMTP id
 h7-20020a056102104700b0045da8b42ce9mr7737120vsq.8.1699321765798; Mon, 06 Nov
 2023 17:49:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106173903.1734114-1-willy@infradead.org>
In-Reply-To: <20231106173903.1734114-1-willy@infradead.org>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Tue, 7 Nov 2023 10:49:09 +0900
Message-ID: <CAKFNMomPu2r-KCrKgM0PTfPA3xWm+BaJc3oi-_kZeGG3fMr=_A@mail.gmail.com>
Subject: Re: [PATCH 00/35] nilfs2: Folio conversions
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 2:39=E2=80=AFAM Matthew Wilcox (Oracle) wrote:
>
> This patch series does most of the page->folio conversions needed in
> nilfs2.  I haven't done the work to support large folios in nilfs2;
> I don't know if that conversion will be worth the effort.  There are
> still a few page uses left, but the infrastructure isn't quite there to
> get rid of them yet.
>
> Arguably, this is two separate series; the first takes care of the file
> paths and the second takes care of directories.  I've tried my best to
> include large folio support in the directory code because it'll be needed
> for large block size devices.  It also tries to stay as close as possible
> to the current ext2 code (so it also includes kmap_local support).
>
> These patches are only compile-tested.  xfstests doesn't seem to know
> about nilfs2.
>
> Matthew Wilcox (Oracle) (35):
>   nilfs2: Add nilfs_end_folio_io()
>   nilfs2: Convert nilfs_abort_logs to use folios
>   nilfs2: Convert nilfs_segctor_complete_write to use folios
>   nilfs2: Convert nilfs_forget_buffer to use a folio
>   nilfs2: Convert to nilfs_folio_buffers_clean()
>   nilfs2: Convert nilfs_writepage() to use a folio
>   nilfs2: Convert nilfs_mdt_write_page() to use a folio
>   nilfs2: Convert to nilfs_clear_folio_dirty()
>   nilfs2: Convert to __nilfs_clear_folio_dirty()
>   nilfs2: Convert nilfs_segctor_prepare_write to use folios
>   nilfs2: Convert nilfs_page_mkwrite() to use a folio
>   nilfs2: Convert nilfs_mdt_create_block to use a folio
>   nilfs2: Convert nilfs_mdt_submit_block to use a folio
>   nilfs2: Convert nilfs_gccache_submit_read_data to use a folio
>   nilfs2: Convert nilfs_btnode_create_block to use a folio
>   nilfs2: Convert nilfs_btnode_submit_block to use a folio
>   nilfs2: Convert nilfs_btnode_delete to use a folio
>   nilfs2: Convert nilfs_btnode_prepare_change_key to use a folio
>   nilfs2: Convert nilfs_btnode_commit_change_key to use a folio
>   nilfs2: Convert nilfs_btnode_abort_change_key to use a folio
>   nilfs2: Remove page_address() from nilfs_set_link
>   nilfs2: Remove page_address() from nilfs_add_link
>   nilfs2: Remove page_address() from nilfs_delete_entry
>   nilfs2: Return the mapped address from nilfs_get_page()
>   nilfs2: Pass the mapped address to nilfs_check_page()
>   nilfs2: Switch to kmap_local for directory handling
>   nilfs2: Add nilfs_get_folio()
>   nilfs2: Convert nilfs_readdir to use a folio
>   nilfs2: Convert nilfs_find_entry to use a folio
>   nilfs2: Convert nilfs_rename() to use folios
>   nilfs2: Convert nilfs_add_link() to use a folio
>   nilfs2: Convert nilfs_empty_dir() to use a folio
>   nilfs2: Convert nilfs_make_empty() to use a folio
>   nilfs2: Convert nilfs_prepare_chunk() and nilfs_commit_chunk() to
>     folios
>   nilfs2: Convert nilfs_page_bug() to nilfs_folio_bug()
>
>  fs/nilfs2/btnode.c  |  62 +++++------
>  fs/nilfs2/dir.c     | 248 ++++++++++++++++++++------------------------
>  fs/nilfs2/file.c    |  28 ++---
>  fs/nilfs2/gcinode.c |   4 +-
>  fs/nilfs2/inode.c   |  11 +-
>  fs/nilfs2/mdt.c     |  23 ++--
>  fs/nilfs2/namei.c   |  33 +++---
>  fs/nilfs2/nilfs.h   |  20 ++--
>  fs/nilfs2/page.c    |  93 +++++++++--------
>  fs/nilfs2/page.h    |  12 +--
>  fs/nilfs2/segment.c | 157 ++++++++++++++--------------
>  11 files changed, 338 insertions(+), 353 deletions(-)
>
> --
> 2.42.0
>

Matthew, thank you so much for this hard work.
Even if full support for large folios cannot be achieved at this time
due to limitations in the nilfs2 implementation, I appreciate that you
are moving forward with the conversion work that should be done.

I haven't reviewed each patch yet, but at least this series can be
built without problems in my environment too, and so far it is working
fine including GC and stress tests.

I will review all the patches, but since there are so many, I will not
add LGTM replies to each one, but will only reply to those that have
comments (if any).

Many thanks,
Ryusuke Konishi

