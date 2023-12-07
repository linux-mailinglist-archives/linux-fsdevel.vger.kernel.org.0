Return-Path: <linux-fsdevel+bounces-5109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95420808349
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 09:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7DF51C21C2E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D4F328BC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUx06QV1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D1D137
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 23:23:51 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-42588e94019so7001511cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Dec 2023 23:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701933830; x=1702538630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gs/KeTJn1LshONCXMIOQjM1noKfy77p9sy3SjuqNkhE=;
        b=mUx06QV15Ccq8sanViItJQWlYcXNWSglV9ena3VWZzylYRlmwDwgUMoqYvr1kQrJ2r
         zwfX276bdtYHUFrsYoNSG0Ae2z5NboclOqk8qeSc39SPIe6/cpuWBAWiQm9O6GCqiURY
         ycHjJOFTlPZYD8YBDw2tJCRWYDtPrmaPdinGqHqE7cOsQPjpVK2u6c55EM0dR37PMOSk
         Gspd4kkPne250LmdLQ7cfb8UQUtKZteHn+N600JJsQANpn8c2fCHr4IINAtUi7kCDUcy
         Ht0FlZDVSFNsR3KbpyZNvDJT2ZPCRZQixiRsDmJQLUlJoSGWB17JKvlnV5eJiklfYvy2
         iR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701933830; x=1702538630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gs/KeTJn1LshONCXMIOQjM1noKfy77p9sy3SjuqNkhE=;
        b=ZVZxbHcCoIJw4eUtePm8qG6TOnuEcqpCDNWltMD6iWIbOEQfLS1CxDTNV7qn4jm1qT
         pHOup+6m5zVqhjdp6mw2HoCvae57DOoxUV0K0Lb15G8k1e1373O0zpyzAwYnFB4g1y0a
         PsGckkUl31p06zTJRbtZyQo8o+LHwELB9Hd1YfBLpK6IJE3wRntnwVuEAZP6FtxZfpR5
         XB1x7Iy3CPw4gdKwcWCh9aFRMKR/OSQFO7923qCTpNcEyhtik/Zr1oaU1USm1tzEYSGG
         4La51ysYtU8XtIC9ctc0KHuctcX6D/Cbx8qRh5wrDp/xGqxdyF2Hp+l2xr8LB+Orxl5z
         GOvQ==
X-Gm-Message-State: AOJu0Yx8CPJa9GSeNvc29KHZ1Z1+1WDX3pbyt1HliSAmBaMYnKTq2tWQ
	nrY9welEF4JQmfI2IZpDmVZ+yC4DVYww1gOiObA=
X-Google-Smtp-Source: AGHT+IEKKDcZDJM4r79q28Ad6zpjaEp6AYErsf+j44+Gl6/gEVz7otEpexTt3bs/m2o3f3Xk3KtLxmsgcHQw3/EJ1pE=
X-Received: by 2002:ad4:5c48:0:b0:67a:a72d:fba8 with SMTP id
 a8-20020ad45c48000000b0067aa72dfba8mr6214820qva.38.1701933830453; Wed, 06 Dec
 2023 23:23:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016160902.2316986-1-amir73il@gmail.com> <CAOQ4uxj+myANTk2C+_tk_YNLe748i2xA0HMZ7FKCuw7W5RUCuA@mail.gmail.com>
 <CAJfpegs1v=JKaEREORbTsvyTe02_DgkFhNSEJKR6xpjUW1NBDg@mail.gmail.com>
 <CAOQ4uxiBu8bZ4URhwKuMeHB_Oykz2LHY8mXA1eB3FBoeM_Vs6w@mail.gmail.com>
 <CAJfpegtr1yOYKOW0GLkow_iALMc_A0+CUaErZasQunAfJ7NFzw@mail.gmail.com>
 <CAOQ4uxjbj4fQr9=wxRR8a5vNp-vo+_JjK6uHizZPyNFiN1jh4w@mail.gmail.com>
 <CAJfpegtWdGVm9iHgVyXfY2mnR98XJ=6HtpaA+W83vvQea5PycQ@mail.gmail.com>
 <CAOQ4uxh6sd0Eeu8z-CpCD1KEiydvQO6AagU93RQv67pAzWXFvQ@mail.gmail.com>
 <CAJfpegsoz12HRBeXzjX+x37fSdzedshOMYbcWS1QtG4add6Nfg@mail.gmail.com>
 <CAOQ4uxjEHEsBr5OgvrKNAsEeH_VUTZ-Cho2bYVPYzj_uBLLp2A@mail.gmail.com>
 <CAJfpegtH1DP19cAuKgYAssZ8nkKhnyX42AYWtAT3h=nmi2j31A@mail.gmail.com>
 <CAOQ4uxgW6xpWW=jLQJuPKOCxN=i_oNeRwNnMEpxOhVD7RVwHHw@mail.gmail.com>
 <CAJfpegtOt6MDFM3vsK+syJhpLMSm7wBazkXuxjRTXtAsn9gCuA@mail.gmail.com>
 <CAOQ4uxhKEGxLQ4nR1RfX+37x6KN-Vy8X_TobYpETtjcWng+=DA@mail.gmail.com> <f224ffac-c59e-47dd-8e11-721d7b1c7104@fastmail.fm>
