Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C693D374DB7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 May 2021 04:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbhEFCyg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 22:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbhEFCyf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 22:54:35 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DACC06174A
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 May 2021 19:53:37 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t2-20020a17090ae502b029015b0fbfbc50so2654223pjy.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 May 2021 19:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YewfXLV+s6eseo7hxW6W1xEDd4aCTIQYY6fGFTM6318=;
        b=1g6apy4Azt+HLbznoibVPTszQApPwt5wzruvbJC5FJnjkaIHYHo+Bkd4lgwAWi7NPW
         FG2uf5WbZPNeI1sj9AWI79NRQyIGbGgASl8Hvh9TLzdRahLtITbx/vWLQcLAEOMeoqt6
         o4CoFGCvqeBFGVkxvhGlpgZkReqTi1xh1Dh619tg3WDYfd+rUBX21oe8O4oiiW11A+/S
         F/Fp3g5j0ChlmaFmRneBoxrv5Jxqs87Wd5p2WI+xAlYMSqilKnXV/Q4HJd34PXoHiOOF
         CMc54ObYAPTg0Fe3Hd1Ammk7j0VlJY6u2D9DGWx8UTwCwMRl95U0OpcLwdtZAbsQSD57
         UQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YewfXLV+s6eseo7hxW6W1xEDd4aCTIQYY6fGFTM6318=;
        b=VAZFNS9HYC0nqSxkAdhXNEgcVeSaJbpwj1DPhraGBPTShzsgTcKoTd0I12wd1mbBaj
         OR9/xgLqoS9dHQvGpAPARmKlsXM0V2HUfONWE/e6qpp7Wf5DRtziQ7e326NOtY7qCZKW
         ES4+1HDiCCUC2JZ8m/s6q21cq3s4OrmX/oTdnyCvdAw2VXCfCTzGYBxpqUwpqKhc/ukr
         upgzyUpI/iw8pEnIhi0/DPEhr+/wdU4mB2uwqNOhmED3pIVjWgTc+6BGtFkglM5Q362I
         uCyVE0jgyujCFFgrji+YtG4mk2HYN+7NdkzFUe2/Afc6uWEiPEmpELZQSfPGyLO9dHs0
         8wcA==
X-Gm-Message-State: AOAM531afMoDbUGfQGAUYqJpRyWWd80X68eX3EY6wEVLpNO9W0j/2WP+
        z9tmTHDp7H/4hR+KW3hb0OonzB+pVx+xYTT/VbZiNRkgbXs=
X-Google-Smtp-Source: ABdhPJxB5teGJjRreLimTCPrUixDSsqCQ2MyfSkZEup9YXKNFbxR8Ed4DozyMoPQhS+fYL8hHVGbgv6P46OeJcEIY7I=
X-Received: by 2002:a17:902:e54e:b029:ed:6ed2:d0ab with SMTP id
 n14-20020a170902e54eb02900ed6ed2d0abmr2031887plf.24.1620269616937; Wed, 05
 May 2021 19:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210430031352.45379-1-songmuchun@bytedance.com>
 <20210430031352.45379-7-songmuchun@bytedance.com> <c2e8bc43-44dc-825d-9f59-0de300815fa4@oracle.com>
