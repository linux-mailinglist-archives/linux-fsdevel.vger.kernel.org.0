Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9EF344D2A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 18:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhCVRWZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 13:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbhCVRWU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:22:20 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0ADC061574;
        Mon, 22 Mar 2021 10:22:20 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id v26so14762038iox.11;
        Mon, 22 Mar 2021 10:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rPH2TP1ud5sxYXi4yLtOgCjSrqlriSXx6tlw55SJBFg=;
        b=J9cj8XpfarEl95wH4kTBxChNRrRCI7/hFwGgahv7rbDnjAr8pLgo9COeGMbq2wjU0Y
         ZJjnwtTDTM5VJoDnekqr028/Iedm0uloLmrJEl1BvPan25rgx53qzI7Lq+NlZ32cdJJh
         FG1tcic02qnKmsncWQosIkLrOKfdjAYoCa2F+XLp3aksQEXyVVOsWKAGYimHZeNFQ3rC
         rv1wSeEzuQYtLGsdpOLlCG2ZW5wQ7HU5uNH1o1VyoraDd8BjDU2CFxgZUMPwoeSYDm67
         sKew2LcK039iDEvNhwt2wQxQtv2e6qDKEVPCgoOr+SLaCdbRx2pnEQF0NE/8mvIyopKH
         4PfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rPH2TP1ud5sxYXi4yLtOgCjSrqlriSXx6tlw55SJBFg=;
        b=fYzyfUMuS7srLqv21ZXKMEkVY5lsPw0StXf4ez9R2S5BkzvE4D3ucs+RpCjWYpe7zF
         EdaQ2LniGqzAMDXfWDgvb2wuZoNMwCtqb6S9io8lVLJYl6TkcU9a15SizMjCBLrrhb17
         SKiM26dbtgvqACk6WYR26RcVbj6p5yPqUrz+HM9cha87i2YWyg/Mp+V1BwRW8WT6pnRf
         s4MMvgUasej+aNFERt0eom4B/P1BqXmGXd2kd1KcSnKEPlAQn7QKqHOXfLizPV8gMYhe
         n+jJHF1Xh2Wvj8iNdrZ0SP/tYHXZyPmp+yCrCwkN9AxhVz8dvUDuuTUhjF92dc6OJJB6
         ZnZQ==
X-Gm-Message-State: AOAM531czOxt0Aqni+fCdETB6k4EWmNOZ03Qze7VmNiOtP6pnRH66P0e
        sCgKC4usuQgKzvs0Ff5owUotV4gMts4/Jf5LSnU=
X-Google-Smtp-Source: ABdhPJyS2chI6K9pPa4PZzaxvTzKsElfvRgC2QUH/DaTmPAhHUcrI7gQdj2d8t5yvP/yyO0oHbe8U2BixHYk9iJpkNs=
X-Received: by 2002:a02:74a:: with SMTP id f71mr414219jaf.30.1616433739529;
 Mon, 22 Mar 2021 10:22:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210317114207.GB2541@quack2.suse.cz> <CAOQ4uxi7ZXJW3_6SN=vw_XJC+wy4eMTayN6X5yRy_HOV6323MA@mail.gmail.com>
 <20210317174532.cllfsiagoudoz42m@wittgenstein> <CAOQ4uxjCjapuAHbYuP8Q_k0XD59UmURbmkGC1qcPkPAgQbQ8DA@mail.gmail.com>
 <20210318143140.jxycfn3fpqntq34z@wittgenstein> <CAOQ4uxiRHwmxTKsLteH_sBW_dSPshVE8SohJYEmpszxaAwjEyg@mail.gmail.com>
 <20210319134043.c2wcpn4lbefrkhkg@wittgenstein> <CAOQ4uxhLYdWOUmpWP+c_JzVeGDbkJ5eUM+1-hhq7zFq23g5J1g@mail.gmail.com>
 <CAOQ4uxhetKeEZX=_iAcREjibaR0ZcOdeZyR8mFEoHM+WRsuVtg@mail.gmail.com>
 <CAOQ4uxhfx012GtvXMfiaHSk1M7+gTqkz3LsT0i_cHLnZLMk8nw@mail.gmail.com> <20210322162855.mz7h2hvececu4rma@wittgenstein>
In-Reply-To: <20210322162855.mz7h2hvececu4rma@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 22 Mar 2021 19:22:08 +0200
Message-ID: <CAOQ4uxgzp81DdV0LXR1hXauLag7jYZTA=iFTJF+SKFj=wiqYYw@mail.gmail.com>
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

