Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50E0371FDA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 20:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhECSp2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 14:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhECSp1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 14:45:27 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD17C06174A
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 May 2021 11:44:34 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id b10so4935348iot.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 May 2021 11:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=48OwPzQ/dhdNNiT1rYXkX3SyDf1iYLk1r5rNpT6bSIM=;
        b=qaRnuT5oEtDg+BN2WI1e5VcBn4uFMnyGWEd+UzzFMLn2jl+cyVS69w85KS9TDh8x5P
         U9tZZIDHPMFPih4F/AUKi3pzkXFlCZrIMMi4DjXTRBMunFVUNYmpxtlERiUYuv0y7u6/
         Q/N5ykXw6Hajk62v6vrkSSbk67mbDzpuP+tLKJrDnCS8K9Nf4FQQBi6FUcOL9Y2YduCy
         My6xG6VTd+avejiwiHNOTIOMrXpuoNpTjW7hP65RtftAQ6qzI/IW0u/UVRhbH2mFjKBt
         2wDekepe15wjVs+1vs8bMatERgiFPuqK6bMeV/SuSXdEKk9jIm+Q2nFBBZ7N/hMCMAQd
         1iLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=48OwPzQ/dhdNNiT1rYXkX3SyDf1iYLk1r5rNpT6bSIM=;
        b=IIGhz1u/p0WT+CphZ4hTErKqVQTDTYFaDCBuZaNnRu9dgzsq7yX6WJvqbD/ess/SXC
         V5TJ3wfzYlPclQBQ2/Rs7bt+hpZ5eZgWzhNj0riYlW+/sgfcLl22+uhvFcsht7XyRUnO
         UqejucKFy0QisAfnw6bWlQyjEsKHTfGR9CJc+l/QECwA+WObecBs/4zS8w2C8O2GqoB0
         nzofddfVrvOQHSyg/wXspF9bgfFybZu3UU/mGSAoq4x3jqsSMp9pykRDBebj/k+16rij
         VqAAA1pm1jBzdKrcdIbacdqip2er+t2uxVsMrG7+T1LYZj7iJrj/W4dzpMNpS/jf/Sld
         YOiw==
X-Gm-Message-State: AOAM531PMBKL2YbztL/CXbGFPDQ06hAKwpALOmT0e+UO+I8j0UHqW4L1
        PjQOl/nI03FaJvdI3kg3cWCCKgJ/CjCRowrKup0=
X-Google-Smtp-Source: ABdhPJz9rTB/wfxVC8PRow3TMCnmee3ju7YhJ70Mr+oppenxB5P1g8K7EZQ1qGhTZjZ6nbimKNLsOR1KTm0eKRngljU=
X-Received: by 2002:a05:6602:72f:: with SMTP id g15mr4866692iox.5.1620067473646;
 Mon, 03 May 2021 11:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <20201109180016.80059-1-amir73il@gmail.com> <20201124134916.GC19336@quack2.suse.cz>
 <CAOQ4uxiJz-j8GA7kMYRTGMmE9SFXCQ-xZxidOU1GzjAN33Txdg@mail.gmail.com>
 <20201125110156.GB16944@quack2.suse.cz> <CAOQ4uxgmExbSmcfhp0ir=7QJMVcwu2QNsVUdFTiGONkg3HgjJw@mail.gmail.com>
 <20201126111725.GD422@quack2.suse.cz> <CAOQ4uxgt1Cx5jx3L6iaDvbzCWPv=fcMgLaa9ODkiu9h718MkwQ@mail.gmail.com>
 <20210503165315.GE2994@quack2.suse.cz>
