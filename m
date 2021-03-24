Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A61A347BA3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 16:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbhCXPGP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 11:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236480AbhCXPF5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:05:57 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB54C061763;
        Wed, 24 Mar 2021 08:05:57 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id r193so21816828ior.9;
        Wed, 24 Mar 2021 08:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rxJNaw8C7ayCx/gjJ/PWUgSwy3kpSmsxitzf9jz+190=;
        b=ZBaoNm6/3tQSyepO0WOOzzDzgLpihJ5Tj09xZ/Lafhn+BwYnYsFOjwSrC5YaDB9/j5
         JJj4QsxIaMmwev+zLeWqeGJHquqX+sIsMwNjqbpKONVdHnQ/5rarEhv6I3zcjHxNe7wP
         gAUvklGrJfHvL+KU7dPSRevPNGG51maJMccMXmkjE+HQPT+++JYS8bBinWa1KKOax9Fs
         lCHazkS+trEQRaJ+WIyT9f6ofBayx1ukFkLVR/ew/NrPnoatbXmJnajiK9nydC1XF/iK
         PkK0tz9ItTErCo89SUYXlsHWb6QvS/ZCgCadclIdUv+Mtdi/T+hoknYxvbwf6GzF25FU
         HxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rxJNaw8C7ayCx/gjJ/PWUgSwy3kpSmsxitzf9jz+190=;
        b=Aq2FrqPRTmny4BJWgk1J51E2USOGVJ3ezzJUHbNXzLP2G94bSNLlcdku2bGCYFzqrl
         LVzGp907w7PJOEZ8C7FLmuf1t+4YtgKwdQmZ/41iEV5Yz6G2CDuu9Ue0eBtBUqniHCVO
         iYw4h9JV1qwsKz3ZIv8nPFrss14PFfs0/Ddk9CxgHBcpZZ5rdvSrOoQOv8tEPMWY0GzF
         bXys6/nCOxS/AW0Re+466aLAcI/gz4t+ZRzSZsBtY8qsRQXt88o6HOcKfrRi6d4iYJMp
         FYeWHpW+px0XhfZ8FNPgLiNKeCN64pUMhHILLSAHdCWr8YmIAvbslZ0xy6oRmOrwBy5X
         28ww==
X-Gm-Message-State: AOAM531uQohqUSwYAFSAO3iYOz5xasgEYWVcxxop3E7WCrW9Qyga0cL5
        yfbIw6vZAMsP9hLsuMSJTHDkbY9KpM70QqcZOinjXUXgGaE=
X-Google-Smtp-Source: ABdhPJwwnDMvFAM+CO4W0KRW1ED8sOVT5mdfH2Z5K7bJmnG1XUeTloBkg4j+bGHA6eHCB3Nl1f1R7Hx61L0nXysZVRo=
X-Received: by 2002:a02:9382:: with SMTP id z2mr3394301jah.120.1616598356447;
 Wed, 24 Mar 2021 08:05:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxi7ZXJW3_6SN=vw_XJC+wy4eMTayN6X5yRy_HOV6323MA@mail.gmail.com>
 <20210317174532.cllfsiagoudoz42m@wittgenstein> <CAOQ4uxjCjapuAHbYuP8Q_k0XD59UmURbmkGC1qcPkPAgQbQ8DA@mail.gmail.com>
 <20210318143140.jxycfn3fpqntq34z@wittgenstein> <CAOQ4uxiRHwmxTKsLteH_sBW_dSPshVE8SohJYEmpszxaAwjEyg@mail.gmail.com>
 <20210319134043.c2wcpn4lbefrkhkg@wittgenstein> <CAOQ4uxhLYdWOUmpWP+c_JzVeGDbkJ5eUM+1-hhq7zFq23g5J1g@mail.gmail.com>
 <CAOQ4uxhetKeEZX=_iAcREjibaR0ZcOdeZyR8mFEoHM+WRsuVtg@mail.gmail.com>
 <CAOQ4uxhfx012GtvXMfiaHSk1M7+gTqkz3LsT0i_cHLnZLMk8nw@mail.gmail.com>
 <CAOQ4uxhFU=H8db35JMhfR+A5qDkmohQ01AWH995xeBAKuuPhzA@mail.gmail.com> <20210324143230.y36hga35xvpdb3ct@wittgenstein>
