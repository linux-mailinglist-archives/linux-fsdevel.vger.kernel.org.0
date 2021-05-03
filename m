Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F743711AB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 08:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbhECGe6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 02:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhECGe5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 02:34:57 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DC1C061756
        for <linux-fsdevel@vger.kernel.org>; Sun,  2 May 2021 23:33:58 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id l10-20020a17090a850ab0290155b06f6267so5149013pjn.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 May 2021 23:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YAfjaggDazXvQtYp2FS5y03jgZVhcBFsjn4+g9RTkfc=;
        b=xVJ7R69O2ECyU0IHuW1rDWvr0VqTU50aIrgzPU9MNFjG8trH7bMeywNS5jLq2b1IWp
         X2yPhy6OQINzdEYHRqLd9uCiHVslCu4qd5YrwV4j7EdBS094XPIhUQpku9O7nzPMuWXc
         ZvAHnnFNRwElWf8eCLM0VcMOr9hg5CCU0sC9mWBnTw91VcdpjRU7v+v5qe2TioP5oYxD
         xn+Yix1jrTA7hER1/DGHC8zmKoU1PfLv+2XuyW5xjTXUU9LP93uSz8AS/kz7Pcg5AVAi
         lyJfj18aUtanwex7L2CWXn3M1gpeWEM/VtFmEijMqRLUzUIBcDH7fquyDzainBL0VlLA
         sjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YAfjaggDazXvQtYp2FS5y03jgZVhcBFsjn4+g9RTkfc=;
        b=bFIbBdqC17kdBh6DZKe/dMArG+dOxQ+CGjmy1mCotnBXUwYvVIzWufpbg2aMxjLUPZ
         NzIXDXmmDH7zM8tN7uBmibSw7xMTwFuJ6bOzLdIZ3kp15bLMPYbvB4daY0pEZnp1/ZEp
         REdNzdK3t0dgSFv2iG6uQdsI6IW0SvBWO7sQoj/vxzGF2GBTzijfg/kn8VOxxQUXbVle
         ENuGOI0NinYqOAUINXzqtyxyznpTEluHy+NaxKv84d25RvdOTQtQtphLL5n3ljTCaJFA
         kIq/6i+JO8nWwHbxhZQnG1lToKkMIp/DrZgjq2RLdMbo9J+1jsxgF0ZipALkcUj04sR0
         ISjQ==
X-Gm-Message-State: AOAM532eGSsPbsJiSTst7o1O8yqx4UwY5Fs1ylW2ncBvbrfzoI9M+Z+O
        +KowDiKpssiHBcvRQs7t9uWaeC29jWvzHxatyB2X/Q==
X-Google-Smtp-Source: ABdhPJxGflL8gqcfGI3qnihVxhFS3o1OhYuGJJNiad6v/bHj/QMwqly1oymqd0EqExsT0FHNjife4SK934iFvznUWNo=
X-Received: by 2002:a17:90a:644b:: with SMTP id y11mr19284123pjm.229.1620023638171;
 Sun, 02 May 2021 23:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210428094949.43579-1-songmuchun@bytedance.com>
 <20210430004903.GF1872259@dread.disaster.area> <YItf3GIUs2skeuyi@carbon.dhcp.thefacebook.com>
 <20210430032739.GG1872259@dread.disaster.area> <CAMZfGtXawtMT4JfBtDLZ+hES4iEHFboe2UgJee_s-NhZR5faAw@mail.gmail.com>
 <20210502235843.GJ1872259@dread.disaster.area>
In-Reply-To: <20210502235843.GJ1872259@dread.disaster.area>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 3 May 2021 14:33:21 +0800
Message-ID: <CAMZfGtVK2Sracf=ongpNJqacafmC2ZsNy-KxEL67fVCAGXz3xA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 0/9] Shrink the list lru size on memory
 cgroup removal
