Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5940027F02E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Sep 2020 19:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgI3RXW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Sep 2020 13:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3RXW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Sep 2020 13:23:22 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CD4C061755;
        Wed, 30 Sep 2020 10:23:21 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a3so3195047ejy.11;
        Wed, 30 Sep 2020 10:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UrgpaXZQcEiWRN4UDFx1mJBkzqn9rEMA2DsycEOwqxw=;
        b=GeSpouXkNgMhABdxtGEAULbpTjggCCUC7yOIyyn+prS51XPGqv0fuKCQaa0RssUOVs
         4Lp+QEJzLdPw7NGgdz6+nxUBYFpwULFSi91lek7bMUHMdrc2dglvgtugmhV00sQ13+tm
         NOyJ4fdAWiSdAakCMtZLGp9eCjsw2jO0+QSUV/A7X+qd36EqdH5CQNcvxDQHeH2L7esv
         FWgyROP46BF472HcsIkKX+UsaiaMpdFXZ2qn7vod/nQg12BwFrjyPjLG9hkosh4410Si
         8ZyVNbD6vRRPjIpIr0laOd5TaB+lLTHOuy8hnLuMaTAYwCTnTEdp9zM25ktQTyXq1IE7
         5Dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UrgpaXZQcEiWRN4UDFx1mJBkzqn9rEMA2DsycEOwqxw=;
        b=IJF0rzowX0Qpov/Y9EoMWD0IvQTdAhzUZC4jVsbjniVlA5rK3dMNUEdRo7mlMzDgzv
         XeYvaSCmAVF3Kc8L4QnLxY7Im/9AMXXDwmoPpn+AQtOlxbSJJAQkr1utGZydX+9s8I7P
         8H1ScmZhMP/s4prHAhQKixUg3k6Q7xk5WC0Xmu1tbRNo94QTWdJ2AD2HT7XIXbJiJ3Ut
         VI22N6Ln3h4/SLFAWVrxvGSIEOiC5KhhMiIdrr0kB6zo/u3OAvcimWRidBYroQGGxxSH
         43Ga1ASs2q2ggw0MbDFV3LHuFGfhETb6Z0z6zOP/5g17sgO4JF9ER6jyLQLjczPpWkvJ
         7bOg==
X-Gm-Message-State: AOAM533quzXgryGLy/Ex/tHpMr1B0AESrcgTPTWgZGDwV5LWQ2CpH42l
        IRFtqF9q/E5u1N3QFMqVIW+mPVxHvSyu2YsiR9yQZIFDDluH0A==
X-Google-Smtp-Source: ABdhPJwepsRiteoDrEmKrYtno7tHE8B1tyjlYMXcr+1OIZY6WQXlxKnWUjBPx6MPce8qUWrKjfz6OgsSjsv4B4cEC2M=
X-Received: by 2002:a17:906:71cc:: with SMTP id i12mr3848447ejk.507.1601486600334;
 Wed, 30 Sep 2020 10:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200916185823.5347-1-shy828301@gmail.com> <20200917023742.GT12096@dread.disaster.area>
 <CAHbLzkrGB_=KBgD1sMpW33QjWSGTXNnLy3JtVUyHc2Omsa3gWA@mail.gmail.com>
 <20200921003231.GZ12096@dread.disaster.area> <CAHbLzkqAWiO4uhGBmbUjgs6EmQazYQXHPxR2-MWo4X8zxZ7gfQ@mail.gmail.com>
 <CAHbLzkoidoBWtLtd_3DjuSvm7dAJV1gSJAMmWY95=e8N7Hy=TQ@mail.gmail.com> <20200930073152.GH12096@dread.disaster.area>
In-Reply-To: <20200930073152.GH12096@dread.disaster.area>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 30 Sep 2020 10:23:07 -0700
Message-ID: <CAHbLzkp2L-g7ms7_ddpA+LpEmKkk6a+9KebBYWkaLV5EXSPu=Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Remove shrinker's nr_deferred
To:     Dave Chinner <david@fromorbit.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 30, 2020 at 12:31 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Sat, Sep 26, 2020 at 01:31:36PM -0700, Yang Shi wrote:
> > Hi Dave,
> >
> > I was exploring to make the "nr_deferred" per memcg. I looked into and
> > had some prototypes for two approaches so far:
> > 1. Have per memcg data structure for each memcg aware shrinker, just
> > like what shrinker_map does.
> > 2. Have "nr_deferred" on list_lru_one for memcg aware lists.
> >
> > Both seem feasible, however the latter one looks much cleaner, I just
> > need to add two new APIs for shrinker which gets and sets
> > "nr_deferred" respectively. And, just memcg aware shrinkers need
> > define those two callouts. We just need to care about memcg aware
> > shrinkers, and the most memcg aware shrinkers (inode/dentry, nfs and
> > workingset) use list_lru, so I'd prefer the latter one.
>
> The list_lru is completely separate from the shrinker context. The
> structure that tracks objects in a subsystem is not visible or aware
> of how the high level shrinker scanning algorithms work. Not to
> mention that subsystem shrinkers can be memcg aware without using
> list_lru structures to index objects owned by a given memcg. Hence I
> really don't like the idea of tying the shrinker control data deeply
> into subsystem cache indexing....

