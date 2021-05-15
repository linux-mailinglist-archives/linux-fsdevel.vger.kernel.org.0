Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A336A38195F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 May 2021 16:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhEOO3x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 May 2021 10:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbhEOO3w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 May 2021 10:29:52 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49B7C061573
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 May 2021 07:28:39 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id z24so1541425ioj.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 May 2021 07:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YUBNPcU2swcrMKnB6gJ6cmw0pPtuyGQegrD/B5U6uDY=;
        b=sbwBCXZBRLrA3VIJJW1qGV2nZ5C1AeLe1glQbiBOzDP8l7sLm6hZ9I4f1C+JudawOL
         eS+gD1sSGrisaqaBxpC7Icv9sKkuhepF9JwRpVnCqT0TDRP2+nAX2s1GZhCazkVSBEby
         jpL05mLgtvVnBazXlr9HPdXy5Xt17qzxVlLoYEdosHMawdOLcIUehk6aSMGp/Mme9jeS
         HH8eDkJYlFpm1qiHFiCPJBsKuLPaugErJAR/e7Q3A+BwM7ZJR/3qE4HWyh6V0rXe20o2
         JuK2QLSnp9FaEmh/M3XjmbaSTc5sylgDZMSF0mUwp1S3aICTHPdyLUm53VaKYA2G/sby
         J+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YUBNPcU2swcrMKnB6gJ6cmw0pPtuyGQegrD/B5U6uDY=;
        b=fDLdqEEYI/CDQqtumpx7VWaYmMUbj42ve0N0QFpUOSLgnWa6JMB2Ti4cRE+h/H4ict
         mEFC+5Jy/r6zIJJymHBxPmdJgG5Hsr0PUIENpIbBZMFuPO+cRtH0H+MjPX5ndCPkA7g7
         iSKpt9XzgrD5VjZlvMOU4Ux8fIKIwi/YHl8mTFlrfJ0blh4cyG+pFkmNh3g4CSCsLb3D
         PTCRca/ZoxKWzvM2rCTAh3aDYsO30PwWtLh1u1lQJodTGpyvfkNzYluaymWQbTozacfh
         lOarn4MAvBVDtmg5a5+F6SJocf0O4j+9Z2zKKAIp6ZB1/rLO+W4Sg8YHUqRVCxbMPKwf
         e8hw==
X-Gm-Message-State: AOAM532Y7wwLL7Ve/90VGyjmvIy3D5e5JHEVMFuirPLyYDtCudwPLy/Q
        XGsdUZob2RQJ3hIUJJE8Q+Gtyi0sf076GY2xvGxpVjqfU98=
X-Google-Smtp-Source: ABdhPJzT2g2XAUnGFlKdlpw5D9hBUq/Tthf5GfkDgPVcSDrYXV9BUxCzGGO78GpUSPnz5GYfmflo3kWXpPQfFAGWoOE=
X-Received: by 2002:a6b:e80f:: with SMTP id f15mr34743283ioh.64.1621088919013;
 Sat, 15 May 2021 07:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <20201126111725.GD422@quack2.suse.cz> <CAOQ4uxgt1Cx5jx3L6iaDvbzCWPv=fcMgLaa9ODkiu9h718MkwQ@mail.gmail.com>
 <20210503165315.GE2994@quack2.suse.cz> <CAOQ4uxgy0DUEUo810m=bnLuHNbs60FLFPUUw8PLq9jJ8VTFD8g@mail.gmail.com>
 <20210505122815.GD29867@quack2.suse.cz> <20210505142405.vx2wbtadozlrg25b@wittgenstein>
 <20210510101305.GC11100@quack2.suse.cz> <CAOQ4uxjqjB2pCoyLzreMziJcE5nYjgdhcAsDWDmu_5-g5AKM3w@mail.gmail.com>
 <20210512152625.i72ct7tbmojhuoyn@wittgenstein> <20210513105526.GG2734@quack2.suse.cz>
 <20210514135632.d53v3pwrh56pnc4d@wittgenstein>
