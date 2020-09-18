Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5701526E9D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 02:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgIRAMW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 20:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgIRAMW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 20:12:22 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B885C061756;
        Thu, 17 Sep 2020 17:12:22 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id i1so4360153edv.2;
        Thu, 17 Sep 2020 17:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x7xoUw4UIz8DNxgvWH4XK9GDVlzuywiCG60Fk455ZCE=;
        b=UNhsHgFJfDDUAO/zwp+0gI8GD3F27P00C70qZ/PjtRzjZds3/ERYgkROdo1oRUXJDE
         3VjmgtCWQrtM4hSL5JGokV5ZLXVO3t9Wf1PUonV4p+RkqgsSKnu8SXe64i5qBTm4ZMwg
         g3k3ju3Ay5UkdjgrAUNX15nZ8Ht/ZRjQ439RWElDCIVEc3u/j22B0zBOeDgNxRh/FFC5
         i5WCeoKRxRMYd+BRnjWqxsVMENAJ7c4+u7NKezOR9sK5bDOo+JMzj/6+8bspbNwA1N0n
         qRdCL9Zale567TiNkUs+gRrrwOzNFm/kxzn2OgRkjfO0HVpQiW2ebc1Dux3LOkd4iVI+
         QNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x7xoUw4UIz8DNxgvWH4XK9GDVlzuywiCG60Fk455ZCE=;
        b=aYyB3ZIcjYwqCALR0YUofq+/g4LbSxsSWC4+4m/MbsfBVO+ftctE7alXz78GuUMh0v
         MNUQ5Air2+Ie4oIMZhHzJ6OlXhzxhhtPl9nZXRONIALlrN7FT/o85sdO68kq2kddHQGq
         ThHjZ2Bjgg+pSD3VT2n8VnKvaDwyrEdVza2PHBiFR+X6wnv6K+5MIpSV4QBbrSan/fGB
         ma/ArPRqgWZCulalgS6cuKpfN7D7I9/EizOdQYg7JuTMdPLrwvnfBAsrKFu+j2GRJeW9
         +KFEHvufbQGWvKPXhGEXOtMjHBKdaWOLRelcyTg6/9fXbKNNsrWfch73kD74b3Z/iacO
         QlZw==
X-Gm-Message-State: AOAM533Q1SISW99Nmvrtvx39T3xbwUm7wkKi4Un4++4WQkQrga3xUMcm
        LTH+V0KE2QoWacAJhKNoNyR9HitVb/GHXVZjimY1huIGbsY=
X-Google-Smtp-Source: ABdhPJwluRs9wBUgbv+VILcAPhpt9vFkuYfJvE1zncgvT233DcSHKS4sgJN+VIlFMacT5G7tHAai5+kTWAEuigSc/rk=
X-Received: by 2002:a05:6402:144c:: with SMTP id d12mr36513378edx.168.1600387940830;
 Thu, 17 Sep 2020 17:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200916185823.5347-1-shy828301@gmail.com> <20200917023742.GT12096@dread.disaster.area>
