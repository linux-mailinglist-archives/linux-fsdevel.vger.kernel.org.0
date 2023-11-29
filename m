Return-Path: <linux-fsdevel+bounces-4210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC407FDD41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 17:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43EAB1F20FCA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 16:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ECC3B295
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iltA2lt1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA264A3
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 07:06:19 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-67a14f504f8so25313756d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 07:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701270379; x=1701875179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnZ3kRb4o1x4kUByYjfvLpmiehGhUqRt4pP7vRCuZgM=;
        b=iltA2lt1qSRyJLhaEnYuy2KqkP0nC2Marai11Dxpjcs85pM7OMj7qbKyqvfjzQ3SdV
         7KxB71mqR/JWk9HENDEKo9GHa4QsAb/m2TlI4CpzuO+46M9wVD+V1u1PgF/lGXX9pv0r
         /evpXr4STDdaZQUP+XJ3hxWucUpiZ/a2ZiGUxOyv/OF4P+7p7ezwYcmfcbI4J4gUf4rO
         VqtE6QhGf0YgT9xIk+R1+5hiwqrz6n275ZM9gCFqFlLoGaEqznfCCy0SvyE9502MZ6jR
         CTEiq81wHASyU8J0L5Gfg++pRz76O3LodW2AFtFjUd167QHl5kfCXeYLs1I52eevvtxP
         VRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701270379; x=1701875179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nnZ3kRb4o1x4kUByYjfvLpmiehGhUqRt4pP7vRCuZgM=;
        b=K9YaK3DkWwTL59mkAHOq2ixM1wCmjq7UE4EnPnTL2Q9/hVUs3J1OdkFEDVMQ8LBsZe
         pVPBolkgcU5OrRRAXJTlfmDCAhEUjHyzHjrL1Y7GoZjAfF+UFDNcjNz9gwTsLxI1EMyO
         WPS/qeYzSHLlAFf4IO8fnkx/42bYvDaAbQtRjaXuo5Ro/4n7Ji/okawoR0RWpERMT7uk
         a0WTOFf8b0lZEO+gtyeNeFH+FMd1z4u6b7SDDzeOg4P20/8ScXwO7W5k6SUMLRSq6qnZ
         giEMVZLT5euYl3XN3mBMS0XsSyv/FuHyVsIHgxS+lwrly3xFMU8dmRAxGXd0lsU5A6jH
         mowQ==
X-Gm-Message-State: AOJu0YzXL2T8kc7UMSzUULpNoVR2EuGL1ML0jjfhZRTCy7LIRw4Z5cCI
	iKtUazktgVG9oomlJLb/wyLXNjPYbFTsoa2lSiTGE1IBffo=
X-Google-Smtp-Source: AGHT+IENbl8JKXjzvS4UHDH27b2Fkd0e7XQwAvyHS0VsT0cTv7+xT8u+4KlJEvtSL6BlhBFmbgIX3GRtbOaTZOnJ2Rs=
X-Received: by 2002:a05:6214:a47:b0:67a:1a19:6b51 with SMTP id
 ee7-20020a0562140a4700b0067a1a196b51mr16109911qvb.29.1701270378687; Wed, 29
 Nov 2023 07:06:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016160902.2316986-1-amir73il@gmail.com> <CAOQ4uxh=cLySge6htd+DnJrqAKF=C_oJYfVrbpvQGik0wR-+iw@mail.gmail.com>
 <CAJfpegtZGC93-ydnFEt1Gzk+Yy5peJ-osuZD8GRYV4c+WPu0EQ@mail.gmail.com>
 <CAOQ4uxjYLta7_fJc90C4=tPUxTw-WR2v9du8JHTVdsy_iZnFmA@mail.gmail.com>
 <CAJfpegufvtaBaK8p+Q3v=9Qoeob3WamWBye=1BwGniRsvO5HZg@mail.gmail.com>
 <CAOQ4uxj+myANTk2C+_tk_YNLe748i2xA0HMZ7FKCuw7W5RUCuA@mail.gmail.com>
 <CAJfpegs1v=JKaEREORbTsvyTe02_DgkFhNSEJKR6xpjUW1NBDg@mail.gmail.com>
 <CAOQ4uxiBu8bZ4URhwKuMeHB_Oykz2LHY8mXA1eB3FBoeM_Vs6w@mail.gmail.com>
 <CAJfpegtr1yOYKOW0GLkow_iALMc_A0+CUaErZasQunAfJ7NFzw@mail.gmail.com>
 <CAOQ4uxjbj4fQr9=wxRR8a5vNp-vo+_JjK6uHizZPyNFiN1jh4w@mail.gmail.com>
 <CAJfpegtWdGVm9iHgVyXfY2mnR98XJ=6HtpaA+W83vvQea5PycQ@mail.gmail.com>
 <CAOQ4uxh6sd0Eeu8z-CpCD1KEiydvQO6AagU93RQv67pAzWXFvQ@mail.gmail.com> <CAJfpegsoz12HRBeXzjX+x37fSdzedshOMYbcWS1QtG4add6Nfg@mail.gmail.com>
