Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A915341F3B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 15:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhCSOVb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 10:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhCSOV3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 10:21:29 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A87C06174A;
        Fri, 19 Mar 2021 07:21:29 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id e8so6259001iok.5;
        Fri, 19 Mar 2021 07:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dwE0qt0FlUFF8JoMdn7egAuryxQVcNL7exhu+ZVpDJc=;
        b=PPRsb/y1bi5DZWddDkVMMVxiklZZg0ixRxcLehArlxZTjXDlIv0+W4+jZdKcpNGF57
         0KKXXf+2gy0/B1wgaVpKC8trUO3rER/9g77s7xISgI4jsx9f9gnHpNPNjaG2u4dgM0xx
         QPdoDdKWf6j4s3t/Z3AMM0wa6Acil0PbWq9h/bwfg+aY7RUgVgxtyOmS1wgN7eIwgByr
         /+kbADobKn3sTY/WhA6Z43n3OvLr54oaYpz2DH75WX9DdbIRKx72YUU8Gyl3vEhIjVpe
         GRjP2lJXmjvBYSya/5Ppz11koXjfxtwR3R13ScNsSz3lv8cvqsjBz3XM/gUhPn1Eut/2
         JLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dwE0qt0FlUFF8JoMdn7egAuryxQVcNL7exhu+ZVpDJc=;
        b=aFu7fYA8ZIONEK3zwLa+73WTmc0Hgw6x2kc/gwNKIOEr8t7hPA6wHIH7Tz+hw1zU2y
         TIHuktPWACqnUT1bIKu/sJKzTSSErs38ffTHvx75JILEQdD1m+DMsLwlEIdnXzV26WlU
         cMHAk/n80tkVI1uG0TccHvMdisrosI5BKaYz3dIW7oarwK+IlfKk1Ie0UEFLBpApE5AA
         lkfbsz9Ozk3RPjZyBr2IOcqMCiRpu2vzqFwVVW7pk4uZYtMVW6pYnBP3pX/Jf+hXZJTI
         YiNt0tf2psH1CiRX5BR47OzvnczGwPSY/pPXTk/iltMSTyfXKSqOL+e4UwOSX8iY1eFA
         FlHw==
X-Gm-Message-State: AOAM532j2Ew+D0Q3fFKmk6IU0kEL5ue7WKZa0MYInF6tZ+irhPONcFAp
        ZyT6biKvj7lU2o7ufoK6httcMnT0xUrzbJiwkcI=
X-Google-Smtp-Source: ABdhPJyRMqLRB3Ava3LI8SEOYwcvdcFzqwlLEavQTP6JrvgYg/Mb2Z5gmWrP1G6irp/2JJtbSp2GOov9VYvRrSR2qJQ=
X-Received: by 2002:a02:9382:: with SMTP id z2mr1615964jah.120.1616163688966;
 Fri, 19 Mar 2021 07:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210304112921.3996419-1-amir73il@gmail.com> <20210316155524.GD23532@quack2.suse.cz>
 <CAOQ4uxgCv42_xkKpRH-ApMOeFCWfQGGc11CKxUkHJq-Xf=HnYg@mail.gmail.com>
 <20210317114207.GB2541@quack2.suse.cz> <CAOQ4uxi7ZXJW3_6SN=vw_XJC+wy4eMTayN6X5yRy_HOV6323MA@mail.gmail.com>
 <20210317174532.cllfsiagoudoz42m@wittgenstein> <CAOQ4uxjCjapuAHbYuP8Q_k0XD59UmURbmkGC1qcPkPAgQbQ8DA@mail.gmail.com>
 <20210318143140.jxycfn3fpqntq34z@wittgenstein> <CAOQ4uxiRHwmxTKsLteH_sBW_dSPshVE8SohJYEmpszxaAwjEyg@mail.gmail.com>
 <20210319134043.c2wcpn4lbefrkhkg@wittgenstein>
