Return-Path: <linux-fsdevel+bounces-4954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEA88069BE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 09:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626F8281B7F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 08:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197201A706
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 08:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMdlGLhH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B633DD3
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 00:25:40 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-677fba00a49so5002046d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Dec 2023 00:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701851140; x=1702455940; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C/RlJ/0i6dTY1VdrdJ+k1E6ZEiT0QfFVf8Ud6BEXjmk=;
        b=nMdlGLhHdIqsZ4ZqGgA/B8VmvSSk3FFqjf4luxDxV/7Z1BWW1xEBRzEl9ueDy4iHNb
         5Ltx9VbcfMG3GLvaypmnwDifOEqlyYDT24oBUPYhN0PwK+Nlw1ba1HJstdtdN0S68J2F
         6kkcTBh19Cv8HlhmCK3tXHFVkcWBhBbxMonDEj2K31xHz4sV2NtEAvwC9sdW94LfRD1v
         9W3TRdZ8Lvb2+rD7Cr3/hPwLWRO/hFzcx58VVdw7kvEPJUtURnH2RRPUGQNrM609WrKD
         sDOp27tBTB/DLvCGAgEoRyfywdzhW4hx9vB34nGyhO3wm1xK92Enq4XBLZesY56lz85W
         qW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701851140; x=1702455940;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C/RlJ/0i6dTY1VdrdJ+k1E6ZEiT0QfFVf8Ud6BEXjmk=;
        b=Og5RTPwx2nHfr1et1XssvwYgXzV1r/shOoQlzwREaw2qiQhcSKNLcXtpWgU9tA2Urs
         B7mdQMoHjK5mt8Tqm29cVoDI/PZ6JuXvxM6ORXtJ6D3bmdHoOS4bm2vRPLkE8VzCe6nf
         ovuu8byUc8mxlNuoYpDYvUpTo7TCZjIpI/9YYvY8Y+28tKtPd1eI2M+Zbpi579/M8+d3
         ekCXn8Sgdyyx15otgp15cWNxXJrGCa41YnppasZXZnksJwinQLR2eeRDUBv21Mh7xX1v
         0EM/WWbH7vP3Y9kMVHGa0L8Xsf+f7RIY3iTFrD/ebXor4Qv0LhWoeFF1d61Ku1rejJua
         mLYg==
X-Gm-Message-State: AOJu0YxnFJsdmC/1mf462a56aM0hRJIFj7Jpvy+Cex0pc2rfEbYTBpLT
	UZWXFs28A/743ieUJzanAkmvwSr5X13CiRfRuKA=
X-Google-Smtp-Source: AGHT+IHtu5OvMYPi0Orx2ECXcXiRj2nJXY0q+bVMjemAm0BIklzZK2AzBzbm8cPsZmZ3OHH03T16DPsWYnF6SVGMgUs=
X-Received: by 2002:a05:6214:27c7:b0:67a:e56:221d with SMTP id
 ge7-20020a05621427c700b0067a0e56221dmr3477933qvb.29.1701851139744; Wed, 06
 Dec 2023 00:25:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920024001.493477-1-tfanelli@redhat.com> <CAJfpegtVbmFnjN_eg9U=C1GBB0U5TAAqag3wY_mi7v8rDSGzgg@mail.gmail.com>
 <32469b14-8c7a-4763-95d6-85fd93d0e1b5@fastmail.fm> <CAOQ4uxgW58Umf_ENqpsGrndUB=+8tuUsjT+uCUp16YRSuvG2wQ@mail.gmail.com>
 <CAOQ4uxh6RpoyZ051fQLKNHnXfypoGsPO9szU0cR6Va+NR_JELw@mail.gmail.com>
 <49fdbcd1-5442-4cd4-8a85-1ddb40291b7d@fastmail.fm> <CAOQ4uxjfU0X9Q4bUoQd_U56y4yUUKGaqyFS1EJ3FGAPrmBMSkg@mail.gmail.com>
 <CAJfpeguuB21HNeiK-2o_5cbGUWBh4uu0AmexREuhEH8JgqDAaQ@mail.gmail.com>
 <abbdf30f-c459-4eab-9254-7b24afc5771b@fastmail.fm> <40470070-ef6f-4440-a79e-ff9f3bbae515@fastmail.fm>
 <CAOQ4uxiHkNeV3FUh6qEbqu3U6Ns5v3zD+98x26K9AbXf5m8NGw@mail.gmail.com>
 <e151ff27-bc6e-4b74-a653-c82511b20cee@fastmail.fm> <47310f64-5868-4990-af74-1ce0ee01e7e9@fastmail.fm>
