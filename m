Return-Path: <linux-fsdevel+bounces-4218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081D57FDD55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 17:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A8FF1C209EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 16:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2283B786
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StG/Hc8+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CF483
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 07:52:17 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-677fba00a49so8683636d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 07:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701273137; x=1701877937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAdFe9oaJTNZ6uCV3e9kEY9sXnQ59A2MNrLB85HT4Rc=;
        b=StG/Hc8+1uchj+AlyF+XEkSqqzm5HWtciMRk+twPmClZTr/tHhggU2te1rf17TCV8b
         wp5zb8gU0BRXVGvrDKSobiNX78tWESu1A1ndx8dE/EwhdkYUlGlF0N3/hQmyzYK896Ub
         WHh4Qtu59Q6oOrtHXH3hvVd5SZi4ox01HgT9XeKcXy7xQGnofI8lmLVfBeVqOMbGx0Ns
         T8YE3KTeONnKwEmeMvGpqJXljubFoiYA0wYsHebybPUz9DnOOMr1KN6hg3yr+HmiNvuj
         18laQesFTbAgEZjhgJpXSejujXxOUmnfCG91RM44zplQYaC0EV/FILkGj1AQVnCwqONc
         60DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701273137; x=1701877937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAdFe9oaJTNZ6uCV3e9kEY9sXnQ59A2MNrLB85HT4Rc=;
        b=Bt93spJwZSbw//lcMqCNZTR1azJwHD+3oFyCZu9uVbzl9LwL7TrAQVfxaoglQRcZ+c
         0cEfKhCc0ilMYWLNdUzHCiGegMn6yiJ2DVaG/RcxKE9gqqung5bDXWovMZQcY95xwX0/
         S9mYr5Im58k2qvFZrqjQdfw9S0KmwKi0twcv7WN8rXhGVF3Npr96TQtFq7k9zLYeiyDF
         vsDDo6dlg8Mui8Qw8K4ZitxrK0RoVYZ6CzM3lYsAhBff3Fy40nmQq0rrn7z0xHD5ygt7
         KyC7gLuWPOK4R/x4jJ6Y9QADDWGHz73EmYkOLBe9MF4F53lf/2OAvPLyYvRzXgg+HHZX
         vviQ==
X-Gm-Message-State: AOJu0YxwlrYFJ01pbzKHDLKz3ItMp8jUfFOZs6AfGO3X1qUhBb6Tlp/G
	Mj0q/rkJMw1fBI9RNbtwvEx6tJyr9VPvg/X9rlA=
X-Google-Smtp-Source: AGHT+IE/V8vHQI4xOr7/+R801aHFy7yp149fv6bswwcsU2RoZw1eC8XLtXyqTvu6T8Gy/7zKXVOTX2ORR7VieJn+DVU=
X-Received: by 2002:a0c:d683:0:b0:66d:9987:68f9 with SMTP id
 k3-20020a0cd683000000b0066d998768f9mr28647156qvi.15.1701273136856; Wed, 29
 Nov 2023 07:52:16 -0800 (PST)
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
 <CAOQ4uxjEHEsBr5OgvrKNAsEeH_VUTZ-Cho2bYVPYzj_uBLLp2A@mail.gmail.com> <CAJfpegtH1DP19cAuKgYAssZ8nkKhnyX42AYWtAT3h=nmi2j31A@mail.gmail.com>
In-Reply-To: <CAJfpegtH1DP19cAuKgYAssZ8nkKhnyX42AYWtAT3h=nmi2j31A@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 29 Nov 2023 17:52:05 +0200
Message-ID: <CAOQ4uxgW6xpWW=jLQJuPKOCxN=i_oNeRwNnMEpxOhVD7RVwHHw@mail.gmail.com>
Subject: Re: [PATCH v14 00/12] FUSE passthrough for file io
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Daniel Rosenberg <drosen@google.com>, 
	Paul Lawrence <paullawrence@google.com>, Alessio Balsini <balsini@android.com>, 
	Christian Brauner <brauner@kernel.org>, fuse-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 5:21=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Wed, 29 Nov 2023 at 16:06, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Wed, Nov 29, 2023 at 4:14=E2=80=AFPM Miklos Szeredi <miklos@szeredi.=
hu> wrote:
> > >
> > > On Wed, 29 Nov 2023 at 08:25, Amir Goldstein <amir73il@gmail.com> wro=
te:
> > >
> > > > My proposed solution is to change the semantics with the init flag
> > > > FUSE_PASSTHROUGH to disallow mmap on FOPEN_DIRECT_IO
> > > > files.
> > >
> > > Why?  FOPEN_DIRECT_IO and FUSE_PASSTHROUGH should mix much more
> > > readily than FOPEN_DIRECT_IO with page cache.
> > >
> >
> > Am I misunderstanding how mmap works with FOPEN_DIRECT_IO file?
> > My understanding is that mmap of FOPEN_DIRECT_IO reads/writes
> > from page cache of fuse inode.
> >
> > To clarify, the plan is to never allow mixing open of passthrough and
> > cached files on the same inode.
>
> Yep.
>
> But passthrough mmap + direct I/O should work, no?
>

direct I/O read()/write() is never a problem.

The question is whether mmap() on a file opened with FOPEN_DIRECT_IO
when the inode is in passthrough mode, also uses fuse_passthrough_mmap()?
or denied, similar to how mmap with ff->open_flags & FOPEN_DIRECT_IO &&
vma->vm_flags & VM_MAYSHARE) && !fc->direct_io_relax
is denied?


> > It is allowed to open FOPEN_DIRECT_IO file for inode either in cached
> > or passthrough mode, but it is NOT allowed to mmap a FOPEN_DIRECT_IO
> > file for inode in passthrough mode.
> >
> > However, if inode only has file open in FOPEN_DIRECT_IO mode, then inod=
e
> > mode is neutral. If we allow mmap in this state then a later open in pa=
ssthourgh
> > mode and mmap in passthrough mode will collide with the direct mode mma=
p.
>
> We can keep track of when there are any page cache mmaps.  Does that
> not solve this?
>

A bit more challenging, because we will need to track unmounts, or at
least track
"was_cached_mmaped" state per file, but doable.

> >
> > Therefore, my proposal is than when filesystem is FUSE_PASSTHROUGH capa=
ble,
> > only passthrough file and cached file may be mmaped, but never allow to
> > mmap a FOPEN_DIRECT_IO file.
> >
> > Does that make sense?
>
> I'm not sure I understand how this is supposed to work.   Disallowing
> mmap will break applications.

How is this different from existing -ENODEV in fuse_file_mmap() for
!fc->direct_io_relax? What am I missing?
Is it because VM_MAYSHARE is far less common for applications?

Thanks,
Amir.

