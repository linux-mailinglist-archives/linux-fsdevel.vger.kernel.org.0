Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47303442E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 13:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhCVMqm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 08:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbhCVMoe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 08:44:34 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E033FC061756;
        Mon, 22 Mar 2021 05:44:31 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id e8so13746052iok.5;
        Mon, 22 Mar 2021 05:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tx+8FwsejaTYxKwzQMimKUY8enUxzBYY0WcDHihEzc8=;
        b=HiDecJyY3S4O7PaPC+k5/Btua4Q6OwE2Ads6a5RBuLheOTlji2JrpfmkFdUfsXkKBl
         stqVEcIu2SKKNWbQbx0SixBaWIMj8f2jyA8d8jCCiJGIdOC1u1nTiyWaw5GZ0qaPptTz
         jiXYNKDvGer4NS2YKa50O+sKAiLx1O17ZN8Zv5hVG6V/kK8UQ12j3M9ZM14TW22AZoFc
         HweuB/MhPHBjOaStMvUop7X0JcBWWVAwuN+kkQtoHmMPeWKFutMqEf6j5yNhAnt8ceTf
         7/6DqGuPMGFeSAlVVKdILcxaQWRcgnpeIeaeMP1ABT/HhJIM+qLTTzAMLa0a5B9DeSEd
         w8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tx+8FwsejaTYxKwzQMimKUY8enUxzBYY0WcDHihEzc8=;
        b=ezispHi325HIA2hQQzbup3wYwLAZtJFP7d1KtHnUnFE12nVw2oMYlfm2ibG+uGQcoG
         GNc6l6UVyZt3dHgegIvMJvh1Ayz5w3ztd0naKRecSfOJZZtINsaVr+wpqW0sJyJJAtKA
         Ju5W0m/d1yy+YJtrkXB6xbYUeZsdJSA1eA8kxMei6rS5VdLLGQ1CLsUpq8hi3UVVywE5
         IXqBZiue/OtAjyXMr6yVc9Z+EALnvOJlI4rLkCeqOb8aLicr0oZ1LqtJg4xM8wdkx9Nd
         b4imoVATxWe+9SBvxK/GogYiP3VcVbJ59YZFL+FTwcUkB/HEFVo16X1mFOJ/JcymS4Kl
         V5QQ==
X-Gm-Message-State: AOAM533yow0rzqJsfFKRlD6kLBLf0XVwHVNIx9HXaflEt1TWgG5+vUSY
        SHQB2vfLFHGnTRSzxLYi6M3fdAJZeBM9T8v4X88=
X-Google-Smtp-Source: ABdhPJwdTpXTpgQBdf60V0sOFxsUEGAFf2zZ8rAHtxYXYbnR/zDiP4zBGKXAeE+98OHzezDaiRM2bGMPykP0WNtRUYk=
X-Received: by 2002:a5d:9f4a:: with SMTP id u10mr10623872iot.186.1616417071360;
 Mon, 22 Mar 2021 05:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210304112921.3996419-1-amir73il@gmail.com> <20210316155524.GD23532@quack2.suse.cz>
 <CAOQ4uxgCv42_xkKpRH-ApMOeFCWfQGGc11CKxUkHJq-Xf=HnYg@mail.gmail.com>
 <20210317114207.GB2541@quack2.suse.cz> <CAOQ4uxi7ZXJW3_6SN=vw_XJC+wy4eMTayN6X5yRy_HOV6323MA@mail.gmail.com>
 <20210317174532.cllfsiagoudoz42m@wittgenstein> <CAOQ4uxjCjapuAHbYuP8Q_k0XD59UmURbmkGC1qcPkPAgQbQ8DA@mail.gmail.com>
 <20210318143140.jxycfn3fpqntq34z@wittgenstein> <CAOQ4uxiRHwmxTKsLteH_sBW_dSPshVE8SohJYEmpszxaAwjEyg@mail.gmail.com>
 <20210319134043.c2wcpn4lbefrkhkg@wittgenstein> <CAOQ4uxhLYdWOUmpWP+c_JzVeGDbkJ5eUM+1-hhq7zFq23g5J1g@mail.gmail.com>
 <CAOQ4uxhetKeEZX=_iAcREjibaR0ZcOdeZyR8mFEoHM+WRsuVtg@mail.gmail.com>
