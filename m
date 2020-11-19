Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353AB2B8A37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 04:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgKSDAr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 22:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgKSDAr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 22:00:47 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C50C0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 19:00:46 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id 34so2881963pgp.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 19:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rRdwwTYB3THrODEV2neHSr1r681wlaqYPsv7e09Hwos=;
        b=LM92KKlORG+zZ7ND3In9NvLTUuK9re084Me4WdGG6FNQ/FegfXF8bEDKTnKVS8A54b
         bBZYilNcw10GGxe98u61T7cHexzpuGG9oumoCCgI0cTCI8hi9HcmJNw0aJuVCfn5eNtH
         PhSKFNxOIv1A4Xtht3ctoaHXv66tBIz/sPAckb0N6dszngr9dU5iHarjcO2qpFmEnAHL
         leBBlyeB/4Nl9L4E5XMn4pBxymZsMlRFFCPA3aDCRchZMPJMvhuw8LyaUFMDp5BOyuUw
         +WMxlr72ywZgxXAuhdDi0izJsqaZRJ+FtUrpGsk+5oLU6DLyGoDvE2jZBy9Qi3pRoYYo
         jpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rRdwwTYB3THrODEV2neHSr1r681wlaqYPsv7e09Hwos=;
        b=RdOS4v4czHZlnxhG9lDWqJflBaP6NibzTUEXwTTyMQDF3snuyFw0vw1vNCLq5vKzEk
         Hj+kCoCNTSxW9uba5mNViMj+JdQ83X0+xFVaty3nzbyCFc9NIzYyG6vpMcH505A+2FfX
         HX5i7DH+fT4LFp49+iDAudDQWXkPETHXSZnddWnYhA78Wn0Jwh+TaEsZDWFKF1CUhcoz
         Qrab7i5LVWDLsOQn78soE2JvVaxPoHsVVgid4CgjSd7YMlVlS+9mFOqMn6W+Ctig5+ba
         oFLH4dQidgN8r7/+To5fidt/HZpDyqHtnFR5yGMj5XT31Jdfuk7VKKSUGkEk1HUelgOt
         eD4g==
X-Gm-Message-State: AOAM531fVfSU4iEw4JgZOwfxjSYvuYKdvh/muefKXvT5j4sbmr7FZ9mt
        sn4GwMfO2uLmACUu3J2lO1Ose/gpQPO0wqwpcgf7xg==
X-Google-Smtp-Source: ABdhPJwDXbhX5HRqxoUbDoFpK+cRpKc7xoI2mgS53bPJI3up3v6EqKVj7uqMndhkyNIuEMh+3AsTFluC7FJRlufAaGY=
X-Received: by 2002:a62:16c1:0:b029:18c:8a64:fc04 with SMTP id
 184-20020a6216c10000b029018c8a64fc04mr7238875pfw.59.1605754845606; Wed, 18
 Nov 2020 19:00:45 -0800 (PST)
MIME-Version: 1.0
References: <20201113105952.11638-1-songmuchun@bytedance.com>
 <20201113105952.11638-5-songmuchun@bytedance.com> <88af8545-14b7-08de-f121-e12295d5d5b9@oracle.com>
In-Reply-To: <88af8545-14b7-08de-f121-e12295d5d5b9@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 19 Nov 2020 11:00:07 +0800
Message-ID: <CAMZfGtXRqTpqJoGonMdTcE4HjPEy98FBFiry3Rry5=Jpfen1xw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4 04/21] mm/hugetlb: Introduce
 nr_free_vmemmap_pages in the struct hstate
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 19, 2020 at 7:48 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 11/13/20 2:59 AM, Muchun Song wrote:
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > new file mode 100644
> > index 000000000000..a6c9948302e2
> > --- /dev/null
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -0,0 +1,108 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Free some vmemmap pages of HugeTLB
> > + *
> > + * Copyright (c) 2020, Bytedance. All rights reserved.
> > + *
> > + *     Author: Muchun Song <songmuchun@bytedance.com>
> > + *
>
> Oscar has already made some suggestions to change comments.  I would suggest
> changing the below text to something like the following.

Thanks Mike. I will change the below comments.