In-Reply-To: <20210324143230.y36hga35xvpdb3ct@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 24 Mar 2021 17:05:45 +0200
Message-ID: <CAOQ4uxiPYbEk1N_7nxXMP7kz+KMnyH+0GqpJS36FR+-v9sHrcg@mail.gmail.com>
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

On Wed, Mar 24, 2021 at 4:32 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Wed, Mar 24, 2021 at 03:57:12PM +0200, Amir Goldstein wrote:
> > > > Now tested FAN_MARK_FILESYSTEM watch on tmpfs mounted
> > > > inside userns and works fine, with two wrinkles I needed to iron:
> > > >
> > > > 1. FAN_REPORT_FID not supported on tmpfs because tmpfs has
> > > >     zero f_fsid (easy to fix)
> > > > 2. open_by_handle_at() is not userns aware (can relax for
> > > >     FS_USERNS_MOUNT fs)
> > > >
> > > > Pushed these two fixes to branch fanotify_userns.
> > >
> > > Pushed another fix to mnt refcount bug in WIP and another commit to
> > > add the last piece that could make fanotify usable for systemd-homed
> > > setup - a filesystem watch filtered by mnt_userns (not tested yet).
> > >
> >
> > Now I used mount-idmapped (from xfstest) to test that last piece.
> > Found a minor bug and pushed a fix.
> >
> > It is working as expected, that is filtering only the events generated via
> > the idmapped mount. However, because the listener I tested is capable in
> > the mapped userns and not in the sb userns, the listener cannot
> > open_ny_handle_at(), so the result is not as useful as one might hope.
>
> This is another dumb question probably but in general, are you saying
> that someone watching a mount or directory and does _not_ want file
> descriptors from fanotify to be returned has no other way of getting to
> the path they want to open other than by using open_by_handle_at()?
>

Well there is another way.
It is demonstrated in my demo with intoifywatch --fanotify --recursive.
It involved userspace iterating a subtree of interest to create fid->path
map.

The fanotify recursive watch is similar but not exactly the same as the
old intoify recursive watch, because with inotify recursive watch you
can miss events.

With fanotify recursive watch, the listener (if capable) can setup a
filesystem mark so events will not be missed. They will be recorded
by fid with an unknown path and the path information can be found later
by the crawler and updated in the map before the final report.

Events on fid that were not found by the crawler need not be reported.
That's essentially a subtree watch for the poor implemented in userspace.

I did not implement the combination --fanotify --global --recursive in my
demo, because it did not make sense with the current permission model
(listener that can setup a fs mark can always resolve fids to path), but it
would be quite trivial to add.


> >
> > I guess we will also need to make open_by_handle_at() idmapped aware
> > and use a variant of vfs_dentry_acceptable() that validates that the opened
> > path is legitimately accessible via the idmapped mount.
>
> So as a first step, I think there's a legitimate case to be made for
> open_by_handle_at() to be made useable inside user namespaces. That's a
> change worth to be made independent of fanotify. For example, nowadays
> cgroups have a 64 bit identifier that can be used with open_by_handle_at
> to map a cgrp id to a path and back:
> https://lkml.org/lkml/2020/12/2/1126
> Right now this can't be used in user namespaces because of this
> restriction but it is genuinely useful to have this feature available
> since cgroups are FS_USERNS_MOUNT and that identifier <-> path mapping
> is very convenient.

FS_USERNS_MOUNT is a simple case and I think it is safe.
There is already a patch for that on my fanotify_userns branch.

> Without looking at the code I'm not super sure how name_to_handle_at()
> and open_by_handle_at() behave in the face of mount namespaces so that
> would need looking into to. But it would be a genuinely useful change, I
> think.
>

name_to_handle_at()/open_by_handle_at() should be indifferent to mount ns,
because the former returns mount_id which is globally unique (I think)
and the latter takes a mount_fd argument, which means the caller needs to
prove access to the mount prior to getting an open fd in that mount.

Thanks,
Amir.
