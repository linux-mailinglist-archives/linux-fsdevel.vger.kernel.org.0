Return-Path: <linux-fsdevel+bounces-4332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CF97FEAC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 09:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4E86B20EB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 08:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1002D60C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 08:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7xfodtm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B6910F4
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 23:30:12 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-67a16594723so3898706d6.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 23:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701329411; x=1701934211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hi1iWfX1RuPQz0xVjHcG/PTXQmXIZNrPf1TE5/7Flgo=;
        b=T7xfodtmdem+RxT6Qyv/Kl/aeCnEh9cI3UjiuzLz+faGJXTT+p2C0zs43089Nyhutj
         OzWa2WtYMn2uO62CAsU9kikNZSnYXnMuLi5YNp3gy/R9D03doAYp1OW+Wf7Xo4zr2Gn0
         dvVlsP+QgLpZCV8RB+DYpi2FNMwo3WAZqGqpYkloUjmjemUl8CWMNBpRKa8/590mkqgW
         UwcG7HFGvQ0wRnkDGfrUsd2PHypY/0H7I5i7T20f5g63QZehoTpFtUQ46ghK9yCkZTz9
         UYoT5qCSWK07ZgxLGLJRzqVxgwjQx3YH4OvybdxIldXrqr/mEm6yJa6eqt9fww9MX+wW
         UVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701329411; x=1701934211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hi1iWfX1RuPQz0xVjHcG/PTXQmXIZNrPf1TE5/7Flgo=;
        b=ZYU/Jekg3MtGbYggTk0cGhuFkyDHLUTDuxJPzK02EN2bi0SMcTDY7eTzzqq5XebS7K
         lvEHp7S8I8wIJFu7agHDV2Lx6NfbLYqj6yii47DWKYtuyzu50W6u4YPbRpw1T/FiDvTr
         ogKeuYygatx5SLUOYZ9S2Gi/v7wgPtZ2/Bo8TC1drVIXF2Y631nwdJPDa5IIdrTo53eW
         HW+c3CE+VVyMtrs8PEEt/ZyHHTnP0LDdv/ZQqd4xXS41FK6IJZDdMBgD/j2593tMMrXB
         iPkonNqdiEfC5RqdVsqasKitHmkVagTRHVRPalQNVHBCWU54QsE6IOY5AmFQ4xBk0lkL
         gfog==
X-Gm-Message-State: AOJu0Yx2CM1poGvaKf1f2ytV6jplULiDn+Rtm2umzms0KSomPeUxjSEG
	330k+UVZONEvFB+kirY59nPor9NbnxkST7Qn5dY=
X-Google-Smtp-Source: AGHT+IH1S3XPhectdYbgV85AFXxYj48gSYf7xxPJdOOtL5NdqFvOk6tjcxoT88q6P/BzPcOxa6DMmNsgOGYyCS2GFAc=
X-Received: by 2002:ad4:528a:0:b0:67a:2875:3ab5 with SMTP id
 v10-20020ad4528a000000b0067a28753ab5mr15768554qvr.65.1701329411445; Wed, 29
 Nov 2023 23:30:11 -0800 (PST)
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
 <de783ce4-6ac1-42ca-94a2-a15aa1795b5d@fastmail.fm>
In-Reply-To: <de783ce4-6ac1-42ca-94a2-a15aa1795b5d@fastmail.fm>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 30 Nov 2023 09:29:58 +0200
Message-ID: <CAOQ4uxgK+-Kbg5TJLQR65X33VyE4zZinZ8G-8dTBTNK5bRLkRw@mail.gmail.com>
Subject: Re: [PATCH v14 00/12] FUSE passthrough for file io
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Antonio SJ Musumeci <trapexit@spawn.link>, Miklos Szeredi <miklos@szeredi.hu>, 
	Daniel Rosenberg <drosen@google.com>, Paul Lawrence <paullawrence@google.com>, 
	Alessio Balsini <balsini@android.com>, Christian Brauner <brauner@kernel.org>, 
	fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 12:01=E2=80=AFAM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 11/29/23 22:39, Antonio SJ Musumeci wrote:
> > On 11/29/23 14:46, Bernd Schubert wrote:
> >>
> >>
> >> On 11/29/23 18:39, Amir Goldstein wrote:
> >>> On Wed, Nov 29, 2023 at 6:55=E2=80=AFPM Miklos Szeredi <miklos@szered=
i.hu> wrote:
> >>>>
> >>>> On Wed, 29 Nov 2023 at 16:52, Amir Goldstein <amir73il@gmail.com> wr=
ote:
> >>>>
> >>>>> direct I/O read()/write() is never a problem.
> >>>>>
> >>>>> The question is whether mmap() on a file opened with FOPEN_DIRECT_I=
O
> >>>>> when the inode is in passthrough mode, also uses fuse_passthrough_m=
map()?
> >>>>
> >>>> I think it should.
> >>>>
> >>>>> or denied, similar to how mmap with ff->open_flags & FOPEN_DIRECT_I=
O &&
> >>>>> vma->vm_flags & VM_MAYSHARE) && !fc->direct_io_relax
> >>>>> is denied?
> >>>>
> >>>> What would be the use case for FOPEN_DIRECT_IO with passthrough mmap=
?
> >>>>
> >>>
> >>> I don't have a use case. That's why I was wondering if we should
> >>> support it at all, but will try to make it work.
> >>
> >> What is actually the use case for FOPEN_DIRECT_IO and passthrough?
> >> Avoiding double page cache?
> >>
> >>>
> >>>>> A bit more challenging, because we will need to track unmounts, or =
at
> >>>>> least track
> >>>>> "was_cached_mmaped" state per file, but doable.
> >>>>
> >>>> Tracking unmaps via fuse_vma_close() should not be difficult.
> >>>>
> >>>
> >>> OK. so any existing mmap, whether on FOPEN_DIRECT_IO or not
> >>> always prevents an inode from being "neutral".
> >>>
> >>
> >>
> >> Thanks,
> >> Bernd
> >>
> >
> >   > Avoiding double page cache?
> >
> > Currently my users enable direct_io because 1) it is typically
> > materially faster than not 2) avoiding double page caching (it is a
> > union filesystem).
>
> 3) You want coherency for network file systems (our use case).
>
> So performance kind of means it is preferred to have it enabled for
> passthrough. And with that MAP_SHARED gets rather important, imho. I
> don't know if recent gcc versions still do it, but gcc used to write
> files using MAP_SHARED. In the HPC AI world python tools also tend to do
> IO with MAP_SHARED.
>

I see. good to know.
That means that an inode in passthrough mode should always imply
direct_io_relax behavior.

The way that passthrough mode and network file systems use cases can
overlap is by per-inode basis, which is the typical case for HSM (out use c=
ase):
- some inodes are local and some are remote
- local inodes are open passthrough mode
- remote inodes are open in direct or cached mode
- inode can change state local =3D> remote (a.k.a local storage evict) when=
 there
  are no files open on the inode
- inode can change state remote =3D> local if there are no files open in
  cached mode and no mmaps (*)
- specifically, remote files open in direct mode, do not block the transiti=
on
  remote =3D> local, where later opens will be in passthrough mode, but
  the files already open in direct mode will not enjoy the performance boos=
t

* If we relax the last condition we will end up with cache incoherency
   that exists in overlayfs after copy up, when lower file is still mmaped

Thanks,
Amir.

