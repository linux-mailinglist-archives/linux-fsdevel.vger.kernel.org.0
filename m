Return-Path: <linux-fsdevel+bounces-1638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D33617DCCF4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 13:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3CA41C20C35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 12:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F065F1DDD5;
	Tue, 31 Oct 2023 12:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4omrioL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA501DDCD
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 12:31:50 +0000 (UTC)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A9E97
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 05:31:49 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-66cfd874520so32690866d6.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 05:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698755508; x=1699360308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSQkZktU84qtEfxnTBKl2VJ38L8KSRr6ZhztrYySHak=;
        b=i4omrioLsaUgFUQv8PC5xZpPLXMpFzqAspzNU6+BOLkLaTNjRsapq5eLODndy2d3ya
         uxHR/MzdLJHV/e6BGw6Kc1MlHxxnzi/uYAMx+uqZjKqOPRCVujfhh544hqt401sonNPG
         wKV+p6daOc+lILnBIHe5MvIMJw9ln17SPHzc7fBAHRTTqQc0R99kWPbWCrktovNehTz9
         1dzMNz5xI8s6R8FDMLV502YilA6+vpga8M4P+ybAooCccf/YxJ/Tl+6JOgg2WSeXIcJ2
         J6WVq6HqgJtc7ZYGlv0YL48fielKl/szELbc5JhygaKu3V4wYVmqNdiP0pL+nFBBFwJW
         EkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698755508; x=1699360308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSQkZktU84qtEfxnTBKl2VJ38L8KSRr6ZhztrYySHak=;
        b=tTE1gROFfFVUg1RPsbXg2y8B1l/GGfcNON0OdpmPKILeSU8n2BLXlOiFaaQlGzExL7
         clis+tURJQAgFyNOBZNk7EzcXIXdp1CXVr+YeoXpkkUD+rq2UlnTmRzkaXXM1E+IVMd2
         wUBp1ElhrckoI3wsY+1uxo0fQdsDB6Cv1yOmTrwsNRygnw3v+hEG99fYD1sisKqQucct
         vW/SnkG2Z1pdjg+EE080BrJcotwO2xw87UHf+b62pDjJnp3jyJ4rx1hWZS+Uc+wghp7t
         icbZ/k175CfrEWjrdX0hyiOsFNd/C6X7dZvX8GUgjdvxns8p54U7advW2K/0FgdglYZT
         d0DQ==
X-Gm-Message-State: AOJu0Yze9XW7cAjA9nuUKcf9So42rUwTtRSkIPilDu3m1buaVPDsYSzP
	YjlOYNk/u4qxtN7I0Mq15t0o2R82Wp8rQyc1H44=
X-Google-Smtp-Source: AGHT+IEQo/NxPPzBhcgfG6JMAK0YFwl58ubjRn35tqFXSbzXoU9lQlYVs+nq6nKoxTrVnVHHlAiszSqHI3fq0t0cUHM=
X-Received: by 2002:ad4:5961:0:b0:656:51b9:990e with SMTP id
 eq1-20020ad45961000000b0065651b9990emr15348025qvb.57.1698755508435; Tue, 31
 Oct 2023 05:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016160902.2316986-1-amir73il@gmail.com> <CAOQ4uxh=cLySge6htd+DnJrqAKF=C_oJYfVrbpvQGik0wR-+iw@mail.gmail.com>
 <CAJfpegtZGC93-ydnFEt1Gzk+Yy5peJ-osuZD8GRYV4c+WPu0EQ@mail.gmail.com>
 <CAOQ4uxjYLta7_fJc90C4=tPUxTw-WR2v9du8JHTVdsy_iZnFmA@mail.gmail.com> <CAJfpegufvtaBaK8p+Q3v=9Qoeob3WamWBye=1BwGniRsvO5HZg@mail.gmail.com>
In-Reply-To: <CAJfpegufvtaBaK8p+Q3v=9Qoeob3WamWBye=1BwGniRsvO5HZg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 31 Oct 2023 14:31:36 +0200
Message-ID: <CAOQ4uxj+myANTk2C+_tk_YNLe748i2xA0HMZ7FKCuw7W5RUCuA@mail.gmail.com>
Subject: Re: [PATCH v14 00/12] FUSE passthrough for file io
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Daniel Rosenberg <drosen@google.com>, 
	Paul Lawrence <paullawrence@google.com>, Alessio Balsini <balsini@android.com>, 
	Christian Brauner <brauner@kernel.org>, fuse-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 1:17=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Tue, 31 Oct 2023 at 11:28, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > These tests do not do msync.
> >
> > Specifically, test generic/080 encodes an expectation that
> > c/mtime will be changed for mmaped write following mmaped read.
> > Not sure where this expectation is coming from?
>
> Probably because "update on first store" is the de-facto standard on
> linux (filemap_page_mkwrite -> file_update_time).
>
> Thinking about it, the POSIX text is a bit sloppy, I think this is
> what it wanted to say:
>
> "The last data modification and last file status change timestamps of
> a file that is mapped with MAP_SHARED and PROT_WRITE shall be marked
> for update at some point in the interval between the _first_ write refere=
nce to
> the mapped region _since_the_last_msync()_ call and the next call to msyn=
c()
> ..."
>
> Otherwise the linux behavior would be non-conforming.
>
> > I was thinking about a cache coherency model for FUSE passthough:
> > At any given point, if we have access to a backing file, we can compare
> > the backing file's inode timestamps with those of the FUSE inode.
>
> Yes, that makes sense as long as there's a 1:1 mapping between backing
> files and backed files.
>
> It's not the case for e.g. a blockdev backed fs.   But current
> patchset doesn't support that mode yet, so I don't think we need to
> care now.
>
> > If the timestamps differ, we do not copy them over to FUSE inode,
> > as overlayfs does, but we invalidate the FUSE attribute cache.
> > We can perform this checkup on open() release() flush() fsync()
> > and at other points, such as munmap() instead of unconditionally
> > invalidating attribute cache.
>
> This check can be done directly in  fuse_update_get_attr(), no?
>

Current patch set does not implement "backing inode" for FUSE inode,
so this only works for fuse_update_attributes() (with a file).
We do not do cached read/write/readdir in fuse passthrough mode
that leaves only lseek/llseek(), so I assume it's not what you meant.

IOW, we need to conditionally call fuse_invalidate_attr_mask()
at occasions that we have a backing file/inode.

> > I already used tha model for atime update:
> >
> >        /* Mimic atime update policy of backing inode, not the actual va=
lue */
> >        if (!timespec64_equal(&backing_inode->i_atime, &inode->i_atime))
> >                fuse_invalidate_atime(inode);
> >
> > Do you think that can work?
> > Do you think that the server should be able to configure this behavior
> > or we can do it by default?
>
> I think this can be the default, and as we generalize the passthrough
> behavior we'll add the necessary controls.
>

OK, I will try to add this and see if that also solved the 2 failing tests.
It should solve the mmaped write test because the tests do
stat()/open()/mmap()/mem-write/close()/stat()

So it's the close/flush that is going to update mtime, even though that's
not the POSIX semantics, it is a bit like the NFS close-to-open (cto)
semantics regarding data cache coherency.

Thanks,
Amir.