In-Reply-To: <CAJfpegsoz12HRBeXzjX+x37fSdzedshOMYbcWS1QtG4add6Nfg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 29 Nov 2023 17:06:07 +0200
Message-ID: <CAOQ4uxjEHEsBr5OgvrKNAsEeH_VUTZ-Cho2bYVPYzj_uBLLp2A@mail.gmail.com>
Subject: Re: [PATCH v14 00/12] FUSE passthrough for file io
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Daniel Rosenberg <drosen@google.com>, 
	Paul Lawrence <paullawrence@google.com>, Alessio Balsini <balsini@android.com>, 
	Christian Brauner <brauner@kernel.org>, fuse-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 4:14=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Wed, 29 Nov 2023 at 08:25, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > My proposed solution is to change the semantics with the init flag
> > FUSE_PASSTHROUGH to disallow mmap on FOPEN_DIRECT_IO
> > files.
>
> Why?  FOPEN_DIRECT_IO and FUSE_PASSTHROUGH should mix much more
> readily than FOPEN_DIRECT_IO with page cache.
>

Am I misunderstanding how mmap works with FOPEN_DIRECT_IO file?
My understanding is that mmap of FOPEN_DIRECT_IO reads/writes
from page cache of fuse inode.

To clarify, the plan is to never allow mixing open of passthrough and
cached files on the same inode.

It is allowed to open FOPEN_DIRECT_IO file for inode either in cached
or passthrough mode, but it is NOT allowed to mmap a FOPEN_DIRECT_IO
file for inode in passthrough mode.

However, if inode only has file open in FOPEN_DIRECT_IO mode, then inode
mode is neutral. If we allow mmap in this state then a later open in passth=
ourgh
mode and mmap in passthrough mode will collide with the direct mode mmap.

Therefore, my proposal is than when filesystem is FUSE_PASSTHROUGH capable,
only passthrough file and cached file may be mmaped, but never allow to
mmap a FOPEN_DIRECT_IO file.

Does that make sense?


> > So with a filesystem that supports FUSE_PASSTHROUGH,
> > FOPEN_DIRECT_IO files can only be used for direct read/write io and
> > mmap maps either the fuse inode pages or the backing inode pages.
> >
> > This also means that FUSE_DIRECT_IO_RELAX conflicts with
> > FUSE_PASSTHROUGH.
> >
> > Should we also deny mixing FUSE_HAS_INODE_DAX with
> > FUSE_PASSTHROUGH? Anything else from virtiofs?
>
> Virtiofs/DAX and passthrough are similar features in totally different
> environments.   We just need to make sure the code paths don't
> collide.
>
> > While I have your attention, I am trying to consolidate the validation
> > of FOPEN_ mode vs inode state into fuse_finish_open().
> >
> > What do you think about this partial patch that also moves
> > fuse_finish_open() to after fuse_release_nowrite().
> > Is it legit?
>
> I suspect it won't work due to the i_size reset being in
> fuse_finish_open().  But I feel there's not enough context to
> understand why this is needed.
>

the re-order of fuse_finish_open() and fuse_release_nowrite() is not
needed - it just makes the code a little cleaner.

I will try without reorder.

Thanks,
Amir.

