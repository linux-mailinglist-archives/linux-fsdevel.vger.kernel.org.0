Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF1F70F3A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 12:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjEXKBF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 06:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjEXKBE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 06:01:04 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0C693
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 03:01:02 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-77115450b8fso605016241.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 03:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684922462; x=1687514462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Or/taqHjoj28PP3Ai9fBEZ5lnHHnvFF6U0gYRCxzbP0=;
        b=YTXmnDzMTOcumcnBXIR4XVThjqd+izWHckM9/hnRVmKzh6iFHiQeXm098A8hyekb59
         3QqFUE40Nv9e+POBPzzCPK8DW/Q0nitNttguvN4vYErUldHaninLfg0rTSiJpUnWUNFR
         /lNVQVlHb/cVq1DrGJTJxiIks43mvwicIncHm7En+i72fPbZrbhfjC0485EUYtmYXygQ
         ofKDnYOwHQjL0NT4Am8+/EP5frlX9NWCa6kPI6zalK5nRR2In1ITv6vQQylQ4K7hY91Y
         TnwJyPzTyJjqgx5I0bD0pTizoEJ2XH66by1DWFG/d9DDlER5E/rb2s+5hJj60wt6VrLb
         Ackg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684922462; x=1687514462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Or/taqHjoj28PP3Ai9fBEZ5lnHHnvFF6U0gYRCxzbP0=;
        b=Eb3cPWckkqhdbzLz8jNAgBidLBeLa5R8EU1N31ux01M8QFr3yp2o4g0iVuvuMDzRnX
         +R/5gos3PBK2ayn0XaqgTL8UTpBt95qILqrovzhapq/s+eXFeN2/TIZReoMqn3aeoyly
         wze82raqzwGjElYPH4Hjgcay7ul6DKSnW5tXH4LZvyDDyoo13n6lgPuuUYrrBumici7+
         YrJgmdA1sUYSdEB50rc34P1owpri9JVXuVdHuCa276eOWVwR5sfBhgNzV33BJIX6OuaJ
         9enKCWiXAK6sGm1/7bJ/4IIea8NzOXRSkTAQR1feDKZfU1exkqtR1J2zs3svzRXPvvRP
         VXZQ==
X-Gm-Message-State: AC+VfDwOG0p+BD6T9RzhXEOmtIKS9lIOSO168f0+xAxtQ84Md7H+baY8
        udiJcVlzXiZnOkqHoVT4uRfnsk0uWhrnn9MRjO5wSUbtYJU=
X-Google-Smtp-Source: ACHHUZ7GqYVvw5d94Yddgd5DNKc0zC0hko6Qd6dw0l7nozNsdkQwQKFJp78pz69ip86IJs0JYv200nPoKt5J1qv1C2c=
X-Received: by 2002:a67:e8c4:0:b0:439:4706:93c0 with SMTP id
 y4-20020a67e8c4000000b00439470693c0mr3254080vsn.23.1684922461739; Wed, 24 May
 2023 03:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <20230519125705.598234-3-amir73il@gmail.com>
 <CAJfpegtK7dJ1wa5NdruK1rPmJ9JgXujjyxFCGFBXnu=6u_KzLQ@mail.gmail.com>
 <CAOQ4uxi=wWWeDb5BLQiOmMG02R-LRugy1TXCM7YU77K-7Ost0A@mail.gmail.com> <CAJfpegsty3wfV=2g_M7pfdrHxDDjecOAnkidcp87pe5o+dBt_A@mail.gmail.com>
In-Reply-To: <CAJfpegsty3wfV=2g_M7pfdrHxDDjecOAnkidcp87pe5o+dBt_A@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 24 May 2023 13:00:50 +0300
Message-ID: <CAOQ4uxjo5_JHeLtrpO3w8Xjd6VwY7chRtcUZKrwQt5f21=xMFQ@mail.gmail.com>
Subject: Re: [PATCH v13 02/10] fuse: Definitions and ioctl for passthrough
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 22, 2023 at 5:50=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Sat, 20 May 2023 at 12:20, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Fri, May 19, 2023 at 6:13=E2=80=AFPM Miklos Szeredi <miklos@szeredi.=
hu> wrote:
> > >
> > > On Fri, 19 May 2023 at 14:57, Amir Goldstein <amir73il@gmail.com> wro=
te:
> > > >
> > > > From: Alessio Balsini <balsini@android.com>
> > > >
> > > > Expose the FUSE_PASSTHROUGH capability to user space and declare al=
l the
> > > > basic data structures and functions as the skeleton on top of which=
 the
