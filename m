Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A01D791C3D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 19:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237000AbjIDR5T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 13:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbjIDR5T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 13:57:19 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4616CA
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Sep 2023 10:57:15 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-5733aa10291so1214633eaf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Sep 2023 10:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693850235; x=1694455035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swkHmiUb0yhEMZkQvxpItqW1CYY4TW8bZX8jwtRrDks=;
        b=cb9tkM/iL4YSN4kL6EYaiuoh7iZHtH84Z8AbWBxKP/TM5mPZwhbu7wT60gMNRFJTFQ
         TLuzLbQUlwbkRCBvMRvDvPITSRO11TREHU54Xpw2o9pbCIH3JGVjFdu975rV1Razk7Zp
         k6Gaszje7/gmjZ/lQ4ZTgR681nWSbeekR/HhUuX1xCuhpmnm4E70hboPgkP8D/7WPHPI
         ia0qEytaAqL9NEU7lmhH5xk65gtnoMi2roa7HJ506sEebh1YtubFVIxjF+f6j0THst00
         qiAe3BN41iv1ZL94XdLlZGqCJqFWVk0vougJMxzAi31JPB92NQMebi+gd7t6PU2c8F4/
         DI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693850235; x=1694455035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=swkHmiUb0yhEMZkQvxpItqW1CYY4TW8bZX8jwtRrDks=;
        b=MHCsJzxQTK255RU63aPgPBDwfhWBtz8te4FKLGleK+nvqcSmrBUBB96sgYjLbJ3Pxd
         EFyuD9v3tp7vyv+d1aB0xzEtDzMZzZQVFRw+SWeOXHUxz0A/q+EBGUFvmGkDgb3b09Wl
         cpCKG5DpEFg22qdNUwUG7qf7c81P7tMd6T2mxwijq32r9mv2c1Loozh81al+/w8Hry/f
         Pz3XSLXn9YBjvhjl5rxOc/5SobLJwTSLsq69WqEPrW4fxSWuW0Np5H5qLxdXJLDS5XdO
         b0Qc58Bgqk4fP4NHVMfF42SLuArOic7qPwYPhbpQjyRr7ChX5c0H5Hc5Eqx5byB11Mrl
         z07A==
X-Gm-Message-State: AOJu0YwnmMmXXyCXe4OvXfJXsyT62bW1xW09BkWNlGaf6JJXX5EC1tpi
        0ph0Dr9oGyJYmSglgSy54mrKCqQzQc+vbjlxk+yjmg==
X-Google-Smtp-Source: AGHT+IHdOus5yMZIdY0V3oMaSqxbqstcsrA7CWMqnWsmMfZIlWsMuFuSAUCbK7FfY1M3ethbVj2G2I2D++Y+esaXCnE=
X-Received: by 2002:a05:6358:7e53:b0:139:b4c0:93c with SMTP id
 p19-20020a0563587e5300b00139b4c0093cmr13972089rwm.5.1693850234778; Mon, 04
 Sep 2023 10:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230831203647.558079-1-mclapinski@google.com>
 <20230831203647.558079-2-mclapinski@google.com> <20230901-lockt-erbfolge-e1f9a26f0d63@brauner>
 <CAAi7L5f1KYrAyCYLzUN0dSy6xuQCGcC7SQML4+KUdxnQ6RaFfg@mail.gmail.com>
 <202309011133.10D66D0785@keescook> <20230904-meistens-umeinander-3366194553a1@brauner>