In-Reply-To: <47310f64-5868-4990-af74-1ce0ee01e7e9@fastmail.fm>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 6 Dec 2023 10:25:28 +0200
Message-ID: <CAOQ4uxhqkJsK-0VRC9iVF5jHuEQaVJK+XXYE0kL81WmVdTUDZg@mail.gmail.com>
Subject: Re: [PATCH 0/2] fuse: Rename DIRECT_IO_{RELAX -> ALLOW_MMAP}
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Tyler Fanelli <tfanelli@redhat.com>, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, gmaglione@redhat.com, 
	hreitz@redhat.com, Hao Xu <howeyxu@tencent.com>, Dharmendra Singh <dsingh@ddn.com>
Content-Type: text/plain; charset="UTF-8"

> >> Is it actually important for FUSE_DIRECT_IO_ALLOW_MMAP fs
> >> (e.g. virtiofsd) to support FOPEN_PARALLEL_DIRECT_WRITES?
> >> I guess not otherwise, the combination would have been tested.
> >
> > I'm not sure how many people are aware of these different flags/features.
> > I had just finalized the backport of the related patches to RHEL8 on
> > Friday, as we (or our customers) need both for different jobs.
> >
> >>
> >> FOPEN_PARALLEL_DIRECT_WRITES is typically important for
> >> network fs and FUSE_DIRECT_IO_ALLOW_MMAP is typically not
> >> for network fs. Right?
> >
> > We kind of have these use cases for our network file systems
> >
> > FOPEN_PARALLEL_DIRECT_WRITES:
> >     - Traditional HPC, large files, parallel IO
> >     - Large file used on local node as container for many small files
> >
> > FUSE_DIRECT_IO_ALLOW_MMAP:
> >     - compilation through gcc (not so important, just not nice when it
> > does not work)
> >     - rather recent: python libraries using mmap _reads_. As it is read
> > only no issue of consistency.
> >
> >
> > These jobs do not intermix - no issue as in generic/095. If such
> > applications really exist, I have no issue with a serialization penalty.
> > Just disabling FOPEN_PARALLEL_DIRECT_WRITES because other
> > nodes/applications need FUSE_DIRECT_IO_ALLOW_MMAP is not so nice.
> >
> > Final goal is also to have FOPEN_PARALLEL_DIRECT_WRITES to work on plain
> > O_DIRECT and not only for FUSE_DIRECT_IO - I need to update this branch
> > and post the next version
> > https://github.com/bsbernd/linux/commits/fuse-dio-v4
> >
> >
> > In the mean time I have another idea how to solve
> > FOPEN_PARALLEL_DIRECT_WRITES + FUSE_DIRECT_IO_ALLOW_MMAP
>
> Please find attached what I had in my mind. With that generic/095 is not
> crashing for me anymore. I just finished the initial coding - it still
> needs a bit cleanup and maybe a few comments.
>

Nice. I like the FUSE_I_CACHE_WRITES state.
For FUSE_PASSTHROUGH I will need to track if inode is open/mapped
in caching mode, so FUSE_I_CACHE_WRITES can be cleared on release
of the last open file of the inode.

I did not understand some of the complexity here:

>        /* The inode ever got page writes and we do not know for sure
>         * in the DIO path if these are pending - shared lock not possible */
>        spin_lock(&fi->lock);
>        if (!test_bit(FUSE_I_CACHE_WRITES, &fi->state)) {
>                if (!(*cnt_increased)) {

How can *cnt_increased be true here?

>                        fi->shared_lock_direct_io_ctr++;
>                        *cnt_increased = true;
>                }
>                excl_lock = false;

Seems like in every outcome of this function
*cnt_increased = !excl_lock
so there is not need for out arg cnt_increased

>        }
>        spin_unlock(&fi->lock);
>
>out:
>        if (excl_lock && *cnt_increased) {
>                bool wake = false;
>                spin_lock(&fi->lock);
>                if (--fi->shared_lock_direct_io_ctr == 0)
>                        wake = true;
>                spin_unlock(&fi->lock);
>                if (wake)
>                        wake_up(&fi->direct_io_waitq);
>        }

I don't see how this wake_up code is reachable.

TBH, I don't fully understand the expected result.
Surely, the behavior of dio mixed with mmap is undefined. Right?
IIUC, your patch does not prevent dirtying page cache while dio is in
flight. It only prevents writeback while dio is in flight, which is the same
behavior as with exclusive inode lock. Right?

Maybe this interaction is spelled out somewhere else, but if not
better spell it out for people like me that are new to this code.

Thanks,
Amir.

