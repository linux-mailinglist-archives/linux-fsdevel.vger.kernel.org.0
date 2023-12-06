Return-Path: <linux-fsdevel+bounces-4962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FEC806C0E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 11:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7069028111F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2872B2DF88
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfBhiy63"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61615C3
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 01:59:27 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-67a959e3afaso34390656d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Dec 2023 01:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701856766; x=1702461566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rHjSeVyKpbAPQaMNrtLRWoP1IoOV86xUWSAk/hnti8=;
        b=QfBhiy63H5eGK0vFhXl9jT8BrdGWSAJu5now0Jmk/KhV8WI5Kh8wi68Bs8RGoxlsDe
         zZ6lxBn6yl34N5J2SI4z+Ie8edeh4ZYZlULxzaHl6cWFR5i0S+DdBYFbo9CuUdkFbc12
         T4cyl4uOytjG8amggOKjrphRNsm+82qtRK19Pyzi5QPbwcNiC0vlDoX6lox2ra/K/dpX
         34zPLDwvcOonvqcgzBPY4XpL3zDwi/mG+KsY4HMmf6dLPQTjO8jwbUtY6AE26NkmP/Bj
         ZZj4jEzbZzRTKEXqF3Oc5eqrqtc6RxgimKAs59Ewd15KxOcrlc4ajVE53vam/Jvyupj3
         8Iag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701856766; x=1702461566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+rHjSeVyKpbAPQaMNrtLRWoP1IoOV86xUWSAk/hnti8=;
        b=Il+8P5umtwj3EmCCTZgdo2OvnfSZW2Tszu4vPuyk76/PjgeH5jqU02E2JC5wJzXgE2
         pWLyP/8qY1sISps1WSu262INtNxg6KBlqQAe1Q/2uz/WM2IJ5DL95fDLwYyfHLLGSp30
         mVfKMmA4Dg4BKcutlVPaqdl+cyefn7a9uy9k82Xe6V/e4K7XIDHsujWoxJDIiiHntZm6
         HUjd2cglZFe+0wePe9FxRV9ZZbuwQiBuEeqWWIlJnbLclosglD/6h71Q1dpk3wnXVqWz
         /qyhFnBucUNgbEYTnhcT0nJFODxrawBa20CECiSbX0wbH4LGL6f3qrdsorNBJGjo+whY
         BvYg==
X-Gm-Message-State: AOJu0Yy7F6IPRir4X/03oNOpoJJ7Y18i8us8XSkqYag29cs4FR0a1YnJ
	zVpQEzUgBRC8Xi9aR5kx1jiMilgqNowwh+11tiU=
X-Google-Smtp-Source: AGHT+IGl333HdZl5ZZ7oZPK64tc4d30DQi1Z4UycTMqX1bF9WU+3mxQ/BHn9xYzlUQg48A1Gv/rugHx3pHDZLG/HS0w=
X-Received: by 2002:ad4:57ac:0:b0:67a:9d24:5e95 with SMTP id
 g12-20020ad457ac000000b0067a9d245e95mr584076qvx.31.1701856766070; Wed, 06 Dec
 2023 01:59:26 -0800 (PST)
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
 <CAOQ4uxh6sd0Eeu8z-CpCD1KEiydvQO6AagU93RQv67pAzWXFvQ@mail.gmail.com>
 <CAJfpegsoz12HRBeXzjX+x37fSdzedshOMYbcWS1QtG4add6Nfg@mail.gmail.com>
 <CAOQ4uxjEHEsBr5OgvrKNAsEeH_VUTZ-Cho2bYVPYzj_uBLLp2A@mail.gmail.com>
 <CAJfpegtH1DP19cAuKgYAssZ8nkKhnyX42AYWtAT3h=nmi2j31A@mail.gmail.com>
 <CAOQ4uxgW6xpWW=jLQJuPKOCxN=i_oNeRwNnMEpxOhVD7RVwHHw@mail.gmail.com> <CAJfpegtOt6MDFM3vsK+syJhpLMSm7wBazkXuxjRTXtAsn9gCuA@mail.gmail.com>
