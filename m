Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116AD373DDB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 16:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbhEEOn4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 10:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbhEEOnz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 10:43:55 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76ABDC061574
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 May 2021 07:42:58 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id y10so1969873ilv.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 May 2021 07:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wdf9BzDva3lNm9mKG/Rt6CLCHoU/qgNk7cgHyz1FvDs=;
        b=mWMg6IFVqkvLLaBIgRO2GK903U9gBTLsW3V8t6MwmA9WW2tbfl6CGEBBI1bpr9j0N1
         ufOIxz63iKy5rPH1I5tG99+NyfkBhzZzn8fEj/p/IoVfE6zIyH4aAv+hny+SAqGkK1Qh
         qb3eMDoWgjLRlwLOQCOXD9Ohhj5RYTWEG9PKwpJFZBpJnDX6qDFFs4yPUii0Gb13lKNI
         Mogu2bkf/txNBeJtIdu6h+X6035ueP9xBl3q4KYTTxrx+scvffShPyLr5SEHrQe+Rhe0
         cIvy7DCMOjv0O4Ist/avv1/NmbTFH0UA7hB7rReG+uvV8/KNpilivVoWfXvBDJ0xRBGA
         CUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wdf9BzDva3lNm9mKG/Rt6CLCHoU/qgNk7cgHyz1FvDs=;
        b=N1LgBVQuXtxzNX4ebbr2cXMWggemvNXYcQVkFJNdpPTzBFWJCRJrxYWWZ83RGsOK0l
         zoqrHM2rT76oiCTP1l8YRbOMHxJyxMDJnezYwo3J5hlkS7+6dhC3aJ4MRC7ffdKAtE+X
         m8Lj05J8H+vN6wYBGAg3J2/zjpf9wq9HKS5X4NsZc20Inrv1hbUcCdZSBUrpw0Lm/fo/
         1msy0rSEJEj3cjNHHRXnDuXDqljvjBVPLCLa6O9qGsVae3KGJEgHQRcZ1yuOmDzxW8iS
         YgM69bBbiB0CDtsBl0ypYc8yczGWUyCNmOuF7EL2iBqF26W0w4Lp13sVOcFRf4rO22+G
         rVFw==
X-Gm-Message-State: AOAM532k/LYLPsrusEAX1amJJiT5NUzCnpix7aih6f5NeTOmfQXlBYcQ
        oOs0D2gy6oxmX+uKENp9x4YxhElwFCXZmd2o0mA=
X-Google-Smtp-Source: ABdhPJz4H2NmcYrFQ8gUAnbVuHfDfBYRsHrEevRtOSj0UmgM3n/vmYIH7e1N7Ugs/ASKin2aBEUE0uac0Tfqd4uOIAo=
X-Received: by 2002:a92:c548:: with SMTP id a8mr25099679ilj.137.1620225777800;
 Wed, 05 May 2021 07:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20201109180016.80059-1-amir73il@gmail.com> <20201124134916.GC19336@quack2.suse.cz>
 <CAOQ4uxiJz-j8GA7kMYRTGMmE9SFXCQ-xZxidOU1GzjAN33Txdg@mail.gmail.com>
 <20201125110156.GB16944@quack2.suse.cz> <CAOQ4uxgmExbSmcfhp0ir=7QJMVcwu2QNsVUdFTiGONkg3HgjJw@mail.gmail.com>
 <20201126111725.GD422@quack2.suse.cz> <CAOQ4uxgt1Cx5jx3L6iaDvbzCWPv=fcMgLaa9ODkiu9h718MkwQ@mail.gmail.com>
 <20210503165315.GE2994@quack2.suse.cz> <CAOQ4uxgy0DUEUo810m=bnLuHNbs60FLFPUUw8PLq9jJ8VTFD8g@mail.gmail.com>
 <20210505122815.GD29867@quack2.suse.cz> <20210505142405.vx2wbtadozlrg25b@wittgenstein>