In-Reply-To: <f224ffac-c59e-47dd-8e11-721d7b1c7104@fastmail.fm>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 7 Dec 2023 09:23:38 +0200
Message-ID: <CAOQ4uxh1UWY_OLV1Zq-phFXcOFVp=EJHtgZdXB021Fr-ZHPWzg@mail.gmail.com>
Subject: Re: [PATCH v14 00/12] FUSE passthrough for file io
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Daniel Rosenberg <drosen@google.com>, 
	Paul Lawrence <paullawrence@google.com>, Alessio Balsini <balsini@android.com>, 
	Christian Brauner <brauner@kernel.org>, fuse-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 1:11=E2=80=AFAM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
> Hi Amir,
>
>
> On 12/6/23 10:59, Amir Goldstein wrote:
> > On Wed, Nov 29, 2023 at 6:55=E2=80=AFPM Miklos Szeredi <miklos@szeredi.=
hu> wrote:
> >>
> >> On Wed, 29 Nov 2023 at 16:52, Amir Goldstein <amir73il@gmail.com> wrot=
e:
> >>
> >>> direct I/O read()/write() is never a problem.
> >>>
> >>> The question is whether mmap() on a file opened with FOPEN_DIRECT_IO
> >>> when the inode is in passthrough mode, also uses fuse_passthrough_mma=
p()?
> >>
> >> I think it should.
> >>
> >>> or denied, similar to how mmap with ff->open_flags & FOPEN_DIRECT_IO =
&&
> >>> vma->vm_flags & VM_MAYSHARE) && !fc->direct_io_relax
> >>> is denied?
> >>
> >> What would be the use case for FOPEN_DIRECT_IO with passthrough mmap?
> >>
> >>> A bit more challenging, because we will need to track unmounts, or at
> >>> least track
> >>> "was_cached_mmaped" state per file, but doable.
> >>
> >> Tracking unmaps via fuse_vma_close() should not be difficult.
> >>
> >
> > I think that it is.
> >
> > fuse_vma_close() does not seem to be balanced with fuse_file_mmap()
> > because IIUC, maps can be cloned via fork() etc.
> >
> > It tried to implement an iocachectr refcount to track cache mmaps,
> > but it keeps underflowing in fuse_vma_close().
> >
> > I would like us to consider a slightly different model.
> >
> > We agreed that caching and passthrough mode on the same
> > inode cannot mix and there is no problem with different modes
> > per inode on the same filesystem.
> >
> > I have a use case for mixing direct_io and passthrough on the
> > same inode (i.e. inode in passthrough mode).
> >
> > I have no use case (yet) for the transition from caching to passthrough
> > mode on the same inode and direct_io cached mmaps complicate
> > things quite a bit for this scenario.
> >
> > My proposal is to taint a direct_io file with FOPEN_CACHE_MMAP
> > if it was ever mmaped using page cache.
> > We will not try to clean this flag in fuse_vma_close(), it stays with
> > the file until release.
> >
> > An FOPEN_CACHE_MMAP file forces an inode into caching mode,
> > same as a regular caching open.
>
> where do you actually want to set that flag? My initial idea for
> FUSE_I_CACHE_WRITES was to set that in fuse_file_mmap, but I would have
> needed the i_rwsem lock and that resulted in a lock ordering issue.
>

Yes, the idea is to set this flag on the first mmap of a FOPEN_DIRECT_IO fi=
le.
Why does that require an i_rwsem lock?

Before setting FUSE_I_CACHE_WRITES inode flag, your patch does:
    wait_event(fi->direct_io_waitq, fi->shared_lock_direct_io_ctr =3D=3D 0)=
;

We can do the same in direct_io mmap, before setting the
FOPEN_CACHE_MMAP file flag and consequently changing inode
mode to caching. No?

I will try to prepare a patch today to demonstrate.

Thanks,
Amir.