In-Reply-To: <20200917023742.GT12096@dread.disaster.area>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 17 Sep 2020 17:12:08 -0700
Message-ID: <CAHbLzkrGB_=KBgD1sMpW33QjWSGTXNnLy3JtVUyHc2Omsa3gWA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Remove shrinker's nr_deferred
To:     Dave Chinner <david@fromorbit.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 16, 2020 at 7:37 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Wed, Sep 16, 2020 at 11:58:21AM -0700, Yang Shi wrote:
> >
> > Recently huge amount one-off slab drop was seen on some vfs metadata heavy workloads,
> > it turned out there were huge amount accumulated nr_deferred objects seen by the
> > shrinker.
> >
> > I managed to reproduce this problem with kernel build workload plus negative dentry
> > generator.
> >
> > First step, run the below kernel build test script:
> >
> > NR_CPUS=`cat /proc/cpuinfo | grep -e processor | wc -l`
> >
> > cd /root/Buildarea/linux-stable
> >
> > for i in `seq 1500`; do
> >         cgcreate -g memory:kern_build
> >         echo 4G > /sys/fs/cgroup/memory/kern_build/memory.limit_in_bytes
> >
> >         echo 3 > /proc/sys/vm/drop_caches
> >         cgexec -g memory:kern_build make clean > /dev/null 2>&1
> >         cgexec -g memory:kern_build make -j$NR_CPUS > /dev/null 2>&1
> >
> >         cgdelete -g memory:kern_build
> > done
> >
> > That would generate huge amount deferred objects due to __GFP_NOFS allocations.
> >
> > Then run the below negative dentry generator script:
> >
> > NR_CPUS=`cat /proc/cpuinfo | grep -e processor | wc -l`
> >
> > mkdir /sys/fs/cgroup/memory/test
> > echo $$ > /sys/fs/cgroup/memory/test/tasks
> >
> > for i in `seq $NR_CPUS`; do
> >         while true; do
> >                 FILE=`head /dev/urandom | tr -dc A-Za-z0-9 | head -c 64`
> >                 cat $FILE 2>/dev/null
> >         done &
> > done
> >
> > Then kswapd will shrink half of dentry cache in just one loop as the below tracing result
> > showed:
> >
> >       kswapd0-475   [028] .... 305968.252561: mm_shrink_slab_start: super_cache_scan+0x0/0x190 0000000024acf00c: nid: 0
> > objects to shrink 4994376020 gfp_flags GFP_KERNEL cache items 93689873 delta 45746 total_scan 46844936 priority 12
> >       kswapd0-475   [021] .... 306013.099399: mm_shrink_slab_end: super_cache_scan+0x0/0x190 0000000024acf00c: nid: 0 unused
> > scan count 4994376020 new scan count 4947576838 total_scan 8 last shrinker return val 46844928
>
>
> You have 93M dentries and inodes in the cache, and the reclaim delta is 45746,
> which is totally sane for a priority 12 reclaim priority. SO you've
> basically had to do a couple of million GFP_NOFS direct reclaim
> passes that were unable to reclaim anything to get to a point
> where the deferred reclaim would up to 4.9 -billion- objects.
>
> Basically, you would up the deferred work so far that it got out of
> control before a GFP_KERNEL reclaim context could do anything to
> bring it under control.
>
> However, removing defered work is not the solution. If we don't
> defer some of this reclaim work, then filesystem intensive workloads
> -cannot reclaim memory from their own caches- when they need memory.
> And when those caches largely dominate the used memory in the
> machine, this will grind the filesystem workload to a halt.. Hence
> this deferral mechanism is actually critical to keeping the
> filesystem caches balanced with the rest of the system.

Yes, I agree there might be imbalance if vfs caches shrinkers can't
keep up due to excessive __GFP_NOFS allocations.

>
> The behaviour you see is the windup clamping code triggering:
>
>         /*
>          * We need to avoid excessive windup on filesystem shrinkers
>          * due to large numbers of GFP_NOFS allocations causing the
>          * shrinkers to return -1 all the time. This results in a large
>          * nr being built up so when a shrink that can do some work
>          * comes along it empties the entire cache due to nr >>>
>          * freeable. This is bad for sustaining a working set in
>          * memory.
>          *
>          * Hence only allow the shrinker to scan the entire cache when
>          * a large delta change is calculated directly.
>          */
>         if (delta < freeable / 4)
>                 total_scan = min(total_scan, freeable / 2);
>
> It clamps the worst case freeing to half the cache, and that is
> exactly what you are seeing. This, unfortunately, won't be enough to
> fix the windup problem once it's spiralled out of control. It's
> fairly rare for this to happen - it takes effort to find an adverse
> workload that will cause windup like this.