>
> > + * Nowadays we track the status of physical page frames using struct page
> > + * structures arranged in one or more arrays. And here exists one-to-one
> > + * mapping between the physical page frame and the corresponding struct page
> > + * structure.
> > + *
> > + * The HugeTLB support is built on top of multiple page size support that
> > + * is provided by most modern architectures. For example, x86 CPUs normally
> > + * support 4K and 2M (1G if architecturally supported) page sizes. Every
> > + * HugeTLB has more than one struct page structure. The 2M HugeTLB has 512
> > + * struct page structure and 1G HugeTLB has 4096 struct page structures. But
> > + * in the core of HugeTLB only uses the first 4 (Use of first 4 struct page
> > + * structures comes from HUGETLB_CGROUP_MIN_ORDER.) struct page structures to
> > + * store metadata associated with each HugeTLB. The rest of the struct page
> > + * structures are usually read the compound_head field which are all the same
> > + * value. If we can free some struct page memory to buddy system so that we
> > + * can save a lot of memory.
> > + *
>
> struct page structures (page structs) are used to describe a physical page
> frame.  By default, there is a one-to-one mapping from a page frame to
> it's corresponding page struct.
>
> HugeTLB pages consist of multiple base page size pages and is supported by
> many architectures. See hugetlbpage.rst in the Documentation directory for
> more details.  On the x86 architecture, HugeTLB pages of size 2MB and 1GB
> are currently supported.  Since the base page size on x86 is 4KB, a 2MB
> HugeTLB page consists of 512 base pages and a 1GB HugeTLB page consists of
> 4096 base pages.  For each base page, there is a corresponding page struct.
>
> Within the HugeTLB subsystem, only the first 4 page structs are used to
> contain unique information about a HugeTLB page.  HUGETLB_CGROUP_MIN_ORDER
> provides this upper limit.  The only 'useful' information in the remaining
> page structs is the compound_head field, and this field is the same for all
> tail pages.
>
> By removing redundant page structs for HugeTLB pages, memory can returned
> to the buddy allocator for other uses.
>
> > + * When the system boot up, every 2M HugeTLB has 512 struct page structures
> > + * which size is 8 pages(sizeof(struct page) * 512 / PAGE_SIZE).
> > + *
> > + *    HugeTLB                  struct pages(8 pages)         page frame(8 pages)
> > + * +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
> > + * |           |                     |     0     | -------------> |     0     |
> > + * |           |                     |     1     | -------------> |     1     |
> > + * |           |                     |     2     | -------------> |     2     |
> > + * |           |                     |     3     | -------------> |     3     |
> > + * |           |                     |     4     | -------------> |     4     |
> > + * |     2M    |                     |     5     | -------------> |     5     |
> > + * |           |                     |     6     | -------------> |     6     |
> > + * |           |                     |     7     | -------------> |     7     |
> > + * |           |                     +-----------+                +-----------+
> > + * |           |
> > + * |           |
> > + * +-----------+
> > + *
> > + *
>
> I think we want the description before the next diagram.
>
> Reworded description here:
>
> The value of compound_head is the same for all tail pages.  The first page of
> page structs (page 0) associated with the HugeTLB page contains the 4 page
> structs necessary to describe the HugeTLB.  The only use of the remaining pages
> of page structs (page 1 to page 7) is to point to compound_head.  Therefore,
> we can remap pages 2 to 7 to page 1.  Only 2 pages of page structs will be used
> for each HugeTLB page.  This will allow us to free the remaining 6 pages to
> the buddy allocator.
>
> Here is how things look after remapping.
>
> > + *
> > + *    HugeTLB                  struct pages(8 pages)         page frame(8 pages)
> > + * +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
> > + * |           |                     |     0     | -------------> |     0     |
> > + * |           |                     |     1     | -------------> |     1     |
> > + * |           |                     |     2     | -------------> +-----------+
> > + * |           |                     |     3     | -----------------^ ^ ^ ^ ^
> > + * |           |                     |     4     | -------------------+ | | |
> > + * |     2M    |                     |     5     | ---------------------+ | |
> > + * |           |                     |     6     | -----------------------+ |
> > + * |           |                     |     7     | -------------------------+
> > + * |           |                     +-----------+
> > + * |           |
> > + * |           |
> > + * +-----------+
>
> --
> Mike Kravetz



-- 
Yours,
Muchun
