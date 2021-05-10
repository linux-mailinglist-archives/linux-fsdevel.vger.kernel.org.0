Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602CA378A62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 14:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbhEJLnG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 07:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbhEJLjR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 07:39:17 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B3BC061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 04:38:11 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id p8so14376889iol.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 04:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DOo8/UspvxpVG9MoYprLXUYRfhKSyv5qV0Mu0bi2oc8=;
        b=Yk2RUJk/CDjuItS6EnwQSzQmjmSAV3HRMbDf7ePigbTtfaL9pzlNmj4X9Nh+0v1MCm
         g6BNWh0B8Aqf3xonRIJthcwbLz4arDY+xkS0VcvedDJ3KX2/g5F2ENldC4UeBbhqsiOK
         2NhCFzZ2DjSbhN1g5SDtUxbpOEcoty0Ye6fe3pULZuGsUUrZrsdRPYs8SjIhO4JQYy+5
         GKYpAunl5cXWyhflYFiwSmv7klHIHsa7HR51kxHOAaM+EHUrsj7GizXoyuCID/IZEb3N
         pVLVC67sRrW0qziCzsAhfv5yWkkeDcbIjjnaS9e2cuQCAraNDpjoEdc+znD7GoMEsqWQ
         o5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DOo8/UspvxpVG9MoYprLXUYRfhKSyv5qV0Mu0bi2oc8=;
        b=nIF0TkFgUzi8mAt/s7+SSNIJoqGuSpIJAKJZrOR3BM3M2CJrr6m3jVMZ8pN21xlfu4
         ijr+lto6FC3gvQXW3fqAw/WOA+NOYIEkdEwz55A5Qy8DkJYJV8OAougtG4c+UENuGaOi
         rPsXF/b2A+EZb0W16qrYY+GyUi8oXagHY3Fsj50RFuXF97zZoZOSwOJ/rosdtLQ+qCnD
         mtNoYf5pFf61EmG/WIhbxorSAcI/jvqKtBBpW61MTsd/Sy+b3les14QxZ/WWPxgEM8MV
         odIM1qk60nEMT44PZ9NAej7t1Bmizhp/8lbg0ljaKDrRGLvtctuu4d/RsbBD5W5TGa7S
         rmjw==
X-Gm-Message-State: AOAM531Hch0UKuNDy1ItHnltvgdNX2EdHgSAoUAsN40qwewcs4EhVNv1
        rymGxhSumOtd1sZnAGmyWqLYwXjvqH9W7oHr9LU=
X-Google-Smtp-Source: ABdhPJxoQPxw+OIrnn0BsN5EB6Kia2s1UKAZxnIyiwoQ+zyIJUHLaa9+MHD8geWHAG3M0Kfbd2UehMESvMhkd51sta4=
X-Received: by 2002:a6b:e80f:: with SMTP id f15mr14843774ioh.64.1620646691000;
 Mon, 10 May 2021 04:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20201124134916.GC19336@quack2.suse.cz> <CAOQ4uxiJz-j8GA7kMYRTGMmE9SFXCQ-xZxidOU1GzjAN33Txdg@mail.gmail.com>
 <20201125110156.GB16944@quack2.suse.cz> <CAOQ4uxgmExbSmcfhp0ir=7QJMVcwu2QNsVUdFTiGONkg3HgjJw@mail.gmail.com>
 <20201126111725.GD422@quack2.suse.cz> <CAOQ4uxgt1Cx5jx3L6iaDvbzCWPv=fcMgLaa9ODkiu9h718MkwQ@mail.gmail.com>
 <20210503165315.GE2994@quack2.suse.cz> <CAOQ4uxgy0DUEUo810m=bnLuHNbs60FLFPUUw8PLq9jJ8VTFD8g@mail.gmail.com>
 <20210505122815.GD29867@quack2.suse.cz> <20210505142405.vx2wbtadozlrg25b@wittgenstein>
 <20210510101305.GC11100@quack2.suse.cz>
