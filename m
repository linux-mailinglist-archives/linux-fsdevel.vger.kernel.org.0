Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0B32C98F5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 09:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgLAIQ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 03:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgLAIQ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 03:16:56 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC7DC0613CF;
        Tue,  1 Dec 2020 00:16:10 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id x15so843364ilq.1;
        Tue, 01 Dec 2020 00:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JJBEGn1P+Ge8sdELJY1SxC5m5DkXTZqsQEXJ8bthTEg=;
        b=gPwHnvVsfUtBAw3vqWFxmVqo4kOj/D27DwmALS2zS4PQ/EU2eEkJNQCY6Eu8T7YKCM
         GCBh9Mk2LM/vQrXkPWuUFxpISu0NzMyyGMgyufTjGsEz7MkciAkJktMv598hYs/vBm/S
         6jP/sL80/BH5pAloYrfgiBLRFH3mbqOyO7KtC2Efe2VEkF4K+BoqCgVXBy5hjqPjSksC
         hax2XdK0yklbJ4HK43HKDmBkhqc2KRQjE8ous2U46Tc5Pe5qgJXzBO3OXi2TqzKqQgeG
         aOXjoXIPkKBOlIUrYv0mh1TV1qqjNWc5CZTA/cxv0K2CIkmkVmmYppR/WDqEZaFWwHH2
         Nf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JJBEGn1P+Ge8sdELJY1SxC5m5DkXTZqsQEXJ8bthTEg=;
        b=ASxXDjOhTaYKMT4SeXVpzUiGRz6mhR+TCzZc/G4kGJU/zfhZWS+2MRdYyPTq8uWtSB
         sy+X8nQGf2r/qYd/N6jItC48g3HRGHPo2AMOMS6Bp7EAWXT/XPdL2EzPTJiSClIWzMM5
         I+NEyOngJqGEqudNKeFvP1ejtScP26UuNDOtUdLQs1FUzaSK1rq2f9jZhoayWSOJJFGJ
         yY+ET/jUGUYYDmz5BCbvXaNNeiudZInahEJvZKITI8atw/ecEMDGgQbyvz6Ng5lbjI1X
         yJN50mrjECThqVL44DJ55pl4u4fwylU/fN5FmbmwQS3qPl8vsL1uip80s4T7qhqQn+WY
         GoQw==
X-Gm-Message-State: AOAM532N2p68SkcCRs4ir9Xn5fBTj04TwnoXZhv8oBE5FLW1pLT/sI4o
        M6K6dcjwrpWDIhU05M+eAWF4eT90TFUrRIijUdk1H48wLI8=
X-Google-Smtp-Source: ABdhPJz5YsFDuVpKwW29Aa42G84aVoTwe57F8tIV09aNiRDbiOddPg0Nk5Dy8STqg8mRF6gL+yGO+Zv04n34WqkWCkQ=
X-Received: by 2002:a92:5e42:: with SMTP id s63mr1631638ilb.250.1606810569704;
 Tue, 01 Dec 2020 00:16:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605723568.git.osandov@fb.com> <977fd16687d8b0474fd9c442f79c23f53783e403.1605723568.git.osandov@fb.com>
 <CAOQ4uxiaWAT6kOkxgMgeYEcOBMsc=HtmSwssMXg0Nn=rbkZRGA@mail.gmail.com>
 <CAG48ez3rLFOWpaQcJxEE7BNXvxHvUQnvhhY-xyR2bZfhnmwQrg@mail.gmail.com> <X8VHcZs6paUvQGkk@relinquished.localdomain>
In-Reply-To: <X8VHcZs6paUvQGkk@relinquished.localdomain>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 1 Dec 2020 10:15:58 +0200
Message-ID: <CAOQ4uxhLG1b03nYEgefcAybvMem26mjG=6dcrD5djjYFSa-q1g@mail.gmail.com>
Subject: Re: [PATCH v6 02/11] fs: add O_ALLOW_ENCODED open flag
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Jann Horn <jannh@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 30, 2020 at 9:26 PM Omar Sandoval <osandov@osandov.com> wrote:
>
> On Sat, Nov 21, 2020 at 12:41:23AM +0100, Jann Horn wrote:
> > On Thu, Nov 19, 2020 at 8:03 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > > On Wed, Nov 18, 2020 at 9:18 PM Omar Sandoval <osandov@osandov.com> wrote:
> > > > The upcoming RWF_ENCODED operation introduces some security concerns:
> > > >
> > > > 1. Compressed writes will pass arbitrary data to decompression
> > > >    algorithms in the kernel.
> > > > 2. Compressed reads can leak truncated/hole punched data.
> > > >
> > > > Therefore, we need to require privilege for RWF_ENCODED. It's not
> > > > possible to do the permissions checks at the time of the read or write
> > > > because, e.g., io_uring submits IO from a worker thread. So, add an open
> > > > flag which requires CAP_SYS_ADMIN. It can also be set and cleared with
> > > > fcntl(). The flag is not cleared in any way on fork or exec. It must be
> > > > combined with O_CLOEXEC when opening to avoid accidental leaks (if
> > > > needed, it may be set without O_CLOEXEC by using fnctl()).
> > > >
> > > > Note that the usual issue that unknown open flags are ignored doesn't
> > > > really matter for O_ALLOW_ENCODED; if the kernel doesn't support
> > > > O_ALLOW_ENCODED, then it doesn't support RWF_ENCODED, either.
> > [...]
> > > > diff --git a/fs/open.c b/fs/open.c
> > > > index 9af548fb841b..f2863aaf78e7 100644
> > > > --- a/fs/open.c
> > > > +++ b/fs/open.c
> > > > @@ -1040,6 +1040,13 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
> > > >                 acc_mode = 0;
> > > >         }
> > > >
> > > > +       /*
> > > > +        * O_ALLOW_ENCODED must be combined with O_CLOEXEC to avoid accidentally
> > > > +        * leaking encoded I/O privileges.
> > > > +        */
> > > > +       if ((how->flags & (O_ALLOW_ENCODED | O_CLOEXEC)) == O_ALLOW_ENCODED)
> > > > +               return -EINVAL;
> > > > +
> > >
> > >
> > > dup() can also result in accidental leak.
> > > We could fail dup() of fd without O_CLOEXEC. Should we?
> > >
> > > If we should than what error code should it be? We could return EPERM,
> > > but since we do allow to clear O_CLOEXEC or set O_ALLOW_ENCODED
> > > after open, EPERM seems a tad harsh.
> > > EINVAL seems inappropriate because the error has nothing to do with
> > > input args of dup() and EBADF would also be confusing.
> >
> > This seems very arbitrary to me. Sure, leaking these file descriptors
> > wouldn't be great, but there are plenty of other types of file
> > descriptors that are probably more sensitive. (Writable file
> > descriptors to databases, to important configuration files, to
> > io_uring instances, and so on.) So I don't see why this specific
> > feature should impose such special rules on it.
>
> I agree with Jann. I'm okay with the O_CLOEXEC-on-open requirement if it
> makes people more comfortable, but I don't think we should be bending
> over backwards to block it anywhere else.

I'm fine with or without the O_CLOEXEC-on-open requirement.
Just pointing out the weirdness.

Thanks,
Amir.
