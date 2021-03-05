Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BE232E4D6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 10:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhCEJbb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Mar 2021 04:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhCEJbQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Mar 2021 04:31:16 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1706C061756
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Mar 2021 01:31:16 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id l18so1614881pji.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Mar 2021 01:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OWC67okOq2PV45DOb1BZyNZyieYGon3uzFcXFG0nskU=;
        b=GfHtCX8YDZPmGbos11QTual1lDalV+HnYUH11Zoyt2Mj4L0HyqE4l3bWqlDFmhAQDW
         A3J83yJc3n1lGx/dQIXrr+jp0PSorhc+JBUvuCRB6SaXXFczCDMZOc/oyhtE61p8sfhj
         x0BLhPOgJGOy+xQm5uRFc/TdYUR62vmEl9sDLX+ikBZMyRsQw0DSwcQr/dCh60Xr+W6d
         fNbEieODot5gQc8TWwSaaaUkZzmGFO1bCEFdImhcdfIL5TfxQx2+F+sQ08dZpoFMgif4
         UycRNolFkuvHRlopqK0WLDs0l+L/RaWRpQjUleLXyGuNcytf+2svE9HBWhX3TX/jPM0V
         1Rbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OWC67okOq2PV45DOb1BZyNZyieYGon3uzFcXFG0nskU=;
        b=Edkv80CPtRzzFCy1u0CwWGHCrpx1buoYeI2uyj863b9ymVtkC6idhFSTJbXXgBFTpw
         mRAViZlKWjkqXIj4YqNPnzRSPNrCPhYmBmYrH2BKJCErvcTh/YMsp0m8SEqO8UtkXaEJ
         n/CXBFtUqxwwwSnIu3ZVAQKmfMMEYU73NjC3hrOe0/ePGnUpungxpcBOL9WXIyck7i6W
         iIpxmBGbHe4e8KGaxre6bfwV2Gxv9etha6XiU43sIEXUEghtpkM2M8bWsD4VpMs6/Tdt
         rTx7DYGcGaO13QB+8JQscxX3sD1kI1AOjNlfswL4vFBoG+F1I+kxlFEBPiOaj2FzOw1G
         KESw==
X-Gm-Message-State: AOAM530uDydTqfyFVV1zgiPN7hYCCxWmjhKPnYqUKYtDMPP4JfoUKO4x
        v6y+tzcVzKzcLJK/ptCa+hBPKGEo5n8g1CCRJ0ZZ6w==
X-Google-Smtp-Source: ABdhPJy/VpOqrYf4Z9yGVhdxYsm2sPHt0sjUhhT6S8jFpM1HY8abCDd8Gwx0mDK4Ab5H5x+d/nF1IXGdTkK7vkchSU4=
X-Received: by 2002:a17:902:da91:b029:e5:e7cf:d737 with SMTP id
 j17-20020a170902da91b02900e5e7cfd737mr3906981plx.24.1614936676069; Fri, 05
 Mar 2021 01:31:16 -0800 (PST)
MIME-Version: 1.0
References: <20210225132130.26451-1-songmuchun@bytedance.com>
 <20210225132130.26451-5-songmuchun@bytedance.com> <20210305085502.GD1223287@balbir-desktop>
