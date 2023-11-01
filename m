Return-Path: <linux-fsdevel+bounces-1735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1467DE170
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 14:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41EC6281415
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 13:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91CF134AC;
	Wed,  1 Nov 2023 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvKq7waN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E05F12B94
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 13:23:17 +0000 (UTC)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61C1F7
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 06:23:15 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-66d0760cd20so7550036d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Nov 2023 06:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698844995; x=1699449795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4fcy9A6CWiBl7YwYtJtqB8YpJwWi5nJtV4b+JSmgPs=;
        b=LvKq7waNv1AI/cVFlIN4UOEMKpR4iMChpQs4yHBLk3DEbMAPwj1dMZyMen78Z+uRTi
         bZl+mQ5XL3AeeMt5bl8A3MAi+IeATgPzYSO6EUP2Lkg523GfcH/bPg1v5VIGDpaxVgTe
         Gl5qgwg542wG9lzpGe9sAJSZvEfwvOqW/TmHuSa7hFbBx1IAkvaAFjdG+bu25KSUkJ73
         lIX8r16fvBN5mjqBtEYKKCn3PQkfmljdIuxlr88cHsOFSF6Tqvm+vwfHVTmvaARnRLku
         0VMPh98pg1uH1D+1pShDAMsOqgpyQM8So2S2T/3ELGOhHBvHNU943otQ3WEEe2whHHKL
         99Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698844995; x=1699449795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4fcy9A6CWiBl7YwYtJtqB8YpJwWi5nJtV4b+JSmgPs=;
        b=ig/lShxG+g1Iw6YuA6WHC62/klpy6S2ox1e/KzOHTXpx7A4vZPS2sKK/VFQ378RsRo
         RcYjnT7UOnii/5QSsMW+PEFmYjkN8lrrXoJ1RpxrY0J2pDNFmg2yW6/enT+2HSZ/ap47
         w1Q8IsxXtZFYgksMbe89byoYgBp3Hyw/leqPTQ684O5DD+AolBOSYbKagUJ3SP56nANS
         y1JXSOqV5YPX3tCt4OfV9B79VTQtu7jWxS2Fo8iV4eRDUo0CcaEnO0AjQGQDFR1bs20q
         eyeUrN/Zjuc2LAfcI8S2wyg3JKMHYbHs8Ik3z1+wouu47uTZxmnvzz52LQYzhdFeDX5l
         ZrBQ==
X-Gm-Message-State: AOJu0YwKHA92mo0in7aEAox9XytZjyZiwe+p8t7TF9qF41oqCGIT5kiN
	RtC0hBNIsEDHsk1TAzFcybDzm8mjPzZVMWjZlMU=
X-Google-Smtp-Source: AGHT+IEvZT6kbJWo0E2WKeLZlPiKAJpx9WU0CTc6Pqa6cICGlCkg2EZsHnFA0ilEwykbgGVZ51fsvHt2un8GCYg7b7w=
X-Received: by 2002:ad4:5c4f:0:b0:66d:9945:5a93 with SMTP id
 a15-20020ad45c4f000000b0066d99455a93mr8592202qva.9.1698844994670; Wed, 01 Nov
 2023 06:23:14 -0700 (PDT)
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
 <CAOQ4uxiBu8bZ4URhwKuMeHB_Oykz2LHY8mXA1eB3FBoeM_Vs6w@mail.gmail.com> <CAJfpegtr1yOYKOW0GLkow_iALMc_A0+CUaErZasQunAfJ7NFzw@mail.gmail.com>
In-Reply-To: <CAJfpegtr1yOYKOW0GLkow_iALMc_A0+CUaErZasQunAfJ7NFzw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 1 Nov 2023 15:23:02 +0200
Message-ID: <CAOQ4uxjbj4fQr9=wxRR8a5vNp-vo+_JjK6uHizZPyNFiN1jh4w@mail.gmail.com>
Subject: Re: [PATCH v14 00/12] FUSE passthrough for file io
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Daniel Rosenberg <drosen@google.com>, 
	Paul Lawrence <paullawrence@google.com>, Alessio Balsini <balsini@android.com>, 
	Christian Brauner <brauner@kernel.org>, fuse-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 1, 2023 at 1:32=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Tue, 31 Oct 2023 at 18:44, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > In that case, we would be able to "attach" the fuse_backing object