In-Reply-To: <20210514135632.d53v3pwrh56pnc4d@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 15 May 2021 17:28:27 +0300
Message-ID: <CAOQ4uxgngZjBseOC_qYtxjZ_J4Rc50_Y7G+CSSpJznKBXvSU5A@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: introduce filesystem view mark
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 14, 2021 at 4:56 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Thu, May 13, 2021 at 12:55:26PM +0200, Jan Kara wrote:
> > On Wed 12-05-21 17:26:25, Christian Brauner wrote:
> > > On Mon, May 10, 2021 at 02:37:59PM +0300, Amir Goldstein wrote:
> > > > On Mon, May 10, 2021 at 1:13 PM Jan Kara <jack@suse.cz> wrote:
> > > > > OK, so this feature would effectively allow sb-wide watching of events that
> > > > > are generated from within the container (or its descendants). That sounds
> > > > > useful. Just one question: If there's some part of a filesystem, that is
> > > > > accesible by multiple containers (and thus multiple namespaces), or if
> > > > > there's some change done to the filesystem say by container management SW,
> > > > > then event for this change won't be visible inside the container (despite
> > > > > that the fs change itself will be visible).
> > > >
> > > > That is correct.
> > > > FYI, a privileged user can already mount an overlayfs in order to indirectly
> > > > open and write to a file.
> > > >
> > > > Because overlayfs opens the underlying file FMODE_NONOTIFY this will
> > > > hide OPEN/ACCESS/MODIFY/CLOSE events also for inode/sb marks.
> > > > Since 459c7c565ac3 ("ovl: unprivieged mounts"), so can unprivileged users.
> > > >
> > > > I wonder if that is a problem that we need to fix...
> > > >
> > > > > This is kind of a similar
> > > > > problem to the one we had with mount marks and why sb marks were created.
> > > > > So aren't we just repeating the mistake with mount marks? Because it seems
> > > > > to me that more often than not, applications are interested in getting
> > > > > notification when what they can actually access within the fs has changed
> > > > > (and this is what they actually get with the inode marks) and they don't
> > > > > care that much where the change came from... Do you have some idea how
> > > > > frequent are such cross-ns filesystem changes?
> > > >
> > > > The use case surely exist, the question is whether this use case will be
> > > > handled by a single idmapped userns or multiple userns.
> > > >
> > > > You see, we simplified the discussion to an idmapped mount that uses
> > > > the same userns and the userns the container processes are associated
> > > > with, but in fact, container A can use userns A container B userns B and they
> > > > can both access a shared idmapped mount mapped with userns AB.
> > > >
> > > > I think at this point in time, there are only ideas about how the shared data
> > > > case would be managed, but Christian should know better than me.
> > >
> > > I think there are two major immediate container use-cases right now that
> > > are already actively used:
> > > 1. idmapped rootfs
> > > A container manager wants to avoid recursively chowning the rootfs or
> > > image for a container. To this end an idmapped mount is created. The
> > > idmapped mount can either share the same userns as the container itself
> > > or a separate userns can be used. What people use depends on their
> > > concept of a container.
> > > For example, systemd has merged support for idmapping a containers
> > > rootfs in [1]. The systemd approach to containers never puts the
> > > container itself in control of most things including most of its mounts.
> > > That is very much the approach of having it be a rather tightly managed
> > > system. Specifically, this means that systemd currently uses a separate
> > > userns to idmap.
> > > In contrast other container managers usually treat the container as a
> > > mostly separate system and put it in charge of all its mounts. This
> > > means the userns used for the idmapped mount will be the same as the
> > > container runs in (see [2]).
> >
> > OK, thanks for explanation. So to make fanotify idmap-filtered marks work
> > for systemd-style containers we would indeed need what Amir proposed -
> > i.e., the container manager intercepts fanotify_mark calls and decides
> > which namespace to setup the mark in as there's no sufficient priviledge
> > within the container to do that AFAIU.
>
> Yes, that's how that would work.
>
> >
> > > 2. data sharing among containers or among the host and containers etc.
> > > The most common use-case is to share data from the host with the
> > > container such as a download folder or the Linux folder on ChromeOS.
> > > Most container managers will simly re-use the container's userns for
> > > that too. More complex cases arise where data is shared between
> > > containers with different idmappings then often a separate userns will
> > > have to be used.
> >
> > OK, but if say on ChromeOS you copy something to the Linux folder by app A
> > (say file manager) and containerized app B (say browser) watches that mount
>
> For ChromeOS it is currently somewhat simple since they currently only
> allow a single container by default. So everytime you start an app in
> the container it's the same app so they all write to the Linux Files
> folder through the same container. (I'm glossing over a range of details
> but that's not really relevant to the general spirit of the example.).
>
>
> > for changes with idmap-filtered mark, then it won't see notification for
> > those changes because A presumably runs in a different namespace than B, am
> > I imagining this right? So mark which filters events based on namespace of
> > the originating process won't be usable for such usecase AFAICT.
>
> Idmap filtered marks won't cover that use-case as envisioned now. Though
> I'm not sure they really need to as the semantics are related to mount
> marks.

We really need to refer to those as filesystem marks. They are definitely
NOT mount marks. We are trying to design a better API that will not share
as many flaws with mount marks...

> A mount mark would allow you to receive events based on the
> originating mount. If two mounts A and B are separate but expose the
> same files you wouldn't see events caused by B if you're watching A.
> Similarly you would only see events from mounts that have been delegated
> to you through the idmapped userns. I find this acceptable especially if
> clearly documented.
>

The way I see it, we should delegate all the decisions over to userspace,
but I agree that the current "simple" proposal may not provide a good
enough answer to the case of a subtree that is shared with the host.

IMO, it should be a container manager decision whether changes done by
the host are:
a) Not visible to containerized application
b) Watched in host via recursive inode watches
c) Watched in host by filesystem mark filtered in userspace
d) Watched in host by an "noop" idmapped mount in host, through
     which all relevant apps in host access the shared folder

We can later provide the option of "subtree filtered filesystem mark"
which can be choice (e). It will incur performance overhead on the system
that is higher than option (d) but lower than option (c).

In the end, it all depends on the individual use case.

The way forward as I see it is:
1. Need to write a proposal where FAN_MARK_IDMAPPED is the
    first step towards a wider API that also includes subtree marks -
    whether we end up implementing subtree mark or not
2. Need to make sure that setting up N idmapped marks
    does not have O(N) performance overhead on the system
3. Need to make sure that the idmapped marks proposal is deemed
    desired by concrete container manager project and use cases

If there are no objections to this roadmap, I will prepare the
proposal on my next context switch.

Thanks,
Amir.
