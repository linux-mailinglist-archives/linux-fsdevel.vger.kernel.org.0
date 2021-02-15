Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E5831BD15
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 16:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhBOPjj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 10:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbhBOPiG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 10:38:06 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E45C06178A
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Feb 2021 07:37:26 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id a24so3911189plm.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Feb 2021 07:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V/qumPgEbTSzAiVIIkXJwkbtFKz9olOOVg0TMm73T7w=;
        b=Y2IFwVEmDtkaG1GqHrd6lFJs/MreSpb8DukAMyN3pnQ841ns7wnagiXyig4FhccgIO
         7SW5mRiJjUrhsJseOuf/AAJdzxdte45p1+QIrG6J01//vgFUe9Z6ePudLL3Oj5UX/vGy
         /OFLdg7AlVkWpFwUfizMVf6ZBnP8xeYZNs9UMcjLF7xyoNsCmpiWRM/DI1DdAv8dblLz
         A08IZ1GL0zrb8+jKcbZ7F3GNtgfBqmy9yq6RD8DZYaownQU46fAWzqfbGaZpUQ/1Ly+l
         kyLCDwCn4c9uC2XIkaxhyaNpvdKdnvZJ3UrvI0nISIeh+63Bm9PTnL4YDgnoOYRjaPUm
         vpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V/qumPgEbTSzAiVIIkXJwkbtFKz9olOOVg0TMm73T7w=;
        b=NGPMQ4CQHLgJeoawTLzNi0uQ3cCRIjpB9Xsqo/0h6lHF0C8pGkUS//x7jaFSu8Ezl5
         vBKvu9YhDRlH/tngLvoFFzKt1/+xgb8tzAhhYXy2Jlwq26trET4yJO3CGmqFxTJLQCEC
         sLxHD1jlZJHZ2jomvqufvIA3IB40LR34xUmm1cHy0/hoCnYPwtK4s0vhVpFnpTaU9d/S
         ZgLfuVaoYksoBTwgUh/QzUqC23ge7qzIz8ZaOhBD3IxPa+j2SukGRCTzZXkKgY7EnP6w
         refKFHdMS82+vexJhe49QtL3HHgC1cnBNEN/6zDWlr3d1pJhGK05QnPFF7QPT9VkcoqX
         gaTw==
X-Gm-Message-State: AOAM531sfH4qbuqjgRWZK2f0oX1gj5EfuFtdGe4wJnAJ7Toyki/+mAeR
        6nCj3aCBEdVibqg4lIyDPTwrG2Xy2a588PuhU76GyA==
X-Google-Smtp-Source: ABdhPJzmcVtK3SgYW950oULzBHMXYADITI4DcNDXEKE689eTWY2EQi8+HjzVWJu04XTSi8qFbi3tPKhJ7taQg18HbaQ=
X-Received: by 2002:a17:90a:c684:: with SMTP id n4mr909082pjt.13.1613403445576;
 Mon, 15 Feb 2021 07:37:25 -0800 (PST)
MIME-Version: 1.0
References: <20210208085013.89436-1-songmuchun@bytedance.com>
 <20210208085013.89436-5-songmuchun@bytedance.com> <YCafit5ruRJ+SL8I@dhcp22.suse.cz>
 <CAMZfGtXgVUvCejpxu1o5WDvmQ7S88rWqGi3DAGM6j5NHJgtdcg@mail.gmail.com>
 <YCpN38i75olgispI@dhcp22.suse.cz> <CAMZfGtUXJTaMo36aB4nTFuYFy3qfWW69o=4uUo-FjocO8obDgw@mail.gmail.com>
 <CAMZfGtWT8CJ-QpVofB2X-+R7GE7sMa40eiAJm6PyD0ji=FzBYQ@mail.gmail.com>
 <YCpmlGuoTakPJs1u@dhcp22.suse.cz> <CAMZfGtWd_ZaXtiEdMKhpnAHDw5CTm-CSPSXW+GfKhyX5qQK=Og@mail.gmail.com>
 <YCp04NVBZpZZ5k7G@dhcp22.suse.cz>
In-Reply-To: <YCp04NVBZpZZ5k7G@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 15 Feb 2021 23:36:49 +0800
Message-ID: <CAMZfGtV8-yJa_eGYtSXc0YY8KhYpgUo=pfj6TZ9zMo8fbz8nWA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v15 4/8] mm: hugetlb: alloc the vmemmap
 pages associated with each HugeTLB page
To:     Michal Hocko <mhocko@suse.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
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
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
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

