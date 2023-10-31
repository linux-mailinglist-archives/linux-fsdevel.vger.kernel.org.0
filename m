Return-Path: <linux-fsdevel+bounces-1625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DD97DCACA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 11:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA9A3B20F5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 10:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E3D199C9;
	Tue, 31 Oct 2023 10:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLJ3APHB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFA0199A0
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 10:28:49 +0000 (UTC)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A215BA2
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 03:28:47 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5afa5dbc378so36955757b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 03:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698748127; x=1699352927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfz1GsV9zfBfe1Ea3lnlRV40Da9oIl9PaWl+Bzs03xA=;
        b=CLJ3APHBRdigpJU/iYvJziyTd/rfryQwid1XUUV7r0Y8Y6+zTgYpzinSej8oqxCZP9
         +RpLmuR8G3v9wTf0KOBs5x8mK3S5hyvvIycNHw+ENalGxG1qrUffOegKD4+//xqmYG2G
         L5nGWTXYQLZHy7L4fMFD22LwGIcNJRUYKa4SA8p/WKYI+WufD8xe1UTq1uU0iBao05My
         SoJEYZkxVotwrYO3FcevAfUvqVwlIrh9lc+adprejOzsDeJUTXWUQhQ9K80ASOgBagi+
         gvmkwL3aemoL3uEMpeNw5TTywgmDlPEzqriaKhwRg/1uA8ZYH0ad0NwbrI5Ic1CB0hm/
         QENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698748127; x=1699352927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfz1GsV9zfBfe1Ea3lnlRV40Da9oIl9PaWl+Bzs03xA=;
        b=xHb5sBmPKY3XzkkqantQncz9NEt47UfLCVWOSXJmC3vxwcmOSzLYQMQMiTMabWKEXX
         5D4/6EyG9syF7Plcr8tsnWMoqQ9bTjS7m/H0HPJOSckaTzbg35NqkN5aAUibqCJD+4GG
         E12wZpoe+NHeG2wpQQB/8KsNzOG/qOZhTEz+1aiYWAvCEw9ehmE14o2KOKIMRNLECWYK
         dpY84MY4qm47EB444pCvYNBqtVeO5HIK7XDgnoOfShA/sYGrNcCVzWssJ4Xpcvq2Gh7M
         AQMqXz/Tx6mdErhwdE/vIuepVpHA1IDlpAFVAOrVSRoJjmgt7yHH7+2SJPIPvM8GvO4v
         7Tbw==
X-Gm-Message-State: AOJu0YwzEGsEZJZPs3k0HcMH8fUOiPX5n5J3r9BToIHHaCTGszfSvqaw
	BZe06lgW9CnOMlolvJxC/xzT2csormnEi8T7Ssg=
X-Google-Smtp-Source: AGHT+IFrBgA4hvfPpYuS4ERL5lrjy6s0mm9YgmfOMJExTKw1VkZoat6yna1wTedxdbcjl8B8S9PoTtR82DlT7ANwC9o=
X-Received: by 2002:a25:410e:0:b0:d9c:a3b8:f39d with SMTP id
 o14-20020a25410e000000b00d9ca3b8f39dmr9182909yba.65.1698748126638; Tue, 31
 Oct 2023 03:28:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016160902.2316986-1-amir73il@gmail.com> <CAOQ4uxh=cLySge6htd+DnJrqAKF=C_oJYfVrbpvQGik0wR-+iw@mail.gmail.com>
 <CAJfpegtZGC93-ydnFEt1Gzk+Yy5peJ-osuZD8GRYV4c+WPu0EQ@mail.gmail.com>
In-Reply-To: <CAJfpegtZGC93-ydnFEt1Gzk+Yy5peJ-osuZD8GRYV4c+WPu0EQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 31 Oct 2023 12:28:35 +0200
Message-ID: <CAOQ4uxjYLta7_fJc90C4=tPUxTw-WR2v9du8JHTVdsy_iZnFmA@mail.gmail.com>
Subject: Re: [PATCH v14 00/12] FUSE passthrough for file io
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Daniel Rosenberg <drosen@google.com>, 
	Paul Lawrence <paullawrence@google.com>, Alessio Balsini <balsini@android.com>, 
	Christian Brauner <brauner@kernel.org>, fuse-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 12:16=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> On Thu, 19 Oct 2023 at 16:33, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > generic/120 tests -o noatime and fails because atime is
> > updated (on the backing file).
> > This is a general FUSE issue and passthrough_hp --nocache fails
> > the same test (i.e. it only passed because of attribute cache).
> >
> > generic/080, generic/215 both test for c/mtime updates after mapped wri=
tes.
> > It is not surprising that backing file passthrough fails these tests -
> > there is no "passthrough getattr" like overlayfs and there is no opport=
unity
> > to invalidate the FUSE inode attribute cache.
>
> This is what POSIX has to say:
>
> "The last data modification and last file status change timestamps of
> a file that is mapped with MAP_SHARED and PROT_WRITE shall be marked
> for update at some point in the interval between a write reference to
> the mapped region and the next call to msync() with MS_ASYNC or
> MS_SYNC for that portion of the file by any process. If there is no
> such call and if the underlying file is modified as a result of a
> write reference, then these timestamps shall be marked for update at
> some time after the write reference."
>
> Not sure if the test is doing msync(), but invalidating cached c/mtime
> on msync() shouldn't be too hard (msync -> fsync).
>

These tests do not do msync.

Specifically, test generic/080 encodes an expectation that
c/mtime will be changed for mmaped write following mmaped read.
Not sure where this expectation is coming from?


Author: Omer Zilberberg <omzg@plexistor.com>
Date:   Wed Apr 1 15:39:36 2015 +1100

    generic: test that mmap-write updates c/mtime

    When using mmap() for file i/o, writing to the file should update
    it's c/mtime. Specifically if we first mmap-read from a page, then
    memap-write to the same page.

    This test was failing for the initial submission of DAX because
    pfn based mapping do not have an page_mkwrite called for them.
    The new Kernel patches that introduce pfn_mkwrite fixes this test.

    Test adapted from a script originally written by Dave Chinner.


> While the standard doesn't seem to require updating c/mtime on
> mumap(2) if there was a modification, that might also make sense in
> practice.

Makes sense.

I was thinking about a cache coherency model for FUSE passthough:
At any given point, if we have access to a backing file, we can compare
the backing file's inode timestamps with those of the FUSE inode.

If the timestamps differ, we do not copy them over to FUSE inode,
as overlayfs does, but we invalidate the FUSE attribute cache.
We can perform this checkup on open() release() flush() fsync()
and at other points, such as munmap() instead of unconditionally
invalidating attribute cache.

I already used tha model for atime update:

       /* Mimic atime update policy of backing inode, not the actual value =
*/
       if (!timespec64_equal(&backing_inode->i_atime, &inode->i_atime))
               fuse_invalidate_atime(inode);

Do you think that can work?
Do you think that the server should be able to configure this behavior
or we can do it by default?

Thanks,
Amir.

