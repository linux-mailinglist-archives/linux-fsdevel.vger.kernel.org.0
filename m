Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36042BA0A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 03:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgKTCwp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 21:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgKTCwo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 21:52:44 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D73C0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2020 18:52:42 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 10so6477593pfp.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2020 18:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x3fQTleE37dBaaRILN4zja/x8tkqs0SN0a6ZWTGISLw=;
        b=xXyxgqODRAMMU0TFUNqpr/JQ8NScJjSNeRtfE69kZJl7F2i+xOmuYWnakeuKW2+7qC
         6LkRF2YJ3oHPUuKEZ3ePeujmEXQ5K84jXbRmhEZR3c+vJAy+CzpTIH2LjMPsZGr9JweN
         70noZeB/jPfeSbknhioqeiqqp0o602+KijL+n/yDY1RVUItp+jDmnbrUBFN9uK4oDE3q
         KUXRKR/cdldDw8NrltAckAJdyU00yBQM3Rg4QcfdTBGoHXPaVKKqfYeNkwyrnv+GNcvE
         TBgx/jRVDZ0OnrWwNsJ47Fi2UeWmrBcMc8yvyMgpJfXpr57aolX/H3ICJvRlSoWtaAi4
         Fo+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x3fQTleE37dBaaRILN4zja/x8tkqs0SN0a6ZWTGISLw=;
        b=QXLnpA+wwrAi1DdKpq/7eO+6TI0IZYswlnk8immPMMTcupOfHwAIaLODnflis5hu1t
         LSAl/bvdJCXAfX19DZduMWzjRpfFk0M3uQ2DyMgDxxhQHt5sa0/M1kvrLwgAZvgaW04B
         dsoFFGvJF2weDt7GZ+5T/CAwzH5G8/6qRNE5UCerw1hDpBTGsteW+Y2Uye69sLJQbm28
         nDsVl4uR+slBN0vZGD21kq9i9RSOD3mhaNl1gsin5hx1xIhf+CTEqBxryG47R86IzHlD
         e1QHOiu2XJwrHx0CU6QiRUyZRteZC0QwOVOie3j4Hx2kAf4ztEU9RdZcF+0w1CabWKlY
         IcTw==
X-Gm-Message-State: AOAM530oND511C622bc+l74JwMM2sMUbvehH+ohtATVEd0/5CpnfCutL
        2ahvW2m3eetQII8HNhUR8ntMjJ5J1TltjkJAyniFng==
X-Google-Smtp-Source: ABdhPJwSi5hXLwYwcc3owyMdpS7hyrS2TAlDEStfyPSgBWEmCwvUNzG52KrLGt3o75xw6sXcUfAk2L+XtfsQE/7R3r4=
X-Received: by 2002:a17:90b:941:: with SMTP id dw1mr7748343pjb.147.1605840761818;
 Thu, 19 Nov 2020 18:52:41 -0800 (PST)
MIME-Version: 1.0
References: <20201113105952.11638-1-songmuchun@bytedance.com>
 <20201113105952.11638-6-songmuchun@bytedance.com> <20201117150604.GA15679@linux>
 <CAMZfGtW=Oyaoooow9_i+R1LkvGpcFoUjBxYzGqBZsOa-t-sFsg@mail.gmail.com> <44efc25e-525b-9e51-60e4-da20deb25ded@oracle.com>
In-Reply-To: <44efc25e-525b-9e51-60e4-da20deb25ded@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 20 Nov 2020 10:52:00 +0800
Message-ID: <CAMZfGtXrieb8n=RqLReaQyFL13B4PN20FqKqYSfAAKoR+AdEeQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4 05/21] mm/hugetlb: Introduce pgtable
 allocation/freeing helpers
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Michal Hocko <mhocko@suse.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 20, 2020 at 7:22 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 11/18/20 10:17 PM, Muchun Song wrote:
> > On Tue, Nov 17, 2020 at 11:06 PM Oscar Salvador <osalvador@suse.de> wrote:
> >>
> >> On Fri, Nov 13, 2020 at 06:59:36PM +0800, Muchun Song wrote:
> >>> +#define page_huge_pte(page)          ((page)->pmd_huge_pte)
> >>
> >> Seems you do not need this one anymore.
> >>
> >>> +void vmemmap_pgtable_free(struct page *page)
> >>> +{
> >>> +     struct page *pte_page, *t_page;
> >>> +
> >>> +     list_for_each_entry_safe(pte_page, t_page, &page->lru, lru) {
> >>> +             list_del(&pte_page->lru);
> >>> +             pte_free_kernel(&init_mm, page_to_virt(pte_page));
> >>> +     }
> >>> +}
> >>> +
> >>> +int vmemmap_pgtable_prealloc(struct hstate *h, struct page *page)
> >>> +{
> >>> +     unsigned int nr = pgtable_pages_to_prealloc_per_hpage(h);
> >>> +
> >>> +     /* Store preallocated pages on huge page lru list */
> >>> +     INIT_LIST_HEAD(&page->lru);
> >>> +
> >>> +     while (nr--) {
> >>> +             pte_t *pte_p;
> >>> +
> >>> +             pte_p = pte_alloc_one_kernel(&init_mm);
> >>> +             if (!pte_p)
> >>> +                     goto out;
> >>> +             list_add(&virt_to_page(pte_p)->lru, &page->lru);
> >>> +     }
> >>
> >> Definetely this looks better and easier to handle.
> >> Btw, did you explore Matthew's hint about instead of allocating a new page,
> >> using one of the ones you are going to free to store the ptes?
> >> I am not sure whether it is feasible at all though.
> >
> > Hi Oscar and Matthew,
> >
> > I have started an investigation about this. Finally, I think that it
> > may not be feasible. If we use a vmemmap page frame as a
> > page table when we split the PMD table firstly, in this stage,
> > we need to set 512 pte entry to the vmemmap page frame. If
> > someone reads the tail struct page struct of the HugeTLB,
> > it can get the arbitrary value (I am not sure it actually exists,
> > maybe the memory compaction module can do this). So on
> > the safe side, I think that allocating a new page is a good
> > choice.
>
> Thanks for looking into this.
>
> If I understand correctly, the issue is that you need the pte page to set
> up the new mappings.  In your current code, this is done before removing
> the pages of struct pages.  This keeps everything 'consistent' as things
> are remapped.
>
> If you want to use one of the 'pages of struct pages' for the new pte
> page, then there will be a period of time when things are inconsistent.
> Before setting up the mapping, some code could potentially access that
> pages of struct pages.

Yeah, you are right.

>
> I tend to agree that allocating allocating a new page is the safest thing
> to do here.  Or, perhaps someone can think of a way make this safe.
> --
> Mike Kravetz



-- 
Yours,
Muchun
