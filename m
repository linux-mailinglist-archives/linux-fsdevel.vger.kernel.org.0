Return-Path: <linux-fsdevel+bounces-7915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F6282D318
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 03:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A5D1F213D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 02:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFDD1874;
	Mon, 15 Jan 2024 02:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSCgA1iV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA84B17CB;
	Mon, 15 Jan 2024 02:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-28ca63fd071so4195872a91.3;
        Sun, 14 Jan 2024 18:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705285538; x=1705890338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Uy/zKEwkQ7YbhJDVPGcaBEyks0QIDEAsE5dyoOAEIQ=;
        b=WSCgA1iVQDHKvBbV85c9r82n2m3eFsZqq7jvBJf+dU7+vkIlfM/TPye4dUsbo9tsMm
         DxozOYqd6rYBeTPRHCmlmoOSs15szxisDVhSKgzzkkiObFWmR+xX6hSM5vZyHUK/dgbg
         ptTMX4jKA4zEJ7yTliqD/PtqcDpwzn5z0KCqFwv0PntPPOY0eeuMVgf3yoN5Q+9+7FVI
         63XYgQEl/BPS4Mc72Ehm1x89Px75WOriCInd+B/tzUuPg9xh3YPU5SCtHkoQHLzvTp2m
         TtMW8c9rTrZ83RYPHfybLo8RObviqkIoAjVF8MLH4ouBDBTaNdfadfOEri1CqZ02HPFJ
         7e3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705285538; x=1705890338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Uy/zKEwkQ7YbhJDVPGcaBEyks0QIDEAsE5dyoOAEIQ=;
        b=Uu+/BCcZQ2HxLQu8TZ0DiRsyg9b2YXgtkoa+iD+1N10VzIorThsPPkAWfrLAizEgxW
         U8ICtioxIH3jl5OSMQuzdsX/KCPz8TDDvibPtDNf0w/fuZ8f2mPGPJKBDSGwAcR+oTb+
         9Gorhhw3K15Rnxf534l48XwYcDyC7bMRPVD0EvPu7jhq/cfj64Cj8kW5G8qp5Dm5YvgI
         wqX6HgOJoyHEE8S7o46WA0sheLp+j5C+v2FbTk0BWlo05NspSuKTz+nQZ3K4MdLo+SLk
         we7MT8W8W9IWWUgojAmgHvcsiRX+x+b3GrUGECitVwumMeYaHh2bP4L5ffonHc47q/aZ
         ieFw==
X-Gm-Message-State: AOJu0Ywdkq9vHfv9lFEouS4Bq1HU8gFrlYVWbzEr7OIgv0RUinfv6JYQ
	P7MvKjIu7weLq2wWEzMcTPrsRtazToY4VqQIp3E=
X-Google-Smtp-Source: AGHT+IEHv1ktXYZDCrq8oObRyYfZ0ULnvB7B7uzQjtCPAeIB5c9G1JRAwwjY1/h2bde1/3k/nxE/yhnY5DSsrNUIJ8M=
X-Received: by 2002:a17:90a:fd93:b0:28c:3907:81d5 with SMTP id
 cx19-20020a17090afd9300b0028c390781d5mr2216759pjb.3.1705285537799; Sun, 14
 Jan 2024 18:25:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <o7py4ia3s75popzz7paf3c6347te6h3qms675lz3s2k5eltskl@cklacfnvxb7k>
In-Reply-To: <o7py4ia3s75popzz7paf3c6347te6h3qms675lz3s2k5eltskl@cklacfnvxb7k>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Mon, 15 Jan 2024 02:25:24 +0000
Message-ID: <CADo9pHgNBew6bVZ9HuH6i+66f3zf+XVG29WXkbm87j4vUf1Cow@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs new years fixes for 6.7
To: Kent Overstreet <kent.overstreet@linux.dev>, Luna Jernberg <droidbittin@gmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey!

Listening to you in Linux Unplugged #545 now:
https://jupiter.tube/w/mug8WfikZs3T5aXyTGTbCF the bcachefs part of the
show starts in around 1,5 hour in

