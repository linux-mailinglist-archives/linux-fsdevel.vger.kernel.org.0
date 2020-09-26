Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B13279C60
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Sep 2020 22:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgIZUbv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Sep 2020 16:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgIZUbv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Sep 2020 16:31:51 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F97C0613CE;
        Sat, 26 Sep 2020 13:31:50 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id a12so5954253eds.13;
        Sat, 26 Sep 2020 13:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jay0daKnkvYBfUjKB5JRTDx+c48xSBvuHJVdzyjqABg=;
        b=PRfQLMOmbCJsg9ynvuFl0Uew1KIZVaftUjAwv/Tak89F3BsFPYRBwD+wf/fHTr5VP3
         0+v3W9CYRzqm1fe3h08XvPHG1yDa6f7fhfDljoOK7cY7HMFZBlHLErE+vMoLmzph6eNj
         gIjiwtktgIb24I4gzhhL1c/8UZIVoEZlQXpUQQO5KYphIn/H6N/iqSscuZI7UsvRv/lZ
         ffYHuDXnpsunfL3ldXYDgYCROv8zwjhoXrVrwEGAKNpEfu0q79WI0FWWP0+REwAxT+lY
         ZLPS3gZQSXwiGGMJnttjCrXb3Qyk7OSwQndCJ/kesL9HGJFVuLYeLNAIeBqcQz7pNBwh
         QOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jay0daKnkvYBfUjKB5JRTDx+c48xSBvuHJVdzyjqABg=;
        b=d4RmkPpCDWfCd1wMb+as4047OJIkrcT9VjExFeG3ttPyF4ad1/h0mvVzEMM9wOkLnX
         9KAhaoowjLkg22QkKFFTgOoTefprDlxF55zXBRx6KTGNxxW7ndmZ2mXBDQcR1GAunzu1
         gUeXlFb9/eyxw6We/aYkjmjv3tCRFyWaTWcwK0ad2vScDVgiak/FhXrR/b7Fm/WDRyJr
         OEIEs3dPX8UHNichkrrmR/FZnzxCUKT3aMJd/sUP7U6W7Oxt8IYY40iaIs3+5ujgV9Jk
         KvLxn7IeKvsSvCGW6GZ6UCAIA42Z7sjz4iQIYfkiu+Pc32GopBxr4zcf8TR4VlvB4f8X
         aglQ==
X-Gm-Message-State: AOAM530vC93qNBkea103MJFdRRdCq5suGpL2lo9ZlPdoo/IfW3I6DEt6
        CyFcYi7H27NAZnSpfgo50z2NIZRmAvqiH/HGtn5sQPoIQjc=
X-Google-Smtp-Source: ABdhPJwzt9Q9f53+ZFpfeYhT4U5EbU0ELS8TJ6jG0DKSIBlS4N0pUDrakjbFBJ0rJpseYpzW12GLxOQNCEcuczI2e/c=
X-Received: by 2002:a05:6402:144c:: with SMTP id d12mr8321623edx.168.1601152308042;
 Sat, 26 Sep 2020 13:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200916185823.5347-1-shy828301@gmail.com> <20200917023742.GT12096@dread.disaster.area>
 <CAHbLzkrGB_=KBgD1sMpW33QjWSGTXNnLy3JtVUyHc2Omsa3gWA@mail.gmail.com>
 <20200921003231.GZ12096@dread.disaster.area> <CAHbLzkqAWiO4uhGBmbUjgs6EmQazYQXHPxR2-MWo4X8zxZ7gfQ@mail.gmail.com>
In-Reply-To: <CAHbLzkqAWiO4uhGBmbUjgs6EmQazYQXHPxR2-MWo4X8zxZ7gfQ@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Sat, 26 Sep 2020 13:31:36 -0700
Message-ID: <CAHbLzkoidoBWtLtd_3DjuSvm7dAJV1gSJAMmWY95=e8N7Hy=TQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Remove shrinker's nr_deferred
To:     Dave Chinner <david@fromorbit.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dave,

