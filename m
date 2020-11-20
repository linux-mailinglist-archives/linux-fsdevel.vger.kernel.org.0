Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9BF2BA7A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 11:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgKTKmG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 05:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgKTKmF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:42:05 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AB6C0617A7
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2020 02:42:04 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id u2so4646475pls.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2020 02:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rhg0TalW++AIGVdey4/dqRvHpgC5hAbWxadUO7j/mIU=;
        b=r5FHE4v24Sxrrbc9fxF9l8xtJhYKEd4JoQk3+U7q+3VcrO8KnwnZuD3xOJkCuBj9dx
         Tyfbmh8/76YsmPtn3BuNDyNTg7cKLaaA5Wgd/JoA6kJ/3JFkMtFnSmakT7jaZLUsr1ou
         H9ePsxd/XmuYwJlA9jLJsRmhCUTPhIiZcyq0pFwSgzSo216XSv/k6cpG5kVu7hiUOsZQ
         gWNC1bihiZYOfeh0aw/NoAC6X0Jcs799g6NpKy1SwIcIrLYnmd/XX15n+4l/z1Liw2PX
         vSxgSiyJeOuKGhLWEx5yTFredAnfVzvhwg4sB5OYFUO9LO4haNJY96fuFcyOhpcusGfW
         FQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rhg0TalW++AIGVdey4/dqRvHpgC5hAbWxadUO7j/mIU=;
        b=GPXWrcrGEHd7RshSzmwB7CbOP1jF2yyNw9zDmoIgSsrdBbDwOEpp4v0X1oF4wxqz7Y
         zSR4SqMm/dVvFZXOHLj+NASmnVpCxiC+fKyJD+YNx6TFpEbJBAmcN2W+21E+QlONy0HH
         ZGXiZwyfByjKJn69pA//81xv9/V44mMJM4ir3WAfJka/I5VlllSo4UpDoFq1h1JsFtYi
         g7ztjr3/Bik0N1SXkHVgU+CuQx5pSkWj/jxv0rl9Upfn4XnTkCxS1g4wUAaT2YxncGbj
         azbQ7ko+O/jdkxdgjJSPLq7mhyPTqHIqLJkpOJBv6pAyTPrKVKCTFpQRJY080f8lwGnz
         1WdA==
X-Gm-Message-State: AOAM5310uNDxBaOeG/gbUJnVlaB8Vzb17efxPAeZXoqThFEwo3mRYq56
        RdJl9cdmZXWFPnK1+vgXM22BkpL/dUZq4HB/JBpqdQ==
X-Google-Smtp-Source: ABdhPJwo70Vau0/TmWAHNwiYzcDzsWluXhtwVyPNqw28cOzHlwgb/GntNZfg3wCuFXDIabBvMCwFFnm5T/4nAtmjV2c=
X-Received: by 2002:a17:902:bb92:b029:d9:e9bf:b775 with SMTP id
 m18-20020a170902bb92b02900d9e9bfb775mr1682739pls.24.1605868924468; Fri, 20
 Nov 2020 02:42:04 -0800 (PST)
MIME-Version: 1.0
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120064325.34492-19-songmuchun@bytedance.com> <20201120082358.GH3200@dhcp22.suse.cz>
In-Reply-To: <20201120082358.GH3200@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 20 Nov 2020 18:41:22 +0800
Message-ID: <CAMZfGtU9pRdWFwH_1dqcYxg8zyMSC-nCiaUbT6zNKDiYkMt8Zw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 18/21] mm/hugetlb: Merge pte to huge pmd
 only for gigantic page
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
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 20, 2020 at 4:24 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 20-11-20 14:43:22, Muchun Song wrote:
> > Merge pte to huge pmd if it has ever been split. Now only support
> > gigantic page which's vmemmap pages size is an integer multiple of
> > PMD_SIZE. This is the simplest case to handle.
>
> I think it would be benefitial for anybody who plan to implement this
> for normal PMDs to document challenges while you still have them fresh
> in your mind.

Yeah, I agree with you. I will document it.