In-Reply-To: <20210305085502.GD1223287@balbir-desktop>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 5 Mar 2021 17:30:39 +0800
Message-ID: <CAMZfGtVqtBhEA=j6JXKFxa5qhohhO3c+Fwd9kVJGU6htf+csJQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v17 4/9] mm: hugetlb: alloc the vmemmap
 pages associated with each HugeTLB page
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
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
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 5, 2021 at 4:55 PM Balbir Singh <bsingharora@gmail.com> wrote:
>
> On Thu, Feb 25, 2021 at 09:21:25PM +0800, Muchun Song wrote:
> > When we free a HugeTLB page to the buddy allocator, we should allocate
> > the vmemmap pages associated with it. But we may cannot allocate vmemmap
> > pages when the system is under memory pressure, in this case, we just
> > refuse to free the HugeTLB page instead of looping forever trying to
> > allocate the pages. This changes some behavior (list below) on some
> > corner cases.
> >
> >  1) Failing to free a huge page triggered by the user (decrease nr_pages).
> >
> >     Need try again later by the user.
> >
> >  2) Failing to free a surplus huge page when freed by the application.
> >
> >     Try again later when freeing a huge page next time.
> >
> >  3) Failing to dissolve a free huge page on ZONE_MOVABLE via
> >     offline_pages().
> >
> >     This is a bit unfortunate if we have plenty of ZONE_MOVABLE memory
> >     but are low on kernel memory. For example, migration of huge pages
> >     would still work, however, dissolving the free page does not work.
> >     This is a corner cases. When the system is that much under memory
> >     pressure, offlining/unplug can be expected to fail. This is
> >     unfortunate because it prevents from the memory offlining which
> >     shouldn't happen for movable zones. People depending on the memory
> >     hotplug and movable zone should carefuly consider whether savings
> >     on unmovable memory are worth losing their hotplug functionality
> >     in some situations.
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
> >  Documentation/admin-guide/mm/hugetlbpage.rst |  8 +++
> >  include/linux/mm.h                           |  2 +
> >  mm/hugetlb.c                                 | 92 +++++++++++++++++++++-------
> >  mm/hugetlb_vmemmap.c                         | 32 ++++++----
> >  mm/hugetlb_vmemmap.h                         | 23 +++++++
> >  mm/sparse-vmemmap.c                          | 75 ++++++++++++++++++++++-
> >  6 files changed, 197 insertions(+), 35 deletions(-)
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
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 4ddfc31f21c6..77693c944a36 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2973,6 +2973,8 @@ static inline void print_vma_addr(char *prefix, unsigned long rip)
> >
> >  void vmemmap_remap_free(unsigned long start, unsigned long end,
> >                       unsigned long reuse);
> > +int vmemmap_remap_alloc(unsigned long start, unsigned long end,
> > +                     unsigned long reuse, gfp_t gfp_mask);
> >
> >  void *sparse_buffer_alloc(unsigned long size);
> >  struct page * __populate_section_memmap(unsigned long pfn,
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 43fed6785322..b6e4e3f31ad2 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1304,16 +1304,59 @@ static inline void destroy_compound_gigantic_page(struct page *page,
> >                                               unsigned int order) { }
> >  #endif
> >
> > -static void update_and_free_page(struct hstate *h, struct page *page)
> > +static int update_and_free_page(struct hstate *h, struct page *page)
> > +     __releases(&hugetlb_lock) __acquires(&hugetlb_lock)
> >  {
> >       int i;
> >       struct page *subpage = page;
> > +     int nid = page_to_nid(page);
> >
> >       if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> > -             return;
> > +             return 0;
> >
> >       h->nr_huge_pages--;
> > -     h->nr_huge_pages_node[page_to_nid(page)]--;
> > +     h->nr_huge_pages_node[nid]--;
> > +     VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
> > +     VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);
> > +     set_page_refcounted(page);
> > +     set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
> > +
> > +     /*
> > +      * If the vmemmap pages associated with the HugeTLB page can be
> > +      * optimized or the page is gigantic, we might block in
> > +      * alloc_huge_page_vmemmap() or free_gigantic_page(). In both
> > +      * cases, drop the hugetlb_lock.
> > +      */
> > +     if (free_vmemmap_pages_per_hpage(h) || hstate_is_gigantic(h))
> > +             spin_unlock(&hugetlb_lock);
> > +
> > +     if (alloc_huge_page_vmemmap(h, page)) {
> > +             spin_lock(&hugetlb_lock);
> > +             INIT_LIST_HEAD(&page->lru);
> > +             set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
> > +             h->nr_huge_pages++;
> > +             h->nr_huge_pages_node[nid]++;
> > +
> > +             /*
> > +              * If we cannot allocate vmemmap pages, just refuse to free the
> > +              * page and put the page back on the hugetlb free list and treat
> > +              * as a surplus page.
> > +              */
> > +             h->surplus_huge_pages++;
> > +             h->surplus_huge_pages_node[nid]++;
> > +
> > +             /*
> > +              * The refcount can be perfectly increased by memory-failure or
> > +              * soft_offline handlers.
> > +              */
> > +             if (likely(put_page_testzero(page))) {
> > +                     arch_clear_hugepage_flags(page);
> > +                     enqueue_huge_page(h, page);
> > +             }
> > +
> > +             return -ENOMEM;
> > +     }
> > +
> >       for (i = 0; i < pages_per_huge_page(h);
> >            i++, subpage = mem_map_next(subpage, page, i)) {
> >               subpage->flags &= ~(1 << PG_locked | 1 << PG_error |
> > @@ -1321,22 +1364,18 @@ static void update_and_free_page(struct hstate *h, struct page *page)
> >                               1 << PG_active | 1 << PG_private |
> >                               1 << PG_writeback);
> >       }
> > -     VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
> > -     VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);
> > -     set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
> > -     set_page_refcounted(page);
> > +
> >       if (hstate_is_gigantic(h)) {
> > -             /*
> > -              * Temporarily drop the hugetlb_lock, because
> > -              * we might block in free_gigantic_page().
> > -              */
> > -             spin_unlock(&hugetlb_lock);
> >               destroy_compound_gigantic_page(page, huge_page_order(h));
> >               free_gigantic_page(page, huge_page_order(h));
> > -             spin_lock(&hugetlb_lock);
> >       } else {
> >               __free_pages(page, huge_page_order(h));
> >       }
> > +
> > +     if (free_vmemmap_pages_per_hpage(h) || hstate_is_gigantic(h))
> > +             spin_lock(&hugetlb_lock);
> > +
> > +     return 0;
> >  }
> >
> >  struct hstate *size_to_hstate(unsigned long size)
> > @@ -1404,9 +1443,9 @@ static void __free_huge_page(struct page *page)
> >       } else if (h->surplus_huge_pages_node[nid]) {
> >               /* remove the page from active list */
> >               list_del(&page->lru);
> > -             update_and_free_page(h, page);
> >               h->surplus_huge_pages--;
> >               h->surplus_huge_pages_node[nid]--;
> > +             update_and_free_page(h, page);
> >       } else {
> >               arch_clear_hugepage_flags(page);
> >               enqueue_huge_page(h, page);
> > @@ -1447,7 +1486,7 @@ void free_huge_page(struct page *page)
> >       /*
> >        * Defer freeing if in non-task context to avoid hugetlb_lock deadlock.
> >        */
> > -     if (!in_task()) {
> > +     if (!in_atomic()) {
> >               /*
> >                * Only call schedule_work() if hpage_freelist is previously
> >                * empty. Otherwise, schedule_work() had been called but the
> > @@ -1699,8 +1738,7 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
> >                               h->surplus_huge_pages--;
> >                               h->surplus_huge_pages_node[node]--;
> >                       }
> > -                     update_and_free_page(h, page);
> > -                     ret = 1;
> > +                     ret = !update_and_free_page(h, page);
> >                       break;
> >               }
> >       }
> > @@ -1713,10 +1751,14 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
> >   * nothing for in-use hugepages and non-hugepages.
> >   * This function returns values like below:
> >   *
> > - *  -EBUSY: failed to dissolved free hugepages or the hugepage is in-use
> > - *          (allocated or reserved.)
> > - *       0: successfully dissolved free hugepages or the page is not a
> > - *          hugepage (considered as already dissolved)
> > + *  -ENOMEM: failed to allocate vmemmap pages to free the freed hugepages
> > + *           when the system is under memory pressure and the feature of
> > + *           freeing unused vmemmap pages associated with each hugetlb page
> > + *           is enabled.
> > + *  -EBUSY:  failed to dissolved free hugepages or the hugepage is in-use
> > + *           (allocated or reserved.)
> > + *       0:  successfully dissolved free hugepages or the page is not a
> > + *           hugepage (considered as already dissolved)
> >   */
> >  int dissolve_free_huge_page(struct page *page)
> >  {
> > @@ -1771,8 +1813,12 @@ int dissolve_free_huge_page(struct page *page)
> >               h->free_huge_pages--;
> >               h->free_huge_pages_node[nid]--;
> >               h->max_huge_pages--;
> > -             update_and_free_page(h, head);
> > -             rc = 0;
> > +             rc = update_and_free_page(h, head);
> > +             if (rc) {
> > +                     h->surplus_huge_pages--;
> > +                     h->surplus_huge_pages_node[nid]--;
> > +                     h->max_huge_pages++;
> > +             }
> >       }
> >  out:
> >       spin_unlock(&hugetlb_lock);
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index 0209b736e0b4..f7ab3d99250a 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -181,21 +181,31 @@
> >  #define RESERVE_VMEMMAP_NR           2U
> >  #define RESERVE_VMEMMAP_SIZE         (RESERVE_VMEMMAP_NR << PAGE_SHIFT)
> >
> > -/*
> > - * How many vmemmap pages associated with a HugeTLB page that can be freed
> > - * to the buddy allocator.
> > - *
> > - * Todo: Returns zero for now, which means the feature is disabled. We will
> > - * enable it once all the infrastructure is there.
> > - */
> > -static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
> > +static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
> >  {
> > -     return 0;
> > +     return (unsigned long)free_vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
> >  }
> >
> > -static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
> > +int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
> >  {
> > -     return (unsigned long)free_vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
> > +     unsigned long vmemmap_addr = (unsigned long)head;
> > +     unsigned long vmemmap_end, vmemmap_reuse;
> > +
> > +     if (!free_vmemmap_pages_per_hpage(h))
> > +             return 0;
> > +
> > +     vmemmap_addr += RESERVE_VMEMMAP_SIZE;
> > +     vmemmap_end = vmemmap_addr + free_vmemmap_pages_size_per_hpage(h);
> > +     vmemmap_reuse = vmemmap_addr - PAGE_SIZE;
>
> This is where I think some optimization is possible, once we are done with
> vmemmap_end calculation, we can use 6 pages (for 2MiB huge page) as pages
> for struct page. Is there a reason to not do so?

If you mean that we reuse part of a huge page as vmemmap while
freeing. You can look at the discussion here.

https://patchwork.kernel.org/project/linux-mm/patch/20210117151053.24600-6-songmuchun@bytedance.com/

Thanks.
>
> Balbir