In-Reply-To: <CAOQ4uxhetKeEZX=_iAcREjibaR0ZcOdeZyR8mFEoHM+WRsuVtg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 22 Mar 2021 14:44:20 +0200
Message-ID: <CAOQ4uxhfx012GtvXMfiaHSk1M7+gTqkz3LsT0i_cHLnZLMk8nw@mail.gmail.com>
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

On Sat, Mar 20, 2021 at 2:57 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> > > > The code that sits in linux-next can give you pretty much a drop-in
> > > > replacement of inotify and nothing more. See example code:
> > > > https://github.com/amir73il/inotify-tools/commits/fanotify_name_fid
> > >
> > > This is really great. Thank you for doing that work this will help quite
> > > a lot of use-cases and make things way simpler. I created a TODO to port
> > > our path-hotplug to this once this feature lands.
> > >
> >
> > FWIW, I just tried to build this branch on Ubuntu 20.04.2 with LTS kernel
> > and there were some build issues, so rebased my branch on upstream
> > inotify-tools to fix those build issues.
> >
> > I was not aware that the inotify-tools project is alive, I never intended
> > to upstream this demo code and never created a github pull request
> > but rebasing on upstream brought in some CI scripts, when I pushed the
> > branch to my github it triggered some tests that reported build failures on
> > Ubuntu 16.04 and 18.04.
> >
> > Anyway, there is a pre-rebase branch 'fanotify_name' and the post rebase
> > branch 'fanotify_name_fid'. You can try whichever works for you.

FYI, fixed the CI build errors on fanotify_name_fid branch.

> >
> > You can look at the test script src/test_demo.sh for usage example.
> > Or just cd into a writable directory and run the script to see the demo.
> > The demo determines whether to use a recursive watch or "global"
> > watch by the uid of the user.
> >
> > > >
> > > > > > If you think that is useful and you want to play with this feature I can
> > > > > > provide a WIP branch soon.
> > > > >
> > > > > I would like to first play with the support for unprivileged fanotify
> > > > > but sure, it does sound useful!
> > > >
> > > > Just so you have an idea what I am talking about, this is a very early
> > > > POC branch:
> > > > https://github.com/amir73il/linux/commits/fanotify_userns
> > >
> > > Thanks!  I'll try to pull this and take a look next week. I hope that's
> > > ok.
> > >
> >
> > Fine. I'm curious to know what it does.
> > Did not get to test it with userns yet :)
>
> Now tested FAN_MARK_FILESYSTEM watch on tmpfs mounted
> inside userns and works fine, with two wrinkles I needed to iron:
>
> 1. FAN_REPORT_FID not supported on tmpfs because tmpfs has
>     zero f_fsid (easy to fix)
> 2. open_by_handle_at() is not userns aware (can relax for
>     FS_USERNS_MOUNT fs)
>
> Pushed these two fixes to branch fanotify_userns.

Pushed another fix to mnt refcount bug in WIP and another commit to
add the last piece that could make fanotify usable for systemd-homed
setup - a filesystem watch filtered by mnt_userns (not tested yet).

One thing I am struggling with is the language to describe user ns
and idmapped mounts related logic. I have a feeling that I am getting
the vocabulary all wrong. See my commit message text below.
Editorial corrections would be appreciated.

Thanks,
Amir.

---

    fanotify: support sb mark filtered by idmapped mount

    For a group created inside userns, adding a mount mark is allowed
    if the mount is idmapped inside the group's userns and adding a
    filesystem mark is allowed if the filesystem was mounted inside the
    group's userns.

    Allow also adding a filesystem mark on a filesystem that is mounted
    in the group's userns via an idmapped mount.

    In that case, the mark is created with an internal flag, which indicates
    that events should be sent to the group only if they happened via an
    idmapped mount inside the group's userns.

    Signed-off-by: Amir Goldstein <amir73il@gmail.com>
