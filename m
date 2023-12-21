Return-Path: <linux-fsdevel+bounces-6653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEB281B23E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 10:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F04F8B269F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 09:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E295027A;
	Thu, 21 Dec 2023 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqYOjXTg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CC650253
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 09:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-67f0cfd3650so3132856d6.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 01:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703150293; x=1703755093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0kjxIw5WiFrb7M5F2ByGP1whlxDid5gx3aic6Bt/I4=;
        b=QqYOjXTgt4+VA398M3uh2+Zx61CJdmN1giEJXBb2aNN4jK17xeTOdAkHI3nOURwsq0
         jNdBS5ZQyUzqP9oEVLThOrnDqKKJf/HrgXqRVXnbL3vfZBLHuR3MtJ1x+cBkSOtDexu0
         fe36NM9uN8zG6lo8VKyKrnaWMV19M6QldiR72tiw4el3e+QgjOw8JH9WTH5cPj5I32ev
         LejwSqRUofWtelJVf/bC2EqzgE0q+BKphmgJZCZuVYibHa12xAyyvKvUzwKjveaZniCw
         wuASlJZdtFr9/yEp7p9siFBykbLGzZMvRoN/XzE091Pm5TqGkTgmwLzgFSpGbhWRSMiB
         tBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703150293; x=1703755093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0kjxIw5WiFrb7M5F2ByGP1whlxDid5gx3aic6Bt/I4=;
        b=SjZswy/RBPlvlgbgWF7G7W+kkI5yp+ya89QljyUIimdNWgpCTn2moN7ArcsBkuAxnr
         9oU4FL1qe7gp5HepPzQUq67aLmBhLGt7I10XbM4psqVcFqg3cZ1VPHdyqR67RWCYyB2P
         wk7bzSaOuuHU9SqvdIKYgM/GYG+/SmsYBU0sAh1ahjrotemIws787bAZI9ibWRHQVwHQ
         f9ATbkf7mybjfgnoxn7ASxlA/taxMH3hqqXtVZ+sBE4ZYIRoUfEWlZm0QBiIiDhsdg90
         HVG+VO6NC/yetvxDkq5QfMVxTK1ArS0zqj1S8pAcAbZqIxcjSuBCDpDLKNYnt7m0i8p3
         xyVw==
X-Gm-Message-State: AOJu0YyXiYxNjSFPGtkRdfuyAukHsEutd2cV014KXpruglgqkPsYI5Lx
	YV3pD9GPfynNpPmrNFMW4hRZWlynvgHTiq8RCzY=
X-Google-Smtp-Source: AGHT+IFhQefP1ElvsFvVMitRpudBRYzthFA/Kd7LpO1RhGO1sWzu2pl+FX+yAnJfzp3K+pWCTUvuZGieCk0yDvknw0A=
X-Received: by 2002:ad4:4708:0:b0:67a:ba4c:6f69 with SMTP id
 qb8-20020ad44708000000b0067aba4c6f69mr22451929qvb.22.1703150293437; Thu, 21
 Dec 2023 01:18:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920024001.493477-1-tfanelli@redhat.com> <CAOQ4uxhqkJsK-0VRC9iVF5jHuEQaVJK+XXYE0kL81WmVdTUDZg@mail.gmail.com>
 <0008194c-8446-491a-8e4c-1a9a087378e1@fastmail.fm> <CAOQ4uxhucqtjycyTd=oJF7VM2VQoe6a-vJWtWHRD5ewA+kRytw@mail.gmail.com>
 <8e76fa9c-59d0-4238-82cf-bfdf73b5c442@fastmail.fm> <CAOQ4uxjKbQkqTHb9_3kqRW7BPPzwNj--4=kqsyq=7+ztLrwXfw@mail.gmail.com>
 <6e9e8ff6-1314-4c60-bf69-6d147958cf95@fastmail.fm> <CAOQ4uxiJfcZLvkKZxp11aAT8xa7Nxf_kG4CG1Ft2iKcippOQXg@mail.gmail.com>
 <06eedc60-e66b-45d1-a936-2a0bb0ac91c7@fastmail.fm> <CAOQ4uxhRbKz7WvYKbjGNo7P7m+00KLW25eBpqVTyUq2sSY6Vmw@mail.gmail.com>
 <7c588ab3-246f-4d9d-9b84-225dedab690a@fastmail.fm> <CAOQ4uxgb2J8zppKg63UV88+SNbZ+2=XegVBSXOFf=3xAVc1U3Q@mail.gmail.com>
 <9d3c1c2b-53c0-4f1d-b4c0-567b23d19719@fastmail.fm> <CAOQ4uxhd9GsWgpw4F56ACRmHhxd6_HVB368wAGCsw167+NHpvw@mail.gmail.com>
 <2d58c415-4162-441e-8887-de6678b2be28@fastmail.fm> <98795992-589d-44cb-a6d0-ccf8575a4cc4@fastmail.fm>
 <c4c87b07-bcae-4c6e-aaec-86168db7804a@fastmail.fm>
In-Reply-To: <c4c87b07-bcae-4c6e-aaec-86168db7804a@fastmail.fm>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 21 Dec 2023 11:18:01 +0200
Message-ID: <CAOQ4uxgy5mV4aP4YHJtoYeeLMzNfj0qYh7zTL32gO1TfJDvYYg@mail.gmail.com>
Subject: Re: [PATCH 0/2] fuse: Rename DIRECT_IO_{RELAX -> ALLOW_MMAP}
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Tyler Fanelli <tfanelli@redhat.com>, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, gmaglione@redhat.com, 
	hreitz@redhat.com, Hao Xu <howeyxu@tencent.com>, Dharmendra Singh <dsingh@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 12:13=E2=80=AFAM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