To:     Dave Chinner <david@fromorbit.com>
Cc:     Roman Gushchin <guro@fb.com>, Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>, alexs@kernel.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 3, 2021 at 7:58 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Fri, Apr 30, 2021 at 04:32:39PM +0800, Muchun Song wrote:
> > On Fri, Apr 30, 2021 at 11:27 AM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > On Thu, Apr 29, 2021 at 06:39:40PM -0700, Roman Gushchin wrote:
> > > > On Fri, Apr 30, 2021 at 10:49:03AM +1000, Dave Chinner wrote:
> > > > > On Wed, Apr 28, 2021 at 05:49:40PM +0800, Muchun Song wrote:
> > > > > > In our server, we found a suspected memory leak problem. The kmalloc-32
> > > > > > consumes more than 6GB of memory. Other kmem_caches consume less than 2GB
> > > > > > memory.
> > > > > >
> > > > > > After our in-depth analysis, the memory consumption of kmalloc-32 slab
> > > > > > cache is the cause of list_lru_one allocation.
> > > > > >
> > > > > >   crash> p memcg_nr_cache_ids
> > > > > >   memcg_nr_cache_ids = $2 = 24574
> > > > > >
> > > > > > memcg_nr_cache_ids is very large and memory consumption of each list_lru
> > > > > > can be calculated with the following formula.
> > > > > >
> > > > > >   num_numa_node * memcg_nr_cache_ids * 32 (kmalloc-32)
> > > > > >
> > > > > > There are 4 numa nodes in our system, so each list_lru consumes ~3MB.
> > > > > >
> > > > > >   crash> list super_blocks | wc -l
> > > > > >   952
> > > > >
> > > > > The more I see people trying to work around this, the more I think
> > > > > that the way memcgs have been grafted into the list_lru is back to
> > > > > front.
> > > > >
> > > > > We currently allocate scope for every memcg to be able to tracked on
> > > > > every not on every superblock instantiated in the system, regardless
> > > > > of whether that superblock is even accessible to that memcg.
> > > > >
> > > > > These huge memcg counts come from container hosts where memcgs are
> > > > > confined to just a small subset of the total number of superblocks
> > > > > that instantiated at any given point in time.
> > > > >
> > > > > IOWs, for these systems with huge container counts, list_lru does
> > > > > not need the capability of tracking every memcg on every superblock.
> > > > >
> > > > > What it comes down to is that the list_lru is only needed for a
> > > > > given memcg if that memcg is instatiating and freeing objects on a
> > > > > given list_lru.
> > > > >
> > > > > Which makes me think we should be moving more towards "add the memcg
> > > > > to the list_lru at the first insert" model rather than "instantiate
> > > > > all at memcg init time just in case". The model we originally came
> > > > > up with for supprting memcgs is really starting to show it's limits,
> > > > > and we should address those limitations rahter than hack more
> > > > > complexity into the system that does nothing to remove the
> > > > > limitations that are causing the problems in the first place.
> > > >
> > > > I totally agree.
> > > >
> > > > It looks like the initial implementation of the whole kernel memory accounting
> > > > and memcg-aware shrinkers was based on the idea that the number of memory
> > > > cgroups is relatively small and stable.
> > >
> > > Yes, that was one of the original assumptions - tens to maybe low
> > > hundreds of memcgs at most. The other was that memcgs weren't NUMA
> > > aware, and so would only need a single LRU list per memcg. Hence the
> > > total overhead even with "lots" of memcgsi and superblocks the
> > > overhead wasn't that great.
> > >
> > > Then came "memcgs need to be NUMA aware" because of the size of the
> > > machines they were being use for resrouce management in, and that
> > > greatly increased the per-memcg, per LRU overhead. Now we're talking
> > > about needing to support a couple of orders of magnitude more memcgs
> > > and superblocks than were originally designed for.
> > >
> > > So, really, we're way beyond the original design scope of this
> > > subsystem now.
> >
> > Got it. So it is better to allocate the structure of the list_lru_node
> > dynamically. We should only allocate it when it is really demanded.
> > But allocating memory by using GFP_ATOMIC in list_lru_add() is
> > not a good idea. So we should allocate the memory out of
> > list_lru_add(). I can propose an approach that may work.
> >
> > Before start, we should know about the following rules of list lrus.
> >
> > - Only objects allocated with __GFP_ACCOUNT need to allocate
> >   the struct list_lru_node.
>
> This seems .... misguided. inode and dentry caches are already
> marked as accounted, so individual calls to allocate from these
> slabs do not need this annotation.

