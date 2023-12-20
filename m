Return-Path: <linux-fsdevel+bounces-6546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B95081979C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 05:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93F91C250C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 04:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDD01D6AE;
	Wed, 20 Dec 2023 04:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLWtRZlh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8404B1D696
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 04:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-67f70727643so1062016d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Dec 2023 20:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703045892; x=1703650692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1QCS1DwsZqzlMMUM8cL8P+j8zk9aG8f+tAGsi1adME=;
        b=dLWtRZlhQyEk7VRggRDy/N2zsd3Bm6vTINAuepPtSrw6SyzStz9XY+eIP9s/s0Okpg
         c81eREzQ+D44hPbzKR99TvWjg+OLu1mp8q0U/4fUPCYnlULgT+vD/ob3JIzUom6A85V+
         j1pz25NX64KTo79nrpTKSUhB1Btxhm0VNAFx7bJCZnh0f/v6FLK6bynQmqFJJbYH+77L
         WXtt9XMfq7EcK8376114nCKgVdyX0kgEtTC6UjZNlWuIVmFOPI/YyxMlbtbZ/I8ldEx6
         gLvnUItk67UnPkmNTtcW2sUIRZwfGNSTkdcd9aZgoO/3gU8+yKlv6Egnc2KOab/G3UiW
         aH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703045892; x=1703650692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1QCS1DwsZqzlMMUM8cL8P+j8zk9aG8f+tAGsi1adME=;
        b=ZJLXl+1lPSoBQQDXbdPhTrVdcq3ZD9nS1k2CtjBQSU0NDkDQiCGhoG5DyArKfZdVRK
         BGicoVFAsULFoDeDkiUG4l7kabWHz75MA5ET4kD8uxo4PcUdbb8nXpr5FHV0ot9F/PYQ
         iWb7Lq8dLSGwKp9kXWlkbbYQdmW+Dv6pMszqK+xALvyvOmUwLlVSLuF+AJOqZbGLg0UJ
         U8JQVlSho46cAoJdpEgTWMhdcMW3HEZ1NyZErD+D18qOVOhDCSxZwSJ5gzEFG4HUjCnS
         ubg689sEhMfU4DZ5wzzRTNzeVTiwQ/5nI/IaPY95wzw41n9pb0QD+Ljcf4TvGSmX5KIL
         sn2A==
X-Gm-Message-State: AOJu0YzavZg7D+dldIzgjqXi1caEogSrCA/d4qdwWAJBIFM2zofpzBTr
	XQZAy7zuj1YFCZtTZ6lsyMJubTz1CMOe8Pt0cz/1Ak9inE0=
X-Google-Smtp-Source: AGHT+IH4D269/Ve8AOLQpjHn4IpN22pj0hbMS09ksbQNapunGS7IuCMlYYsYh7kw9/QYjf6dptB2tVqHdHCxBbAO2Ss=
X-Received: by 2002:a05:6214:1bc8:b0:67f:4305:d826 with SMTP id
 m8-20020a0562141bc800b0067f4305d826mr3230366qvc.33.1703045892279; Tue, 19 Dec
 2023 20:18:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920024001.493477-1-tfanelli@redhat.com> <40470070-ef6f-4440-a79e-ff9f3bbae515@fastmail.fm>
 <CAOQ4uxiHkNeV3FUh6qEbqu3U6Ns5v3zD+98x26K9AbXf5m8NGw@mail.gmail.com>
 <e151ff27-bc6e-4b74-a653-c82511b20cee@fastmail.fm> <47310f64-5868-4990-af74-1ce0ee01e7e9@fastmail.fm>
 <CAOQ4uxhqkJsK-0VRC9iVF5jHuEQaVJK+XXYE0kL81WmVdTUDZg@mail.gmail.com>
 <0008194c-8446-491a-8e4c-1a9a087378e1@fastmail.fm> <CAOQ4uxhucqtjycyTd=oJF7VM2VQoe6a-vJWtWHRD5ewA+kRytw@mail.gmail.com>
 <8e76fa9c-59d0-4238-82cf-bfdf73b5c442@fastmail.fm> <CAOQ4uxjKbQkqTHb9_3kqRW7BPPzwNj--4=kqsyq=7+ztLrwXfw@mail.gmail.com>
 <6e9e8ff6-1314-4c60-bf69-6d147958cf95@fastmail.fm> <CAOQ4uxiJfcZLvkKZxp11aAT8xa7Nxf_kG4CG1Ft2iKcippOQXg@mail.gmail.com>
 <06eedc60-e66b-45d1-a936-2a0bb0ac91c7@fastmail.fm> <CAOQ4uxhRbKz7WvYKbjGNo7P7m+00KLW25eBpqVTyUq2sSY6Vmw@mail.gmail.com>
 <7c588ab3-246f-4d9d-9b84-225dedab690a@fastmail.fm> <CAOQ4uxgb2J8zppKg63UV88+SNbZ+2=XegVBSXOFf=3xAVc1U3Q@mail.gmail.com>
 <9d3c1c2b-53c0-4f1d-b4c0-567b23d19719@fastmail.fm>
In-Reply-To: <9d3c1c2b-53c0-4f1d-b4c0-567b23d19719@fastmail.fm>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 20 Dec 2023 06:18:00 +0200
Message-ID: <CAOQ4uxhd9GsWgpw4F56ACRmHhxd6_HVB368wAGCsw167+NHpvw@mail.gmail.com>
Subject: Re: [PATCH 0/2] fuse: Rename DIRECT_IO_{RELAX -> ALLOW_MMAP}
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Tyler Fanelli <tfanelli@redhat.com>, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, gmaglione@redhat.com, 
	hreitz@redhat.com, Hao Xu <howeyxu@tencent.com>, Dharmendra Singh <dsingh@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 10:47=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 12/19/23 14:01, Amir Goldstein wrote:
> >>> Here is what I was thinking about:
> >>>
> >>> https://github.com/amir73il/linux/commits/fuse_io_mode
> >>>
> >>> The concept that I wanted to introduce was the
> >>> fuse_inode_deny_io_cache()/fuse_inode_allow_io_cache()
> >>> helpers (akin to deny_write_access()/allow_write_access()).
> >>>
> >>> In this patch, parallel dio in progress deny open in caching mode
> >>> and mmap, and I don't know if that is acceptable.
> >>> Technically, instead of deny open/mmap you can use additional
> >>> techniques to wait for in progress dio and allow caching open/mmap.
> >>>
> >>> Anyway, I plan to use the iocachectr and fuse_inode_deny_io_cache()
> >>> pattern when file is open in FOPEN_PASSTHROUGH mode, but
> >>> in this case, as agreed with Miklos, a server trying to mix open
> >>> in caching mode on the same inode is going to fail the open.
> >>>
> >>> mmap is less of a problem for inode in passthrough mode, because
> >>> mmap in of direct_io file and inode in passthrough mode is passthroug=
h
> >>> mmap to backing file.
> >>>
> >>> Anyway, if you can use this patch or parts of it, be my guest and if =
you
> >>> want to use a different approach that is fine by me as well - in that=
 case
> >>> I will just remove the fuse_file_shared_dio_{start,end}() part from m=
y patch.
> >>
> >> Hi Amir,
> >>
> >> here is my fuse-dio-v5 branch:
> >> https://github.com/bsbernd/linux/commits/fuse-dio-v5/
> >>
> >> (v5 is just compilation tested, tests are running now over night)
> >
> > This looks very nice!
> > I left comments about some minor nits on github.
> >
> >>
> >> This branch is basically about consolidating fuse write direct IO code
> >> paths and to allow a shared lock for O_DIRECT. I actually could have
> >> noticed the page cache issue with shared locks before with previous
> >> versions of these patches, just my VM kernel is optimized for
> >> compilation time and some SHM options had been missing - with that fio
> >> refused to run.
> >>
> >> The branch includes a modified version of your patch:
> >> https://github.com/bsbernd/linux/commit/6b05e52f7e253d9347d97de675b21b=
1707d6456e
> >>
> >> Main changes are
> >> - fuse_file_io_open() does not set the FOPEN_CACHE_IO flag for
> >> file->f_flags & O_DIRECT
> >> - fuse_file_io_mmap() waits on a dio waitq
> >> - fuse_file_shared_dio_start / fuse_file_shared_dio_end are moved up i=
n
> >> the file, as I would like to entirely remove the fuse_direct_write ite=
r
> >> function (all goes through cache_write_iter)
> >>
> >
> > Looks mostly good, but I think that fuse_file_shared_dio_start() =3D>
> > fuse_inode_deny_io_cache() should actually be done after taking
> > the inode lock (shared or exclusive) and not like in my patch.
> >
> > First of all, this comment in fuse_dio_wr_exclusive_lock():
> >
> >          /*
> >           * fuse_file_shared_dio_start() must not be called on retest,
> >           * as it decreases a counter value - must not be done twice
> >           */
> >          if (!fuse_file_shared_dio_start(inode))
> >                  return true;
> >
> > ...is suggesting that semantics are not clean and this check
> > must remain last, because if fuse_dio_wr_exclusive_lock()
> > returns false, iocachectr must not be elevated.
> > This is easy to get wrong in the future with current semantics.
> >
> > The more important thing is that while fuse_file_io_mmap()
> > is waiting for iocachectr to drop to zero, new parallel dio can
> > come in and starve the mmap() caller forever.
> >
> > I think that we are going to need to use some inode state flag
> > (e.g. FUSE_I_DIO_WR_EXCL) to protect against this starvation,
> > unless we do not care about this possibility?
> > We'd only need to set this in fuse_file_io_mmap() until we get
> > the iocachectr refcount.
> >
> > I *think* that fuse_inode_deny_io_cache() should be called with
> > shared inode lock held, because of the existing lock chain
> > i_rwsem -> page lock -> mmap_lock for page faults, but I am
> > not sure. My brain is too cooked now to figure this out.
> > OTOH, I don't see any problem with calling
> > fuse_inode_deny_io_cache() with shared lock held?
> >
> > I pushed this version to my fuse_io_mode branch [1].
> > Only tested generic/095 with FOPEN_DIRECT_IO and
> > DIRECT_IO_ALLOW_MMAP.
> >
> > Thanks,
> > Amir.
> >
> > [1] https://github.com/amir73il/linux/commits/fuse_io_mode
>
> Thanks, will look into your changes next. I was looking into the initial
> issue with generic/095 with my branch. Fixed by the attached patch. I
> think it is generic and also applies to FOPEN_DIRECT_IO + mmap.
> Interesting is that filemap_range_has_writeback() is exported, but there
> was no user. Hopefully nobody submits an unexport patch in the mean time.
>

Ok. Now I am pretty sure that filemap_range_has_writeback() should be
check after taking the shared lock in fuse_dio_lock() as in my branch and
not in fuse_dio_wr_exclusive_lock() outside the lock.

But at the same time, it is a little concerning that you are able to observ=
e
dirty pages on a fuse inode after success of fuse_inode_deny_io_cache().
The whole point of fuse_inode_deny_io_cache() is that it should be
granted after all users of the inode page cache are gone.

Is it expected that fuse inode pages remain dirty after no more open files
and no more mmaps?

Did we miss some case of access to page cache? unaligned dio perhaps?

Thanks,
Amir.

