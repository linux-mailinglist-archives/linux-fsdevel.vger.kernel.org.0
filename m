Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEDF34FF7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 13:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbhCaLav (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 07:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbhCaLaW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 07:30:22 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D1BC061574;
        Wed, 31 Mar 2021 04:29:15 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id r193so19716626ior.9;
        Wed, 31 Mar 2021 04:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iww1/sddqyH/KQZ8vJMvmYebJg1acq/WZ4H0LPzqvw4=;
        b=PQ5AGqmPB8tH6bnXEqrsMkbA3ZVFT52CdooCurj6EyZawKGgdnPDiIL+LifLNSFDgN
         ZYOqR/oDue7TOjs8nknqLtO0BSdnKJMMREspB/U8B0whDc/pHbItkDzgZpQGmcRohWOi
         6bOz1rq/BV9+OHBxHcn/aol94Q1clX8WzXQ86HEi2HmyfpvT6n9EEpkdKllCppJt1NsN
         4PEg0eK0Pt93ZHj9y9JjN+84c1UeuIY3Fp174Bt43KJVD0x30o6VLQnU+X+zPbVA7r5E
         r8/wIG+1KPOxFpkXg5i4ee0IujjfLrHRW5Y+Gn4jOrlfXAgfBuiX6BDrnOOePMME6ASB
         o7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iww1/sddqyH/KQZ8vJMvmYebJg1acq/WZ4H0LPzqvw4=;
        b=B4KgRrCUsO3t8X3cITNhTdsrFycwY1iQC4ctQTwdhySw4/WrRSkL9ZKFku50X2mllf
         8OBemEMLK3+8nXRdI0vFoA71dXVbnhSQiBuRMUhzIkAkHV4Yk70rDnJ+Feu82lbBU7rR
         y3mBWROFzApG5St1Wk5Jty9tDoRkZDze2FLJm5I6+sC6Zjhr3rIGduKOlNuvhBdZw4FF
         7kttP2olL1ChRIiuU6JPHQcXV4a3vB/s4oUDh4As9IeOowCyJWIL2x81+YbbXd5d7WnG
         sfDOOKByPfo4kT+shKAc1qeRhSq8KvTjwW9F/QYcL1fsgQVreN1wnSi2ifhe8k+lNocN
         jV7w==
X-Gm-Message-State: AOAM533u3aLB1eWwHyrIwx9/GgJPMisc3KZd+dwq4aM7MsmmpnT6BUYY
        h5Jdir9NGQSwHXVhyztbivtHvwADGllS63Q2BAg6HdviuUA=
X-Google-Smtp-Source: ABdhPJyReBk1uLPjW6MTvDywIpZN0zsxFkfQTS1oQHZqGQF1pQYhSWyhkKrmCcCj92DqngN5mWRxJNl6J8tbvmvQQc0=
X-Received: by 2002:a05:6638:1388:: with SMTP id w8mr2500843jad.30.1617190155110;
 Wed, 31 Mar 2021 04:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210328155624.930558-1-amir73il@gmail.com> <20210330121204.b7uto3tesqf6m7hb@wittgenstein>
 <CAOQ4uxjVdjLPbkkZd+_1csecDFuHxms3CcSLuAtRbKuozHUqWA@mail.gmail.com>
 <20210330125336.vj2hkgwhyrh5okee@wittgenstein> <CAOQ4uxjPhrY55kJLUr-=2+S4HOqF0qKAAX27h2T1H1uOnxM9pQ@mail.gmail.com>
 <20210330141703.lkttbuflr5z5ia7f@wittgenstein> <CAOQ4uxirMBzcaLeLoBWCMPPr7367qeKjnW3f88bh1VMr_3jv_A@mail.gmail.com>
 <20210331094604.xxbjl3krhqtwcaup@wittgenstein>
In-Reply-To: <20210331094604.xxbjl3krhqtwcaup@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 31 Mar 2021 14:29:04 +0300
Message-ID: <CAOQ4uxirud-+ot0kZ=8qaicvjEM5w1scAeoLP_-HzQx+LwihHw@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: allow setting FAN_CREATE in mount mark mask
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 12:46 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Tue, Mar 30, 2021 at 05:56:25PM +0300, Amir Goldstein wrote:
> > > > > My example probably would be something like:
> > > > >
> > > > > mount -t ext4 /dev/sdb /A
> > > > >
> > > > > 1. FAN_MARK_MOUNT(/A)
> > > > >
> > > > > mount --bind /A /B
> > > > >
> > > > > 2. FAN_MARK_MOUNT(/B)
> > > > >
> > > > > mount -t ecryptfs /B /C
> > > > >
> > > > > 3. FAN_MARK_MOUNT(/C)
> > > > >
> > > > > let's say I now do
> > > > >
> > > > > touch /C/bla
> > > > >
> > > > > I may be way off here but intuitively it seems both 1. and 2. should get
> > > > > a creation event but not 3., right?
> > > > >
> > > >
> > > > Why not 3?
> > > > You explicitly set a mark on /C requesting to be notified when
> > > > objects are created via /C.
> > >
> > > Sorry, that was a typo. I meant to write, both 2. and 3. should get a
> > > creation event but not 1.
> > >
> > > >
> > > > > But with your proposal would both 1. and 2. still get a creation event?
> > > > >
> > >
> > > Same obvious typo. The correct question would be: with your proposal do
> > > 2. and 3. both get an event?
> > >
> > > Because it feels like they both should since /C is mounted on top of /B
> > > and ecryptfs acts as a shim. Both FAN_MARK_MOUNT(/B) and
> > > FAN_MARK_MOUNT(/C) should get a creation event after all both will have
> > > mnt->mnt_fsnotify_marks set.
> > >
> >
> > Right.
> >
> > There are two ways to address this inconsistency:
> > 1. Change internal callers of vfs_ helpers to use a private mount,
> >     as you yourself suggested for ecryptfs and cachefiles
>
> I feel like this is he correct thing to do independently of the fanotify
> considerations. I think I'll send an RFC for this today or later this
> week.
>
> > 2. Add fsnotify_path_ hooks at caller site - that would be the
> >     correct thing to do for nfsd IMO
>
> I do not have an informed opinion yet on nfsd so I simply need to trust
> you here. :)
>

