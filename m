Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41454342CE8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 13:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhCTM5b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 08:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCTM5R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 08:57:17 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D789C061762;
        Sat, 20 Mar 2021 05:57:17 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id u10so10549912ilb.0;
        Sat, 20 Mar 2021 05:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aaz5vIn5nArItqTRFs02OpD1fPWq0lVp2I+2//tPwmE=;
        b=e0mBNUGs5Pm9m68S9vqDUZ6s2mbVvqyEsryA2N4v0UG9AABaya6JAbS3bE5vuff/cg
         4ls8ugBmiv5AUG136MKeyA44RKmfxs0DmJAF/7MMAZKabVVKlKJBrPIob3me6SFv0TCk
         thcICgbvnnXPlZZWTMMqhCs3GD/Vp1dMHI2Ru5rZ3D6PQ+WeKwUw+BnSChBBA7AjSq/I
         ZbR8vIrfXpJbnAV9aTSu+N/PGSHj3MijYFkrRHqbzfmoetvN7jf1UnvovW71fk2uBgIm
         hgYCV5377cv+tJYc47mOzCFQtvhQIS/j6WBJdNdSZdasQ11S65NSh3lZh9mgQrmiwMso
         2NZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aaz5vIn5nArItqTRFs02OpD1fPWq0lVp2I+2//tPwmE=;
        b=T3HZnwQfn0GSIyfqSl/vakiyKKIIZNQTqJsyJal0JCXud6EMrOvjX/7NqKGPEXWYfo
         jt+AL0o3huBeDPjx08dN0L4CBXkil0jNRpM+NnLasmVTxReJM1kHfQRtNBaINNJF6NC8
         w7MwbIrj8D761CxVG9hqhpza2bbOxxJD6+8FDnuA8HJ2smyjvU2delvQBhszrBJpY0JB
         /8fEDJmyhyPWGDPFPgQ/Fz7b3yN/WKzbF0CV/NtjB6MRK90up5+XrWal/ZfywJHOpawu
         IX1SRLgqIJIMRB+v0QmV2B0ljNlh1oEE35LhLIB8JXJ9b2PDxzVR5AIarIFviZCe5NG3
         sMKg==
X-Gm-Message-State: AOAM531m98nWV2pGncvvSwu/Z84HRPX67eT8zUFl0MhkMpLCLbvY33PP
        OPsax+34BaVVHVl9h67C8cAhDN694cAwlyPliDMEx2w4/NI=
X-Google-Smtp-Source: ABdhPJyLFgFGvqV7T6clWmJMWQ3UrgZs99iYt4w/+E3129OthjlVw7w0r9abwwHb5WfKUlTN2XAM/tdS+D5lPcRVPBo=
X-Received: by 2002:a92:da48:: with SMTP id p8mr5702355ilq.137.1616245036519;
 Sat, 20 Mar 2021 05:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210304112921.3996419-1-amir73il@gmail.com> <20210316155524.GD23532@quack2.suse.cz>
 <CAOQ4uxgCv42_xkKpRH-ApMOeFCWfQGGc11CKxUkHJq-Xf=HnYg@mail.gmail.com>
 <20210317114207.GB2541@quack2.suse.cz> <CAOQ4uxi7ZXJW3_6SN=vw_XJC+wy4eMTayN6X5yRy_HOV6323MA@mail.gmail.com>
 <20210317174532.cllfsiagoudoz42m@wittgenstein> <CAOQ4uxjCjapuAHbYuP8Q_k0XD59UmURbmkGC1qcPkPAgQbQ8DA@mail.gmail.com>
 <20210318143140.jxycfn3fpqntq34z@wittgenstein> <CAOQ4uxiRHwmxTKsLteH_sBW_dSPshVE8SohJYEmpszxaAwjEyg@mail.gmail.com>
 <20210319134043.c2wcpn4lbefrkhkg@wittgenstein> <CAOQ4uxhLYdWOUmpWP+c_JzVeGDbkJ5eUM+1-hhq7zFq23g5J1g@mail.gmail.com>
In-Reply-To: <CAOQ4uxhLYdWOUmpWP+c_JzVeGDbkJ5eUM+1-hhq7zFq23g5J1g@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 20 Mar 2021 14:57:05 +0200
Message-ID: <CAOQ4uxhetKeEZX=_iAcREjibaR0ZcOdeZyR8mFEoHM+WRsuVtg@mail.gmail.com>
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

> > > The code that sits in linux-next can give you pretty much a drop-in
> > > replacement of inotify and nothing more. See example code:
> > > https://github.com/amir73il/inotify-tools/commits/fanotify_name_fid
> >
> > This is really great. Thank you for doing that work this will help quite
> > a lot of use-cases and make things way simpler. I created a TODO to port
> > our path-hotplug to this once this feature lands.
> >
>
> FWIW, I just tried to build this branch on Ubuntu 20.04.2 with LTS kernel
> and there were some build issues, so rebased my branch on upstream
> inotify-tools to fix those build issues.
>
> I was not aware that the inotify-tools project is alive, I never intended
> to upstream this demo code and never created a github pull request
> but rebasing on upstream brought in some CI scripts, when I pushed the
> branch to my github it triggered some tests that reported build failures on
> Ubuntu 16.04 and 18.04.
>
> Anyway, there is a pre-rebase branch 'fanotify_name' and the post rebase
> branch 'fanotify_name_fid'. You can try whichever works for you.
>
> You can look at the test script src/test_demo.sh for usage example.
> Or just cd into a writable directory and run the script to see the demo.
> The demo determines whether to use a recursive watch or "global"
> watch by the uid of the user.
>
> > >
> > > > > If you think that is useful and you want to play with this feature I can
> > > > > provide a WIP branch soon.
> > > >
> > > > I would like to first play with the support for unprivileged fanotify
> > > > but sure, it does sound useful!
> > >
> > > Just so you have an idea what I am talking about, this is a very early
> > > POC branch:
> > > https://github.com/amir73il/linux/commits/fanotify_userns
> >
> > Thanks!  I'll try to pull this and take a look next week. I hope that's
> > ok.
> >
>
> Fine. I'm curious to know what it does.
> Did not get to test it with userns yet :)

Now tested FAN_MARK_FILESYSTEM watch on tmpfs mounted
inside userns and works fine, with two wrinkles I needed to iron:

1. FAN_REPORT_FID not supported on tmpfs because tmpfs has
    zero f_fsid (easy to fix)
2. open_by_handle_at() is not userns aware (can relax for
    FS_USERNS_MOUNT fs)

Pushed these two fixes to branch fanotify_userns.

Thanks,
Amir.
