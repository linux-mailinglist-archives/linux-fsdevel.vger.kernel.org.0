Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3873049C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 21:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732460AbhAZFXq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbhAYJpv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:45:51 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CD1C06178C
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 01:34:46 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id m6so8085176pfk.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 01:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z8nrxtJb3XhTbQvd5j67XtkO/vay+xDoaZCK/pVC+LY=;
        b=OffTwV4C2tkYhMHP6e+JkFb3UOud8nOV2gy5gMoKIW5bnZNdA+5n248fLiUoZ3y0N7
         LvcraooP074rVny2vjWLcEzJUsyOgrGRAxb3225v3IAGn/yUOM08NmGUYwN3mE3kaoB0
         u4YaR8QdfYX9ZiiNyuEUTNrdV/JhUilTlAVCMs99kfebStJUoBYBv5gqCKS8HRhVLxRx
         2jVdPLkW8gspVaGYIaZqtha4Tvrx9gdQRI/9QIZvFxN5+R/GRrw2Jb17Qli5+89HuJaR
         oXVh/O53vepMV9itsBDojL2HUASfwpKoMbAtL3qeww3Zfoooe4VH4a8gbNMEaAQXTK/o
         rPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z8nrxtJb3XhTbQvd5j67XtkO/vay+xDoaZCK/pVC+LY=;
        b=IY+2yjsC6wEd/icL55uznPbdfhQe90wz1tx0duH2HC3EUhnduQU4yARL/GYqreHLJZ
         twP6qU59mvi/IrUqYrRDJRioGuoLJI2ODN6gOdPjRxK0REJiHLANufjhLPhtWUOfqiJw
         GK/qPdAjP26cQHBr6Dn7fqwEyRjzpJT+931s5fnUy7KnJLUgiqsS/3Ajs1eilRj8lq8l
         QnhdEit1JVSCLCFXgm6oQl74Wj2hGgvSCfo+EOwI3R1zsQA00mIf/yAGywhFQbwzeQJ/
         U5wCYjWVYptavsXIm9p1fqJ0vFTJVc5adv+gdLhUSv07zJjA3rhXi1XRMoreyRXBi7uM
         rzEg==
X-Gm-Message-State: AOAM533GoBGJEXz2wjYwfOGM8WXJJNB4qxs2LxWLfw43lqrZkRoDnRmE
        7ycVqxc7CIOfwDaQnPaYrzQVanDmK+SRFi2aYsKCmA==
X-Google-Smtp-Source: ABdhPJxVx55V16cI4xy7oBEQg8xxEV5bUx60rUKse8vz37JdPHqIzHsWLuoVk+Wl8tff+ZV+FKqr9jBd+q5Qmp1fQDY=
X-Received: by 2002:a62:7694:0:b029:1b9:8d43:95af with SMTP id
 r142-20020a6276940000b02901b98d4395afmr17392890pfc.2.1611567285933; Mon, 25
 Jan 2021 01:34:45 -0800 (PST)
MIME-Version: 1.0
References: <20210117151053.24600-1-songmuchun@bytedance.com>
 <20210117151053.24600-6-songmuchun@bytedance.com> <6a68fde-583d-b8bb-a2c8-fbe32e03b@google.com>
 <CAMZfGtXpg30RhrPm836S6Tr09ynKRPG=_DXtXt9sVTTponnC-g@mail.gmail.com>
 <CAMZfGtX19x8m+Bkvj+8Ue31m5L_4DmgtZevp2fd++JL7nuSzWw@mail.gmail.com> <552e8214-bc6f-8d90-0ed8-b3aff75d0e47@redhat.com>
In-Reply-To: <552e8214-bc6f-8d90-0ed8-b3aff75d0e47@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 25 Jan 2021 17:34:09 +0800
Message-ID: <CAMZfGtWK=zBri_zAx=uP_dLv2Kh-2_vfjAyN7XtESwqukg5Eug@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v13 05/12] mm: hugetlb: allocate the
 vmemmap pages associated with each HugeTLB page
