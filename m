Return-Path: <linux-fsdevel+bounces-359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FD37C953C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Oct 2023 18:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A32D1F21502
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Oct 2023 16:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD7E13AE4;
	Sat, 14 Oct 2023 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJecJkfk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408F812B8E
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Oct 2023 16:01:32 +0000 (UTC)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8F4B7
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Oct 2023 09:01:30 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-66d03491a1eso16466336d6.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Oct 2023 09:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697299290; x=1697904090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLrlG5/qQWi+r9nE9Bak3REM3dGWKBElrq1PyfxplWI=;
        b=EJecJkfkM7o8YXX7kl9wUfmcmNFUYs66/905jesw9dH+51FXvUHVuVYtbmJZBr8+ot
         XJCIdU2iMidpCT63ty24OrzXH/GwK7oX3m767032YjS6kaD+rSP9jerUpobq0lNhYFXs
         HH2vT8uJ3bXhA4e7/SZAc2JhMcORyjwhBgdphm/S0UY3r4x2iqghwol9wFzEWPkXB9CK
         nDmxZUvdu7ZoQlJcQWGMjE/4CWsw8ixaDqJjTTPshMkakiRKOMRUq0bPJK4uPf/r3P8P
         TMMyDsS5CgisAgoflc+IX8edbMf6jGeId8jL1iyM9CPFdn+klQTVrzFQMlKTHPWLYO3i
         iPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697299290; x=1697904090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLrlG5/qQWi+r9nE9Bak3REM3dGWKBElrq1PyfxplWI=;
        b=vqYXWAovmPlbP073KiBmKZzqsGrFh8m1lJFF6W+pf523eUDkyi6NgIwNv71K2T1Z8k
         qFWr6OgFYekf8jrZjRTyYh9NAYgsWO2c9ono81cwmjGM9dIPPkDa1YU/945ImhY74gwt
         uVH8GJnNXbIr5qNE4w9FgigH+zvU/y/VM75+hkLzrP3WWYClbjbA3EG0M+AShqlMl1Ve
         7RcwETO2aT5sWYp4VZcRV01jbkx9ie3F+Eh+r6SVyJXTEtapvGJNgiBaRKhhvnuJyuae
         SVclklVjL3DD5SvGn2kdaTkUz4x++XEsCWN8IJMe5w2XJ2Tq0wKZDROq6GC+yemvAKxd
         9/RA==
X-Gm-Message-State: AOJu0YyoOjOno+d0cL83Y7usrPQGD/OWvyndjMtPxp/Dl6lAllC/YONp
	fbGkLf8bUl3LVSOlPzpZ+Yn2tRXBjOXBiIvl6eM=
X-Google-Smtp-Source: AGHT+IEHXO/ibq031zO0thnMayVeC+Uk8wmTVBCD+wAXvz4+ic7X4001bQl/2XPXpXGxAetCR0AeC1wIEHg2/VELX+E=
X-Received: by 2002:a05:6214:2603:b0:66d:12b5:68c1 with SMTP id
 gu3-20020a056214260300b0066d12b568c1mr11161051qvb.59.1697299289714; Sat, 14
 Oct 2023 09:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <CAOQ4uxibuwUwaLaJNKSifLHBm9G-Tgn67k_TKWKcN1+A4Rw-zg@mail.gmail.com>
 <CAJfpegucD6S=yUTzpQGsR6C3E64ve+bgG_4TGP7Y+0NicqyQ_g@mail.gmail.com>
 <CAOQ4uxjGWHnwd5fcp8VwHk59q=BftAhw0uYbdR-KmJCq3fpnDg@mail.gmail.com>
 <CAJfpegu2+aMaEmUCjem7em0om8ZWr0ENfvihxXMkSsoV-vLKrw@mail.gmail.com>
 <CAOQ4uxgySnycfgqgNkZ83h5U4k-m4GF2bPvqgfFuWzerf2gHRQ@mail.gmail.com>
 <CAOQ4uxi_Kv+KLbDyT3GXbaPHySbyu6fqMaWGvmwqUbXDSQbOPA@mail.gmail.com>
 <CAJfpegvRBj8tRQnnQ-1doKctqM796xTv+S4C7Z-tcCSpibMAGw@mail.gmail.com>
 <CAOQ4uxjBA81pU_4H3t24zsC1uFCTx6SaGSWvcC5LOetmWNQ8yA@mail.gmail.com>
 <CAJfpegs1DB5qwobtTky2mtyCiFdhO_Au0cJVbkHQ4cjk_+B9=A@mail.gmail.com>
 <CAOQ4uxgpLvATavet1pYAV7e1DfaqEXnO4pfgqx37FY4-j0+Zzg@mail.gmail.com>
 <CAJfpegvS_KPprPCDCQ-HyWfaVoM7M2ioJivrKYNqy0P0GbZ1ww@mail.gmail.com>
 <CAOQ4uxhkcZ8Qf+n1Jr0R8_iGoi2Wj1-ZTQ4SNooryXzxxV_naw@mail.gmail.com>
 <CAJfpegstwnUSCX1vf2VsRqE_UqHuBegDnYmqt5LmXdR5CNLAVg@mail.gmail.com>
 <CAOQ4uxhu0RXf7Lf0zthfMv9vUzwKM3_FUdqeqANxqUsA5CRa7g@mail.gmail.com>
 <CAOQ4uxjQx3nBPuWiS0upV_q9Qe7xW=iJDG8Wyjq+rZfvWC3NWw@mail.gmail.com>
 <CAJfpegtLAxY+vf18Yht+NPztv+wO9S28wyJp9MB_=yuAOSbCDA@mail.gmail.com> <CAOQ4uxj1LvL+Gszag-3umA-YGLOhQBmC-WF6ks1v+upQUQNZ9w@mail.gmail.com>
