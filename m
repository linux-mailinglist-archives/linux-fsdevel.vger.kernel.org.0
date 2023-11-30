Return-Path: <linux-fsdevel+bounces-4331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B47497FEAC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 09:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 329F2B20F8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 08:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86212208E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 08:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKP6N0k3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C39B122
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 23:12:39 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5d3687a6574so1526357b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 23:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701328358; x=1701933158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ua1pt4woq8sw3x+ewQUIXOchTjuj4ym+sF97jwtlVTk=;
        b=LKP6N0k31wwiYYvv68xfUz8ARbhWQ+315SWyFxyC6R9QTzUU92A1k/rJITAtB44uny
         O5QfLl0HtVK+jA2PXR2x9UKNInVrWUK1IUVEKdlzOFk030BIK0GBqpwhCH/8geaR5JNA
         VV8W998RRDXKQbFkXNty7C6U1RsfU25wVx5s9nRovjJoKoUImW4JQJM60LhGH/zmTp5G
         q0ifzllz+qjfJFNqck302Cp9TQgyZmDSPTp7hYOL0XNNYUZ89KJTbZfNyowcBaoPMqtN
         +/2Zvavspg2SpcatGMQMPbgx7Qv4ia5nI9+F/syObRna+9b/ekRrk2UVZH9yEwl0/ChK
         wVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701328358; x=1701933158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ua1pt4woq8sw3x+ewQUIXOchTjuj4ym+sF97jwtlVTk=;
        b=QiXupJp4ArbfX/ihQ8/Kubugf0VQLU09GxP7kQWgDttA/+BmSc8HoJ8b3jEFwS2P7O
         V7bmN9ksS1BMhdzdGHLG/EeZrScJ5aui703fhsVawXY9OTfsXwufgTMtH30s5nk60xji
         6crmzAnyDWLevDYibfPvb8bBfTU6Grn67mwYro1cN/an4bWCh2imsx+rC3Cxk6jqxObM
         F4R1obmPodYu84AtlnPo4T65KD2PXOeIoimMNEKoxnE4uEqJV3rcrEjtGK2BQkMOWxXv
         7V09T41ZEKPhce5OPmVqiBa5yMpZxaU9FcDQqfJ1CQWwjMhI1iPkF+emHJizFt8u6vN/
         +pGA==
X-Gm-Message-State: AOJu0YxFxPQujcToow61qbi6d0MTe/RPo023wmAu3EeRWKdvDGb5e9IT
	ZzLahHb2c5q1MyeUG+IKLErElSt7VLxfhmi07y8=
X-Google-Smtp-Source: AGHT+IEucX8WwP8Oxrr58nsO7sU039Smi8+b2YW+qJ5amycTYZXx7VYieXU+0uVGiLBlU8HTZwokJ1qEYjM88YUmxFo=
X-Received: by 2002:a05:690c:a90:b0:5cd:fd7c:274f with SMTP id
 ci16-20020a05690c0a9000b005cdfd7c274fmr22274258ywb.26.1701328358415; Wed, 29
 Nov 2023 23:12:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016160902.2316986-1-amir73il@gmail.com> <CAOQ4uxh6sd0Eeu8z-CpCD1KEiydvQO6AagU93RQv67pAzWXFvQ@mail.gmail.com>
 <CAJfpegsoz12HRBeXzjX+x37fSdzedshOMYbcWS1QtG4add6Nfg@mail.gmail.com>
 <CAOQ4uxjEHEsBr5OgvrKNAsEeH_VUTZ-Cho2bYVPYzj_uBLLp2A@mail.gmail.com>
 <CAJfpegtH1DP19cAuKgYAssZ8nkKhnyX42AYWtAT3h=nmi2j31A@mail.gmail.com>
 <CAOQ4uxgW6xpWW=jLQJuPKOCxN=i_oNeRwNnMEpxOhVD7RVwHHw@mail.gmail.com>
 <CAJfpegtOt6MDFM3vsK+syJhpLMSm7wBazkXuxjRTXtAsn9gCuA@mail.gmail.com>
 <CAOQ4uxiCjX2uQqdikWsjnPtpNeHfFk_DnWO3Zz2QS3ULoZkGiA@mail.gmail.com>
 <2f6513fa-68d8-43c8-87a4-62416c3e1bfd@fastmail.fm> <44ff6b37-7c4b-485d-8ebf-de5fadd3c527@spawn.link>
