Return-Path: <linux-fsdevel+bounces-4241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 627357FDF86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 19:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2674B282794
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 18:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B235DF01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 18:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PX+gd6YK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7BCCA
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 09:39:52 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b3f55e1bbbso4450819b6e.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 09:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701279591; x=1701884391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0iaA1iPdTkS1d7PjNeQyUAz9aroKezKkkRx//ZDtK4=;
        b=PX+gd6YK6FmT3yE77PsCGq0+Q4DbZY/QNhKjufH1fJVN5oY8R1mhY6zN6t3loZAQOk
         /k5sGsBri93w45iS2qnoRotTfZCOLN8hh53T2XuOmL7zWz4THqHb5Zvk769Tvy53/FHZ
         pEeuoKItxNCSNNN0GHb21evTw1m/Tr6QqhbNcI5XT9HgsDeqYu9dG62M121MX5FfXvRq
         mhwF9I7xZak0ol6/zAYSL28/RgsxWSDb4cxbfG70ztL2NH6vbvZy5fgEhFNr5oKzLpOu
         KdcEt+CBrGewpQXYu5lOiFbqHFY2DfefvPk6FyoLKr69uZ4nCLUXoELiJYG22WMsUcL5
         XOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701279591; x=1701884391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0iaA1iPdTkS1d7PjNeQyUAz9aroKezKkkRx//ZDtK4=;
        b=uPqGTvW2CbGqWjaWC/4UJm8XvQGdu2rIutRbaBmDZc3OhJYPkoThuKy/duESLpthZw
         kZQJ+HXcqqpFgS/atKqCXwFTbeuCit8WhG/jU0vK6gTDxHwOXYZ4pYkWfhEcSSSZDnmK
         f0VtWMVDD3tkSqMEa4rzJmoEN23mjBhxPWMVHXfKd2Us64Coi4X2gtlKO+pg82kDcUMK
         bjtXNa7y166DHe/XGrR7nyeZ9/+2Ym51jpS9mS0Nqydg4Z50ulrbHIl5TNk69ONdi8PA
         ySOMHT04zNqOEr96vx0qG+72Qq1jTmQn8e9RqQHO1TJg6lqaq04HbxhS7n/o5HLUABiF
         HDBw==
X-Gm-Message-State: AOJu0YwnKXuPR09/ixNFl0nqt75umsYmNXfmoXSOjXtjnYHAkFTMtMJy
	fX/OmatCAXGnZdZk9or5ZJve23oPE/lnyLoA9xg=
X-Google-Smtp-Source: AGHT+IFTA01IoFYYJW0T/bcOd3Jq1zEzN5Ftd0YQF73nnZXIB+ANGLpMS3lAKoxXFTCQcEIVAdnogsygoXV7xt8Su70=
X-Received: by 2002:a05:6358:9889:b0:16e:4c10:9a68 with SMTP id
 q9-20020a056358988900b0016e4c109a68mr8163735rwa.28.1701279591328; Wed, 29 Nov
 2023 09:39:51 -0800 (PST)
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
 <CAOQ4uxh6sd0Eeu8z-CpCD1KEiydvQO6AagU93RQv67pAzWXFvQ@mail.gmail.com>
 <CAJfpegsoz12HRBeXzjX+x37fSdzedshOMYbcWS1QtG4add6Nfg@mail.gmail.com>
 <CAOQ4uxjEHEsBr5OgvrKNAsEeH_VUTZ-Cho2bYVPYzj_uBLLp2A@mail.gmail.com>
 <CAJfpegtH1DP19cAuKgYAssZ8nkKhnyX42AYWtAT3h=nmi2j31A@mail.gmail.com>
 <CAOQ4uxgW6xpWW=jLQJuPKOCxN=i_oNeRwNnMEpxOhVD7RVwHHw@mail.gmail.com> <CAJfpegtOt6MDFM3vsK+syJhpLMSm7wBazkXuxjRTXtAsn9gCuA@mail.gmail.com>
In-Reply-To: <CAJfpegtOt6MDFM3vsK+syJhpLMSm7wBazkXuxjRTXtAsn9gCuA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 29 Nov 2023 19:39:39 +0200
Message-ID: <CAOQ4uxiCjX2uQqdikWsjnPtpNeHfFk_DnWO3Zz2QS3ULoZkGiA@mail.gmail.com>
Subject: Re: [PATCH v14 00/12] FUSE passthrough for file io
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Daniel Rosenberg <drosen@google.com>, 
	Paul Lawrence <paullawrence@google.com>, Alessio Balsini <balsini@android.com>, 
	Christian Brauner <brauner@kernel.org>, fuse-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 6:55=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Wed, 29 Nov 2023 at 16:52, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > direct I/O read()/write() is never a problem.
> >
> > The question is whether mmap() on a file opened with FOPEN_DIRECT_IO
> > when the inode is in passthrough mode, also uses fuse_passthrough_mmap(=
)?
>
> I think it should.
>
> > or denied, similar to how mmap with ff->open_flags & FOPEN_DIRECT_IO &&
> > vma->vm_flags & VM_MAYSHARE) && !fc->direct_io_relax
> > is denied?
>
> What would be the use case for FOPEN_DIRECT_IO with passthrough mmap?
>

I don't have a use case. That's why I was wondering if we should
support it at all, but will try to make it work.

> > A bit more challenging, because we will need to track unmounts, or at
> > least track
> > "was_cached_mmaped" state per file, but doable.
>
> Tracking unmaps via fuse_vma_close() should not be difficult.
>

OK. so any existing mmap, whether on FOPEN_DIRECT_IO or not
always prevents an inode from being "neutral".

Thanks,
Amir.

