Return-Path: <linux-fsdevel+bounces-4229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3287FDF75
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 19:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BFD31F20CA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 18:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155863399B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 18:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="CMVTN9EI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93644120
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 08:55:49 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9fa2714e828so950454166b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 08:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1701276948; x=1701881748; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ptm4JtUTfofmY0LoPy3mJ1nVaZBmoaQzwua0Z7IZy20=;
        b=CMVTN9EI+Y3yvYtqHDv2+2RJ1+oY1JFQnVrQU+IGEMW5mWxUZqDcQKkbR4sJiJNvyX
         wausH23GT60+4eTNOm1rA6MZqSr3cw+m6p0uWFqRuZOsjVKLi9VKwOpoqu9DMgotEjLn
         vNYcktGIo92QYNEIWt5LTaRcFSml9GLBYlwpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701276948; x=1701881748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ptm4JtUTfofmY0LoPy3mJ1nVaZBmoaQzwua0Z7IZy20=;
        b=etuVHKV3woAG7h1F5gAkiWS10YceTFlAxaT4Uqrv6YdPea6avInz+j1e6cpKu5zUmj
         Vazab6tRfOczUbwqXkyPL+lD/GJWf2OWP5BY+piimIVDGebdJCwQffWsOn94O/L/9FOX
         Q8rbLxvyLJ7pKb5HcvX3s0LcRPF3O7R4KnoM5PcqjTYQnDls+qEa1omZgKc0AtLCFqdN
         cJq/2VxZEM3LoIsFKzlXNydZWLAbNs16rNejiUl5Oi/w8k3COJdUzrzGvt1reu5Fl9PK
         qNK3SvdrSL6NBsWEnd28GeWWRHdLuZckzIEYL/fRry1gbn/AZAiIcdmumG52LcEMMMm4
         Ttzg==
X-Gm-Message-State: AOJu0YytDWiSX6dywwJut7JNWrFkIu9sbUsMIx4eDbDcF1zRP0XdIqHH
	v8dbTYcNS994FR9odMTdOU6bbztj6d19WQx5lQjDYw==
X-Google-Smtp-Source: AGHT+IHLaKKNsy7FR6jLP7wXMYn0Z0M6sqcX0kvKToECrrZfhx36Ml0wAWdDu9QFfxJ91lna9WXfmLBjWOdNbcOgr3o=
X-Received: by 2002:a17:906:2659:b0:9c6:9342:1459 with SMTP id
 i25-20020a170906265900b009c693421459mr13839776ejc.20.1701276948017; Wed, 29
 Nov 2023 08:55:48 -0800 (PST)
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
 <CAJfpegtH1DP19cAuKgYAssZ8nkKhnyX42AYWtAT3h=nmi2j31A@mail.gmail.com> <CAOQ4uxgW6xpWW=jLQJuPKOCxN=i_oNeRwNnMEpxOhVD7RVwHHw@mail.gmail.com>
In-Reply-To: <CAOQ4uxgW6xpWW=jLQJuPKOCxN=i_oNeRwNnMEpxOhVD7RVwHHw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 29 Nov 2023 17:55:36 +0100
Message-ID: <CAJfpegtOt6MDFM3vsK+syJhpLMSm7wBazkXuxjRTXtAsn9gCuA@mail.gmail.com>
Subject: Re: [PATCH v14 00/12] FUSE passthrough for file io
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Daniel Rosenberg <drosen@google.com>, 
	Paul Lawrence <paullawrence@google.com>, Alessio Balsini <balsini@android.com>, 
	Christian Brauner <brauner@kernel.org>, fuse-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Nov 2023 at 16:52, Amir Goldstein <amir73il@gmail.com> wrote:

> direct I/O read()/write() is never a problem.
>
> The question is whether mmap() on a file opened with FOPEN_DIRECT_IO
> when the inode is in passthrough mode, also uses fuse_passthrough_mmap()?

I think it should.

> or denied, similar to how mmap with ff->open_flags & FOPEN_DIRECT_IO &&
> vma->vm_flags & VM_MAYSHARE) && !fc->direct_io_relax
> is denied?

What would be the use case for FOPEN_DIRECT_IO with passthrough mmap?

> A bit more challenging, because we will need to track unmounts, or at
> least track
> "was_cached_mmaped" state per file, but doable.

Tracking unmaps via fuse_vma_close() should not be difficult.


>
> > >
> > > Therefore, my proposal is than when filesystem is FUSE_PASSTHROUGH capable,
> > > only passthrough file and cached file may be mmaped, but never allow to
> > > mmap a FOPEN_DIRECT_IO file.
> > >
> > > Does that make sense?
> >
> > I'm not sure I understand how this is supposed to work.   Disallowing
> > mmap will break applications.
>
> How is this different from existing -ENODEV in fuse_file_mmap() for
> !fc->direct_io_relax? What am I missing?
> Is it because VM_MAYSHARE is far less common for applications?

Yes, MAP_SHARE is far less common than MAP_PRIVATE.

Thanks,
Miklos