To:     David Hildenbrand <david@redhat.com>
Cc:     David Rientjes <rientjes@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 25, 2021 at 5:15 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 25.01.21 08:41, Muchun Song wrote:
> > On Mon, Jan 25, 2021 at 2:40 PM Muchun Song <songmuchun@bytedance.com> wrote:
> >>
> >> On Mon, Jan 25, 2021 at 8:05 AM David Rientjes <rientjes@google.com> wrote:
> >>>
> >>>
> >>> On Sun, 17 Jan 2021, Muchun Song wrote:
> >>>
> >>>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> >>>> index ce4be1fa93c2..3b146d5949f3 100644
> >>>> --- a/mm/sparse-vmemmap.c
> >>>> +++ b/mm/sparse-vmemmap.c
> >>>> @@ -29,6 +29,7 @@
> >>>>  #include <linux/sched.h>
> >>>>  #include <linux/pgtable.h>
> >>>>  #include <linux/bootmem_info.h>
> >>>> +#include <linux/delay.h>
> >>>>
> >>>>  #include <asm/dma.h>
> >>>>  #include <asm/pgalloc.h>
> >>>> @@ -40,7 +41,8 @@
> >>>>   * @remap_pte:               called for each non-empty PTE (lowest-level) entry.
> >>>>   * @reuse_page:              the page which is reused for the tail vmemmap pages.
> >>>>   * @reuse_addr:              the virtual address of the @reuse_page page.
> >>>> - * @vmemmap_pages:   the list head of the vmemmap pages that can be freed.
> >>>> + * @vmemmap_pages:   the list head of the vmemmap pages that can be freed
> >>>> + *                   or is mapped from.
> >>>>   */
> >>>>  struct vmemmap_remap_walk {
> >>>>       void (*remap_pte)(pte_t *pte, unsigned long addr,
> >>>> @@ -50,6 +52,10 @@ struct vmemmap_remap_walk {
> >>>>       struct list_head *vmemmap_pages;
> >>>>  };
> >>>>
> >>>> +/* The gfp mask of allocating vmemmap page */
> >>>> +#define GFP_VMEMMAP_PAGE             \
> >>>> +     (GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN | __GFP_THISNODE)
> >>>> +
> >>>
> >>> This is unnecessary, just use the gfp mask directly in allocator.
> >>
> >> Will do. Thanks.
> >>
> >>>
> >>>>  static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
> >>>>                             unsigned long end,
> >>>>                             struct vmemmap_remap_walk *walk)
> >>>> @@ -228,6 +234,75 @@ void vmemmap_remap_free(unsigned long start, unsigned long end,
> >>>>       free_vmemmap_page_list(&vmemmap_pages);
> >>>>  }
> >>>>
> >>>> +static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
> >>>> +                             struct vmemmap_remap_walk *walk)
> >>>> +{
> >>>> +     pgprot_t pgprot = PAGE_KERNEL;
> >>>> +     struct page *page;
> >>>> +     void *to;
> >>>> +
> >>>> +     BUG_ON(pte_page(*pte) != walk->reuse_page);
> >>>> +
> >>>> +     page = list_first_entry(walk->vmemmap_pages, struct page, lru);
> >>>> +     list_del(&page->lru);
> >>>> +     to = page_to_virt(page);
> >>>> +     copy_page(to, (void *)walk->reuse_addr);
> >>>> +
> >>>> +     set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
> >>>> +}
> >>>> +
> >>>> +static void alloc_vmemmap_page_list(struct list_head *list,
> >>>> +                                 unsigned long start, unsigned long end)
> >>>> +{
> >>>> +     unsigned long addr;
> >>>> +
> >>>> +     for (addr = start; addr < end; addr += PAGE_SIZE) {
> >>>> +             struct page *page;
> >>>> +             int nid = page_to_nid((const void *)addr);
> >>>> +
> >>>> +retry:
> >>>> +             page = alloc_pages_node(nid, GFP_VMEMMAP_PAGE, 0);
> >>>> +             if (unlikely(!page)) {
> >>>> +                     msleep(100);
> >>>> +                     /*
> >>>> +                      * We should retry infinitely, because we cannot
> >>>> +                      * handle allocation failures. Once we allocate
> >>>> +                      * vmemmap pages successfully, then we can free
> >>>> +                      * a HugeTLB page.
> >>>> +                      */
> >>>> +                     goto retry;
> >>>
> >>> Ugh, I don't think this will work, there's no guarantee that we'll ever
> >>> succeed and now we can't free a 2MB hugepage because we cannot allocate a
> >>> 4KB page.  We absolutely have to ensure we make forward progress here.
> >>
> >> This can trigger a OOM when there is no memory and kill someone to release
> >> some memory. Right?
> >>
> >>>
> >>> We're going to be freeing the hugetlb page after this succeeeds, can we
> >>> not use part of the hugetlb page that we're freeing for this memory
> >>> instead?
> >>
> >> It seems a good idea. We can try to allocate memory firstly, if successful,
> >> just use the new page to remap (it can reduce memory fragmentation).
> >> If not, we can use part of the hugetlb page to remap. What's your opinion
> >> about this?
> >
> > If the HugeTLB page is a gigantic page which is allocated from
> > CMA. In this case, we cannot use part of the hugetlb page to remap.
> > Right?
>
> Right; and I don't think the "reuse part of a huge page as vmemmap while
> freeing, while that part itself might not have a proper vmemmap yet (or
> might cover itself now)" is particularly straight forward. Maybe I'm
> wrong :)
>
> Also, watch out for huge pages on ZONE_MOVABLE, in that case you also
> shouldn't allocate the vmemmap from there ...

Yeah, you are right. So I tend to trigger OOM to kill other processes to
reclaim some memory when we allocate memory fails.

>
> --
> Thanks,
>
> David / dhildenb
>
