Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A42A5511BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 09:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239500AbiFTHqB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 03:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238584AbiFTHqA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:46:00 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E79BFD19;
        Mon, 20 Jun 2022 00:45:59 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id e20so9866077vso.4;
        Mon, 20 Jun 2022 00:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GxXkUt6216ao0IAs5e/9DRYdl00qb60wg/J8RDVkjsk=;
        b=BLoaFYruaso9jWufq53oE/bl/3unP9Q++L3TPsiXzyhkwByY2wB9NQa5HZ0g0k+M7s
         AudoV3xYGuQoPC0q5fc+0TA4sGzoE+3pnq1HaAgK0S7kyLzm4dzdewRXzv5D5TqGanlf
         8tsV78Hk1R1+hXfhZAgmhsoOiVL++Y0xgF010mIUA0iS+3dv8gTWA8J594l73F4YAmSI
         VR3phYw8ZtQOBX/SR2ZHQ05abA8Y/ESqSwHWmca38tRDN4zwd6Tl+pTqfjnlJDg/HowB
         sxmTWII67lJlNR5CahWM1jEFficpNQjqfK1A7M5/KajIiZp07YRPasTvma+Xhiq3rJ5s
         T0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GxXkUt6216ao0IAs5e/9DRYdl00qb60wg/J8RDVkjsk=;
        b=eq611Q0ZHoCSYEKZMdedo2F5dUzj2sy6qPLc7t9ScnlO9qk006uHLr7/WCBpwS3wjW
         FpmXSq+y/VT4iD5cWffZqo17ghWzA4k0wYYtsfFLygdNAGtToIhyjykAmd/BFVzyECvz
         BkzgSLSCoksTxSC6xWhHLdXA5Ee4H0s18D/Eqd27K33jbb8xrXAko66c9MlMb11cRRs7
         kV3vF3baxUBv1m13cLvfB8s0TzMu64b3Vg5uECM3xfzEUA22H2V9TgqoWwr5KTCzoyxI
         1iBTKDj7Acat11WBSv+N7igrAcHG59zVpAQL6Rxqbzh6VtNSFifoMsJCjG80esiccBM7
         3nJQ==
X-Gm-Message-State: AJIora9TmsSdUoP7IDkAkRh+iwr+7gGz+0QgZV2LeuRoI8BpIFivH4qi
        nVwudDe/tKM0SVhKjJowSvUKwP/BhahAsxIudh8=
X-Google-Smtp-Source: AGRyM1s299FTFvsyu9Uwre7pgytXJpjIIjZeSrR0sXJ+2tYosrWCOR3r3VoXZ9I49k8CK+xY4SDdRTGeCsKayEdCgOs=
X-Received: by 2002:a67:c113:0:b0:354:3ef9:3f79 with SMTP id
 d19-20020a67c113000000b003543ef93f79mr252323vsj.3.1655711158361; Mon, 20 Jun
 2022 00:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220607153139.35588-1-cgzones@googlemail.com>
 <20220608112728.b4xrdppxqmyqmtwf@wittgenstein> <CAOQ4uxipD6khNUYuZT80WUa0KOMdyyP0ia55uhmeRCLj4NBicg@mail.gmail.com>
 <20220608124808.uylo5lntzfgxxmns@wittgenstein> <CAOQ4uxjP7kC95ou56wabVhQcc2vkNcD-8usYhLhbLOoJZ-jkOw@mail.gmail.com>
 <20220618031805.nmgiuapuqeblm3ba@senku> <CAOQ4uxg6QLJ26pX8emXmUvq6jDDEH_Qq=Z4RPUK-jGLsZpHzfg@mail.gmail.com>
 <20220620060741.3clikqadotq2p5ja@senku>