On Mon, Feb 15, 2021 at 9:19 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 15-02-21 20:44:57, Muchun Song wrote:
> > On Mon, Feb 15, 2021 at 8:18 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Mon 15-02-21 20:00:07, Muchun Song wrote:
> > > > On Mon, Feb 15, 2021 at 7:51 PM Muchun Song <songmuchun@bytedance.com> wrote:
> > > > >
> > > > > On Mon, Feb 15, 2021 at 6:33 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > > >
> > > > > > On Mon 15-02-21 18:05:06, Muchun Song wrote:
> > > > > > > On Fri, Feb 12, 2021 at 11:32 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > > > [...]
> > > > > > > > > +int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
> > > > > > > > > +{
> > > > > > > > > +     int ret;
> > > > > > > > > +     unsigned long vmemmap_addr = (unsigned long)head;
> > > > > > > > > +     unsigned long vmemmap_end, vmemmap_reuse;
> > > > > > > > > +
> > > > > > > > > +     if (!free_vmemmap_pages_per_hpage(h))
> > > > > > > > > +             return 0;
> > > > > > > > > +
> > > > > > > > > +     vmemmap_addr += RESERVE_VMEMMAP_SIZE;
> > > > > > > > > +     vmemmap_end = vmemmap_addr + free_vmemmap_pages_size_per_hpage(h);
> > > > > > > > > +     vmemmap_reuse = vmemmap_addr - PAGE_SIZE;
> > > > > > > > > +
> > > > > > > > > +     /*
> > > > > > > > > +      * The pages which the vmemmap virtual address range [@vmemmap_addr,
> > > > > > > > > +      * @vmemmap_end) are mapped to are freed to the buddy allocator, and
> > > > > > > > > +      * the range is mapped to the page which @vmemmap_reuse is mapped to.
> > > > > > > > > +      * When a HugeTLB page is freed to the buddy allocator, previously
> > > > > > > > > +      * discarded vmemmap pages must be allocated and remapping.
> > > > > > > > > +      */
> > > > > > > > > +     ret = vmemmap_remap_alloc(vmemmap_addr, vmemmap_end, vmemmap_reuse,
> > > > > > > > > +                               GFP_ATOMIC | __GFP_NOWARN | __GFP_THISNODE);
> > > > > > > >
> > > > > > > > I do not think that this is a good allocation mode. GFP_ATOMIC is a non
> > > > > > > > sleeping allocation and a medium memory pressure might cause it to
> > > > > > > > fail prematurely. I do not think this is really an atomic context which
> > > > > > > > couldn't afford memory reclaim. I also do not think we want to grant
> > > > > > >
> > > > > > > Because alloc_huge_page_vmemmap is called under hugetlb_lock
> > > > > > > now. So using GFP_ATOMIC indeed makes the code more simpler.
> > > > > >
> > > > > > You can have a preallocated list of pages prior taking the lock.
> > > > >
> > > > > A discussion about this can refer to here:
> > > > >
> > > > > https://patchwork.kernel.org/project/linux-mm/patch/20210117151053.24600-5-songmuchun@bytedance.com/
> > > > >
> > > > > > Moreover do we want to manipulate vmemmaps from under spinlock in
> > > > > > general. I have to say I have missed that detail when reviewing. Need to
> > > > > > think more.
> > > > > >
> > > > > > > From the document of the kernel, I learned that __GFP_NOMEMALLOC
> > > > > > > can be used to explicitly forbid access to emergency reserves. So if
> > > > > > > we do not want to use the reserve memory. How about replacing it to
> > > > > > >
> > > > > > > GFP_ATOMIC | __GFP_NOMEMALLOC | __GFP_NOWARN | __GFP_THISNODE
> > > > > >
> > > > > > The whole point of GFP_ATOMIC is to grant access to memory reserves so
> > > > > > the above is quite dubious. If you do not want access to memory reserves
> > > > >
> > > > > Look at the code of gfp_to_alloc_flags().
> > > > >
> > > > > static inline unsigned int gfp_to_alloc_flags(gfp_t gfp_mask)
> > > > > {
> > > > >         [...]
> > > > >         if (gfp_mask & __GFP_ATOMIC) {
> > > > >         /*
> > > > >          * Not worth trying to allocate harder for __GFP_NOMEMALLOC even
> > > > >          * if it can't schedule.
> > > > >          */
> > > > >         if (!(gfp_mask & __GFP_NOMEMALLOC))
> > > > >                 alloc_flags |= ALLOC_HARDER;
> > > > >        [...]
> > > > > }
> > > > >
> > > > > Seems to allow this operation (GFP_ATOMIC | __GFP_NOMEMALLOC).
> > >
> > > Please read my response again more carefully. I am not claiming that
> > > combination is not allowed. I have said it doesn't make any sense in
> > > this context.
> >
> > I see you are worried that using GFP_ATOMIC will use reverse memory
> > unlimited. So I think that __GFP_NOMEMALLOC may be suitable for us.
> > Sorry, I may not understand the point you said. What I missed?
>
> OK, let me try to explain again. GFP_ATOMIC is not only a non-sleeping
> allocation request. It also grants access to memory reserves. The later
> is a bit more involved because there are more layers of memory reserves
> to access but that is not really important. Non-sleeping semantic can be
> achieved by GFP_NOWAIT which will not grant access to reserves unless
> explicitly stated - e.g. by __GFP_HIGH or __GFP_ATOMIC.
> Is that more clear?
>
> Now again why I do not think access to memory reserves is suitable.
> Hugetlb pages can be released in a large batches and that might cause a
> peak depletion of memory reserves which are normally used by other
> consumers as well. Other GFP_ATOMIC users might see allocation failures.
> Those shouldn't be really fatal as nobody should be relying on those and
> a failure usually mean a hand over to a different, less constrained,
> context. So this concern is more about a more well behaved behavior from
> the hugetlb side than a correctness.
> Is that more clear?

Ok. It is very clear. Very thanks for your patient explanations.

>
> There shouldn't be any real reason why the memory allocation for
> vmemmaps, or handling vmemmap in general, has to be done from within the
> hugetlb lock and therefore requiring a non-sleeping semantic. All that
> can be deferred to a more relaxed context. If you want to make a

Yeah, you are right. We can put the freeing hugetlb routine to a
workqueue. Just like I do in the previous version (before v13) patch.
I will pick up these patches.

> GFP_NOWAIT optimistic attempt in the direct free path then no problem
> but you have to expect failures under memory pressure. If you want to
> have a more robust allocation request then you have to go outside of the
> spin lock and use GFP_KERNEL | __GFP_NORETRY or GFP_KERNEL |
> __GFP_RETRY_MAYFAIL depending on how hard you want to try.
> __GFP_THISNODE makes a slight difference here but something that I would
> recommend not depending on.
> Is that more clear?

OK. I will use GFP_KERNEL instead of GFP_ATOMIC. Thanks for your
suggestions.


> --
> Michal Hocko
> SUSE Labs
