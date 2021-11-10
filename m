Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E675244B9E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 02:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhKJBSt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 20:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhKJBSs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 20:18:48 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB58FC061764
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Nov 2021 17:16:01 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id k21so915757ioh.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Nov 2021 17:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=stj94EGwcr6EDZXIntFwkyJLCwHPIAGx8uGsazwEWlU=;
        b=Jt159WJFXb+w9GnjT9mv9XpfUzn44VzYBSGluRMBQq31QXeEB0uBGz1HaJfKr7+WAu
         9dLdie2BzO/H6uyvavd9+NitYen0fSltpbIILd2hHjz5ospJO39A+puws0q7jdoU9qLL
         WLu8kyP2Qo8JTKUmCwwtpzJ4v4HP3wFiPCL8LiFPFJbfdw0DX7Mqr3ljvIdqvz7rEEJh
         lBrFU1tCi5cBUwCk1zn7e8t3MCU3Gm3O2ISNL6GsQo9bvKz61Hif4ZdC7TwHKIWzeR6I
         0aRXxOf9lP77tLEoEAVbs9BeyLF2JsGrAoVecOKXhI/3phAeErf6uBoPZ9eHYds3AHNU
         CWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=stj94EGwcr6EDZXIntFwkyJLCwHPIAGx8uGsazwEWlU=;
        b=rlOvi+LZpg5iD33B0k8Fakvq8FZgi7V/jXW53QuEXRumXKHbRJXXJN8xG+BISgXDrT
         NvKq/XoJ8bNY/dRIGfNeopQv5zTbK2RjupVmAP0yQPplXXYQNvS8la87t1sCnP+IhSLO
         5d1becC1QFsYQTANYFpNvm/2brXdnfa6X5LuAUsFOjwviGowc3wJRtkCCPkYgjVA4P+a
         1U6lvXXhp4db1yQ6d6OYLtw3QB9MRzrJOe/vRL8HWy9wVM9B5K9IaaoGvw1+D8NB8ZJT
         vkO3gXaK4g+M3hmNLURHgukzBZb6I/gyWq6ZFCNQxpY/IWVPvZ82QNk4K6qU+DX6cF4H
         LiHw==
X-Gm-Message-State: AOAM533IEEtDsMjUZSl5dI8LQp+mtLovnzD8Z1RJ9Ge4nXKHm+36wUHN
        squ+MgSTwRrn7UR0Y64r/+zNwy3D8sUwmXt6fjU+GA==
X-Google-Smtp-Source: ABdhPJx+8CQ0vAG8/UG1uH9LXnlbcoqHFW49RVAfbweQNd64OIQ81ONcrEhO9Dg9TmUxbFTxvIfWLG8IEVNteOr4lxo=
X-Received: by 2002:a05:6602:1d0:: with SMTP id w16mr8087681iot.140.1636506960996;
 Tue, 09 Nov 2021 17:16:00 -0800 (PST)
MIME-Version: 1.0
References: <20211108211959.1750915-1-almasrymina@google.com>
 <20211108211959.1750915-2-almasrymina@google.com> <20211108221047.GE418105@dread.disaster.area>
 <YYm1v25dLZL99qKK@casper.infradead.org> <20211109011837.GF418105@dread.disaster.area>
 <CAHS8izNwX80px5X=JrQAfgTBO5=rCN_hSybLW6T1CWmqG5b7eQ@mail.gmail.com>
