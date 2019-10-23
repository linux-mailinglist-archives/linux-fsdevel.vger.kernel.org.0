Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6C57E11EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 08:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733273AbfJWGGh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 02:06:37 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40983 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfJWGGh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 02:06:37 -0400
Received: by mail-yw1-f67.google.com with SMTP id o195so2272218ywd.8;
        Tue, 22 Oct 2019 23:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kv+6IoQR6bEB2iX/xqg9xXvx4UX3aidmtCoBvt739tg=;
        b=LwkqCuhwjrZ+s2dT41pwHds7Laitwn8zRsM4BRLBieEW3LRdNfgO0pyGQhChE/9XZo
         FFzsPqUrJX93YsVOu89BexM0esXwfeCBR1SpacmgZDQq6Ev1tw3TGGsHr/qpeP6u3eYW
         vKUmaXm53lCNy4hshKSkjN6VrKUQVlR6jVd9OUc5i4kAQLycuVUnwPpR5kufnzEBDgOf
         p/+VRrQ8KSo9t8yZBZbNsTnzzbwZZks3xLIi+NWVJqELZqZDJ3ymOB917eWMbygb/lAE
         T86SHOTYC0+GePfAegXYIfHILkN/5jF1qNwM1FEdHkwW4DR/RQpF0YZF0Jx/WvVNUl06
         GR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kv+6IoQR6bEB2iX/xqg9xXvx4UX3aidmtCoBvt739tg=;
        b=QysdAxntw5Fn0qaVOzEy8oM3y2BkyFyrvlD30j/aaYA2HofH7q23aX3ZsVgOJrTu7B
         Rpj2Pck9RqVWy3Q6y1uoWtBheJdqz6CMm/oJI6PVqlwfB+kJ8gjc3prpams7HtxDsd/f
         2G2jUlgVUeDUHPSvYr1gX9kCD/lVrkK363sw+bYUxSouUF6hPRl7v5jm+0a/Hnt59RxD
         zFkMPCh2MMhl9fzhGT7BZIQ/LJZwg1tnBGB/lhmnic39TMAJARyuETqrr8WHKUZH5vEu
         jtEkPW6myZuqLp/4IA2iI+MORwgNfsw5uQgrlpCfH+kC1FQpOsbumfIDIPGUEoJ6QpdD
         Scpw==
X-Gm-Message-State: APjAAAV+Z8wVz71QE8yjC3Mh0m++8oWyLm4i580VLH/LPRaM5DyoYAVz
        soPPPecuvkp450bpFEWSi8OjWCKX1W5kvqtaR8w=
X-Google-Smtp-Source: APXvYqyO/UpMuAPduTSsdjCSuogzNS7cxq3uHwOvGAm5Zm4mlxa1F5AFrdhhyVClN9rWcZjE2ekn4dtvmNntGOUnLP0=
X-Received: by 2002:a81:4a02:: with SMTP id x2mr1537190ywa.31.1571810796157;
 Tue, 22 Oct 2019 23:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571164762.git.osandov@fb.com> <c7e8f93596fee7bb818dc0edf29f484036be1abb.1571164851.git.osandov@fb.com>
 <CAOQ4uxh_pZSiMmD=46Mc3o0GE+svXuoC155P_9FGJXdsE4cweg@mail.gmail.com>
 <20191021185356.GB81648@vader> <CAOQ4uxgm6MWwCDO5stUwOKKSq7Ot4-Sc96F1Evc6ra5qBE+-wA@mail.gmail.com>
 <20191023044430.alow65tnodgnu5um@yavin.dot.cyphar.com>
In-Reply-To: <20191023044430.alow65tnodgnu5um@yavin.dot.cyphar.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 23 Oct 2019 09:06:24 +0300
Message-ID: <CAOQ4uxjyNZhyU9yEYkuMnD0o=sU1vJMOYJAzjV7FDjG45gaevg@mail.gmail.com>
Subject: Re: [PATCH man-pages] Document encoded I/O
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Linux API <linux-api@vger.kernel.org>, kernel-team@fb.com,
        Theodore Tso <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> >
> > No, I see why you choose to add the flag to open(2).
> > I have no objection.
> >
> > I once had a crazy thought how to add new open flags
> > in a non racy manner without adding a new syscall,
> > but as you wrote, this is not relevant for O_ALLOW_ENCODED.
> >
> > Something like:
> >
> > /*
> >  * Old kernels silently ignore unsupported open flags.
> >  * New kernels that gets __O_CHECK_NEWFLAGS do
> >  * the proper checking for unsupported flags AND set the
> >  * flag __O_HAVE_NEWFLAGS.
> >  */
> > #define O_FLAG1 __O_CHECK_NEWFLAGS|__O_FLAG1
> > #define O_HAVE_FLAG1 __O_HAVE_NEWFLAGS|__O_FLAG1
> >
> > fd = open(path, O_FLAG1);
> > if (fd < 0)
> >     return -errno;
> > flags = fcntl(fd, F_GETFL, 0);
> > if (flags < 0)
> >     return flags;
> > if ((flags & O_HAVE_FLAG1) != O_HAVE_FLAG1) {
> >     close(fd);
> >     return -EINVAL;
> > }
>
> You don't need to add __O_HAVE_NEWFLAGS to do this -- this already works
> today for userspace to check whether a flag works properly
> (specifically, __O_FLAG1 will only be set if __O_FLAG1 is supported --
> otherwise it gets cleared during build_open_flags).

That's a behavior of quite recent kernels since
629e014bb834 fs: completely ignore unknown open flags
and maybe some stable kernels. Real old kernels don't have that luxury.

>
> The problem with adding new flags is that an *old* program running on a
> *new* kernel could pass a garbage flag (__O_CHECK_NEWFLAGS for instance)
> that causes an error only on the new kernel.
>

That's a theoretic problem. Same as O_PATH|O_TMPFILE.
Show me a real life program that passes garbage files to open.

> The only real solution to this (and several other problems) is
> openat2().

No argue about that. Come on, let's get it merged ;-)

> As for O_ALLOW_ENCODED -- the current semantics (-EPERM if it
> is set without CAP_SYS_ADMIN) *will* cause backwards compatibility
> issues for programs that have garbage flags set...
>

Again, that's theoretical.
In practice, O_ALLOW_ENCODED can work with open()/openat().
In fact, even if O_ALLOW_ENCODED gets merged after openat2(),
I don't think it should be forbidden by open()/openat(), right?
Do in that sense, O_ALLOW_ENCODED does not depend on openat2().

Thanks,
Amir.