In-Reply-To: <44ff6b37-7c4b-485d-8ebf-de5fadd3c527@spawn.link>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 30 Nov 2023 09:12:26 +0200
Message-ID: <CAOQ4uxgWQbuiMQ5FaXyWALAXqdF-S2MrCLNB14-1ZYPfUs_d+g@mail.gmail.com>
Subject: Re: [PATCH v14 00/12] FUSE passthrough for file io
To: Antonio SJ Musumeci <trapexit@spawn.link>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Miklos Szeredi <miklos@szeredi.hu>, 
	Daniel Rosenberg <drosen@google.com>, Paul Lawrence <paullawrence@google.com>, 
	Alessio Balsini <balsini@android.com>, Christian Brauner <brauner@kernel.org>, 
	fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 11:39=E2=80=AFPM Antonio SJ Musumeci
<trapexit@spawn.link> wrote:
>
> On 11/29/23 14:46, Bernd Schubert wrote:
> >
> >
> > On 11/29/23 18:39, Amir Goldstein wrote:
> >> On Wed, Nov 29, 2023 at 6:55=E2=80=AFPM Miklos Szeredi <miklos@szeredi=
.hu> wrote:
> >>>
> >>> On Wed, 29 Nov 2023 at 16:52, Amir Goldstein <amir73il@gmail.com> wro=
te:
> >>>
> >>>> direct I/O read()/write() is never a problem.
> >>>>
> >>>> The question is whether mmap() on a file opened with FOPEN_DIRECT_IO
> >>>> when the inode is in passthrough mode, also uses fuse_passthrough_mm=
ap()?
> >>>
> >>> I think it should.
> >>>
> >>>> or denied, similar to how mmap with ff->open_flags & FOPEN_DIRECT_IO=
 &&
> >>>> vma->vm_flags & VM_MAYSHARE) && !fc->direct_io_relax
> >>>> is denied?
> >>>
> >>> What would be the use case for FOPEN_DIRECT_IO with passthrough mmap?
> >>>
> >>
> >> I don't have a use case. That's why I was wondering if we should
> >> support it at all, but will try to make it work.
> >
> > What is actually the use case for FOPEN_DIRECT_IO and passthrough?
> > Avoiding double page cache?
> >
> >>
> >>>> A bit more challenging, because we will need to track unmounts, or a=
t
> >>>> least track
> >>>> "was_cached_mmaped" state per file, but doable.
> >>>
> >>> Tracking unmaps via fuse_vma_close() should not be difficult.
> >>>
> >>
> >> OK. so any existing mmap, whether on FOPEN_DIRECT_IO or not
> >> always prevents an inode from being "neutral".
> >>
> >
> >
> > Thanks,
> > Bernd
> >
>
>  > Avoiding double page cache?
>
> Currently my users enable direct_io because 1) it is typically
> materially faster than not 2) avoiding double page caching (it is a
> union filesystem).
>
> The only real reason people disable direct_io is because many apps need
> shared mmap. I've implemented a mode to lookup details about the
> requesting app and optionally disable direct_io for apps which are known
> to need shared mmap but that isn't ideal. The relaxed mode being
> discussed would likely be more performant and more transparent to the
> user. That transparency is nice if that can continue as it is already
> pretty difficult to explain all these options to the layman.
>
> Offtopic: What happens in passthrough mode when an error occurs?

passthrough is passthrough, in sickness and in health...

whatever read/write/splice on the real file returns, that is what applicati=
on
will get for read/write/splice on the fuse file.

Regarding passthrough mmap - this means that the memory is really
mapped to the real file (in sickness and in health...).

The semantics of whether we do "normal" mmap or passthrough mmap
on a file that the server opened as FOPEN_DIRECT_IO will be:

If there is any file open for passthrough on this inode, mmap() will be to
the real inode page cache, regardless of FOPEN_DIRECT_IO.

Otherwise, whether there is a file open in cached mode or not, mmap()
will be to fuse inode page cache, regardless of FOPEN_DIRECT_IO.

Thanks,
Amir.

