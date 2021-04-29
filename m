Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D0036E37C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 05:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236667AbhD2DHV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 23:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhD2DHT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 23:07:19 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63366C06138C
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 20:06:31 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id y32so46134707pga.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 20:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LzsK0XRJRcKd/jwe345M4zklKfr0vxO+HQX9uMQzJl4=;
        b=CFpdvqjMM2iO0438xm8jADNK0yBAPYo0Y8B4AXgDvbm6NzHw+ne8F3PKaur9a2Hy1B
         s29wsFmG9lcJavLzBUgguYTdPhRAvNHdTmYFJ/CIfD4OrU2h+hnbyxf/MKU0LbcwtEtH
         nQi0KXxiMO0i0CZkS0/L4CgQpXEWPNUbkvWmAd5Y/JycUjy4FcXbyFzECLbh6M4XrT8k
         IbR0zFiLPepzcpY8z0Q1M2eOJ+seyn7hkFu26WFJeUnm+007p1/95bRBI+NJay0RIvbn
         6haBsXTRdsPEK7Oz+gt/k6mqMcSQ8BmVn8DzXhuY20PWjEDaPl0YyEGUhmcj0R7HE9x+
         P0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LzsK0XRJRcKd/jwe345M4zklKfr0vxO+HQX9uMQzJl4=;
        b=hRiktE34YuhgJFw568wGGNfr3evi5UwuGQeKtBRZXOCxmrcgNJ6ojLY9i5TymfOGQW
         /PUjXwZqciH31nMK/nFuAE1xquIEs2AzSsSE95EZP1SNfcLTESylr6XEoVURsfgdnMoD
         E/YyeJPYaCVAfv4zPLvV1hQWh/+zriv0gD/gcCRQivqKEPKrZB6ytUjB3b7mJLvruJzO
         ZtZ1Lb55ZmjWC0x+lOK1pZkIjJk18vnrkAcpE3EzWmiqwcRdocM9I9tSfqZN2ZWzVgVk
         giQ2o7ywUB0E6//BUmQYtzwJvg1xRkIicIujq9HKAWnmYdkSNzbAD/f5RASWgBfClc04
         o6Tw==
X-Gm-Message-State: AOAM530ZCFoRKzPEnXu9OpAu1KAVs49nxYVX14lbBplFYTCdJsXx9eAY
        GILiR1o3W9zZaTl4H43itMRBtZIxZ6yxj1OO54zUWg==
X-Google-Smtp-Source: ABdhPJxpPyXvdCZEeyYIOqvE+aee4n1bqCETIhvrgSUIn3wIKuGSLDBgNYTRXHjGCjHCYUxwxi2fmdHH694cC62htOU=
X-Received: by 2002:a05:6a00:8c7:b029:20f:1cf4:d02 with SMTP id
 s7-20020a056a0008c7b029020f1cf40d02mr31717884pfu.49.1619665590935; Wed, 28
 Apr 2021 20:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210428094949.43579-1-songmuchun@bytedance.com> <CALvZod6XtOpPAg5BipOe3fWJrDXFhonqgne8eaD6QBr07rDR2w@mail.gmail.com>
In-Reply-To: <CALvZod6XtOpPAg5BipOe3fWJrDXFhonqgne8eaD6QBr07rDR2w@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 29 Apr 2021 11:05:53 +0800
Message-ID: <CAMZfGtXfauTObW=+PA03WD14b7wzX7cbgXBYqQ0nFs1LVXmzWg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 0/9] Shrink the list lru size on memory
 cgroup removal
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Yang Shi <shy828301@gmail.com>,
        alexs@kernel.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 29, 2021 at 7:32 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Wed, Apr 28, 2021 at 2:54 AM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > In our server, we found a suspected memory leak problem. The kmalloc-32
> > consumes more than 6GB of memory. Other kmem_caches consume less than 2GB
> > memory.
> >
> > After our in-depth analysis, the memory consumption of kmalloc-32 slab
> > cache is the cause of list_lru_one allocation.
> >
> >   crash> p memcg_nr_cache_ids
> >   memcg_nr_cache_ids = $2 = 24574
> >
> > memcg_nr_cache_ids is very large and memory consumption of each list_lru
> > can be calculated with the following formula.
> >
> >   num_numa_node * memcg_nr_cache_ids * 32 (kmalloc-32)
> >
> > There are 4 numa nodes in our system, so each list_lru consumes ~3MB.
> >
> >   crash> list super_blocks | wc -l
> >   952
> >
> > Every mount will register 2 list lrus, one is for inode, another is for
> > dentry. There are 952 super_blocks. So the total memory is 952 * 2 * 3
> > MB (~5.6GB). But the number of memory cgroup is less than 500. So I
> > guess more than 12286 containers have been deployed on this machine (I
> > do not know why there are so many containers, it may be a user's bug or
> > the user really want to do that). But now there are less than 500
> > containers in the system. And memcg_nr_cache_ids has not been reduced
> > to a suitable value. This can waste a lot of memory. If we want to reduce
> > memcg_nr_cache_ids, we have to reboot the server. This is not what we
> > want.
> >
> > So this patchset will dynamically adjust the value of memcg_nr_cache_ids
> > to keep healthy memory consumption. In this case, we may be able to restore
> > a healthy environment even if the users have created tens of thousands of
> > memory cgroups and then destroyed those memory cgroups. This patchset also
> > contains some code simplification.
> >
>
> There was a recent discussion [1] on the same issue. Did you get the
> chance to take a look at that. I have not gone through this patch
> series yet but will do in the next couple of weeks.
>
> [1] https://lore.kernel.org/linux-fsdevel/20210405054848.GA1077931@in.ibm.com/

Thanks for your reminder.

No, I haven't. But now I have looked at this. The issue is very similar
to mine. But Bharata seems to want to run 10k containers. And
optimize the memory consumption of list_lru_one in this case.
This is not what I do. I want to try to shrink the size of the list lrus
when the number of memcgs is reduced from tens of thousands
to hundreds.

Thanks.
