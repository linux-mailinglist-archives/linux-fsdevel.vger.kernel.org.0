Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB577ABF74
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Sep 2023 11:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjIWJxB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Sep 2023 05:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjIWJw7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Sep 2023 05:52:59 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB31180
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Sep 2023 02:52:52 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-57ad95c555eso1953283eaf.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Sep 2023 02:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695462771; x=1696067571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMH/+nJD03dgwbKuD8pLeeHCLP78c1dJ+i3+7FWLksw=;
        b=fZVHnyWM6Gm+2Pthjf66W9oX0xydHY/0/KyPGzE3Ybv8Cb3h9wH+IaYWh8O40f4ad8
         BFFPx24IyrxX7HfwY2/c930nf7HhOqsTtar/u6+Q7y1J63dOMk2WeISDiaSDskhO2i9a
         TlRfr4p2xpCxxqbHlQRoV0yJC+i1scmydXQfOA0BRvnmED29y5nuuD7r0XSHnUEJ1oLx
         z7IyOGX/DNP6AyFteRzKrW0RflRO5Hr3DMZ2BaEj5NkBeIZmAfAa/vANVL/jXyoAEAJ1
         tMjn4wn82fs88EtaeEsjhPoO97UtdJhOgvh56M0/9lHgFz1jJ+bHOQyc5TpTVrsuMVLG
         A5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695462771; x=1696067571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMH/+nJD03dgwbKuD8pLeeHCLP78c1dJ+i3+7FWLksw=;
        b=XeQUVTC6G82WjYGasLjSW5uONAFYUKu6K9z97QlMwgrlG9M8ymEEpunFGCzImrn/cv
         bm3i5lu9UYK/Lc1U3tK0r9AB1r7E+0rWLDlxMB9QFqbYgbIUXwGeC3vU5/iSlCLXzjbG
         LlnlEUqm1T7keLpq+cWP2tmSaj5lhoxedvtjFHBOwjXjikd2AHAu4eQHqmzsDWKK2LU2
         HaPayQFhJWvSFLeHB39tr2L2do+WK+QeFdW0bqQTEczChdpvW2xb+EHuotYqfDhK4Gjy
         uxscDS5h+7WHxDmsYDcGWkuRFKUrfNxR53w6ku5EvuuK2SwqVVHBbZgQboq+jdKtOFmC
         m4kw==
X-Gm-Message-State: AOJu0YzkKN396TFNio7dhL4375HPKyg0QnzcZfpUGy6GHfxDwPq8Uxj+
        iwFR26MAs5xuntgrMjvU4JH8C1cNUaovzG+HZ3fUiCVNO2Y=
X-Google-Smtp-Source: AGHT+IFJ81DYHwOqAXn0c3yPf6zY7wcwrZWW3maN/fBL6HWKjCO9ZiLNLKlwKK0wtN995SOdcz55j8NHlfndvyaPUOw=
X-Received: by 2002:a05:6808:611:b0:3ae:1031:594 with SMTP id
 y17-20020a056808061100b003ae10310594mr1896384oih.34.1695462771598; Sat, 23
 Sep 2023 02:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230912185408.3343163-1-amir73il@gmail.com> <20230913-galaxie-irrfahrt-a815cf10ebdc@brauner>
 <CAOQ4uxgta6y7fi_hfrF4fDvHA2RjeA+JTCb-eSaORZOY6XZbVQ@mail.gmail.com> <CAOQ4uxh616M=QdQ+AurOL+G5wJyXeq+auAzu06u=O+LoCE0KpQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxh616M=QdQ+AurOL+G5wJyXeq+auAzu06u=O+LoCE0KpQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 23 Sep 2023 12:52:40 +0300
Message-ID: <CAOQ4uxgYkksBL+2Fhp54s7efE4eUVvxU6SkEKRbY1zRXiABiWg@mail.gmail.com>
Subject: Re: [PATCH] ovl: factor out some common helpers for backing files io
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 21, 2023 at 6:51=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Wed, Sep 13, 2023 at 2:24=E2=80=AFPM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > On Wed, Sep 13, 2023 at 11:29=E2=80=AFAM Christian Brauner <brauner@ker=
nel.org> wrote:
> > >
> > > On Tue, Sep 12, 2023 at 09:54:08PM +0300, Amir Goldstein wrote:
> > > > Overlayfs stores its files data in backing files on other filesyste=
ms.
> > > >
> > > > Factor out some common helpers to perform io to backing files, that=
 will