In-Reply-To: <20210503165315.GE2994@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 3 May 2021 21:44:22 +0300
Message-ID: <CAOQ4uxgy0DUEUo810m=bnLuHNbs60FLFPUUw8PLq9jJ8VTFD8g@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: introduce filesystem view mark
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > Getting back to this old thread, because the "fs view" concept that
> > it presented is very close to two POCs I tried out recently which leverage
> > the availability of mnt_userns in most of the call sites for fsnotify hooks.
> >
> > The first POC was replacing the is_subtree() check with in_userns()
> > which is far less expensive:
> >
> > https://github.com/amir73il/linux/commits/fanotify_in_userns
> >
> > This approach reduces the cost of check per mark, but there could
> > still be a significant number of sb marks to iterate for every fs op
> > in every container.
> >
> > The second POC is based off the first POC but takes the reverse
> > approach - instead of marking the sb object and filtering by userns,
> > it places a mark on the userns object and filters by sb:
> >
> > https://github.com/amir73il/linux/commits/fanotify_idmapped
> >
> > The common use case is a single host filesystem which is
> > idmapped via individual userns objects to many containers,
> > so normally, fs operations inside containers would have to
> > iterate a single mark.
> >
> > I am well aware of your comments about trying to implement full
> > blown subtree marks (up this very thread), but the userns-sb
> > join approach is so much more low hanging than full blown
> > subtree marks. And as a by-product, it very naturally provides
> > the correct capability checks so users inside containers are
> > able to "watch their world".
> >
> > Patches to allow resolving file handles inside userns with the
> > needed permission checks are also available on the POC branch,
> > which makes the solution a lot more useful.
> >
> > In that last POC, I introduced an explicit uapi flag
> > FAN_MARK_IDMAPPED in combination with
> > FAN_MARK_FILESYSTEM it provides the new capability.
> > This is equivalent to a new mark type, it was just an aesthetic
> > decision.
>
> So in principle, I have no problem with allowing mount marks for ns-capable
> processes. Also FAN_MARK_FILESYSTEM marks filtered by originating namespace
> look OK to me (although if we extended mount marks to support directory
> events as you try elsewhere, would there be still be a compeling usecase for
> this?).
>

In my opinion it would. This is the reason why I stopped that direction.
The difference between FAN_MARK_FILESYSTEM|FAN_MARK_IDMAPPED
and FAN_MARK_MOUNT is that the latter can be easily "escaped" by creating
a bind mount or cloning a mount ns while the former is "sticky" to all additions
to the mount tree that happen below the idmapped mount.

That is a key difference that can allow running system services that use sb
marks inside containers and actually be useful.
"All" the system service needs to do in order to become idmapped aware
is to check the path it is marking in /proc/self/mounts (or via syscall) and
set the FAN_MARK_IDMAPPED flag.
Everything else "just works" the same as in init user ns.

> My main concern is creating a sane API so that if we expand the
> functionality in the future we won't create a mess out of all
> possibilities.
>

Agreed.
If and when I post these patches, I will include the complete vision
for the API to show where this fits it.

> So I think there are two, relatively orthogonal decicions to make:
>
> 1) How the API should look like? For mounts there's no question I guess.
> It's a mount mark as any other and we just relax the permission checks.

Right.

> For FAN_MARK_FILESYSTEM marks we have to me more careful - I think
> restricting mark to events generated only from a particular userns has to
> be an explicit flag when adding the mark. Otherwise process that is
> CAP_SYS_ADMIN in init_user_ns has no way of using these ns-filtered marks.

True. That's the reason I added the explicit flag in POC2.

> But this is also the reason why I'd like to think twice before adding this
> event filtering if we can cover similar usecases by expanding mount marks
> capabilities instead (it would certainly better fit overall API design).
>

I explained above why that would not be good enough IMO.
I think that expanding mount marks to support more events is nice for
the unified APIs, but it is not nice enough IMO to justify the efforts
related to
promoting the vfs API changes against resistance and testing all the affected
filesystems.

> 2) Whether to internally attach marks to sb or to userns and how to
> efficiently process them when generating events. This is an internal
> decision of fsnotify and so I'm not concerned too much about it. We can
> always tweak it in the future if the usecases show the CPU overhead is
> significant. E.g. we could attach filtered marks to sb but hash it by
> userns (or have rbtree ordered by userns in sb) to lower the CPU overhead
> if there will be many sb marks expected.

So we use a data structure in sb to hold the marked userns and keep one
connector for sb-userns pair? That sounds pretty good.
It will make cleanup easier for fsnotify_sb_delete().

> Attaching to userns as you suggest
> in POC2 is certainly an option as well although I guess I sligthly prefer
> to keep things in the sb so that we don't have to create yet another place
> to attach marks to and all the handling associated with that.

Agreed.

Thanks,
Amir.