In-Reply-To: <20210505142405.vx2wbtadozlrg25b@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 5 May 2021 17:42:46 +0300
Message-ID: <CAOQ4uxiab7M8i5E9shfCS=Rof1vCK0Jpfi-A2_3LPnK=_gFT9g@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: introduce filesystem view mark
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 5, 2021 at 5:24 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Wed, May 05, 2021 at 02:28:15PM +0200, Jan Kara wrote:
> > On Mon 03-05-21 21:44:22, Amir Goldstein wrote:
> > > > > Getting back to this old thread, because the "fs view" concept that
> > > > > it presented is very close to two POCs I tried out recently which leverage
> > > > > the availability of mnt_userns in most of the call sites for fsnotify hooks.
> > > > >
> > > > > The first POC was replacing the is_subtree() check with in_userns()
> > > > > which is far less expensive:
> > > > >
> > > > > https://github.com/amir73il/linux/commits/fanotify_in_userns
> > > > >
> > > > > This approach reduces the cost of check per mark, but there could
> > > > > still be a significant number of sb marks to iterate for every fs op
> > > > > in every container.
> > > > >
> > > > > The second POC is based off the first POC but takes the reverse
> > > > > approach - instead of marking the sb object and filtering by userns,
> > > > > it places a mark on the userns object and filters by sb:
> > > > >
> > > > > https://github.com/amir73il/linux/commits/fanotify_idmapped
> > > > >
> > > > > The common use case is a single host filesystem which is
> > > > > idmapped via individual userns objects to many containers,
> > > > > so normally, fs operations inside containers would have to
> > > > > iterate a single mark.
> > > > >
> > > > > I am well aware of your comments about trying to implement full
> > > > > blown subtree marks (up this very thread), but the userns-sb
> > > > > join approach is so much more low hanging than full blown
> > > > > subtree marks. And as a by-product, it very naturally provides
> > > > > the correct capability checks so users inside containers are
> > > > > able to "watch their world".
> > > > >
> > > > > Patches to allow resolving file handles inside userns with the
> > > > > needed permission checks are also available on the POC branch,
> > > > > which makes the solution a lot more useful.
> > > > >
> > > > > In that last POC, I introduced an explicit uapi flag
> > > > > FAN_MARK_IDMAPPED in combination with
> > > > > FAN_MARK_FILESYSTEM it provides the new capability.
> > > > > This is equivalent to a new mark type, it was just an aesthetic
> > > > > decision.
> > > >
> > > > So in principle, I have no problem with allowing mount marks for ns-capable
> > > > processes. Also FAN_MARK_FILESYSTEM marks filtered by originating namespace
> > > > look OK to me (although if we extended mount marks to support directory
> > > > events as you try elsewhere, would there be still be a compeling usecase for
> > > > this?).
> > >
> > > In my opinion it would. This is the reason why I stopped that direction.
> > > The difference between FAN_MARK_FILESYSTEM|FAN_MARK_IDMAPPED
> > > and FAN_MARK_MOUNT is that the latter can be easily "escaped" by creating
> > > a bind mount or cloning a mount ns while the former is "sticky" to all additions
> > > to the mount tree that happen below the idmapped mount.
> >
> > As far as I understood Christian, he was specifically interested in mount
> > events for container runtimes because filtering by 'mount' was desirable
> > for his usecase. But maybe I misunderstood. Christian? Also if you have
>
> I discussed this with Amir about two weeks ago. For container runtimes
> Amir's idea of generating events based on the userns the fsnotify
> instance was created in is actually quite clever because it gives a way
> for the container to receive events for all filesystems and idmapped
> mounts if its userns is attached to it. The model as we discussed it -
> Amir, please tell me if I'm wrong - is that you'd be setting up an
> fsnotify watch in a given userns and you'd be seeing events from all
> superblocks that have the caller's userns as s_user_ns and all mounts
> that have the caller's userns as mnt_userns. I think that's safe.

Not sure if we want to get events from all the fs mounted in this userns.
We do not want events from proc/sys/debug fs which are mounted inside
the usersn.

My POC does not implement a watch for ALL fs in userns, it implements
only a filtered watch by userns-sb pair.

>
> The reason why I found mount marks to be so compelling initially was
> that they also work in cases where the caller is not in the userns that
> is attached to the mnt (Similar to how you don't need to be in the
> s_user_ns of the superblock you attached a filesystem mark to.).
> That's not per se a container use-case though as the container will
> almost always be in the userns that is attached to the mount (They don't
> have to be of course just as with s_usern_s. You can very well be clever
> and make a superblock be visible outside of the mounter's userns.).
>
> In addition the mount mark seemed to offer more granularity as the
> caller can specifically select what they want to monitor. But I don't
> think that justifies the complexity of the implementation that we would
> need to push for.
>
> > FAN_MARK_FILESYSTEM mark filtered by namespace, you still will not see
> > events to your shared filesystem generated from another namespace. So
> > "escaping" is just a matter of creating new namespace and mounting fs
> > there?
>
> Hm, that depends on the implementation. If Amir is using in_userns()
> then the caller would be seeing events for their own userns and all
> descendant userns. Since userns are hierarchical a container creating a
> new userns wouldn't be able to "escape" the notifications.
>

Not seeing events generated from another userns idmapped mount is a feature.
FAN_MARK_FILESYSTEM gets events generated on fs from anywhere.
FAN_MARK_MOUNT gets events generated on fs only via a specific mount.
The idmapped fs mark is in between - get all events on fs via any mount inside
a specific container (and all its descendants).

Escaping is not possible from within the container. In order to generate events
that are not via a mount that is idmapped to the container userns, the
host would
need to provide access to a non-idmapped mount into the container and that
would be a container management problem, not an fsnotify problem.

Christian, please correct me if I am wrong.

Thanks,
Amir.
