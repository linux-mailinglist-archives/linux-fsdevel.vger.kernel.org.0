Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40313375FD8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 May 2021 07:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbhEGFr3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 May 2021 01:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbhEGFr3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 May 2021 01:47:29 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327DBC061761
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 May 2021 22:46:30 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id cl24-20020a17090af698b0290157efd14899so4771252pjb.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 May 2021 22:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5QMYEa6puQXBOEG+O6tTaTEgtrWwSdoO23hCLMWVhmA=;
        b=hdyY/ZRp0zaTHGB93v9guBByXiAWJNp82XAvn21vWb8WxO24CM2HZaJiiwXKWs235W
         UI+CAmzo0KybZ+vPgEvBiSfvXX1Yu85mHvxsBPJU9PdaQbFCJ6HDeMDAtLd9P6VGR116
         6DBmpEhJfAEJBpe7AzbWn/r3yfA+QzAxQW2/axKv6MNb3kxg49GXHQwtQTwXrwDnzTF6
         lCQoyBGfe9hJbbolVuZPADjY0sU4m4axB/4TxCIT4odv99TeM6v8ru90NNnK1Vzz6Mu6
         N6kqyzSRYygq2DfqB2Z2UcirOmcOiyWjQ24lC5OXWiV3XCXzaAymp6LLlzRZEErwpT0h
         qG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5QMYEa6puQXBOEG+O6tTaTEgtrWwSdoO23hCLMWVhmA=;
        b=O4y2HfAACWYZrP9jCqzFl/WnV/jzi3xXwXgM41O87k2aZmXg+nkfXDn9ctPCTsZJDl
         4hKVamMAxBPq0WiQYRtN1kk1e8oABxQfmqF82v7FhB6lI1qq1sdyLiF2ZG0T4ilVn7KB
         rAAWsfwuXh0cnGIZdzminWGHLOoZnQATroeElTCO51GQDyDYNDfjcg4LZfxNpJ+peWOD
         9FwdEMbT6lgJsByQ0flEQG1WxK7G0+47nyb4ZmfnSKQVWLKc6DGsqsi4YpJmSDyCRRbR
         To3RMThLWOl0c9T8ZSZLVynZvowKgkqQvgoKTk8z2uc9HaNx3aTVbs4A+Ysln73pk5l5
         L0+g==
X-Gm-Message-State: AOAM531SoA3638cOXhXMRsiTRjwBwynEqV0VgGbnYlfBPyY6en+DRk8i
        /zxcbL784+jp0aNuwqHr+rnQvg/QxLXy430ou/k/Iw==
X-Google-Smtp-Source: ABdhPJwBHnWooalbHPmdSUpXCowHfy3SHRmS+7fnjNEon7F2Y9NK9R/hhSADwZCSxVqHcubCFzZvs7pRBteBN2R6fAU=
X-Received: by 2002:a17:902:e54e:b029:ed:6ed2:d0ab with SMTP id
 n14-20020a170902e54eb02900ed6ed2d0abmr8084770plf.24.1620366389736; Thu, 06
 May 2021 22:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210428094949.43579-1-songmuchun@bytedance.com>
 <20210430004903.GF1872259@dread.disaster.area> <YItf3GIUs2skeuyi@carbon.dhcp.thefacebook.com>
 <20210430032739.GG1872259@dread.disaster.area> <CAMZfGtXawtMT4JfBtDLZ+hES4iEHFboe2UgJee_s-NhZR5faAw@mail.gmail.com>
 <20210502235843.GJ1872259@dread.disaster.area> <CAMZfGtVK2Sracf=ongpNJqacafmC2ZsNy-KxEL67fVCAGXz3xA@mail.gmail.com>
 <20210505011331.GM1872259@dread.disaster.area>
In-Reply-To: <20210505011331.GM1872259@dread.disaster.area>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 7 May 2021 13:45:53 +0800
Message-ID: <CAMZfGtW-Ad0wrtkx7qvfYOcjPFa67vyPZ2SKEJSdq118+Z8myA@mail.gmail.com>
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
        Wei Yang <richard.weiyang@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 5, 2021 at 9:13 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Mon, May 03, 2021 at 02:33:21PM +0800, Muchun Song wrote:
> > On Mon, May 3, 2021 at 7:58 AM Dave Chinner <david@fromorbit.com> wrote:
> > > > If the user wants to insert the allocated object to its lru list in
> > > > the feature. The
> > > > user should use list_lru_kmem_cache_alloc() instead of kmem_cache_alloc().
> > > > I have looked at the code closely. There are 3 different kmem_caches that
> > > > need to use this new API to allocate memory. They are inode_cachep,
> > > > dentry_cache and radix_tree_node_cachep. I think that it is easy to migrate.
> > >
> > > It might work, but I think you may have overlooked the complexity
> > > of inode allocation for filesystems. i.e.  alloc_inode() calls out
> > > to filesystem allocation functions more often than it allocates
> > > directly from the inode_cachep.  i.e.  Most filesystems provide
> > > their own ->alloc_inode superblock operation, and they allocate
> > > inodes out of their own specific slab caches, not the inode_cachep.
> >
> > I didn't realize this before. You are right. Most filesystems
> > have their own kmem_cache instead of inode_cachep.
> > We need a lot of filesystems special to be changed.
> > Thanks for your reminder.
> >
> > >
> > > And then you have filesystems like XFS, where alloc_inode() will
> > > never be called, and implement ->alloc_inode as:
> > >
> > > /* Catch misguided souls that try to use this interface on XFS */
> > > STATIC struct inode *
> > > xfs_fs_alloc_inode(
> > >         struct super_block      *sb)
> > > {
> > >         BUG();
> > >         return NULL;
> > > }
> > >
> > > Because all the inode caching and allocation is internal to XFS and
> > > VFS inode management interfaces are not used.
> > >
> > > So I suspect that an external wrapper function is not the way to go
> > > here - either internalising the LRU management into the slab
> > > allocation or adding the memcg code to alloc_inode() and filesystem
> > > specific routines would make a lot more sense to me.
> >
> > Sure. If we introduce kmem_cache_alloc_lru, all filesystems
> > need to migrate to kmem_cache_alloc_lru. I cannot figure out
> > an approach that does not need to change filesystems code.
>
> Right, I don't think there's a way to avoid changing all the
> filesystem code if we are touching the cache allocation routines.
> However, if we hide it all inside the allocation routine, then
> the changes to each filesystem is effectively just a 1-liner like:
>
> -       inode = kmem_cache_alloc(inode_cache, GFP_NOFS);
> +       inode = kmem_cache_alloc_lru(inode_cache, sb->s_inode_lru, GFP_NOFS);
>
> Or perhaps, define a generic wrapper function like:
>
> static inline void *
> alloc_inode_sb(struct superblock *sb, struct kmem_cache *cache, gfp_flags_t gfp)
> {
>         return kmem_cache_alloc_lru(cache, sb->s_inode_lru, gfp);
> }

Good idea. I am doing this. A preliminary patch is expected next week.

Thanks.

>
> And then each filesystem ends up with:
>
> -       inode = kmem_cache_alloc(inode_cache, GFP_NOFS);
> +       inode = alloc_inode_sb(sb, inode_cache, GFP_NOFS);
>
> so that all the superblock LRU stuff is also hidden from the
> filesystems...
>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
