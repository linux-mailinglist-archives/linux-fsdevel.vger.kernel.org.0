Return-Path: <linux-fsdevel+bounces-4204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0287FD999
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 15:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB5CB1C209BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 14:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C1932C80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 14:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="hthlFLVj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2350B6
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 06:14:03 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54b0e553979so6537106a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 06:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1701267242; x=1701872042; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mWRzSS/o94V0X2ansQHgqbwk9Hw4ZmwzrPeu+w1E518=;
        b=hthlFLVjkAazs2h3d/PlikvWTRl0FZ3VgJ3fj2HmKR3swhqPokh2PBgWAxBSNHH5Ll
         axrPLEaK+qe4kBNgrS3Oa/YIOPKlgtAiGJN6YXCFs5tinH5mAIqV5FMQ9q4+FMA0mTKK
         /vRPooxN7u2zDfw6rw4pUk4Uwfy/7kv78m+Dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701267242; x=1701872042;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWRzSS/o94V0X2ansQHgqbwk9Hw4ZmwzrPeu+w1E518=;
        b=SyzSDCBx8eqGALurvnYWJ5U1VaSV92zjScF3W2WSSooUNo1VsYFvEazObRX5Dg3mhC
         6QO8xtAnjOD1/SWZ6KHG4o06vaSFruAjDmngP8C+Ay/2IRbI5XqDpEjLd8Ej+Q9XaKBb
         gFezMyxlUb7h9aENMZyTpAR/lMBPwBysffCURKKwni35iCQamZozgLRefqTZd41vbO0u
         ebZYwUA3dAVYFND9eYZ8rYUCQ6epANJKIk2ZpSnhUW7pnQD4iKL1XrrfTeUZ5hcEGP3M
         +JG5K4nxzGH4iXS2BNex8eD4aeyoaU5aacbloQZH0HBeyAgrrWpG6NPsJnRESusRvlMJ
         MvyA==
X-Gm-Message-State: AOJu0Yx66axXrhb1KeZ7tfcRRV0DEWXQ9l2bCheICtnIA2OmOxUtyCty
	MudfmENIbZRlqdHijg6ATdzpmu9AtMGNuEnyItqDig==
X-Google-Smtp-Source: AGHT+IFKYbY/9N0/tbiLjxdKdT7etiDvRaBiqWAsyfUfVa2tzwvgl8t/Msglrylws2CC6cazGPp/8ASBv8Cb1LVAd4c=
X-Received: by 2002:a17:906:4a0b:b0:9fe:ebb:b2b8 with SMTP id
 w11-20020a1709064a0b00b009fe0ebbb2b8mr13075553eju.68.1701267242413; Wed, 29
 Nov 2023 06:14:02 -0800 (PST)
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
 <CAJfpegtWdGVm9iHgVyXfY2mnR98XJ=6HtpaA+W83vvQea5PycQ@mail.gmail.com> <CAOQ4uxh6sd0Eeu8z-CpCD1KEiydvQO6AagU93RQv67pAzWXFvQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxh6sd0Eeu8z-CpCD1KEiydvQO6AagU93RQv67pAzWXFvQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 29 Nov 2023 15:13:50 +0100
Message-ID: <CAJfpegsoz12HRBeXzjX+x37fSdzedshOMYbcWS1QtG4add6Nfg@mail.gmail.com>
Subject: Re: [PATCH v14 00/12] FUSE passthrough for file io
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Daniel Rosenberg <drosen@google.com>, 
	Paul Lawrence <paullawrence@google.com>, Alessio Balsini <balsini@android.com>, 
	Christian Brauner <brauner@kernel.org>, fuse-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Nov 2023 at 08:25, Amir Goldstein <amir73il@gmail.com> wrote:

> My proposed solution is to change the semantics with the init flag
> FUSE_PASSTHROUGH to disallow mmap on FOPEN_DIRECT_IO
> files.

Why?  FOPEN_DIRECT_IO and FUSE_PASSTHROUGH should mix much more
readily than FOPEN_DIRECT_IO with page cache.

> So with a filesystem that supports FUSE_PASSTHROUGH,
> FOPEN_DIRECT_IO files can only be used for direct read/write io and
> mmap maps either the fuse inode pages or the backing inode pages.
>
> This also means that FUSE_DIRECT_IO_RELAX conflicts with
> FUSE_PASSTHROUGH.
>
> Should we also deny mixing FUSE_HAS_INODE_DAX with
> FUSE_PASSTHROUGH? Anything else from virtiofs?

Virtiofs/DAX and passthrough are similar features in totally different
environments.   We just need to make sure the code paths don't
collide.

> While I have your attention, I am trying to consolidate the validation
> of FOPEN_ mode vs inode state into fuse_finish_open().
>
> What do you think about this partial patch that also moves
> fuse_finish_open() to after fuse_release_nowrite().
> Is it legit?

I suspect it won't work due to the i_size reset being in
fuse_finish_open().  But I feel there's not enough context to
understand why this is needed.

Thanks,
Miklos