I was exploring to make the "nr_deferred" per memcg. I looked into and
had some prototypes for two approaches so far:
1. Have per memcg data structure for each memcg aware shrinker, just
like what shrinker_map does.
2. Have "nr_deferred" on list_lru_one for memcg aware lists.

Both seem feasible, however the latter one looks much cleaner, I just
need to add two new APIs for shrinker which gets and sets
"nr_deferred" respectively. And, just memcg aware shrinkers need
define those two callouts. We just need to care about memcg aware
shrinkers, and the most memcg aware shrinkers (inode/dentry, nfs and
workingset) use list_lru, so I'd prefer the latter one.

But there are two memcg aware shrinkers are not that straightforward
to deal with:
1. The deferred split THP. It doesn't use list_lru, but actually I
don't worry about this one, since it is not cache just some partial
unmapped THPs. I could try to convert it to use list_lru later on or
just kill deferred split by making vmscan split partial unmapped THPs.
So TBH I don't think it is a blocker.
2. The fs_objects. This one looks weird. It shares the same shrinker
with inode/dentry. The only user is XFS currently. But it looks it is
not really memcg aware at all, right? They are managed by radix tree
which is not per memcg by looking into xfs code, so the "per list_lru
nr_deferred" can't work for it. I thought of a couple of ways to
tackle it off the top of my head:
    A. Just ignore it. If the amount of fs_objects are negligible
comparing to inode/dentry, then I think it can be just ignored and
kept it as is.
    B. Move it out of inode/dentry shrinker. Add a dedicated shrinker
for it, for example, sb->s_fs_obj_shrink.
    C. Make it really memcg aware and use list_lru.

I don't have any experience on XFS code, #C seems the most optimal,
but should be the most time consuming, I'm not sure if it is worth it
or not. So, #B sounds more preferred IMHO.

Advice is much appreciated. Thanks.