In-Reply-To: <20210319134043.c2wcpn4lbefrkhkg@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 19 Mar 2021 16:21:17 +0200
Message-ID: <CAOQ4uxhLYdWOUmpWP+c_JzVeGDbkJ5eUM+1-hhq7zFq23g5J1g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] unprivileged fanotify listener
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 19, 2021 at 3:40 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Thu, Mar 18, 2021 at 06:48:11PM +0200, Amir Goldstein wrote:
> > [...]
> >
> > I understand the use case.
> >
> > > I'd rather have something that allows me to mirror
> > >
> > > /home/jdoe
> > >
> > > recursively directly. But maybe I'm misunderstanding fanotify and it
> > > can't really help us but I thought that subtree watches might.
> > >
> >
> > There are no subtree watches. They are still a holy grale for fanotify...
> > There are filesystem and mnt watches and the latter support far fewer
> > events (only events for operations that carry the path argument).
> >
> > With filesystem watches, you can get events for all mkdirs and you can
> > figure out the created path, but you'd have to do all the filtering in
> > userspace.
> >
> > What I am trying to create is "filtered" filesystem watches and the filter needs
> > to be efficient enough so the watcher will not incur too big of a penalty
> > on all the operations in the filesystem.
> >
> > Thanks to your mnt_userns changes, implementing a filter to intercept
> > (say) mkdir calles on a specific mnt_userns should be quite simple, but
> > filtering by "path" (i.e. /home/jdoe/some/path) will still need to happen in
> > userspace.
> >
> > This narrows the problem to the nested container manager that will only
> > need to filter events which happened via mounts under its control.
> >
> > [...]
> >
> > > > there shouldn't be a problem to setup userns filtered watches in order to
> > > > be notified on all the events that happen via those idmapped mounts
> > > > and filtering by "subtree" is not needed.
> > > > I am clearly far from understanding the big picture.
> > >
> > > I think I need to refamiliarize myself with what "subtree" watches do.
> > > Maybe I misunderstood what they do. I'll take a look.
> > >
> >
> > You will not find them :-)
>
> Heh. :)
>
> >
> > [...]
> >
> > > > Currently, (upstream) only init_userns CAP_SYS_ADMIN can setup
> > > > fanotify watches.
> > > > In linux-next, unprivileged user can already setup inode watches
> > > > (i.e. like inotify).
> > >
> > > Just to clarify: you mean "unprivileged" as in non-root users in
> > > init_user_ns and therefore also users in non-init userns. That's what
> >
> > Correct.
> >
> > > inotify allows you. This would probably allows us to use fanotify
> > > instead of the hand-rolled recursive notify watching we currently do and
> > > that I linked to above.
> > >
> >
> > The code that sits in linux-next can give you pretty much a drop-in
> > replacement of inotify and nothing more. See example code:
> > https://github.com/amir73il/inotify-tools/commits/fanotify_name_fid
>
> This is really great. Thank you for doing that work this will help quite
> a lot of use-cases and make things way simpler. I created a TODO to port
> our path-hotplug to this once this feature lands.
>

FWIW, I just tried to build this branch on Ubuntu 20.04.2 with LTS kernel
and there were some build issues, so rebased my branch on upstream
inotify-tools to fix those build issues.

I was not aware that the inotify-tools project is alive, I never intended
to upstream this demo code and never created a github pull request
but rebasing on upstream brought in some CI scripts, when I pushed the
branch to my github it triggered some tests that reported build failures on
Ubuntu 16.04 and 18.04.

Anyway, there is a pre-rebase branch 'fanotify_name' and the post rebase
branch 'fanotify_name_fid'. You can try whichever works for you.

You can look at the test script src/test_demo.sh for usage example.
Or just cd into a writable directory and run the script to see the demo.
The demo determines whether to use a recursive watch or "global"
watch by the uid of the user.

> >
> > > > If you think that is useful and you want to play with this feature I can
> > > > provide a WIP branch soon.
> > >
> > > I would like to first play with the support for unprivileged fanotify
> > > but sure, it does sound useful!
> >
> > Just so you have an idea what I am talking about, this is a very early
> > POC branch:
> > https://github.com/amir73il/linux/commits/fanotify_userns
>
> Thanks!  I'll try to pull this and take a look next week. I hope that's
> ok.
>

Fine. I'm curious to know what it does.
Did not get to test it with userns yet :)

Thanks,
Amir.