Sorry for the confusion. You are right.

>
> > - The caller of allocating memory must know which list_lru the
> >   object will insert.
> >
> > So we can allocate struct list_lru_node when allocating the
> > object instead of allocating it when list_lru_add().  It is easy, because
> > we already know the list_lru and memcg which the object belongs
> > to. So we can introduce a new helper to allocate the object and
> > list_lru_node. Like below.
> >
> > void *list_lru_kmem_cache_alloc(struct list_lru *lru, struct kmem_cache *s,
> >                                 gfp_t gfpflags)
> > {
> >         void *ret = kmem_cache_alloc(s, gfpflags);
> >
> >         if (ret && (gfpflags & __GFP_ACCOUNT)) {
> >                 struct mem_cgroup *memcg = mem_cgroup_from_obj(ret);
> >
> >                 if (mem_cgroup_is_root(memcg))
> >                         return ret;
> >
> >                 /* Allocate per-memcg list_lru_node, if it already
> > allocated, do nothing. */
> >                 memcg_list_lru_node_alloc(lru, memcg,
> > page_to_nid(virt_to_page(ret)), gfpflags);
>
> If we are allowing kmem_cache_alloc() to fail, then we can allow
> memcg_list_lru_node_alloc() to fail, too.
>
> Also, why put this outside kmem_cache_alloc()? Node id and memcg is
> already known internally to kmem_cache_alloc() when allocating from
> a slab, so why not associate the slab allocation with the LRU
> directly when doing the memcg accounting and so avoid doing costly
> duplicate work on every allocation?
>
> i.e. the list-lru was moved inside the mm/ dir because "it's a mm
> specific construct only", so why not actually make use of that
> designation to internalise this entire memcg management issue into
> the slab allocation routines? i.e.  an API like

Yeah, we can.

> kmem_cache_alloc_lru(cache, lru, gfpflags) allows this to be
> completely internalised and efficiently implemented with minimal
> change to callers. It also means that memory allocation callers
> don't need to know anything about memcg management, which is always
> a win....

Great idea. It's efficient. I'd give it a try.

>
> >         }
> >
> >         return ret;
> > }
> >
> > If the user wants to insert the allocated object to its lru list in
> > the feature. The
> > user should use list_lru_kmem_cache_alloc() instead of kmem_cache_alloc().
> > I have looked at the code closely. There are 3 different kmem_caches that
> > need to use this new API to allocate memory. They are inode_cachep,
> > dentry_cache and radix_tree_node_cachep. I think that it is easy to migrate.
>
> It might work, but I think you may have overlooked the complexity
> of inode allocation for filesystems. i.e.  alloc_inode() calls out
> to filesystem allocation functions more often than it allocates
> directly from the inode_cachep.  i.e.  Most filesystems provide
> their own ->alloc_inode superblock operation, and they allocate
> inodes out of their own specific slab caches, not the inode_cachep.

I didn't realize this before. You are right. Most filesystems
have their own kmem_cache instead of inode_cachep.
We need a lot of filesystems special to be changed.
Thanks for your reminder.

>
> And then you have filesystems like XFS, where alloc_inode() will
> never be called, and implement ->alloc_inode as:
>
> /* Catch misguided souls that try to use this interface on XFS */
> STATIC struct inode *
> xfs_fs_alloc_inode(
>         struct super_block      *sb)
> {
>         BUG();
>         return NULL;
> }
>
> Because all the inode caching and allocation is internal to XFS and
> VFS inode management interfaces are not used.
>
> So I suspect that an external wrapper function is not the way to go
> here - either internalising the LRU management into the slab
> allocation or adding the memcg code to alloc_inode() and filesystem
> specific routines would make a lot more sense to me.

Sure. If we introduce kmem_cache_alloc_lru, all filesystems
need to migrate to kmem_cache_alloc_lru. I cannot figure out
an approach that does not need to change filesystems code.

Thanks.

>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