In-Reply-To: <CAJfpegtOt6MDFM3vsK+syJhpLMSm7wBazkXuxjRTXtAsn9gCuA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 6 Dec 2023 11:59:14 +0200
Message-ID: <CAOQ4uxhKEGxLQ4nR1RfX+37x6KN-Vy8X_TobYpETtjcWng+=DA@mail.gmail.com>
Subject: Re: [PATCH v14 00/12] FUSE passthrough for file io
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Daniel Rosenberg <drosen@google.com>, Paul Lawrence <paullawrence@google.com>, 
	Alessio Balsini <balsini@android.com>, Christian Brauner <brauner@kernel.org>, 
	fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 6:55=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Wed, 29 Nov 2023 at 16:52, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > direct I/O read()/write() is never a problem.
> >
> > The question is whether mmap() on a file opened with FOPEN_DIRECT_IO
> > when the inode is in passthrough mode, also uses fuse_passthrough_mmap(=
)?
>
> I think it should.
>
> > or denied, similar to how mmap with ff->open_flags & FOPEN_DIRECT_IO &&
> > vma->vm_flags & VM_MAYSHARE) && !fc->direct_io_relax
> > is denied?
>
> What would be the use case for FOPEN_DIRECT_IO with passthrough mmap?
>
> > A bit more challenging, because we will need to track unmounts, or at
> > least track
> > "was_cached_mmaped" state per file, but doable.
>
> Tracking unmaps via fuse_vma_close() should not be difficult.
>

I think that it is.

fuse_vma_close() does not seem to be balanced with fuse_file_mmap()
because IIUC, maps can be cloned via fork() etc.

It tried to implement an iocachectr refcount to track cache mmaps,
but it keeps underflowing in fuse_vma_close().

I would like us to consider a slightly different model.

We agreed that caching and passthrough mode on the same
inode cannot mix and there is no problem with different modes
per inode on the same filesystem.

I have a use case for mixing direct_io and passthrough on the
same inode (i.e. inode in passthrough mode).

I have no use case (yet) for the transition from caching to passthrough
mode on the same inode and direct_io cached mmaps complicate
things quite a bit for this scenario.

My proposal is to taint a direct_io file with FOPEN_CACHE_MMAP
if it was ever mmaped using page cache.
We will not try to clean this flag in fuse_vma_close(), it stays with
the file until release.

An FOPEN_CACHE_MMAP file forces an inode into caching mode,
same as a regular caching open.
We could allow server to set FOPEN_CACHE_MMAP along with
FOPEN_DIRECT_IO to preemptively deny future passthrough open,
but not sure this is important.
If we wanted to, we could let this flag combination have the same
meaning as direct_io_allow_mmap, but per file/inode.

In relation to the FOPEN_PARALLEL_DIRECT_WRITES vs.
FUSE_DIRECT_IO_ALLOW_MMAP discussion, Bernd has suggested
a per inode FUSE_I_CACHE_WRITES, state that tracks if caching writes
were ever done on inode to allow parallel dio on the rest of the inodes
in the filesystem.

FUSE_I_CACHE_WRITES is a sub-state of caching mode inode state.
I think maybe caching mode would be enough for both use cases -
preventing parallel dio and preventing passthrough open.

The result would be that parallel dio would be performed on inodes that
are not currently open in caching mode and have not been mmaped
at all (regardless of writes to page cache) using any of the currently
open direct_io files.

As long as the applications that use mmap write (e.g. compiler)
do not usually work on the same files as the applications that do
parallel dio writes (e.g. db) and as long as files that are typically mmape=
d
privately (exe and libs) don't need parallel dio writes,
I think that FUSE_I_CACHE_WRITES state will not be needed.

But maybe I am missing some cases. In any case, there is nothing
preventing FUSE_I_CACHE_WRITES to exist along side caching mode
if needed.

Thanks,
Amir.

