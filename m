Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFB67A981F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 19:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjIURbh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 13:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjIURbX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:31:23 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B1312E
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 09:57:43 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3ab244e7113so760619b6e.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 09:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695315449; x=1695920249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDQlj4oipKP0ojZKuNY07pjyHuFMwfCQQrM/CUZVpds=;
        b=JOVeXKPwQ/4mMc5QH4FmBdsyD/5LGZii8dsPeJoHzSW6wORPhRq7GNq+oChFR7e4DA
         XMn2SXd0fV1ddQ/QCQca/SNoZ65vpnDblaUNAsGm84crs5FV2uypobRjVN086Prh0Ezw
         jNFdPdpZHXxtcIT1gu6rOqh18tDiPCiNhfdAHUTxPHr0SvptAymOMEzNM8r9GfomHh59
         qJRhtm+OXYNYTNYooyl8am48WnD58lXqeiVA6PUuuPi0ltCNnCfATQwhdB/4PlWUl9wP
         GI46tBcZIAPN1OzC9vHTfCdMaOkWcU9jIwA4jAykt1577KUOwJ9A7tI90WtmkMoVvpUG
         0BdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315449; x=1695920249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDQlj4oipKP0ojZKuNY07pjyHuFMwfCQQrM/CUZVpds=;
        b=JPmk1uRHQLjislYoIOTECOnOZaHAr3I4Q7I5JHh/yNz303qK33WjPu7wk0VSq1DzTW
         jHmpCoaXIVU884hclV1eOADm+C4x7vBx/k07sHGhFYGmKQ6gPl6Uew6AA7VjKSOo+Us3
         rRundip0d8bgzkj77ajkOG8vTHrlOJJDAWzVi1jON+645fSdD+/hAc9f5S1EbtBvIlo6
         yFefSciUwHd4WVAvuA2Xj4GPSI6wKWtcb5r8shmgqQEKjIpQRCeK61DVciUiJ2COpRkx
         maJ2wnYnHZekVJ27F1IWSOsp9UoeNAk6AjcpKwzxmjo4OavjS5wg2Q8C43AA9MjGKpEJ
         kcoA==
X-Gm-Message-State: AOJu0YwdoZ5QIO+Ui/c/dTcDqquX/3181AtbZhp6Tku+vv7W2RfZKj7V
        8xusOKc2ybwXyaQg7q4ru50bZuU7OZ8iScgP/pAxQ0TebCw=
X-Google-Smtp-Source: AGHT+IF+wHlo+3hc5SSJbJNcWSdkBEn9s4sDltX3aQ+na86yuda6OHfZsYjRCDDkuI76yrkvcNKBUX9C7rAvG6r3uUE=
X-Received: by 2002:a67:ef8a:0:b0:452:7128:f56d with SMTP id
 r10-20020a67ef8a000000b004527128f56dmr5058923vsp.0.1695311515326; Thu, 21 Sep
 2023 08:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230912185408.3343163-1-amir73il@gmail.com> <20230913-galaxie-irrfahrt-a815cf10ebdc@brauner>
 <CAOQ4uxgta6y7fi_hfrF4fDvHA2RjeA+JTCb-eSaORZOY6XZbVQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxgta6y7fi_hfrF4fDvHA2RjeA+JTCb-eSaORZOY6XZbVQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 21 Sep 2023 18:51:44 +0300
Message-ID: <CAOQ4uxh616M=QdQ+AurOL+G5wJyXeq+auAzu06u=O+LoCE0KpQ@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 13, 2023 at 2:24=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Wed, Sep 13, 2023 at 11:29=E2=80=AFAM Christian Brauner <brauner@kerne=
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
> >
> > I'm sorry but I'm missing mountains of context.
> > How is that related to the backing file stuff exactly?
> > The backing file stuff has this unpleasant
> >
> > file->f_inode =3D=3D real_inode !=3D file->f_path->dentry->d_inode
> >
> > that we all agree is something we really don't like. Is FUSE trying to
> > do the same thing and build an read_iter/write_iter abstraction around
> > it? I really really hope that's not the case.
>
> That is not the case.
> The commonality between FUSE passthrough and overlayfs is that
> a "virtual" file (i.e. ovl/fuse), which has no backing blockdev of its ow=
n
> "forwards" the io requests to a backing file on another filesystem.
>
> The name "backing file" is therefore a pretty accurate description
> for both cases. HOWEVER, FUSE does not need to use the
> backing_file struct to hold an alternative path, so FUSE backing files
> do not have FMODE_BACKING, same as cachefiles uses backing
> files, but does not use the FMODE_BACKING/file_backing struct.
>
> Yes, it's a bit of a naming mess.
> I don't have any good ideas on how to do better naming.
> Ideally, we will get rid of struct backing_file, so we won't need
> to care about the confusing names...
>

Alas, my explanation about FUSE passthrough backing files
turned out to be inaccurate.

FUSE IO passthrough to backing file is very similar to overlayfs
IO "passthrough" to lower/upper backing file.

Which creates the same problem w.r.t mmap'ing the FUSE file
to the underlying backing file inode.
That problem in overlayfs caused the inception of the fake path file
now embedded in the backing_file object.
So yes, FUSE is trying to do the same thing.

However, the helpers in this patch are not dealing with the fake path
aspect of those backing files specifically.
They are common code for a "stacked fs" (i.e. s_stack_depth > 0)
which delegates IO to files on the underlying fs.

I will give it some thought on how we can at least narrow the amount
of filesystem code that could be exposed to those fake path files.
The read/write/splice iterators do not really need to operate of fake path
files, so this is something that I can try to avoid.

Thanks,
Amir.