In-Reply-To: <20210510101305.GC11100@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 10 May 2021 14:37:59 +0300
Message-ID: <CAOQ4uxjqjB2pCoyLzreMziJcE5nYjgdhcAsDWDmu_5-g5AKM3w@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: introduce filesystem view mark
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 10, 2021 at 1:13 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 05-05-21 16:24:05, Christian Brauner wrote:
> > On Wed, May 05, 2021 at 02:28:15PM +0200, Jan Kara wrote:
> > > On Mon 03-05-21 21:44:22, Amir Goldstein wrote:
> > > > > > Getting back to this old thread, because the "fs view" concept that
> > > > > > it presented is very close to two POCs I tried out recently which leverage
> > > > > > the availability of mnt_userns in most of the call sites for fsnotify hooks.
> > > > > >
> > > > > > The first POC was replacing the is_subtree() check with in_userns()
> > > > > > which is far less expensive:
> > > > > >
> > > > > > https://github.com/amir73il/linux/commits/fanotify_in_userns
> > > > > >
> > > > > > This approach reduces the cost of check per mark, but there could
> > > > > > still be a significant number of sb marks to iterate for every fs op
> > > > > > in every container.
> > > > > >
> > > > > > The second POC is based off the first POC but takes the reverse
> > > > > > approach - instead of marking the sb object and filtering by userns,
> > > > > > it places a mark on the userns object and filters by sb:
> > > > > >
> > > > > > https://github.com/amir73il/linux/commits/fanotify_idmapped
> > > > > >
> > > > > > The common use case is a single host filesystem which is
> > > > > > idmapped via individual userns objects to many containers,
> > > > > > so normally, fs operations inside containers would have to
> > > > > > iterate a single mark.
> > > > > >
> > > > > > I am well aware of your comments about trying to implement full
> > > > > > blown subtree marks (up this very thread), but the userns-sb
> > > > > > join approach is so much more low hanging than full blown
> > > > > > subtree marks. And as a by-product, it very naturally provides
> > > > > > the correct capability checks so users inside containers are
> > > > > > able to "watch their world".
> > > > > >
> > > > > > Patches to allow resolving file handles inside userns with the
> > > > > > needed permission checks are also available on the POC branch,
> > > > > > which makes the solution a lot more useful.
> > > > > >
> > > > > > In that last POC, I introduced an explicit uapi flag
> > > > > > FAN_MARK_IDMAPPED in combination with
> > > > > > FAN_MARK_FILESYSTEM it provides the new capability.
> > > > > > This is equivalent to a new mark type, it was just an aesthetic
> > > > > > decision.
> > > > >
> > > > > So in principle, I have no problem with allowing mount marks for ns-capable
> > > > > processes. Also FAN_MARK_FILESYSTEM marks filtered by originating namespace
> > > > > look OK to me (although if we extended mount marks to support directory
> > > > > events as you try elsewhere, would there be still be a compeling usecase for
> > > > > this?).
> > > >
> > > > In my opinion it would. This is the reason why I stopped that direction.
> > > > The difference between FAN_MARK_FILESYSTEM|FAN_MARK_IDMAPPED
> > > > and FAN_MARK_MOUNT is that the latter can be easily "escaped" by creating
> > > > a bind mount or cloning a mount ns while the former is "sticky" to all additions
> > > > to the mount tree that happen below the idmapped mount.
> > >
> > > As far as I understood Christian, he was specifically interested in mount
> > > events for container runtimes because filtering by 'mount' was desirable
> > > for his usecase. But maybe I misunderstood. Christian? Also if you have
> >
> > I discussed this with Amir about two weeks ago. For container runtimes
> > Amir's idea of generating events based on the userns the fsnotify
> > instance was created in is actually quite clever because it gives a way
> > for the container to receive events for all filesystems and idmapped
> > mounts if its userns is attached to it. The model as we discussed it -
> > Amir, please tell me if I'm wrong - is that you'd be setting up an
> > fsnotify watch in a given userns and you'd be seeing events from all
> > superblocks that have the caller's userns as s_user_ns and all mounts
> > that have the caller's userns as mnt_userns. I think that's safe.
>
> OK, so this feature would effectively allow sb-wide watching of events that
> are generated from within the container (or its descendants). That sounds
> useful. Just one question: If there's some part of a filesystem, that is
> accesible by multiple containers (and thus multiple namespaces), or if
> there's some change done to the filesystem say by container management SW,
> then event for this change won't be visible inside the container (despite
> that the fs change itself will be visible).

That is correct.
FYI, a privileged user can already mount an overlayfs in order to indirectly
open and write to a file.

Because overlayfs opens the underlying file FMODE_NONOTIFY this will
hide OPEN/ACCESS/MODIFY/CLOSE events also for inode/sb marks.
Since 459c7c565ac3 ("ovl: unprivieged mounts"), so can unprivileged users.

I wonder if that is a problem that we need to fix...

> This is kind of a similar
> problem to the one we had with mount marks and why sb marks were created.
> So aren't we just repeating the mistake with mount marks? Because it seems
> to me that more often than not, applications are interested in getting
> notification when what they can actually access within the fs has changed
> (and this is what they actually get with the inode marks) and they don't
> care that much where the change came from... Do you have some idea how
> frequent are such cross-ns filesystem changes?

The use case surely exist, the question is whether this use case will be
handled by a single idmapped userns or multiple userns.

You see, we simplified the discussion to an idmapped mount that uses
the same userns and the userns the container processes are associated
with, but in fact, container A can use userns A container B userns B and they
can both access a shared idmapped mount mapped with userns AB.

I think at this point in time, there are only ideas about how the shared data
case would be managed, but Christian should know better than me.

> I fully appreciate the
> simplicity of Amir's proposal but I'm trying to estimate when (or how many)
> users are going to come back complaining it is not good enough ;).
>

IMO we should seriously consider the following model:
1. Implement userns-filtered sb marks, WITHOUT relaxing capability checks -
    setting userns-filtered sb marks requires the same capability as sb marks
2. When container users call fanotify_{init,mark}(), container manager can
    intercept these calls (this is standard practice) and setup userns-filtered
    sb marks on their behalf
3. Container manager has all the knowledge about shared data, so when
    container A asks to watch the shared fs, container manager can do the
    right thing and set filtered marks for userns A, B, AB or a subset depending
    on configuration
4. Is it up to container manager to decide, per configuration, whether container
    users should be able to get events on changes made on filesystem from the
    host userns. Per configuration, container manager can decide to convert
    a request for sb mark to a filtered sb mark, reject it, or allow
it and filter by
    subtree in userspace.

IOW, if we only implement the "simple" technical solution of the beast
called "idmapped filesystem mark", container manager SW can leverage
that to a lot more.

Having said that, I think we need to wait to see the deployed container
management solutions that will be built on top of idmapped mounts and
wait for feature requests for specific use cases.

Then we can see if the plan above makes sense.

I think we need to wait to see the deployed container management solutions
that build on top of idmapped mounts and wait for feature requests for
specific use cases.

Christian,

If you feel there is already a concrete use case to discuss, you may
bring in the relevant users to discuss it.
Otherwise, I would wait for the dust to settle before we continue this
effort.

Thanks,
Amir.