As long as "exp_export: export of idmapped mounts not yet supported.\n"
I don't think it matters much.
It feels like adding idmapped mounts to nfsd is on your roadmap.
When you get to that we can discuss adding fsnotify path hooks to nfsd
if Jan agrees to the fsnotify path hooks concept.

> >
> > > >
> > > > They would not get an event, because fsnotify() looks for CREATE event
> > > > subscribers on inode->i_fsnotify_marks and inode->i_sb_s_fsnotify_marks
> > > > and does not find any.
> > >
> > > Well yes, but my example has FAN_MARK_MOUNT(/B) set. So fanotify
> > > _should_ look at
> > >             (!mnt || !mnt->mnt_fsnotify_marks) &&
> > > and see that there are subscribers and should notify the subscribers in
> > > /B even if the file is created through /C.
> > >
> > > My point is with your solution this can't be handled and I want to make
> > > sure that this is ok. Because right now you'd not be notified about a
> > > new file having been created in /B even though mnt->mnt_fsnotify_marks
> > > is set and the creation went through /B via /C.
> > >
> >
> > If you are referring to the ecryptfs use case specifically, then I think it is
> > ok. After all, whether ecryptfs uses a private mount clone or not is not
> > something the user can know.
> >
> > > _Unless_ we switch to an argument like overlayfs and say "This is a
> > > private mount which is opaque and so we don't need to generate events.".
> > > Overlayfs handles this cleanly due to clone_private_mount() which will
> > > shed all mnt->mnt_fsnotify_marks and ecryptfs should too if that is the
> > > argument we follow, no?
> > >
> >
> > There is simply no way that the user can infer from the documentation
> > of FAN_MARK_MOUNT that the event on /B is expected when /B is
> > underlying layer of ecryptfs or overlayfs.
> > It requires deep internal knowledge of the stacked fs implementation.
> > In best case, the user can infer that she MAY get an event on /B.
> > Some users MAY also expect to get an event on /A because they do not
> > understand the concept of bind mounts...
> > Clone a mount ns and you will get more lost users...
>
> I disagree to some extent. For example, a user might remount /B
> read-only at which point /C is effectively read-only too which makes it
> plain obvious to the user that /C piggy-backs on /B.

Yes, but that is a bug. /C should not become read-only. It should use
a private clone of /B, so I don't see where this is going.

> But leaving that aside my questioning is more concerned with whether the
> implementation we're aiming for is consistent and intuitive and that
> stacking example came to my mind pretty quickly.
>

This implementation is a compromise for not having clear user mount
context in all places that call for an event.
For every person you find that thinks it is intuitive to get an event on /B
for touch C/bla, you will find another person that thinks it is not intuitive
to get an event. I think we are way beyond the stage with mount
namespaces where intuition alone suffice.

w.r.t consistent, you gave a few examples and I suggested how IMO
they should be fixed to behave consistently.
If you have other examples of alleged inconsistencies, please list them.

> >
> > > >
> > > > The vfs_create() -> fsnotify_create() hook passes data_type inode to
> > > > fsnotify() so there is no fsnotify_data_path() to extract mnt event
> > > > subscribers from.
> > >
> > > Right, that was my point. You don't have the mnt context for the
> > > underlying fs at a time when e.g. call vfs_link() which ultimately calls
> > > fsnotify_create/link() which I'm saying might be a problem.
> > >
> >
> > It's a problem. If it wasn't a problem I wouldn't need to work around it ;-)
> >
> > It would be a problem if people think that the FAN_MOUNT_MARK
> > is a subtree mark, which it certainly is not. And I have no doubt that
>
> I don't think subtree marks figure into the example above. But we
> digress.
>
> > as Jan said, people really do want a subtree mark.
> >
> > My question to you with this RFC is: Does the ability to subscribe to
> > CREATE/DELETE/MOVE events on a mount help any of your use
> > cases? With or without the property that mount marks are allowed
>
> Since I explicitly pointed on in a prior mail that it would be great to
> have the same events as for a regular fanotify watch I think I already
> answered that question. :)
>
> > inside userns for idmapped mounts.
>
> But if it helps then I'll do it once: yes, both would indeed be very
> useful.
>

OK. I understand that the "promise" of those abilities is very useful.
Please also confirm once you tested the demo code that the new
events on an idmapped mount will "actually" be useful to container
managers. If you can work my demo code into a demo branch for
the bind mount injection or something that would be best.

The reason I am asking this is because while I was working on
enabling sb/mount marks inside userns I found several other issues
(e.g. open_by_handle_at()) without fixing them the demo would have
been much less impressive and much less useful in practice.

So I would like to know that we really have all the pieces needed for
a useful solution, before proposing the fanotify patches.

Thanks,
Amir.