On Mon, Mar 22, 2021 at 6:28 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Mon, Mar 22, 2021 at 02:44:20PM +0200, Amir Goldstein wrote:
> > On Sat, Mar 20, 2021 at 2:57 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > > > > The code that sits in linux-next can give you pretty much a drop-in
> > > > > > replacement of inotify and nothing more. See example code:
> > > > > > https://github.com/amir73il/inotify-tools/commits/fanotify_name_fid
> > > > >
> > > > > This is really great. Thank you for doing that work this will help quite
> > > > > a lot of use-cases and make things way simpler. I created a TODO to port
> > > > > our path-hotplug to this once this feature lands.
> > > > >
> > > >
> > > > FWIW, I just tried to build this branch on Ubuntu 20.04.2 with LTS kernel
> > > > and there were some build issues, so rebased my branch on upstream
> > > > inotify-tools to fix those build issues.
> > > >
> > > > I was not aware that the inotify-tools project is alive, I never intended
> > > > to upstream this demo code and never created a github pull request
> > > > but rebasing on upstream brought in some CI scripts, when I pushed the
> > > > branch to my github it triggered some tests that reported build failures on
> > > > Ubuntu 16.04 and 18.04.
> > > >
> > > > Anyway, there is a pre-rebase branch 'fanotify_name' and the post rebase
> > > > branch 'fanotify_name_fid'. You can try whichever works for you.
> >
> > FYI, fixed the CI build errors on fanotify_name_fid branch.
> >
> > > >
> > > > You can look at the test script src/test_demo.sh for usage example.
> > > > Or just cd into a writable directory and run the script to see the demo.
> > > > The demo determines whether to use a recursive watch or "global"
> > > > watch by the uid of the user.
> > > >
> > > > > >
> > > > > > > > If you think that is useful and you want to play with this feature I can
> > > > > > > > provide a WIP branch soon.
> > > > > > >
> > > > > > > I would like to first play with the support for unprivileged fanotify
> > > > > > > but sure, it does sound useful!
> > > > > >
> > > > > > Just so you have an idea what I am talking about, this is a very early
> > > > > > POC branch:
> > > > > > https://github.com/amir73il/linux/commits/fanotify_userns
> > > > >
> > > > > Thanks!  I'll try to pull this and take a look next week. I hope that's
> > > > > ok.
> > > > >
> > > >
> > > > Fine. I'm curious to know what it does.
> > > > Did not get to test it with userns yet :)
> > >
> > > Now tested FAN_MARK_FILESYSTEM watch on tmpfs mounted
> > > inside userns and works fine, with two wrinkles I needed to iron:
> > >
> > > 1. FAN_REPORT_FID not supported on tmpfs because tmpfs has
> > >     zero f_fsid (easy to fix)
> > > 2. open_by_handle_at() is not userns aware (can relax for
> > >     FS_USERNS_MOUNT fs)
> > >
> > > Pushed these two fixes to branch fanotify_userns.
> >
> > Pushed another fix to mnt refcount bug in WIP and another commit to
> > add the last piece that could make fanotify usable for systemd-homed
> > setup - a filesystem watch filtered by mnt_userns (not tested yet).
>
> Sounds interesting.
>
> So I'm looking and commenting on that branch a little.
> One general question, when fanotify FANOTIFY_PERM_EVENTS is set fanotify
> will return a file descriptor (for relevant events) referring to the
> file/directory that e.g. got created. And there are no permissions
> checks other than the capable(CAP_SYS_ADMIN) check when the fanotify
> instance is created, right?
>

Correct.
fanotify_init() enforces that in a few maybe not so obvious steps:

1. Either CAP_SYS_ADMIN or fid_mode (no file descriptor in event):

        if (!capable(CAP_SYS_ADMIN)) {
                /*
                 * An unprivileged user can setup an fanotify group with
                 * limited functionality - an unprivileged group is limited to
                 * notification events with file handles and it cannot use
                 * unlimited queue/marks.
                 */
                if ((flags & FANOTIFY_ADMIN_INIT_FLAGS) || !fid_mode)
                        return -EPERM;
        }

2. fid_mode is not supported for high priority classes:

        if (fid_mode && class != FAN_CLASS_NOTIF)
                return -EINVAL;

3. Permission events are only allowed for high priority classes:
        /*
         * group->priority == FS_PRIO_0 == FAN_CLASS_NOTIF.  These are not
         * allowed to set permissions events.
         */
        ret = -EINVAL;
        if (mask & FANOTIFY_PERM_EVENTS &&
            group->priority == FS_PRIO_0)

You may want to look at the summary of all the limitations on
unprivileged listener here:
https://github.com/amir73il/man-pages/blob/fanotify_unpriv/man2/fanotify_init.2#L400

Thanks,
Amir.