Den m=C3=A5n 1 jan. 2024 kl 16:57 skrev Kent Overstreet <kent.overstreet@li=
nux.dev>:
>
> Hi Linus, some more fixes for you, and some compatibility work so that
> 6.7 will be able to handle the disk space accounting rewrite when it
> rolls out.
>
> Happy new year!
>
> The following changes since commit 453f5db0619e2ad64076aab16ff5a00e0f7c53=
a2:
>
>   Merge tag 'trace-v6.7-rc7' of git://git.kernel.org/pub/scm/linux/kernel=
/git/trace/linux-trace (2023-12-30 11:37:35 -0800)
>
> are available in the Git repository at:
>
>   https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-01-01
>
> for you to fetch changes up to 0d72ab35a925d66b044cb62b709e53141c3f0143:
>
>   bcachefs: make RO snapshots actually RO (2024-01-01 11:47:07 -0500)
>
> ----------------------------------------------------------------
> More bcachefs bugfixes for 6.7, and forwards compatibility work:
>
>  - fix for a nasty extents + snapshot interaction, reported when reflink
>    of a snapshotted file wouldn't complete but turned out to be a more
>    general bug
>  - fix for an invalid free in dio write path when iov vector was longer
>    than our inline vecotr
>  - fix for a buffer overflow in the nocow write path - BCH_REPLICAS_MAX
>    doesn't actually limit the number of pointers in an extent when
>    cached pointers are included
>  - RO snapshots are actually RO now
>  - And, a new superblock section to avoid future breakage when the disk
>    space acounting rewrite rolls out: the new superblock section
>    describes versions that need work to downgrade, where the work
>    required is a list of recovery passes and errors to silently fix.
>
> ----------------------------------------------------------------
> Kent Overstreet (13):
>       bcachefs: Fix extents iteration + snapshots interaction
>       bcachefs: fix invalid free in dio write path
>       bcachefs: fix setting version_upgrade_complete
>       bcachefs: Factor out darray resize slowpath
>       bcachefs: Switch darray to kvmalloc()
>       bcachefs: DARRAY_PREALLOCATED()
>       bcachefs: fix buffer overflow in nocow write path
>       bcachefs: move BCH_SB_ERRS() to sb-errors_types.h
>       bcachefs: prt_bitflags_vector()
>       bcachefs: Add persistent identifiers for recovery passes
>       bcachefs: bch_sb.recovery_passes_required
>       bcachefs: bch_sb_field_downgrade
>       bcachefs: make RO snapshots actually RO
>
>  fs/bcachefs/Makefile          |   2 +
>  fs/bcachefs/acl.c             |   3 +-
>  fs/bcachefs/bcachefs.h        |   1 +
>  fs/bcachefs/bcachefs_format.h |  51 ++++++---
>  fs/bcachefs/btree_iter.c      |  35 ++++--
>  fs/bcachefs/darray.c          |  24 ++++
>  fs/bcachefs/darray.h          |  48 +++++---
>  fs/bcachefs/errcode.h         |   3 +
>  fs/bcachefs/error.c           |   3 +
>  fs/bcachefs/fs-io-direct.c    |  13 +--
>  fs/bcachefs/fs-ioctl.c        |  12 +-
>  fs/bcachefs/fs.c              |  38 ++++++-
>  fs/bcachefs/io_write.c        |  82 +++++++-------
>  fs/bcachefs/printbuf.c        |  22 ++++
>  fs/bcachefs/printbuf.h        |   2 +
>  fs/bcachefs/recovery.c        | 137 +++++++++++++++++++----
>  fs/bcachefs/recovery.h        |   3 +
>  fs/bcachefs/recovery_types.h  |  86 ++++++++------
>  fs/bcachefs/sb-clean.c        |   2 -
>  fs/bcachefs/sb-downgrade.c    | 188 +++++++++++++++++++++++++++++++
>  fs/bcachefs/sb-downgrade.h    |  10 ++
>  fs/bcachefs/sb-errors.c       |   6 +-
>  fs/bcachefs/sb-errors.h       | 253 +-----------------------------------=
------
>  fs/bcachefs/sb-errors_types.h | 253 ++++++++++++++++++++++++++++++++++++=
++++++
>  fs/bcachefs/subvolume.c       |  18 +++
>  fs/bcachefs/subvolume.h       |   3 +
>  fs/bcachefs/super-io.c        |  86 +++++++++++++-
>  fs/bcachefs/super-io.h        |  12 +-
>  fs/bcachefs/util.h            |   1 +
>  fs/bcachefs/xattr.c           |   3 +-
>  30 files changed, 977 insertions(+), 423 deletions(-)
>  create mode 100644 fs/bcachefs/darray.c
>  create mode 100644 fs/bcachefs/sb-downgrade.c
>  create mode 100644 fs/bcachefs/sb-downgrade.h
>

