Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815E979E6AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 13:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240127AbjIML0f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 07:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240112AbjIML0e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:26:34 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044DF19B3
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 04:26:30 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-450f8f1368cso133612137.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 04:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694604389; x=1695209189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwE40sJjoPcc15DhMGEmaXI0Xw/O6FpsHFKxViIXT/M=;
        b=gBLtf4px6C2EtGGDqWgBV1CzhcOU4VQWh2b0I/6ntRUPq6Lh6tWb69Oivd8p13tCLK
         T0AXfFEGyxgMByap/QWuk2fRs/589Vio71vl6XD8RlTfMQiioYTvQ09RQlLZ9Ihkx2e0
         O2P5fdZuSV+OUrFB8gI22Nkj9Wrl5N/viHgR3fZVzTpkn2Qpe+jTD0uyZtDVTs/Y96Sz
         G5lqhYAFpzHV8BcAgr/AaKe4Ex8eS5b5AxgXj1g5Ch2v+I+YFCJ+VR7+TrByWmJuV+CQ
         m5hIOBCAiow63wAFy/9r7WZ2JR7dQKBcC0VTLu1vZ3EvWIHwJs/pTQrjQ2Ot+R/gB/Di
         HySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694604389; x=1695209189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dwE40sJjoPcc15DhMGEmaXI0Xw/O6FpsHFKxViIXT/M=;
        b=D4kOklH5xlwIlP5W1/p63epZgYV/Ws6F53dxWazCUSCmFfUHdTl4tlZO3Nbn5Jz60n
         4oUjuaC6l1KwOyFgOug0WM0TXrttj4n1Ye2fJXA8ntC4z2eroUscpD2/BtX20mayt6U8
         zcYswolFwF07S06Nm78yh17Vbho45zI4jqE8TZdPbj/+PWFqT5CbVxkgmf/Y+9WZwefn
         MB4nxGiGhABLIP+Dv0NIGfC1ZuHVVVSwbqi4QrWVK+gn6PC9WAl/hEVxpbV7XrD6jHJq
         c4xcoXYyM03Jz6hw0Yjy3hSIhdG7pZFUhrsWQuZ8QmPSLA7oTgyaDvPEVCrHMJUkfUlJ
         SXdQ==
X-Gm-Message-State: AOJu0Yxh65DI4oCHMwmKjAhLAMoR4FidDhpP1NJvM9NYUaEcq+lfUmch
        7ouvOwfXcgEfSQHaI5aoVezSj0nA4AwvM6Uj8zk=
X-Google-Smtp-Source: AGHT+IHa2M24mSGTgC/2sEXTxp6dy8P2TgX2To2HZbfVt2Sg3Sj49M6zNanAfY8Yjh2sBKNTwxmK7mjf/ZQ3lxb5J74=
X-Received: by 2002:a05:6102:2c5:b0:450:de69:1a6a with SMTP id
 h5-20020a05610202c500b00450de691a6amr1561821vsh.8.1694604388956; Wed, 13 Sep
 2023 04:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230912185408.3343163-1-amir73il@gmail.com> <20230913-sticken-warnzeichen-099bceebc54d@brauner>
In-Reply-To: <20230913-sticken-warnzeichen-099bceebc54d@brauner>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 13 Sep 2023 14:26:17 +0300
Message-ID: <CAOQ4uxiDpMkR-45m9X6AinK50oK5fMBsvmQfHW94U40ngJWV=Q@mail.gmail.com>
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

On Wed, Sep 13, 2023 at 11:37=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Tue, Sep 12, 2023 at 09:54:08PM +0300, Amir Goldstein wrote:
> > Overlayfs stores its files data in backing files on other filesystems.
> >
> > Factor out some common helpers to perform io to backing files, that wil=
l
> > later be reused by fuse passthrough code.
> >
> > Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
> > Link: https://lore.kernel.org/r/CAJfpeguhmZbjP3JLqtUy0AdWaHOkAPWeP827BB=
WwRFEAUgnUcQ@mail.gmail.com
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Miklos,
> >
> > This is the re-factoring that you suggested in the FUSE passthrough
> > patches discussion linked above.
> >
> > This patch is based on the overlayfs prep patch set I just posted [1].
> >
> > Although overlayfs currently is the only user of these backing file
> > helpers, I am sending this patch to a wider audience in case other
> > filesystem developers want to comment on the abstraction.
> >
> > We could perhaps later considering moving backing_file_open() helper
> > and related code to backing_file.c.
> >
> > In any case, if there are no objections, I plan to queue this work
> > for 6.7 via the overlayfs tree.
> >
> > Thanks,
> > Amir.
> >
> > [1] https://lore.kernel.org/linux-unionfs/20230912173653.3317828-1-amir=
73il@gmail.com/
> >
> >
> >  MAINTAINERS                  |   2 +
> >  fs/Kconfig                   |   4 +
> >  fs/Makefile                  |   1 +
> >  fs/backing_file.c            | 160 +++++++++++++++++++++++++++++++++++
> >  fs/overlayfs/Kconfig         |   1 +
> >  fs/overlayfs/file.c          | 137 ++----------------------------
> >  fs/overlayfs/overlayfs.h     |   2 -
> >  fs/overlayfs/super.c         |  11 +--
> >  include/linux/backing_file.h |  22 +++++
> >  9 files changed, 199 insertions(+), 141 deletions(-)
> >  create mode 100644 fs/backing_file.c
> >  create mode 100644 include/linux/backing_file.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 90f13281d297..4e1d21773e0e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16092,7 +16092,9 @@ L:    linux-unionfs@vger.kernel.org
> >  S:   Supported
> >  T:   git git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.gi=
t
> >  F:   Documentation/filesystems/overlayfs.rst
> > +F:   fs/backing_file.c
> >  F:   fs/overlayfs/
> > +F:   include/linux/backing_file.h
>
> I'd like to do this slightly differently, please. All vfs infra goes
> through vfs trees

OK. it will take a bit more git collaboration for a new
infra that is not used by any fs yet, but it's fine by me.

> but for new infra like this where someone steps up to
> be a maintainer we add a new section (like bpf or networking does):
>
> VFS [BACKING FILE]
> M:      Miklos Szeredi <miklos@szeredi.hu>
> M:      Amir Goldstein <amir73il@gmail.com>
> F:      fs/backing_file.c
> F:      include/linux/backing_file.h
> L:      linux-fsdevel@vger.kernel.org
> S:      Maintained

That sounds good.

Thanks,
Amir.