In-Reply-To: <CAOQ4uxj1LvL+Gszag-3umA-YGLOhQBmC-WF6ks1v+upQUQNZ9w@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 14 Oct 2023 19:01:18 +0300
Message-ID: <CAOQ4uxi326mYRodab1Qh7b8xqc4BSZhWDjMShGHHF4DW4iXp6A@mail.gmail.com>
Subject: Re: [PATCH v13 00/10] fuse: Add support for passthrough read/write
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Daniel Rosenberg <drosen@google.com>, Paul Lawrence <paullawrence@google.com>, 
	Alessio Balsini <balsini@android.com>, fuse-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 6:14=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Tue, Oct 10, 2023 at 5:31=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu=
> wrote:
> >
> > On Sun, 8 Oct 2023 at 19:53, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > > Ok, posted your original suggestion for opt-in to fake path:
> > > https://lore.kernel.org/linux-fsdevel/20231007084433.1417887-1-amir73=
il@gmail.com/
> > >
> > > Now the problem is that on FUSE_DEV_IOC_BACKING_OPEN ioctl,
> > > the fake (fuse) path is not known.
> > >
> > > We can set the fake path on the first FOPEN_PASSTHROUGH response,
> > > but then the whole concept of a backing id that is not bound to a
> > > single file/inode
> > > becomes a bit fuzzy.
> > >
> > > One solution is to allocate a backing_file container per fuse file on
> > > FOPEN_PASSTHROUGH response.
> >
> > Right.   How about the following idea:
> >
> >  - mapping request is done with an O_PATH fd.
> >  - fuse_open() always opens a backing file (just like overlayfs)
> >
>
> I think it makes sense and it is in the direction that FUSE BPF took
> so that's good.
>
> > The disadvantage is one more struct file (the third).  The advantage
> > is that the server doesn't have to care about open flags, hence the
> > mapping can always be per-inode.
>
> I am fine with that.
> One more struct file per inode is not that big of an overhead
> and one backing file per fuse file is the same overhead as overlayfs.
>
> Does it mean that we can drop backing_id's and use the "inode bound"
> FUSE_BACKING_MAP_INODE mode to map the O_PATH fd to an inode,
> where the FUSE_DEV_IOC_BACKING_OPEN ioctl takes a nodeid as
> an input argument?
>
> Or do you still think that we need the backing_id, so we can map
> the same O_PATH fd to different inodes?
>
> To me, one O_PATH fd per inode without any backing_id seems
> like a simpler start.
>

I did not take into account that during create, backing file is setup
before the kernel knows about the nodeid.
I will keep the backing_id and will figure out how to avoid multi
backing ids per inode.

Thanks,
Amir.