> > > > FUSE passthrough functionality will be built.
> > > >
> > > > As part of this, introduce the new FUSE passthrough ioctl, which al=
lows
> > > > the FUSE daemon to specify a direct connection between a FUSE file =
and a
> > > > backing file.  The ioctl requires user space to pass the file descr=
iptor
> > > > of one of its opened files to the FUSE driver and get an id in retu=
rn.
> > > > This id may be passed in a reply to OPEN with flag FOPEN_PASSTHROUG=
H
> > > > to setup passthrough of read/write operations on the open file.
> > > >
> > > > Also, add the passthrough functions for the set-up and tear-down of=
 the
> > > > data structures and locks that will be used both when fuse_conns an=
d
> > > > fuse_files are created/deleted.
> > > >
> > > > Signed-off-by: Alessio Balsini <balsini@android.com>
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > ---
> > > >  fs/fuse/Makefile          |  1 +
> > > >  fs/fuse/dev.c             | 33 ++++++++++++++++++++++++--------
> > > >  fs/fuse/dir.c             |  7 ++++++-
> > > >  fs/fuse/file.c            | 17 +++++++++++++----
> > > >  fs/fuse/fuse_i.h          | 27 ++++++++++++++++++++++++++
> > > >  fs/fuse/inode.c           | 21 +++++++++++++++++++-
> > > >  fs/fuse/passthrough.c     | 40 +++++++++++++++++++++++++++++++++++=
++++
> > > >  include/uapi/linux/fuse.h | 13 +++++++++++--
> > > >  8 files changed, 143 insertions(+), 16 deletions(-)
> > > >  create mode 100644 fs/fuse/passthrough.c
> > > >
> > > > diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
> > > > index 0c48b35c058d..d9e1b47382f3 100644
> > > > --- a/fs/fuse/Makefile
> > > > +++ b/fs/fuse/Makefile
> > > > @@ -8,6 +8,7 @@ obj-$(CONFIG_CUSE) +=3D cuse.o
> > > >  obj-$(CONFIG_VIRTIO_FS) +=3D virtiofs.o
> > > >
> > > >  fuse-y :=3D dev.o dir.o file.o inode.o control.o xattr.o acl.o rea=
ddir.o ioctl.o
> > > > +fuse-y +=3D passthrough.o
> > > >  fuse-$(CONFIG_FUSE_DAX) +=3D dax.o
> > > >
> > > >  virtiofs-y :=3D virtio_fs.o
> > > > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > > > index 1a8f82f478cb..cb00234e7843 100644
> > > > --- a/fs/fuse/dev.c
> > > > +++ b/fs/fuse/dev.c
> > > > @@ -2255,16 +2255,19 @@ static long fuse_dev_ioctl(struct file *fil=
e, unsigned int cmd,
> > > >                            unsigned long arg)
> > > >  {
> > > >         int res;
> > > > -       int oldfd;
> > > > -       struct fuse_dev *fud =3D NULL;
> > > > +       int fd, id;
> > > > +       struct fuse_dev *fud =3D fuse_get_dev(file);
> > >
> > > This is broken, see below.
> >
> > IIUC, *this* is not broken for the new ioctls...
> >
> > >
> > > >         struct fd f;
> > > >
> > > > +       if (!fud)
> > > > +               return -EINVAL;
> > > > +
>
> This is also broken for the old ioctl.
>
> > > >         switch (cmd) {
> > > >         case FUSE_DEV_IOC_CLONE:
> > > > -               if (get_user(oldfd, (__u32 __user *)arg))
> > > > +               if (get_user(fd, (__u32 __user *)arg))
> > > >                         return -EFAULT;
> > > >
> > > > -               f =3D fdget(oldfd);
> > > > +               f =3D fdget(fd);
> > > >                 if (!f.file)
> > > >                         return -EINVAL;
> > > >
> > > > @@ -2272,17 +2275,31 @@ static long fuse_dev_ioctl(struct file *fil=
e, unsigned int cmd,
> > > >                  * Check against file->f_op because CUSE
> > > >                  * uses the same ioctl handler.
> > > >                  */
> > > > -               if (f.file->f_op =3D=3D file->f_op)
> > > > -                       fud =3D fuse_get_dev(f.file);
> > > > -
> > > >                 res =3D -EINVAL;
> > > > -               if (fud) {
> > > > +               if (f.file->f_op =3D=3D file->f_op) {
> >
> > and this can be fixed by adding:
> >  +                           fud =3D fuse_get_dev(f.file);
>
> Yes, but it's still messy.
>
> I suggest separating out unrelated ioctl commands into different
> functions.  Not sure if it's worth doing the open/close in a common
> function, I'll leave that to you.
>
> [snip]

ok.

>
> > > Seems too restrictive.  We could specify the max stacking depth in th=
e
> > > protocol and verify that when registering the passthrough file.
> > >
> > > I.e. fuse_sb->s_stack_depth of
> > >
> > > 0 -> passthrough disabled
> > > 1 -> backing_sb->s_stack_depth =3D=3D 0
> > > 2 -> backing_sb->stack_depth <=3D 1
> > > ...
> > >
> >
> > Ok. Let's see.
> > What do we stand to gain from the ability to setup nax stacking depth?
> >
> > We could use it to setup an overlayfs with lower FUSE that allows passt=
hrough
> > fds to a non-stacked backing fs and we could use it to setup FUSE that =
allows
> > passthrough fds to overlayfs.
> >
> > I pity the FUSE userspace developers that will need to understand this
> > setup parameter...
>
> I guess libfuse could parse it with other common options.  It's
> something that needs to be tuned on a per-case basis, not something
> the filesystem designer can predict.
>
> Would be better if we could have a per-inode stack depth and then this
> wouldn't have to be tuned.  Is that feasible?
>

We could do something like:

real =3D d_real(dentry);
for (depth =3D 0; real !=3D dentry && depth < FILESYSTEM_MAX_STACK_DEPTH;
      dentry =3D real, real =3D d_real(dentry));

Which brings up the question - what should fuse_d_real() return
if we fuse passthrough is per file and not per inode?
Should we add f_real() op?

Doing this check on FUSE passthrough open is easy, because FUSE
server can fall back to non-passthrough, but what about overlayfs?
I don't think we want to fail open in overlayfs because a lower FUSE
file turns out to be using the max stack depth.

This is getting a bit complicated, so I would like to take a step back
and think about which configurations we *really* want/need to support.

I already listed FUSE over overlayfs and overlayfs over FUSE -
they both seem reasonably likely.

How about FUSE over FUSE (nested passthrough) and more combinations
if you would like to take stack depth > 2 into design considerations?

Do you think we can relax allowed combinations to make things easier?
To me, it feels that restricting nested FUSE bypass is not so bad, because
server has the option to fallback to non-passthrough at any level.

So how about:
1. init: FUSE s_stack_depth =3D FUSE_PASSTHOUGH ? 1 : 0
2. Let stacking fs set a flag FMODE_PASSTHROUGH on backing file
3. on passthrough setup, check if fuse_file has FMODE_PASSTHROUGH
    (i.e. is FUSE the top of the stack?)
3.a. if FUSE is top of the stack, allow backing file stack depth 1
3.b. if FUSE is below something, limit backing file stack depth 0

This implies that the API to setup a backing file should provide
the fuse_file that is expected to be setup for passthrough, so that
server will have an opportunity to react and not reply to the open
request with FOPEN_PASSTHROUGH.
Alternatively, the client can silently ignore FOPEN_PASSTHROUGH,
but that seems less ideal.

Thanks,
Amir.
