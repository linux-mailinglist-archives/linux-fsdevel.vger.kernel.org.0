Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68726D4B0F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 16:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbjDCOwX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 10:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbjDCOwG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:52:06 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C0D29BCD
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 07:51:49 -0700 (PDT)
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com [209.85.219.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BA3B83F23A
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 14:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1680533507;
        bh=XBz1zna37ysInm5qeEZxPeU0HrWb4OHRI+Pz2i9OGHc=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=bcBGm75mUP1+EgKudfIRC72QtMZSAvRStaB488pqxSolGC19Dj8ZtjUy5GYmCQ5Ir
         gPyZsC5WSyhHFo7xF3mRW83W4Ri73847v/hzvpQHh36KNvNeAjHHp0haLcgJYQX4uJ
         uN0hqTxMbShZm6NWrYSIakx4cllgWoPcrfODjXtSgpzeNYnzSbF1KfJ5U2Pe35iiQV
         OUFAbdBwJbfMKvRqSrKvgIKfW+bS0FPWGwPoT78g0BZlq9mn+uAR5z/0R2hICm2xdB
         o6DBbykHyzqApNxZYuxQ4F7IaTAPLBy5VEXKA83FT2TBLminGQA0BQmpYFKglMmkRU
         ueWUeOpMfeb/Q==
Received: by mail-yb1-f198.google.com with SMTP id z4-20020a25bb04000000b00b392ae70300so29200722ybg.21
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Apr 2023 07:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680533506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBz1zna37ysInm5qeEZxPeU0HrWb4OHRI+Pz2i9OGHc=;
        b=Sh3LnvTN3rTEFuK+Uyzy116Wv8KpFgByJHm+iU/H6BAXzNaoBaN+5o+oehg7D/CeMb
         qIf/YPs4pj73kSOhc1kbHw7vuwUR1DTUbz7o+6HsO7pbxBaXDdUskl3JYMko/sNu9uZT
         4qhHCW4PP+oBad2VWUCR9LqYY/E+6NyxyZGyYdgGuxrZFTrK3Bt4BjmY2T8R3WEELWO4
         6EzkpFc6cM2lQBZTwMv/P/55B/utjiSXvE4SpGIpJctgsi31bOlAdKFPA/iuPNSi+Zqg
         5E7MRjR+9NBTt09r+bFBJTk9g7fZp814MalFC3frb6zShncva16Aa4/D53BTpTnakoNw
         /NQQ==
X-Gm-Message-State: AAQBX9d6NzhmGK204/v4EBaif18GLVX+X3bI24x92X8r0DwmLJXFXpbb
        ROVGuXIqu9rzuyFLbbLbTkcjGDvOcJl9HDX2ItH6352xRQH3s01aEWMdIZGhAvWwYxD0B/jGrNg
        6rtMvOVuRMCDy95xHgDf+K9tsBlXeZr+ADI24WyIICSn2YS0zI8Nsq4REaRWE9zU60jtY1Q==
X-Received: by 2002:a25:d784:0:b0:b76:3b21:b1dc with SMTP id o126-20020a25d784000000b00b763b21b1dcmr11288527ybg.0.1680533505809;
        Mon, 03 Apr 2023 07:51:45 -0700 (PDT)
X-Google-Smtp-Source: AKy350aqgVvrDZpj3W0dpqiva+R1snhDKUQ7qQHwf84isS5iLyZponbAZ23XQDzrn0oLSQL21JAYXzfwIO48DtPuJpY=
X-Received: by 2002:a25:d784:0:b0:b76:3b21:b1dc with SMTP id
 o126-20020a25d784000000b00b763b21b1dcmr11288511ybg.0.1680533505602; Mon, 03
 Apr 2023 07:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
 <20230220193754.470330-8-aleksandr.mikhalitsyn@canonical.com>
 <381a19bb-d17e-b48b-8259-6287dbe170df@fastmail.fm> <CAEivzxf8HKs2FJwTohzGVcb0TRNy9QJbEALC3dni3zx+tOb9Gg@mail.gmail.com>
In-Reply-To: <CAEivzxf8HKs2FJwTohzGVcb0TRNy9QJbEALC3dni3zx+tOb9Gg@mail.gmail.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Mon, 3 Apr 2023 16:51:34 +0200
Message-ID: <CAEivzxdjjJmwPaxe5miWPxun_ZCRt-wjuCCA2nzOWWyzZZUuOg@mail.gmail.com>
Subject: Re: [RFC PATCH 7/9] fuse: add fuse device ioctl(FUSE_DEV_IOC_REINIT)
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     mszeredi@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        criu@openvz.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 6, 2023 at 3:09=E2=80=AFPM Aleksandr Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> On Fri, Mar 3, 2023 at 8:26=E2=80=AFPM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
> >
> >
> >
> > On 2/20/23 20:37, Alexander Mikhalitsyn wrote:
> > > This ioctl aborts fuse connection and then reinitializes it,
> > > sends FUSE_INIT request to allow a new userspace daemon
> > > to pick up the fuse connection.
> > >
> > > Cc: Miklos Szeredi <mszeredi@redhat.com>
> > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > Cc: Amir Goldstein <amir73il@gmail.com>
> > > Cc: St=C3=83=C2=A9phane Graber <stgraber@ubuntu.com>
> > > Cc: Seth Forshee <sforshee@kernel.org>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Andrei Vagin <avagin@gmail.com>
> > > Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> > > Cc: linux-fsdevel@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: criu@openvz.org
> > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical=
.com>
> > > ---
> > >   fs/fuse/dev.c             | 132 +++++++++++++++++++++++++++++++++++=
+++
> > >   include/uapi/linux/fuse.h |   1 +
> > >   2 files changed, 133 insertions(+)
> > >
> > > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > > index 737764c2295e..0f53ffd63957 100644
> > > --- a/fs/fuse/dev.c
> > > +++ b/fs/fuse/dev.c
> > > @@ -2187,6 +2187,112 @@ void fuse_abort_conn(struct fuse_conn *fc)
> > >   }
> > >   EXPORT_SYMBOL_GPL(fuse_abort_conn);
> > >
> > > +static int fuse_reinit_conn(struct fuse_conn *fc)
> > > +{
> > > +     struct fuse_iqueue *fiq =3D &fc->iq;
> > > +     struct fuse_dev *fud;
> > > +     unsigned int i;
> > > +
> > > +     if (fc->conn_gen + 1 < fc->conn_gen)
> > > +             return -EOVERFLOW;
> > > +
> > > +     fuse_abort_conn(fc);
> > > +     fuse_wait_aborted(fc);
> >
> > Shouldn't this also try to flush all data first?

Dear Bernd,

I've reviewed this place 2nd time and I'm not sure that we have to
perform any flushing there, because userspace daemon can be dead or
stuck.
Technically, if userspace knows that daemon is alive then it can call
fsync/sync before doing reinit.

What do you think about it?

Kind regards,
Alex

>
> I think we should. Thanks for pointing to that!
>
> I've read all your comments and I'll prepare -v2 series soon.
>
> Thanks a lot, Bernd!
>
> >