>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  arch/x86/include/asm/hugetlb.h |   8 +++
> >  mm/hugetlb_vmemmap.c           | 118 ++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 124 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/hugetlb.h
> > index c601fe042832..1de1c519a84a 100644
> > --- a/arch/x86/include/asm/hugetlb.h
> > +++ b/arch/x86/include/asm/hugetlb.h
> > @@ -12,6 +12,14 @@ static inline bool vmemmap_pmd_huge(pmd_t *pmd)
> >  {
> >       return pmd_large(*pmd);
> >  }
> > +
> > +#define vmemmap_pmd_mkhuge vmemmap_pmd_mkhuge
> > +static inline pmd_t vmemmap_pmd_mkhuge(struct page *page)
> > +{
> > +     pte_t entry = pfn_pte(page_to_pfn(page), PAGE_KERNEL_LARGE);
> > +
> > +     return __pmd(pte_val(entry));
> > +}
> >  #endif
> >
> >  #define hugepages_supported() boot_cpu_has(X86_FEATURE_PSE)
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index c958699d1393..bf2b6b3e75af 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -144,6 +144,14 @@ static inline bool vmemmap_pmd_huge(pmd_t *pmd)
> >  }
> >  #endif
> >
> > +#ifndef vmemmap_pmd_mkhuge
> > +#define vmemmap_pmd_mkhuge vmemmap_pmd_mkhuge
> > +static inline pmd_t vmemmap_pmd_mkhuge(struct page *page)
> > +{
> > +     return pmd_mkhuge(mk_pmd(page, PAGE_KERNEL));
> > +}
> > +#endif
> > +
> >  static bool hugetlb_free_vmemmap_disabled __initdata;
> >
> >  static int __init early_hugetlb_free_vmemmap_param(char *buf)
> > @@ -422,6 +430,104 @@ static void __remap_huge_page_pte_vmemmap(struct page *reuse, pte_t *ptep,
> >       }
> >  }
> >
> > +static void __replace_huge_page_pte_vmemmap(pte_t *ptep, unsigned long start,
> > +                                         unsigned int nr, struct page *huge,
> > +                                         struct list_head *free_pages)
> > +{
> > +     unsigned long addr;
> > +     unsigned long end = start + (nr << PAGE_SHIFT);
> > +     pgprot_t pgprot = PAGE_KERNEL;
> > +
> > +     for (addr = start; addr < end; addr += PAGE_SIZE, ptep++) {
> > +             struct page *page;
> > +             pte_t old = *ptep;
> > +             pte_t entry;
> > +
> > +             prepare_vmemmap_page(huge);
> > +
> > +             entry = mk_pte(huge++, pgprot);
> > +             VM_WARN_ON(!pte_present(old));
> > +             page = pte_page(old);
> > +             list_add(&page->lru, free_pages);
> > +
> > +             set_pte_at(&init_mm, addr, ptep, entry);
> > +     }
> > +}
> > +
> > +static void replace_huge_page_pmd_vmemmap(pmd_t *pmd, unsigned long start,
> > +                                       struct page *huge,
> > +                                       struct list_head *free_pages)
> > +{
> > +     unsigned long end = start + VMEMMAP_HPAGE_SIZE;
> > +
> > +     flush_cache_vunmap(start, end);
> > +     __replace_huge_page_pte_vmemmap(pte_offset_kernel(pmd, start), start,
> > +                                     VMEMMAP_HPAGE_NR, huge, free_pages);
> > +     flush_tlb_kernel_range(start, end);
> > +}
> > +
> > +static pte_t *merge_vmemmap_pte(pmd_t *pmdp, unsigned long addr)
> > +{
> > +     pte_t *pte;
> > +     struct page *page;
> > +
> > +     pte = pte_offset_kernel(pmdp, addr);
> > +     page = pte_page(*pte);
> > +     set_pmd(pmdp, vmemmap_pmd_mkhuge(page));
> > +
> > +     return pte;
> > +}
> > +
> > +static void merge_huge_page_pmd_vmemmap(pmd_t *pmd, unsigned long start,
> > +                                     struct page *huge,
> > +                                     struct list_head *free_pages)
> > +{
> > +     replace_huge_page_pmd_vmemmap(pmd, start, huge, free_pages);
> > +     pte_free_kernel(&init_mm, merge_vmemmap_pte(pmd, start));
> > +     flush_tlb_kernel_range(start, start + VMEMMAP_HPAGE_SIZE);
> > +}
> > +
> > +static inline void dissolve_compound_page(struct page *page, unsigned int order)
> > +{
> > +     int i;
> > +     unsigned int nr_pages = 1 << order;
> > +
> > +     for (i = 1; i < nr_pages; i++)
> > +             set_page_count(page + i, 1);
> > +}
> > +
> > +static void merge_gigantic_page_vmemmap(struct hstate *h, struct page *head,
> > +                                     pmd_t *pmd)
> > +{
> > +     LIST_HEAD(free_pages);
> > +     unsigned long addr = (unsigned long)head;
> > +     unsigned long end = addr + vmemmap_pages_size_per_hpage(h);
> > +
> > +     for (; addr < end; addr += VMEMMAP_HPAGE_SIZE) {
> > +             void *to;
> > +             struct page *page;
> > +
> > +             page = alloc_pages(GFP_VMEMMAP_PAGE & ~__GFP_NOFAIL,
> > +                                VMEMMAP_HPAGE_ORDER);
> > +             if (!page)
> > +                     goto out;
> > +
> > +             dissolve_compound_page(page, VMEMMAP_HPAGE_ORDER);
> > +             to = page_to_virt(page);
> > +             memcpy(to, (void *)addr, VMEMMAP_HPAGE_SIZE);
> > +
> > +             /*
> > +              * Make sure that any data that writes to the
> > +              * @to is made visible to the physical page.
> > +              */
> > +             flush_kernel_vmap_range(to, VMEMMAP_HPAGE_SIZE);
> > +
> > +             merge_huge_page_pmd_vmemmap(pmd++, addr, page, &free_pages);
> > +     }
> > +out:
> > +     free_vmemmap_page_list(&free_pages);
> > +}
> > +
> >  static inline void alloc_vmemmap_pages(struct hstate *h, struct list_head *list)
> >  {
> >       int i;
> > @@ -454,10 +560,18 @@ void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
> >                                   __remap_huge_page_pte_vmemmap);
> >       if (!freed_vmemmap_hpage_dec(pmd_page(*pmd)) && pmd_split(pmd)) {
> >               /*
> > -              * Todo:
> > -              * Merge pte to huge pmd if it has ever been split.
> > +              * Merge pte to huge pmd if it has ever been split. Now only
> > +              * support gigantic page which's vmemmap pages size is an
> > +              * integer multiple of PMD_SIZE. This is the simplest case
> > +              * to handle.
> >                */
> >               clear_pmd_split(pmd);
> > +
> > +             if (IS_ALIGNED(vmemmap_pages_per_hpage(h), VMEMMAP_HPAGE_NR)) {
> > +                     spin_unlock(ptl);
> > +                     merge_gigantic_page_vmemmap(h, head, pmd);
> > +                     return;
> > +             }
> >       }
> >       spin_unlock(ptl);
> >  }
> > --
> > 2.11.0
>
> --
> Michal Hocko
> SUSE Labs



--
Yours,
Muchun