In-Reply-To: <CAHS8izNwX80px5X=JrQAfgTBO5=rCN_hSybLW6T1CWmqG5b7eQ@mail.gmail.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 9 Nov 2021 17:15:49 -0800
Message-ID: <CAHS8izNkHbiYs=GGNrid5O3oRktXoWgsbaKn4RBYFeHK+H+qfw@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] mm/shmem: support deterministic charging of tmpfs
To:     david@fromorbit.com
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Roman Gushchin <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, riel@surriel.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 9, 2021 at 3:56 PM Mina Almasry <almasrymina@google.com> wrote:
>
> On Mon, Nov 8, 2021 at 5:18 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Mon, Nov 08, 2021 at 11:41:51PM +0000, Matthew Wilcox wrote:
> > > On Tue, Nov 09, 2021 at 09:10:47AM +1100, Dave Chinner wrote:
> > > > > + rcu_read_lock();
> > > > > + memcg = rcu_dereference(mapping->host->i_sb->s_memcg_to_charge);
> > > >
> > > > Anything doing pointer chasing to obtain static, unchanging
> > > > superblock state is poorly implemented. The s_memcg_to_charge value never
> > > > changes, so this code should associate the memcg to charge directly
> > > > on the mapping when the mapping is first initialised by the
> > > > filesystem. We already do this with things like attaching address
> > > > space ops and mapping specific gfp masks (i.e
> > > > mapping_set_gfp_mask()), so this association should be set up that
> > > > way, too (e.g. mapping_set_memcg_to_charge()).
> > >
> > > I'm not a fan of enlarging struct address_space with another pointer
> > > unless it's going to be used by all/most filesystems.  If this is
> > > destined to be a shmem-only feature, then it should be in the
> > > shmem_inode instead of the mapping.
> >
> > Neither am I, but I'm also not a fan of the filemap code still
> > having to drill through the mapping to the host inode just to check
> > if it needs to do special stuff for shmem inodes on every call that
> > adds a page to the page cache. This is just as messy and intrusive
> > and the memcg code really has no business digging about in the
> > filesystem specific details of the inode behind the mapping.
> >
> > Hmmm. The mem_cgroup_charge() call in filemap_add_folio() passes a
> > null mm context, so deep in the guts it ends getting the memcg from
> > active_memcg() in get_mem_cgroup_from_mm(). That ends up using
> > current->active_memcg, so maybe a better approach here is to have
> > shmem override current->active_memcg via set_active_memcg() before
> > it enters the generic fs paths and restore it on return...
> >
> > current_fsmemcg()?
> >
>
> Thank you for providing a detailed alternative. To be honest it seems
> a bit brittle to me, as in folks can easily add calls to generic fs
> paths forgetting to override the active_memcg and having memory
> charged incorrectly, but if there is no other option and we want to
> make this a shmem-only feature, I can do this anyway.
>
> > > If we are to have this for all filesystems, then let's do that properly
> > > and make it generic functionality from its introduction.
> >
> > Fully agree.
>
> So the tmpfs feature addresses the first 2 usecases I mention in the
> cover letter. For the 3rd usecase I will likely need to extend this
> support to 1 disk-based filesystem, and I'm not sure which at this
> point. It also looks like Roman has in mind 1 or more use cases and
> may extend it to other filesystems as a result. I'm hoping that I can
> provide the generic implementation and the tmpfs support and in follow
> up patches folks can extend this to other file systems by providing
> the fs-specific changes needed for that filesystem.
>
> AFAICT with this patch the work to extend to another file system is to
> parse the memcg= option in that filesystem, set the s_memcg_to_charge
> on the superblock (or mapping) of that filesystem, and to charge
> s_memcg_to_charge in fs specific code paths, so all are fs-specific
> changes.
>
> Based on this, it seems to me the suggestion is to hang the
> memcg_to_charge off the mapping? I'm not sure if *most/all*
> filesystems will eventually support it, but likely more than just
> tmpfs.
>

Greg actually points out to me off list that the patches - as written
- supports remounting the tmpfs with a different memcg= option, where
future charges will be directed to the new memcg provided by the
option, so s_memcg_to_charge is more of a property of the super_block.

We could explicitly disable remounting with a different memcg=, but
I'm hoping to preserve that support if possible. The only way to
preserve it I think and avoid the pointer chasing in fs generic paths
is for shmem to set_active_memcg() before calling into the generic fs
code, but all other fs that apply this feature will need to do the
same. I'm not sure if that's the better option. Let me know what you
think please. Thanks!

>
> >
> > Cheers,
> >
> > Dave.
> > --
> > Dave Chinner
> > david@fromorbit.com