In-Reply-To: <c2e8bc43-44dc-825d-9f59-0de300815fa4@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 6 May 2021 10:52:58 +0800
Message-ID: <CAMZfGtWaSGCUaubv6kwc1hzRoc9=O2eXJBcU9t8bX3XeQtP9Yw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v22 6/9] mm: hugetlb: alloc the vmemmap
 pages associated with each HugeTLB page
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        X86 ML <x86@kernel.org>, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, zhengqi.arch@bytedance.com,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 6, 2021 at 6:21 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 4/29/21 8:13 PM, Muchun Song wrote:
> > When we free a HugeTLB page to the buddy allocator, we need to allocate
> > the vmemmap pages associated with it. However, we may not be able to
> > allocate the vmemmap pages when the system is under memory pressure. In
> > this case, we just refuse to free the HugeTLB page. This changes behavior
> > in some corner cases as listed below:
> >
> >  1) Failing to free a huge page triggered by the user (decrease nr_pages).
> >
> >     User needs to try again later.
> >
> >  2) Failing to free a surplus huge page when freed by the application.
> >
> >     Try again later when freeing a huge page next time.
> >
> >  3) Failing to dissolve a free huge page on ZONE_MOVABLE via
> >     offline_pages().
> >
> >     This can happen when we have plenty of ZONE_MOVABLE memory, but
> >     not enough kernel memory to allocate vmemmmap pages.  We may even
> >     be able to migrate huge page contents, but will not be able to
> >     dissolve the source huge page.  This will prevent an offline
> >     operation and is unfortunate as memory offlining is expected to
> >     succeed on movable zones.  Users that depend on memory hotplug
> >     to succeed for movable zones should carefully consider whether the
> >     memory savings gained from this feature are worth the risk of
> >     possibly not being able to offline memory in certain situations.
> >
> >  4) Failing to dissolve a huge page on CMA/ZONE_MOVABLE via
> >     alloc_contig_range() - once we have that handling in place. Mainly
> >     affects CMA and virtio-mem.
> >
> >     Similar to 3). virito-mem will handle migration errors gracefully.
> >     CMA might be able to fallback on other free areas within the CMA
> >     region.
> >
> > Vmemmap pages are allocated from the page freeing context. In order for
> > those allocations to be not disruptive (e.g. trigger oom killer)
> > __GFP_NORETRY is used. hugetlb_lock is dropped for the allocation
> > because a non sleeping allocation would be too fragile and it could fail
> > too easily under memory pressure. GFP_ATOMIC or other modes to access
> > memory reserves is not used because we want to prevent consuming
> > reserves under heavy hugetlb freeing.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  Documentation/admin-guide/mm/hugetlbpage.rst    |  8 ++
> >  Documentation/admin-guide/mm/memory-hotplug.rst | 13 ++++
> >  include/linux/hugetlb.h                         |  3 +
> >  include/linux/mm.h                              |  2 +
> >  mm/hugetlb.c                                    | 98 +++++++++++++++++++++----
> >  mm/hugetlb_vmemmap.c                            | 34 +++++++++
> >  mm/hugetlb_vmemmap.h                            |  6 ++
> >  mm/migrate.c                                    |  5 +-
> >  mm/sparse-vmemmap.c                             | 75 ++++++++++++++++++-
> >  9 files changed, 227 insertions(+), 17 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
> > index f7b1c7462991..6988895d09a8 100644
> > --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> > +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> > @@ -60,6 +60,10 @@ HugePages_Surp
> >          the pool above the value in ``/proc/sys/vm/nr_hugepages``. The
> >          maximum number of surplus huge pages is controlled by
> >          ``/proc/sys/vm/nr_overcommit_hugepages``.
> > +     Note: When the feature of freeing unused vmemmap pages associated
> > +     with each hugetlb page is enabled, the number of surplus huge pages
> > +     may be temporarily larger than the maximum number of surplus huge
> > +     pages when the system is under memory pressure.
> >  Hugepagesize
> >       is the default hugepage size (in Kb).
> >  Hugetlb
> > @@ -80,6 +84,10 @@ returned to the huge page pool when freed by a task.  A user with root
> >  privileges can dynamically allocate more or free some persistent huge pages
> >  by increasing or decreasing the value of ``nr_hugepages``.
> >
> > +Note: When the feature of freeing unused vmemmap pages associated with each
> > +hugetlb page is enabled, we can fail to free the huge pages triggered by
> > +the user when ths system is under memory pressure.  Please try again later.
> > +
> >  Pages that are used as huge pages are reserved inside the kernel and cannot
> >  be used for other purposes.  Huge pages cannot be swapped out under
> >  memory pressure.
> > diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
> > index 05d51d2d8beb..c6bae2d77160 100644
> > --- a/Documentation/admin-guide/mm/memory-hotplug.rst
> > +++ b/Documentation/admin-guide/mm/memory-hotplug.rst
> > @@ -357,6 +357,19 @@ creates ZONE_MOVABLE as following.
> >     Unfortunately, there is no information to show which memory block belongs
> >     to ZONE_MOVABLE. This is TBD.
> >
> > +   Memory offlining can fail when dissolving a free huge page on ZONE_MOVABLE
> > +   and the feature of freeing unused vmemmap pages associated with each hugetlb
> > +   page is enabled.
> > +
> > +   This can happen when we have plenty of ZONE_MOVABLE memory, but not enough
> > +   kernel memory to allocate vmemmmap pages.  We may even be able to migrate
> > +   huge page contents, but will not be able to dissolve the source huge page.
> > +   This will prevent an offline operation and is unfortunate as memory offlining
> > +   is expected to succeed on movable zones.  Users that depend on memory hotplug
> > +   to succeed for movable zones should carefully consider whether the memory
> > +   savings gained from this feature are worth the risk of possibly not being
> > +   able to offline memory in certain situations.
> > +
> >  .. note::
> >     Techniques that rely on long-term pinnings of memory (especially, RDMA and
> >     vfio) are fundamentally problematic with ZONE_MOVABLE and, therefore, memory
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index d523a345dc86..d3abaaec2a22 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -525,6 +525,7 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
> >   *   code knows it has only reference.  All other examinations and
> >   *   modifications require hugetlb_lock.
> >   * HPG_freed - Set when page is on the free lists.
> > + * HPG_vmemmap_optimized - Set when the vmemmap pages of the page are freed.
> >   *   Synchronization: hugetlb_lock held for examination and modification.
>
> You just moved the Synchronization comment so that it applies to both
> HPG_freed and HPG_vmemmap_optimized.  However, HPG_vmemmap_optimized is
> checked/modified both with and without hugetlb_lock.  Nothing wrong with
> that, just need to update/fix the comment.
>

Thanks, Mike. I will update the comment.

> Everything else looks good to me,
>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
>
> --
> Mike Kravetz