On Tue, Sep 22, 2020 at 4:45 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Sun, Sep 20, 2020 at 5:32 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Thu, Sep 17, 2020 at 05:12:08PM -0700, Yang Shi wrote:
> > > On Wed, Sep 16, 2020 at 7:37 PM Dave Chinner <david@fromorbit.com> wrote:
> > > > On Wed, Sep 16, 2020 at 11:58:21AM -0700, Yang Shi wrote:
> > > > It clamps the worst case freeing to half the cache, and that is
> > > > exactly what you are seeing. This, unfortunately, won't be enough to
> > > > fix the windup problem once it's spiralled out of control. It's
> > > > fairly rare for this to happen - it takes effort to find an adverse
> > > > workload that will cause windup like this.
> > >
> > > I'm not sure if it is very rare, but my reproducer definitely could
> > > generate huge amount of deferred objects easily. In addition it might
> > > be easier to run into this case with hundreds of memcgs. Just imaging
> > > hundreds memcgs run limit reclaims with __GFP_NOFS, the amount of
> > > deferred objects can be built up easily.
> >
> > This is the first time I've seen a report that indicates excessive
> > wind-up is occurring in years. That definitely makes it a rare
> > problem in the real world.
> >
> > > On our production machine, I saw much more absurd deferred objects,
> > > check the below tracing result out:
> > >
> > > <...>-48776 [032] .... 27970562.458916: mm_shrink_slab_start:
> > > super_cache_scan+0x0/0x1a0 ffff9a83046f3458: nid: 0 objects to shrink
> > > 2531805877005 gfp_flags GFP_HIGHUSER_MOVABLE pgs_scanned 32 lru_pgs
> > > 9300 cache items 1667 delta 11 total_scan 833
> > >
> > > There are 2.5 trillion deferred objects on one node! So total > 5 trillion!
> >
> > Sure, I'm not saying it's impossible to trigger, just that there are
> > not many common workloads that actually cause it to occur. And,
> > really, if it's wound up that far before you've noticed a problem,
> > then wind-up itself isn't typically a serious problem for
> > systems....
>
> Actually the problem was observed some time ago, I just got some time
> to look into the root cause.
>
> This kind of problem may be more common with memcg environment. For
> example, a misconfigured memcg may incur excessive __GFP_NOFS limit
> reclaims.
>
> >
> > > > So, with all that said, a year ago I actually fixed this problem
> > > > as part of some work I did to provide non-blocking inode reclaim
> > > > infrastructure in the shrinker for XFS inode reclaim.
> > > > See this patch:
> > > >
> > > > https://lore.kernel.org/linux-xfs/20191031234618.15403-13-david@fromorbit.com/
> > >
> > > Thanks for this. I remembered the patches, but I admitted I was not
> > > aware deferred objects could go wild like that.
> >
> > Not many people are....
> >
> > > > It did two things. First it ensured all the deferred work was done
> > > > by kswapd so that some poor direct reclaim victim didn't hit a
> > > > massive reclaim latency spike because of windup. Secondly, it
> > > > clamped the maximum windup to the maximum single pass reclaim scan
> > > > limit, which is (freeable * 2) objects.
> > > >
> > > > Finally it also changed the amount of deferred work a single kswapd
> > > > pass did to be directly proportional to the reclaim priority. Hence
> > > > as we get closer to OOM, kswapd tries much harder to get the
> > > > deferred work backlog down to zero. This means that a single, low
> > > > priority reclaim pass will never reclaim half the cache - only
> > > > sustained memory pressure and _reclaim priority windup_ will do
> > > > that.
> > >
> > > Other than these, there are more problems:
> > >
> > > - The amount of deferred objects seem get significantly overestimated
> > > and unbounded. For example, if one lru has 1000 objects, the amount of
> > > reclaimables is bounded to 1000, but the amount of deferred is not. It
> > > may go much bigger than 1000, right? As the above tracing result
> > > shows, 2.5 trillion deferred objects on one node, assuming all of them
> > > are dentry (192 bytes per object), so the total size of deferred on
> > > one node is ~480TB! Or this is a bug?
> >
> > As the above patchset points out: it can get out of control because
> > it is unbounded. The above patchset bounds the deferred work to (2 *
> > current cache item count) and so it cannot ever spiral out of
> > control like this.
>
> I was thinking about cap it to (2 * freeable) too before I looked into
> your patches :-)
>
> >
> > > - The deferred will be reset by the reclaimer who gets there first,
> > > then other concurrent reclaimers just see 0 or very few deferred
> > > objects.
> >
> > No, not exactly.
> >
> > The current behaviour is that the deferred count is drained by the
> > current shrinker context, then it does whatever work it can, then it
> > puts the remainder of the work that was not done back on the
> > deferred count. This was done so that only a single reclaim context
> > tried to execute the deferred work (i.e. to prevent the deferred
> > work being run multiple times by concurrent reclaim contexts), but
> > if the work didn't get done it was still accounted and would get
> > done later.
>
> Yes, definitely. I should articulated it at the first place.
>
> >
> > A side effect of this was that nothing ever zeros the deferred
> > count, however, because there is no serialisation between concurrent
> > shrinker contexts. That's why it can wind up if the number of
> > GFP_NOFS reclaim contexts greatly exceeds the number of GFP_KERNEL
> > reclaim contexts.
> >
> > This is what the above patchset fixes - deferred work is only ever
> > done by kswapd(), which means it doesn't have to care about multiple
> > reclaim contexts doing deferred work. This simplifies it right down,
> > and it allows us to bound the quantity of deferred work as a single
> > reclaimer will be doing it all...
> >
> > > So the clamp may not happen on the lrus which have most
> > > objects. For example, memcg A's dentry lru has 1000 objects, memcg B's
> > > dentry lru has 1 million objects, but memcg A's limit reclaim is run
> > > first, then just 500 was clamped.
> >
> > Yup, that's a memcg bug. memcg's were grafted onto the side of the
> > shrinker infrastructure, and one of the parts of the shrinker
> > behaviour that was not made per-memcg was the amount of work
> > deferred from the per-memcg shrinker invocation. If you want memcgs
> > to behave correctly w.r.t. work deferred inside a specific memcg
> > shrinker context, then the deferred work accounting needs to be made
> > per-memcg, not just a global per-node count.
> >
> > The first step to doing this, however, is fixing up the problems we
> > currently have with deferred work, and that is the patchset I
> > pointed you to above. We have to push the defered work to the kswapd
> > context so that it can process all the deferred work for all of the
> > memcgs in the system in a single reclaim context; if the memcg is
> > just doing GFP_NOFS allocations, then just deferring the work to the
> > next GFP_KERNEL direct reclaim that specific memcg enters is not
> > going to be sufficient.
>
> But kswapd may be not called in some cases at all. For example, the
> system may have some memcgs configured, every memcg reaches its limit
> and does limit reclaim, but the global memory usage is not high enough
> to wake up kswapd. The deferred objects can get windup, and limit
> reclaim can't bring it down under control.
>
> By making nr_deferred per memcg, memcg limit reclaim could bring the
> deferred objects under control.
>
> >
> > > - Currently the deferred objects are account per shrinker, it sounds
> > > not very fair, particularly given the environment with hundreds of
> > > memcgs. Some memcgs may not do a lot __GFP_NOFS allocations, but the
> > > clamp may hit them. So, off the top of my head, I'm wondering whether
> > > it sounds better to have deferred per-memcg, so who generates deferred
> > > who gets punished.
> >
> > Yup, see above.
> >
> > > - Some workloads, i.e. git server, don't want that clamp behavior or
> > > wish it goes more mild. For example, the ratio between vfs caches and
> > > page caches is 10:1 on some our production servers.
> >
> > The overall system cache balancing has nothing to do with deferred
> > work clamping. The deferred work mechanism is there to make sure
> > unrealised reclaim pressure is fed back into the reclaim subsystem
> > to tell it it needs to do more work...
> >
> > > - Waiting for kswapd to clamp those deferred may be too late, and it
> > > may not be able to drive deferred down to a reasonable number at all.
> > > IMHO avoiding the amount of deferred objects goes out of control at
> > > the first place may be much more important.
> >
> > kswapd is the only guaranteed reclaim context that can make
> > progress on deferred work. Windup is an indications that it hasn't
> > been kicked soon enough. One of the advantages of deferring work to
> > kswapd is that now we have a -algorithmic trigger- for shrinker
> > reclaim contexts kicking kswapd sooner than we currently do. e.g. if
> > the deferred work reaches 1/4 the size of the current cache, kick
> > kswapd to start doing the work we are deferring. This might require
> > marking memcgs and shrinkers as "needing deferred work" similar to
> > how we currently mark memcg shrinkers as "containing shrinkable
> > items" so that we can run kswapd quickly on just the memcgs/shrinker
> > contexts that need deferred work to be done....
>
> This seems feasible, but it sounds like we need introduce another "watermark".
>
> IMHO we could make shrinker behave more fair among memcgs and keep
> deferred objects under control just by making nr_deferred per memcg
> and capping nr_deferred to (2 * freeable) or whatever reasonable
> number.
>
> Both kswapd and global direct reclaim would traverse all memcgs and
> they get nr_deferred from each memcg, they can guarantee all memcgs
> get shrunk at a fair rate. We could shrink harder in kswapd, but both
> kswapd and direct reclaim should do shrink according to priority. This
> should be able to mitigate direct reclaim latency.
>
> Limit reclaim would traverse all memcgs under reclaim root, it could
> help keep deferred objects under control for "limit reclaim only"
> case.
>
> >
> > Cheers,
> >
> > Dave.
> > --
> > Dave Chinner
> > david@fromorbit.com
