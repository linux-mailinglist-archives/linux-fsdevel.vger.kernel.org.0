Return-Path: <linux-fsdevel+bounces-1763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A047DE605
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 19:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26CED2819A1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 18:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3771944E;
	Wed,  1 Nov 2023 18:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dq1oKaZf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BD918E2A
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 18:32:44 +0000 (UTC)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC5C102
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 11:32:42 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-777745f1541so3623185a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Nov 2023 11:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698863562; x=1699468362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIXjSh5F5nckWkBZlQ7O1zvbkAPZk6rRrNcQXeC9Kt0=;
        b=dq1oKaZfVCbNc1avquXoRp7P8+9UC/mIQkhbzDMEvlXqISrykTfCn+lW1Jo39rvHxz
         b31vTbi9b4pS6DeoWw8fzL+nP/WLC8wmCo1ztXJ3Zx8otQ3D8mVRXaYi1p2x3NTMJ2Y3
         vM+f+zhbp9vJhMh25Zim/3qnEHEk9BPERE8WoS6YiGsbjztp3TRojKzK3Pp5rnDvFvqY
         6eOh64oBGklgXuiPu2/xEE98xHxkcaU1zLqQL0MTTvHIxSTcX9d5e3xPXqzo09p5CzrM
         8Qbngu7qLrTqjanHZ2Ubq8T02PEhSqYKHpwSXHEUkf0ZHh9tNWBGUfjA58CljWJTFlCY
         /0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698863562; x=1699468362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIXjSh5F5nckWkBZlQ7O1zvbkAPZk6rRrNcQXeC9Kt0=;
        b=I22ioYrWUVgrbzY4F7xkKE1H6s+uxIqRnrnHqu8WQkD4oJ49a2UVtyyN/G5V6OSvSm
         0CrdRJUfyARuM6JvrukZBz4Uje9z1Se4m8ARaivbenPPhK4CbkWoBqjkLojHsVZl6IqQ
         tQwfJORLiI/Rdd/eKpv56O2bCEU8IXiWksr+17YcQi70olRrFkczmFyZ5/PMJgt3EkcY
         vF78ulZDytc0wVHz+jwQpD5rHiHBBwMktmrw17F+aoadctI73e2VbsNZK8qKO+T7elQp
         J3UcRuN/KB6vlLn0U1N99BCH581r24HAdpW9OtBdFbPJQeLAwb4UrtBUIqA02VfOD236
         qCww==
X-Gm-Message-State: AOJu0YynKfop3Y5dF3tp13O0gvWdkZGRea/La8TFVV6p2L8w3KVRAr2z
	Yw+5gdStSLwvMvUFjpfx75Sx1ng2eLP2i8zPoX4=
X-Google-Smtp-Source: AGHT+IFxGu82Ca+PSTpxl/4n/2Ok45R3nMHjtTX1qqd/WhRErePPXt87ksLkXdsik7YLKczZH0oYxlqq2PUx6Nbcqbo=
X-Received: by 2002:a05:6214:b6f:b0:671:3f49:c8b4 with SMTP id
 ey15-20020a0562140b6f00b006713f49c8b4mr16635251qvb.3.1698863561872; Wed, 01
 Nov 2023 11:32:41 -0700 (PDT)
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
 <CAOQ4uxja2G2M22bWSi_kDE2vdxs+sJ0ua9JgD-e7LEGsTcNGXw@mail.gmail.com> <CAJfpegt3mEii075roOTk6RKeNKGc89pGMkWrvVM0uLyrpg7Ebg@mail.gmail.com>
In-Reply-To: <CAJfpegt3mEii075roOTk6RKeNKGc89pGMkWrvVM0uLyrpg7Ebg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 1 Nov 2023 20:32:29 +0200
Message-ID: <CAOQ4uxipyZOSMcko+V+ZxGZwAgKVwWTUeoH79zqtMqbcKSnOoA@mail.gmail.com>
Subject: Re: [PATCH v14 00/12] FUSE passthrough for file io
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Daniel Rosenberg <drosen@google.com>, 
	Paul Lawrence <paullawrence@google.com>, Alessio Balsini <balsini@android.com>, 
	Christian Brauner <brauner@kernel.org>, fuse-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 1, 2023 at 5:25=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Wed, 1 Nov 2023 at 16:06, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > That would make sense if readdirplus request is sent to server
> > in parallel to executing readdir passthrough and readdirplus
> > response does the prepopulation asynchronously.
>
> Yes, that's fine, and it might even make sense to do that regardless
> of passthrough.  Readdirplus is similar to read-ahead in this regard.
>
> > Are you also referring to mixing cached and uncached readdir?
> > because that seems fine to me.
>
> But is it really fine?  The server must be very careful to prevent
> inconsistency between the cached and the uncached readdir, which could
> lead to really surprising results.  I just see no point in caching if
> the same result is available from a backing directory.
>

I see. so if dir has backing inode, we can always
disable FOPEN_CACHE_DIR (as my patch already does)
but instead of alway doing passthrough readdir, we employ the
heuristic whether or not to do readdirplus.
If not doing readdirplus, we can do fuse_passthrough_readdir().
In the future, we could do async readdirplus and always call
fuse_passthrough_readdir() if we have backing inode.

For now, I will just remove the readdir passthough patch.

> > I will try to add these rules to FOPEN_PASSTHROUGH:
> > - ignore request on backing inode conflict
> > - ignore request if inode is already open in caching mode
> > - make FOPEN_PASSTHROUGH implicit if inode is already open
> >   in passthrough *unless* file is open with FOPEN_DIRECT_IO
>
> Sounds good.
>
> There's still this case:
>
>  - file is opened in non-passthrough caching mode, and is being read/writ=
ten
>  - at the same time the file is opened in passthrough mode
>
> The proper thing would be to switch the first file to passthrough mode
> while it's open.  It adds some complexity but I think it's worth it.

Remember that we would actually need to do backing_file_open()
for all existing open files of the inode.

Also, after the server calls FUSE_DEV_IOC_BACKING_CLOSE,
will the fuse_backing object still be referenced from the inode
(as it was in v13)? and then properly closed only on the last file
close on that inode?

Otherwise, new file opens without explicit FOPEN_PASSTHROUGH
will not have a fuse_backing object to open the backing_file from.

I am not convinced that this complexity is a must for the first version.
If the server always sets FOPEN_PASSTHROUGH (as I expect many
servers will) this is unneeded complexity.

It seems a *lot* easier to do what you suggested and ignore
FOPEN_PASSTHROUGH if the server is not being consistent
with the FOPEN_ flags it uses.

Thanks,
Amir.