In-Reply-To: <20230904-meistens-umeinander-3366194553a1@brauner>
From:   =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date:   Mon, 4 Sep 2023 19:57:03 +0200
Message-ID: <CAAi7L5eW1ZOfwvFz4b9As7-MkKyCgCQcG-41VMv6vfYpyRW_eA@mail.gmail.com>
Subject: Re: [PATCH 1/2] fcntl: add fcntl(F_CHECK_ORIGINAL_MEMFD)
To:     Christian Brauner <brauner@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Xu <jeffxu@google.com>, Aleksa Sarai <cyphar@cyphar.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 4, 2023 at 9:29=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Fri, Sep 01, 2023 at 11:34:32AM -0700, Kees Cook wrote:
> > On Fri, Sep 01, 2023 at 04:50:53PM +0200, Micha=C5=82 C=C5=82api=C5=84s=
ki wrote:
> > > On Fri, Sep 1, 2023 at 2:56=E2=80=AFPM Christian Brauner <brauner@ker=
nel.org> wrote:
> > > >
> > > > On Thu, Aug 31, 2023 at 10:36:46PM +0200, Michal Clapinski wrote:
> > > > > Add a way to check if an fd points to the memfd's original open f=
d
> > > > > (the one created by memfd_create).
> > > > > Useful because only the original open fd can be both writable and
> > > > > executable.
> > > > >
> > > > > Signed-off-by: Michal Clapinski <mclapinski@google.com>
> > > > > ---
> > > > >  fs/fcntl.c                 | 3 +++
> > > > >  include/uapi/linux/fcntl.h | 9 +++++++++
> > > > >  2 files changed, 12 insertions(+)
> > > > >
> > > > > diff --git a/fs/fcntl.c b/fs/fcntl.c
> > > > > index e871009f6c88..301527e07a4d 100644
> > > > > --- a/fs/fcntl.c
> > > > > +++ b/fs/fcntl.c
> > > > > @@ -419,6 +419,9 @@ static long do_fcntl(int fd, unsigned int cmd=
, unsigned long arg,
> > > > >       case F_SET_RW_HINT:
> > > > >               err =3D fcntl_rw_hint(filp, cmd, arg);
> > > > >               break;
> > > > > +     case F_CHECK_ORIGINAL_MEMFD:
> > > > > +             err =3D !(filp->f_mode & FMODE_WRITER);
> > > > > +             break;
> > > >
> > > > Honestly, make this an ioctl on memfds. This is so specific that it
> > > > really doesn't belong into fcntl().
> > >
> > > I've never touched ioctls but if I'm correct, I can't just add it to
> > > memfd. I would have to add it to the underlying fs, so hugetlbfs and
> > > shmem (which I think can be defined as ramfs so also there). File
> > > sealing fcntl is already memfd specific. Are you sure ioctl will be a
> > > better idea?
>
> fcntl() should be generic. Frankly, the sealing stuff should've gone
> into an ioctl as well and only upgraded to a fcntl() once multiple fd
> types support it.
>

But ioctl is good for stuff related to the underlying fs, which this
isn't. I'm worried if I rewrite it as an ioctl and put it in 3
different places, the maintainers of shmem, hugetlbfs and ramfs will
tell me to rewrite it as an fcntl. If a new filesystem pops up that
can be used as the backend for memfd, the ioctl will also have to be
added there.

> >
> > Does this check "mean" anything for other files? Because if it's
> > generically useful (and got renamed) it maybe would be right for
> > fcntl...
>
> For regular files it just means that the file has gotten write access to
> the underlying fs and we use this flag to release the necessary
> refcounts/protections once the file is closed.
>
> If this check has any meaning beyond that than it only has meaning for
> memfd. I'm also not sure why this checks FMODE_WRITER and not
> FMODE_WRITE as FMODE_WRITER is almost an entirely internal thing that
> only very specific codepaths need to know about.

If you reopen the memfd via /proc/<pid>/fd/ with O_RDWR, both file
objects (the original and the reopened one) have FMODE_WRITE, so
knowing if the flag is set gives me nothing. FMODE_WRITER is the only
difference between the original fd and the reopened one. This flag
also dictates whether `inode->i_writecount` will be decremented on
close (in `put_file_access`) which influences exec()ability of the
other fd. It surprised me too that this flag theoretically means
"write access to underlying fs" but it's used to determine whether to
decrement i_writecount.
