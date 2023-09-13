Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCBF79E768
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 14:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240566AbjIMMAR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 08:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239632AbjIMMAQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:00:16 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721D719A8
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 05:00:12 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7a52a27fe03so2594889241.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 05:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694606411; x=1695211211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMKePbqS6Bt4Wcoq+DFth8SrbaYVhPNZP+oaxh9cTD0=;
        b=JI1Rp6vn2eS6ZuZH1/PmM6S2gxVDpUImOBJSA+4l/MbJeeE1/8v8YCcNKgcBBmt2dW
         adThY9orx8lzlb03DLOSILzAl+zKWN927SsWGtpzWXtbhnBYRgf97QzAQoA/ogzXDLT9
         iiPBzWm5jivcBIhrG1EcurFJcPcb5n4+G1JjaKAoAwC3twSOHFPQfDqwrQ/+XJaBgnV3
         phYSd85kzBADxLvIzYRd7f/GIQrYwKTb7XuGOvWgnaumxr3l2cz2q70o7nbm6lNCTcEG
         Xe4WwQDQFTFaArgsIxe0xJEQUmDZMu0luENC+yGj+rvYMUouDOLepl6Kblv6NnSmVm9b
         8pSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694606411; x=1695211211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMKePbqS6Bt4Wcoq+DFth8SrbaYVhPNZP+oaxh9cTD0=;
        b=Le/Ank9Dg3Ph0rJ6xooAYwxbYtUiXWTfQjwZ841HpnX3hMCx0kve59npnJ7ZLYncUr
         mJ1vQokCKFR9tHpERKMyZiQYtSfPn6xa/JMfEpSnAQ/7RIk/b3uzCh7Uu39fjYipo1sk
         naMyEtbFWp724Cya2OeHmq0v0rhWLFtyu6/LTRF91JbXG/6f5Nr7WPJA6mQwHletbjmp
         T4mXyu7GsRADpreEqd1dpGNjE1ip+8Agcm5VJypinGM2JXdndTYuAD9QwBVinz37h5IK
         xr1ejSr9x6qST8397Qi0AxcZcVylAnK+42YfpkOsOPER3/DCTSGt9vvfrOZATeBqbIqA
         rf6g==
X-Gm-Message-State: AOJu0YzfdMWPRmDfovd2K90qchmqwwKUcdMVVAiQjZuDscC6Xvgn/BuZ
        qkmslxRy9JcHB3j5KQwINpkm/Qw498Gnjd/2zLGjVB3FjEA=
X-Google-Smtp-Source: AGHT+IEgOdXC+BUjazh8bNbOOfgQazjTkT9klkdHxhp09uakfrGGL7I8h7N3Er0bxcbXC5zXhwx4KOgqJxsrV48mZXk=
X-Received: by 2002:a67:f348:0:b0:44e:8e28:284f with SMTP id
 p8-20020a67f348000000b0044e8e28284fmr1900309vsm.18.1694606411271; Wed, 13 Sep
 2023 05:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230912185408.3343163-1-amir73il@gmail.com> <20230913-sticken-warnzeichen-099bceebc54d@brauner>
 <CAOQ4uxiDpMkR-45m9X6AinK50oK5fMBsvmQfHW94U40ngJWV=Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxiDpMkR-45m9X6AinK50oK5fMBsvmQfHW94U40ngJWV=Q@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 13 Sep 2023 15:00:00 +0300
Message-ID: <CAOQ4uxhG5=Oszi8CqU0gaG3t2nYpT3Rteg3xjvpJ4CzkUUL7=g@mail.gmail.com>
Subject: Re: [PATCH] ovl: factor out some common helpers for backing files io
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 13, 2023 at 2:26=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Wed, Sep 13, 2023 at 11:37=E2=80=AFAM Christian Brauner <brauner@kerne=
l.org> wrote:
> >
> > On Tue, Sep 12, 2023 at 09:54:08PM +0300, Amir Goldstein wrote:
> > > Overlayfs stores its files data in backing files on other filesystems=
.
> > >
> > > Factor out some common helpers to perform io to backing files, that w=
ill
> > > later be reused by fuse passthrough code.
> > >
> > > Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
> > > Link: https://lore.kernel.org/r/CAJfpeguhmZbjP3JLqtUy0AdWaHOkAPWeP827=
BBWwRFEAUgnUcQ@mail.gmail.com
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >
> > > Miklos,
> > >
> > > This is the re-factoring that you suggested in the FUSE passthrough
> > > patches discussion linked above.
> > >
> > > This patch is based on the overlayfs prep patch set I just posted [1]=
.
> > >
> > > Although overlayfs currently is the only user of these backing file
> > > helpers, I am sending this patch to a wider audience in case other
> > > filesystem developers want to comment on the abstraction.
> > >
> > > We could perhaps later considering moving backing_file_open() helper
> > > and related code to backing_file.c.
> > >
> > > In any case, if there are no objections, I plan to queue this work
> > > for 6.7 via the overlayfs tree.
> > >
> > > Thanks,
> > > Amir.
> > >
> > > [1] https://lore.kernel.org/linux-unionfs/20230912173653.3317828-1-am=
ir73il@gmail.com/
> > >
> > >
> > >  MAINTAINERS                  |   2 +
> > >  fs/Kconfig                   |   4 +
> > >  fs/Makefile                  |   1 +
> > >  fs/backing_file.c            | 160 +++++++++++++++++++++++++++++++++=
++
> > >  fs/overlayfs/Kconfig         |   1 +
> > >  fs/overlayfs/file.c          | 137 ++----------------------------
> > >  fs/overlayfs/overlayfs.h     |   2 -
> > >  fs/overlayfs/super.c         |  11 +--
> > >  include/linux/backing_file.h |  22 +++++
> > >  9 files changed, 199 insertions(+), 141 deletions(-)
> > >  create mode 100644 fs/backing_file.c
> > >  create mode 100644 include/linux/backing_file.h
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 90f13281d297..4e1d21773e0e 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -16092,7 +16092,9 @@ L:    linux-unionfs@vger.kernel.org
> > >  S:   Supported
> > >  T:   git git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.=
git
> > >  F:   Documentation/filesystems/overlayfs.rst
> > > +F:   fs/backing_file.c
> > >  F:   fs/overlayfs/
> > > +F:   include/linux/backing_file.h
> >
> > I'd like to do this slightly differently, please. All vfs infra goes
> > through vfs trees
>
> OK. it will take a bit more git collaboration for a new
> infra that is not used by any fs yet, but it's fine by me.
>
> > but for new infra like this where someone steps up to
> > be a maintainer we add a new section (like bpf or networking does):
> >
> > VFS [BACKING FILE]
> > M:      Miklos Szeredi <miklos@szeredi.hu>
> > M:      Amir Goldstein <amir73il@gmail.com>
> > F:      fs/backing_file.c
> > F:      include/linux/backing_file.h
> > L:      linux-fsdevel@vger.kernel.org
> > S:      Maintained
>
> That sounds good.

But if you want to follow the ways of BFP and NETWORKING,
we first need to agree on the prefix, because there is no
^VFS entry at the moment there is:

FILESYSTEMS (VFS and infrastructure)

So do you intend to change that, or should we carry on with
the ^FILESYSTEM prefix, such as the entry:
FILESYSTEM DIRECT ACCESS (DAX)

and add the entry:
FILESYSTEM [BACKING FILE]

Thanks,
Amir.
