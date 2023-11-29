Return-Path: <linux-fsdevel+bounces-4214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3727FDD50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 17:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9C1282581
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 16:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AD93B295
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="HL8VxN2Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE5FD6E
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 07:21:23 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a02c48a0420so942759866b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 07:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1701271281; x=1701876081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NE3dLucEMCrnv4EmFzHeQRoc9bwd9ajHXtVS/RD86kw=;
        b=HL8VxN2Y5cAUycxhQpQc79hZOciIIg/kE6LSlnT+71Rf+4RGYpHvzhjgbKumhTCC62
         mb2rOl1iT+Nj+4Q5oefxfVxPjX9g+1vahzq1/bkzy/D2wKBv0rczK0UoZXCowSkaIQ4P
         /+sHOKqJf2EO6e5/PCwZueY9sVorfBTiELGL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701271281; x=1701876081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NE3dLucEMCrnv4EmFzHeQRoc9bwd9ajHXtVS/RD86kw=;
        b=vQh9p1HAaInh7Muo2+J4RWcY+sgIBD5+1oCPjttXAJ5GchKznnlI+3VCave7PS1FvQ
         ZCTbpqEU4aQeNdtb8G7owklr2uUDhIyRFxfCPZH5I7rsj9jz8XNyGmR2rmreoJraP9iu
         De9uVwQ9LiGpmHq2SsBAY52Jse5zq3ZxpDbM5D/kDRUtsdbPNnYNtaCIkQ1FKzs+1JS+
         29GmFNrBDwC//U0g9+An6W/0/fUnbDee9SPT8oo7NBUqtDKKnoNoUsDMetMdch4amLLO
         Rcitertj4MVKxHSX+Q0mQAOKUBKMpnWE4FaAL7NLmtx3zPHLg2medIz0ihwd7vfROLNR
         Spzg==
X-Gm-Message-State: AOJu0YzJVwWETWn904HIyTn6GL2gPkao0N/Nfzk+2B8q733+FSCpfr6N
	5srHJYaZOI+Ws79/JLYL8U3uD829PKZKJzMad+fw1Q==
X-Google-Smtp-Source: AGHT+IEpvkJudB3KItLXyCsQ4qh+BdxdjDi6za6xDSgLypfaL0uypeOqCP4hF7mTU7ymlCpLmbR9mMU8hbOaMgfRnqo=
X-Received: by 2002:a17:906:f34e:b0:a0e:7563:51bd with SMTP id
 hg14-20020a170906f34e00b00a0e756351bdmr6955733ejb.53.1701271281702; Wed, 29
 Nov 2023 07:21:21 -0800 (PST)
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
 <CAJfpegsoz12HRBeXzjX+x37fSdzedshOMYbcWS1QtG4add6Nfg@mail.gmail.com> <CAOQ4uxjEHEsBr5OgvrKNAsEeH_VUTZ-Cho2bYVPYzj_uBLLp2A@mail.gmail.com>
In-Reply-To: <CAOQ4uxjEHEsBr5OgvrKNAsEeH_VUTZ-Cho2bYVPYzj_uBLLp2A@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 29 Nov 2023 16:21:10 +0100
Message-ID: <CAJfpegtH1DP19cAuKgYAssZ8nkKhnyX42AYWtAT3h=nmi2j31A@mail.gmail.com>
Subject: Re: [PATCH v14 00/12] FUSE passthrough for file io
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Daniel Rosenberg <drosen@google.com>, 
	Paul Lawrence <paullawrence@google.com>, Alessio Balsini <balsini@android.com>, 
	Christian Brauner <brauner@kernel.org>, fuse-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Nov 2023 at 16:06, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Wed, Nov 29, 2023 at 4:14=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu=
> wrote:
> >
> > On Wed, 29 Nov 2023 at 08:25, Amir Goldstein <amir73il@gmail.com> wrote=
:
> >
> > > My proposed solution is to change the semantics with the init flag
> > > FUSE_PASSTHROUGH to disallow mmap on FOPEN_DIRECT_IO
> > > files.
> >
> > Why?  FOPEN_DIRECT_IO and FUSE_PASSTHROUGH should mix much more
> > readily than FOPEN_DIRECT_IO with page cache.
> >
>
> Am I misunderstanding how mmap works with FOPEN_DIRECT_IO file?
> My understanding is that mmap of FOPEN_DIRECT_IO reads/writes
> from page cache of fuse inode.
>
> To clarify, the plan is to never allow mixing open of passthrough and
> cached files on the same inode.

Yep.

But passthrough mmap + direct I/O should work, no?

> It is allowed to open FOPEN_DIRECT_IO file for inode either in cached
> or passthrough mode, but it is NOT allowed to mmap a FOPEN_DIRECT_IO
> file for inode in passthrough mode.
>
> However, if inode only has file open in FOPEN_DIRECT_IO mode, then inode
> mode is neutral. If we allow mmap in this state then a later open in pass=
thourgh
> mode and mmap in passthrough mode will collide with the direct mode mmap.

We can keep track of when there are any page cache mmaps.  Does that
not solve this?

>
> Therefore, my proposal is than when filesystem is FUSE_PASSTHROUGH capabl=
e,
> only passthrough file and cached file may be mmaped, but never allow to
> mmap a FOPEN_DIRECT_IO file.
>
> Does that make sense?

I'm not sure I understand how this is supposed to work.   Disallowing
mmap will break applications.

Thanks,
Miklos