> > > > later be reused by fuse passthrough code.
> > > >
> > > > Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
> > > > Link: https://lore.kernel.org/r/CAJfpeguhmZbjP3JLqtUy0AdWaHOkAPWeP8=
27BBWwRFEAUgnUcQ@mail.gmail.com
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > ---
> > > >
> > > > Miklos,
> > > >
> > > > This is the re-factoring that you suggested in the FUSE passthrough
> > > > patches discussion linked above.
> > > >
> > > > This patch is based on the overlayfs prep patch set I just posted [=
1].
> > > >
> > > > Although overlayfs currently is the only user of these backing file
> > > > helpers, I am sending this patch to a wider audience in case other
> > > > filesystem developers want to comment on the abstraction.
> > > >
> > > > We could perhaps later considering moving backing_file_open() helpe=
r
> > > > and related code to backing_file.c.
> > > >
> > > > In any case, if there are no objections, I plan to queue this work
> > > > for 6.7 via the overlayfs tree.
> > > >
> > > > Thanks,
> > > > Amir.
> > > >
> > > > [1] https://lore.kernel.org/linux-unionfs/20230912173653.3317828-1-=
amir73il@gmail.com/
> > > >
> > > >
> > > >  MAINTAINERS                  |   2 +
> > > >  fs/Kconfig                   |   4 +
> > > >  fs/Makefile                  |   1 +
> > > >  fs/backing_file.c            | 160 +++++++++++++++++++++++++++++++=
++++
> > >
> > > I'm sorry but I'm missing mountains of context.
> > > How is that related to the backing file stuff exactly?
> > > The backing file stuff has this unpleasant
> > >
> > > file->f_inode =3D=3D real_inode !=3D file->f_path->dentry->d_inode
> > >
> > > that we all agree is something we really don't like. Is FUSE trying t=
o
> > > do the same thing and build an read_iter/write_iter abstraction aroun=
d
> > > it? I really really hope that's not the case.
> >
> > That is not the case.
> > The commonality between FUSE passthrough and overlayfs is that
> > a "virtual" file (i.e. ovl/fuse), which has no backing blockdev of its =
own
> > "forwards" the io requests to a backing file on another filesystem.
> >
> > The name "backing file" is therefore a pretty accurate description
> > for both cases. HOWEVER, FUSE does not need to use the
> > backing_file struct to hold an alternative path, so FUSE backing files
> > do not have FMODE_BACKING, same as cachefiles uses backing
> > files, but does not use the FMODE_BACKING/file_backing struct.
> >
> > Yes, it's a bit of a naming mess.
> > I don't have any good ideas on how to do better naming.
> > Ideally, we will get rid of struct backing_file, so we won't need
> > to care about the confusing names...
> >
>
> Alas, my explanation about FUSE passthrough backing files
> turned out to be inaccurate.
>
> FUSE IO passthrough to backing file is very similar to overlayfs
> IO "passthrough" to lower/upper backing file.
>
> Which creates the same problem w.r.t mmap'ing the FUSE file
> to the underlying backing file inode.
> That problem in overlayfs caused the inception of the fake path file
> now embedded in the backing_file object.
> So yes, FUSE is trying to do the same thing.
>
> However, the helpers in this patch are not dealing with the fake path
> aspect of those backing files specifically.
> They are common code for a "stacked fs" (i.e. s_stack_depth > 0)
> which delegates IO to files on the underlying fs.
>

Funny story: following my clarification of the terminology above
I was going to rename the common helpers and I wanted to create
include/linux/fs_stack.h, but what do you know, it already exists.

It was created in 2006 to have common helpers for eCryptfs and
*Unionfs* (not overlayfs) and indeed, today it has a few helpers
which only ecryptfs uses.

Not only that, but it appears that the copy_attr_size helper does
things that ovl does not do - need to look into that and copy_attr_all
does not deal with uid translations and atomicity (which I just added
to the respective ovl helper).

So I am going to shake the dust from fs/stack.c and merge those
diverged helpers for starters and then go on to adding the new
common helpers for read/write/splice iter and code for handling the
backing_file (or stacked_file) fake path anomaly.

> I will give it some thought on how we can at least narrow the amount
> of filesystem code that could be exposed to those fake path files.
> The read/write/splice iterators do not really need to operate of fake pat=
h
> files, so this is something that I can try to avoid.
>

I am not sure but there may be another problem related to mmap and
the backing_file because ovl_mmap() of writable mapping does not
keep an elevated mount writer count on the upper fs mount.

The easy solution is perhaps for overlayfs mount to keep the elevated
mount writer count on the upper fs mount. Not sure if this is really
something to worry about. I will need to take a closer look.

Thanks,
Amir.