I'm not sure if it is very rare, but my reproducer definitely could
generate huge amount of deferred objects easily. In addition it might
be easier to run into this case with hundreds of memcgs. Just imaging
hundreds memcgs run limit reclaims with __GFP_NOFS, the amount of
deferred objects can be built up easily.

On our production machine, I saw much more absurd deferred objects,
check the below tracing result out:

<...>-48776 [032] .... 27970562.458916: mm_shrink_slab_start:
super_cache_scan+0x0/0x1a0 ffff9a83046f3458: nid: 0 objects to shrink
2531805877005 gfp_flags GFP_HIGHUSER_MOVABLE pgs_scanned 32 lru_pgs
9300 cache items 1667 delta 11 total_scan 833

There are 2.5 trillion deferred objects on one node! So total > 5 trillion!

> So, with all that said, a year ago I actually fixed this problem
> as part of some work I did to provide non-blocking inode reclaim
> infrastructure in the shrinker for XFS inode reclaim.
> See this patch:
>
> https://lore.kernel.org/linux-xfs/20191031234618.15403-13-david@fromorbit.com/

Thanks for this. I remembered the patches, but I admitted I was not
aware deferred objects could go wild like that.

>
> It did two things. First it ensured all the deferred work was done
> by kswapd so that some poor direct reclaim victim didn't hit a
> massive reclaim latency spike because of windup. Secondly, it
> clamped the maximum windup to the maximum single pass reclaim scan
> limit, which is (freeable * 2) objects.
>
> Finally it also changed the amount of deferred work a single kswapd
> pass did to be directly proportional to the reclaim priority. Hence
> as we get closer to OOM, kswapd tries much harder to get the
> deferred work backlog down to zero. This means that a single, low
> priority reclaim pass will never reclaim half the cache - only
> sustained memory pressure and _reclaim priority windup_ will do
> that.

Other than these, there are more problems:

- The amount of deferred objects seem get significantly overestimated
and unbounded. For example, if one lru has 1000 objects, the amount of
reclaimables is bounded to 1000, but the amount of deferred is not. It
may go much bigger than 1000, right? As the above tracing result
shows, 2.5 trillion deferred objects on one node, assuming all of them
are dentry (192 bytes per object), so the total size of deferred on
one node is ~480TB! Or this is a bug?

- The deferred will be reset by the reclaimer who gets there first,
then other concurrent reclaimers just see 0 or very few deferred
objects. So the clamp may not happen on the lrus which have most
objects. For example, memcg A's dentry lru has 1000 objects, memcg B's
dentry lru has 1 million objects, but memcg A's limit reclaim is run
first, then just 500 was clamped.

- Currently the deferred objects are account per shrinker, it sounds
not very fair, particularly given the environment with hundreds of
memcgs. Some memcgs may not do a lot __GFP_NOFS allocations, but the
clamp may hit them. So, off the top of my head, I'm wondering whether
it sounds better to have deferred per-memcg, so who generates deferred
who gets punished.

- Some workloads, i.e. git server, don't want that clamp behavior or
wish it goes more mild. For example, the ratio between vfs caches and
page caches is 10:1 on some our production servers.

- Waiting for kswapd to clamp those deferred may be too late, and it
may not be able to drive deferred down to a reasonable number at all.
IMHO avoiding the amount of deferred objects goes out of control at
the first place may be much more important.

>
> You probably want to look at all the shrinker infrastructure patches
> in that series as the deferred work tracking and accounting changes
> span a few patches in the series:
>
> https://lore.kernel.org/linux-xfs/20191031234618.15403-1-david@fromorbit.com/

Yes, I will take a closer look. I do appreciate all the comments.

>
> Unfortunately, none of the MM developers showed any interest in
> these patches, so when I found a different solution to the XFS
> problem it got dropped on the ground.
>
> > So why do we have to still keep it around?
>
> Because we need a feedback mechanism to allow us to maintain control
> of the size of filesystem caches that grow via GFP_NOFS allocations.
>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