I see your points. Yes, makes sense to me. The list_lru is a common
data structure and could be used by other subsystems, not only memcg
aware shrinkers.

Putting shrinker control data in list_lru seems break the layer. So,
option #1 might be more appropriate. The change looks like:

struct mem_cgroup_per_node {
...
        struct memcg_shrinker_map __rcu *shrinker_map;
+       struct memcg_shrinker_deferred __rcu    *shrinker_deferred;
...
}

>
>
> > But there are two memcg aware shrinkers are not that straightforward
> > to deal with:
> > 1. The deferred split THP. It doesn't use list_lru, but actually I
> > don't worry about this one, since it is not cache just some partial
> > unmapped THPs. I could try to convert it to use list_lru later on or
> > just kill deferred split by making vmscan split partial unmapped THPs.
> > So TBH I don't think it is a blocker.
>
> What a fantastic abuse of the reclaim infrastructure. :/
>
> First it was just defered work. Then it became NUMA_AWARE. THen it
> became MEMCG_AWARE and....
>
> Oh, man what a nasty hack that SHRINKER_NONSLAB flag is so that it
> runs through shrink_slab_memcg() even when memcgs are configured in
> but kmem tracking disabled. We have heaps of shrinkers that reclaim
> from things that aren't slab caches, but this one is just nuts.
>
> > 2. The fs_objects. This one looks weird. It shares the same shrinker
> > with inode/dentry. The only user is XFS currently. But it looks it is
> > not really memcg aware at all, right?
>
> It most definitely is.
>
> The VFS dentry and inode cache reclaim are memcg aware. The
> fs_objects callout is for filesystem level object garbage collection
> that can be done as a result of the dentry and inode caches being
> reclaimed.
>
> i.e. once the VFS has reclaimed the inode attached to the memcg, it
> is no longer attached and accounted to the memcg anymore. It is
> owned by the filesystem at this point, and it is entirely up to the
> filesytem to when it can then be freed. Most filesystems do it in
> the inode cache reclaim via the ->destroy method. XFS, OTOH, tags
> freeable inodes in it's internal radix trees rather than freeing
> them immediately because it still may have to clean the inode before
> it can be freed. Hence we defer freeing of inodes until the
> ->fs_objects pass....

Aha, thanks for elaborating. Now I see what it is doing for...

>
> > They are managed by radix tree
> > which is not per memcg by looking into xfs code, so the "per list_lru
> > nr_deferred" can't work for it.  I thought of a couple of ways to
> > tackle it off the top of my head:
> >     A. Just ignore it. If the amount of fs_objects are negligible
> > comparing to inode/dentry, then I think it can be just ignored and
> > kept it as is.
>
> Ah, no, they are not negliable. Under memory pressure, the number of
> objects is typically 1/3rd dentries, 1/3rd VFS inodes, 1/3rd fs
> objects to be reclaimed. The dentries and VFS inodes are owned by
> VFS level caches and associated with memcgs, the fs_objects are only
> visible to the filesystem.
>
> >     B. Move it out of inode/dentry shrinker. Add a dedicated shrinker
> > for it, for example, sb->s_fs_obj_shrink.
>
> No, they are there because the reclaim has to be kept in exact
> proportion to the dentry and inode reclaim quantities. That's the
> reason I put that code there in the first place: a separate inode
> filesystem cache shrinker just didn't work well at all.
>
> >     C. Make it really memcg aware and use list_lru.
>
> Two things. Firstly, objects are owned by the filesystem at this
> point, not memcgs. Memcgs were detatched at the VFS inode reclaim
> layer.
>
> Secondly, list-lru does not scale well enough for the use needed by
> XFS. We use radix trees so we can do lockless batch lookups and
> IO-efficient inode-order reclaim passes. We also have concurrent
> reclaim capabilities because of the lockless tag lookup walks.
> Using a list_lru for this substantially reduces reclaim performance
> and greatly increases CPU usage of reclaim because of contention on
> the internal list lru locks. Been there, measured that....
>
> > I don't have any experience on XFS code, #C seems the most optimal,
> > but should be the most time consuming, I'm not sure if it is worth it
> > or not. So, #B sounds more preferred IMHO.
>
> I think you're going completely in the wrong direction. The problem
> that needs solving is integrating shrinker scanning control state
> with memcgs more tightly, not force every memcg aware shrinker to
> use list_lru for their subsystem shrinker implementations....

Thanks a lot for all the elaboration and advice. Integrating shrinker
scanning control state with memcgs more tightly makes sense to me.

>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