>
> [...]
>
> >>>>> I think that we are going to need to use some inode state flag
> >>>>> (e.g. FUSE_I_DIO_WR_EXCL) to protect against this starvation,
> >>>>> unless we do not care about this possibility?
> >>>>> We'd only need to set this in fuse_file_io_mmap() until we get
> >>>>> the iocachectr refcount.
>
>
> I added back FUSE_I_CACHE_IO_MODE I had used previously.
>

ACK.
Name is a bit confusing for the "want io mode" case, but IMO
a comment would be enough to make it clear.
Push a version with a comment to my branch.


>
> >>>>>
> >>>>> I *think* that fuse_inode_deny_io_cache() should be called with
> >>>>> shared inode lock held, because of the existing lock chain
> >>>>> i_rwsem -> page lock -> mmap_lock for page faults, but I am
> >>>>> not sure. My brain is too cooked now to figure this out.
> >>>>> OTOH, I don't see any problem with calling
> >>>>> fuse_inode_deny_io_cache() with shared lock held?
> >>>>>
> >>>>> I pushed this version to my fuse_io_mode branch [1].
> >>>>> Only tested generic/095 with FOPEN_DIRECT_IO and
> >>>>> DIRECT_IO_ALLOW_MMAP.
> >>>>>
> >>>>> Thanks,
> >>>>> Amir.
> >>>>>
> >>>>> [1] https://github.com/amir73il/linux/commits/fuse_io_mode
> >>>>
> >>>> Thanks, will look into your changes next. I was looking into the
> >>>> initial
> >>>> issue with generic/095 with my branch. Fixed by the attached patch. =
I
> >>>> think it is generic and also applies to FOPEN_DIRECT_IO + mmap.
> >>>> Interesting is that filemap_range_has_writeback() is exported, but
> >>>> there
> >>>> was no user. Hopefully nobody submits an unexport patch in the mean
> >>>> time.
> >>>>
> >>>
> >>> Ok. Now I am pretty sure that filemap_range_has_writeback() should be
> >>> check after taking the shared lock in fuse_dio_lock() as in my branch
> >>> and
> >>> not in fuse_dio_wr_exclusive_lock() outside the lock.
> >>
> >>
> >>
> >>>
> >>> But at the same time, it is a little concerning that you are able to
> >>> observe
> >>> dirty pages on a fuse inode after success of fuse_inode_deny_io_cache=
().
> >>> The whole point of fuse_inode_deny_io_cache() is that it should be
> >>> granted after all users of the inode page cache are gone.
> >>>
> >>> Is it expected that fuse inode pages remain dirty after no more open
> >>> files
> >>> and no more mmaps?
> >>
> >>
> >> I'm actually not sure anymore if filemap_range_has_writeback() is
> >> actually needed. In fuse_flush() it calls write_inode_now(inode, 1),
> >> but I don't think that will flush queued fi->writectr
> >> (fi->writepages). Will report back in the afternoon.
> >
> > Sorry, my fault, please ignore the previous patch. Actually no dirty
> > pages to be expected, I had missed the that fuse_flush calls
> > fuse_sync_writes(). The main bug in my branch was due to the different
> > handling of FOPEN_DIRECT_IO and O_DIRECT - for O_DIRECT I hadn't called
> > fuse_file_io_mmap().

But why would you need to call fuse_file_io_mmap() for O_DIRECT?
If a file was opened without FOPEN_DIRECT_IO, we already set inode to
caching mode on open.
Does your O_DIRECT patch to mmap solve an actual reproducible bug?

>
>
> I pushed a few fixes/updates into my fuse-dio-v5 branch and also to
> simplify it for you to my fuse_io_mode branch. Changes are onto of the
> previous patches io-mode patch to simplify it for you to see the changes
> and to possibly squash it into the main io patch.
>
> https://github.com/bsbernd/linux/commits/fuse_io_mode/
>

Cool. I squashed all your fixes to my branch, with minor comments
that I also left on github, except for the O_DIRECT patch, because
I do not understand why it is needed.

The 6.8 merge window is very close and the holidays are upon us,
so not sure if you and Miklos could be bothered, but do you think there
is  a chance that we can get fuse_io_mode patches ready for queuing
in time for the 6.8 merge window?

They do have merit on their own for re-allowing parallel dio along with
FOPEN_PARALLEL_DIRECT_WRITES, but also, it would make it easier
for the both of us to develop fuse-dio and fuse-passthrough based on
the io cache mode during the 6.9 dev cycle.

>
> PS: I start to feel a bit guilty about this long thread on
> linux-fsdevel. Would be better to have that on fuse-devel, just the
> sourceforge list is badly spammed.
>

According to MAINTAINERS, linux-fsdevel is the list for linux FUSE
kernel development. The sourceforge fuse-devel is for libfuse.

We could open a linux-fuse list, but it has been this way forever
and I do not know of any complaints from fsdevel members.
the downside of not having linux-fuse list IMO is that we do not
have a "fuse only" searchable archive, but we won't have it for all the
historic messages on fsdevel anyway.

Thanks,
Amir.