> > to fuse_inode on CREATE response. If we end up with a backing map
> > conflict at this point, we can return -EBUSY error to the user and forg=
et
> > the inode, but the server would have no easy feedback on its mistake.
> > Also, -EBUSY to user would be confusing if user did not request O_EXCL.
>
> I think -EIO is more appropriate.  Server is broken, WARN_ON_ONCE
> could also be used to indicate that.
>

WARN_ON is a kernel assertion - we should not use it for user possible
wrong inputs. we can use pr_warn_ratelimited().

According to your suggestion below that FOPEN_PASSTHROUGH
is an advice flag, we can simply ignore the conflicting passthrough request
and keep passthrough on the existing backing file without any feedback
to the user or server. I can live with that.

> > Do you consider the described "atomic_open conflict" case an API proble=
m?
> >
> > It is true that with v14 patches that do not enforce backing inode conf=
licts,
> > the attribute coherency model that I proposed may result in attribute
> > cache thrashing if the backing inode of a fuse inode is ambiguous.
> >
> > Do you have an idea how to handle this case elegantly?
>
> Let me add some perspective.
>
> Currently we have FOPEN_DIRECT_IO that disables caching.  My feeling
> when dealing with this interface is that it was a mistake to make this
> a property of the open file.  It should insted be a property of the
> inode and all open file instances should respect this property
> equally.  It makes no sense to have one file do cached reads while the
> other is doing direct writes, etc.  Also it should be possible to turn
> this on or off for all open file instances at any time.
>
> Passthrough is similar, I think.  At any point in time all I/O should eit=
her be
>
>  - cached
>  - direct
>  - passthrough to a specific backing file
>
> Allowing these to be mixed leads to confusing semantics, especially
> cached and non-cached
>
> OTOH allowing passthrough to be switched on at any point in time
> presents challenges.   If passthrough is turned on for an inode that
> didn't have it previously means that the backing file needs to be set
> up before the actual I/O.    So it's definitely more complex than just
> setting up the backing at open.  But I feel that longer term we'll end
> up with a better interface.
>
> For the first version we can just bypass this whole mess, and say that
> passthrough can only be turned on for the first open.  I.e. if there
> are already open instances and passthrough has not yet been set up,
> then FOPEN_PASSTHROUGH will be ignored.  Similarly if it has already
> been set up, then the lack of FOPEN_PASSTHROUGH is also ignored.
>
> Hmm?

Sounds like a small change, which will work fine with the example server
as well as with my in-house server requirement for regular files.

However, I can imagine users wanting to do passthrough for read-only
fd without doing passthrough for read-write fd, for example, if data is
never manipulated by the server, but it is inspected on write.
I wonder if this model fits the existing use of Android applications with
the v12 patches.

I have one problem with my in-house server and passthough of readdir.
readdir passthrough cannot do readdirplus to populate inode cache.
For readdir of a large, read-mostly directory, cached readdir is preferred
because of readdirplus.
For a large, write-often directory, when only readdir is needed, readdir
passthough is preferred.
No one size fits all here.

My in-house server chooses whether to do readdir passthrough based
on userspace hint regarding readdir vs. readdirplus.

Since directory has no "write modes" and since FOPEN_CACHE_DIR
is going to stay per-fd, I do not really see a problem with allowing
readdir passthrough and cached/uncached readdir on the same inode.
Do you see a problem with that?

I don't mind dropping the last readdir passthrough patch for the first
version, if you want to take more time to think this over.
I'd just like to know that there is a path forward to make conditional
passthrough per fd possible in future versions.

BTW, the FUSE BPF patches that map a backing inode to
fuse inode allow fallback to server depending on BPF program result.

Thoughts?

Thanks,
Amir.