In-Reply-To: <20220620060741.3clikqadotq2p5ja@senku>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 20 Jun 2022 10:45:46 +0300
Message-ID: <CAOQ4uxhq8HVoM=6O_H-uowv65m6tLAPUj2a_r3-CWpiX-48MoQ@mail.gmail.com>
Subject: Re: [RFC PATCH] f*xattr: allow O_PATH descriptors
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > > The goal would be that the semantics of fooat(<fd>, AT_EMPTY_PATH) and
> > > foo(/proc/self/fd/<fd>) should always be identical, and the current
> > > semantics of /proc/self/fd/<fd> are too leaky so we shouldn't always
> > > assume that keeping them makes sense (the most obvious example is being
> > > able to do tricks to open /proc/$pid/exe as O_RDWR).
> >
> > Please make a note that I have applications relying on current magic symlink
> > semantics w.r.t setxattr() and other metadata operations, and the libselinux
> > commit linked from the patch commit message proves that magic symlink
> > semantics are used in the wild, so it is not likely that those semantics could
> > be changed, unless userspace breakage could be justified by fixing a serious
> > security issue (i.e. open /proc/$pid/exe as O_RDWR).
>
> Agreed. We also use magiclinks for similar TOCTOU-protection purposes in
> runc (as does lxc) as well as in libpathrs so I'm aware we need to be
> careful about changing existing behaviours. I would prefer to have the
> default be as restrictive as possible, but naturally back-compat is
> more important.
>
> > > I suspect that the long-term solution would be to have more upgrade
> > > masks so that userspace can opt-in to not allowing any kind of
> > > (metadata) write access through a particular file descriptor. You're
> > > quite right that we have several metadata write AT_EMPTY_PATH APIs, and
> > > so we can't retroactively block /everything/ but we should try to come
> > > up with less leaky rules by default if it won't break userspace.
> >
> > Ok, let me try to say this in my own words using an example to see that
> > we are all on the same page:
> >
> > - lsetxattr(PATH_TO_FILE,..) has inherent TOCTOU races
> > - fsetxattr(fd,...) is not applicable for symbolic links
>
> While I agree with Christian's concerns about making O_PATH descriptors
> more leaky, if userspace already relies on this through /proc/self/fd/$x
> then there's not much we can do about it other than having an opt-out
> available in openat2(2). Having the option to disable this stuff to
> avoid making O_PATH descriptors less safe as a mechanism for passing
> around "capability-less" file handles should make most people happy
> (with the note that ideally we would not be *adding* capabilities to
> O_PATH we don't need to).
>
> > - setxattr("/proc/self/fd/<fd>",...) is the current API to avoid TOCTOU races
> >   when setting xattr on symbolic links
> > - setxattrat(o_path_fd, "", ..., AT_EMPTY_PATH) is proposed as a the
> >   "new API" for setting xattr on symlinks (and special files)
>
> If this is a usecase we need to support then we may as well just re-use
> fsetxattr() since it's basically an *at(2) syscall already (and I don't
> see why we'd want to split up the capabilities between two similar
> *at(2)-like syscalls). Though this does come with the above caveats that
> we need to have the opt-outs available if we're going to enshrine this
> as intentional part of the ABI.


Christian preferred that new functionality be added with a new API
and I agree that this is nicer and more explicit.

The bigger question IMO is, whether fsomething() should stay identical
to somethingat(,,,AT_EMPTY_PATH). I don't think that it should.

To me, open(path,O_PATH)+somethingat(,,,AT_EMPTY_PATH) is identical
to something(path) - it just breaks the path resolution and operation to two
distinguished steps.

fsomething() was traditionally used for "really" open fds, so if we don't need
to, we better not relax it further by allowing O_PATH, but that's just one
opinion.

>
> > - The new API is going to be more strict than the old magic symlink API
> > - *If* it turns out to not break user applications, old API can also become
> >   more strict to align with new API (unlikely the case for setxattr())
> > - This will allow sandboxed containers to opt-out of the "old API", by
> >   restricting access to /proc/self/fd and to implement more fine grained
> >   control over which metadata operations are allowed on an O_PATH fd
> >
> > Did I understand the plan correctly?
>
> Yup, except I don't think we need setxattrat(2).
>
> > Do you agree with me that the plan to keep AT_EMPTY_PATH and magic
> > symlink semantics may not be realistic?
>
> To clarify -- my view is that if any current /proc/self/fd/$n semantic
> needs to be maintained then I would prefer that the proc-less method of
> doing it (such as through AT_EMPTY_PATH et al) would have the same
> capability and semantics. There are some cases where the current
> /proc/self/fd/$n semantics need to be fixed (such as the /proc/$pid/exe
> example) and in that case the proc-less semantics also need to be made
> safe.
>
> While I would like us to restrict O_PATH as much as possible, if
> userspace already depends on certain behaviour then we may not be able
> to do much about it. Having an opt-out would be very important since
> enshrining these leaky behaviours (which seem to have been overlooked)
> means we need to consider how userspace can opt out of them.
>
> Unfortunately, it should be noted that due to the "magical" nature of
> nd_jump_link(), I'm not sure how happy Al Viro will be with the kinds of
> restrictions necessary. Even my current (quite limited) upgrade-mask
> patchset has to do a fair bit of work to unify the semantics of
> magic-links and openat(O_EMPTYPATH) -- expanding this to all *at(2)
> syscalls might be quite painful. (There are also several handfuls of
> semantic questions which need to be answered about magic-link modes and
> whether for other *at(2) operations we may need even more complicated
> rules or even a re-thinking of my current approach.)
>

The question remains, regarding the $SUBJECT patch,
is it fair to block it and deprive libselinux of a non buggy API
until such time that all the details around masking O_PATH fds
will be made clear and the new API implemented?

There is no guarantee this will ever happen, so it does not seem
reasonable to me.

To be a reasonable reaction to the currently broken API is
to either accept the patch as is or request that setxattrat()
will be added to provide the new functionality.

Thanks,
Amir.
