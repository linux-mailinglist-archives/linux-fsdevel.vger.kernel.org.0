Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D842B5CD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 11:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgKQK1h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 05:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgKQK1h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 05:27:37 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1075CC0617A7
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2020 02:27:37 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id f12so208308pjp.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2020 02:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UEn7Tg67K8I+wuhjEqj+cLB1GUHLkYFWQgXtnTAPhSQ=;
        b=gtmw1WzMH1yzcm8QlpY77DjqO/GkYsqX/x5tE8tgWOzgbX4k4wBBkqIswDYOB89/s6
         HfXOzYLME8Z+TqIX+VDNA79THzawOFIs6RvKnKF4Y2LGzc/a3NuQJyAJAQbyjFadkmvd
         4pU/hJdkTHLWFZ8cJsopM5IyBWPqyDIY3RmtUvMAq1wmhJMTnEcZ+Z7E/1qXqbusPz8w
         Ab4P/6nSyy1Tc0KPstAy9aCBSorAO51IMPlvV/RnNgmgYdE+7v3Ejb4mNrG1jPKjUXDg
         FloQh9xtdy/HmdGwYo8bmR2yD/PqjNq4snysCIAcBqcNcJlkDEAilI0TBlsYNPlOPL0W
         YWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UEn7Tg67K8I+wuhjEqj+cLB1GUHLkYFWQgXtnTAPhSQ=;
        b=XpXNZ2Smis8PYo2jKXcdhyMdapqgDcf2+2IUtcWjVliGql4OP1pyrXSInRrbMmzIwT
         XMdXgW4Feoh0XwVNbYGV8U/vLwP8hQtheRCfJhkZG2woGl3SfAL9/eEgso4yqwvNuMTg
         olQXu3S0LEWZM/NlqhyXtC0MMtaAVk6COVQ4zKuRqk4mhVz+uPBvFNiUQdNIx8gjxqHS
         unb8Fl7ZD8gu7sRogIU3VBkyOQANm4IQDzxf7uNrB8srvMaCYXlrv9aEN0AQdmltrzM3
         rcdUiZfb8xwrKsEPahT8R8LhzsnlRCLGJlpXxBxrkP/dnxv+GLxW9ztZojG8QSpJdjGo
         VPeg==
X-Gm-Message-State: AOAM532ruBouFEG56B9SieL819Ihkx2FVpzXwvsJcHs7JCCOQ2zPwt3B
        axv/9M0WIVCmiXmz89Xch3FvsIIeKbU2JGgt0u/PAjec0+GD98aVcOU=
X-Google-Smtp-Source: ABdhPJz0rYxwirlLTEbGkVnGUEEflqkI1+KPPpp28wi2CM40/f+7A4UcZmhXswOgw3t7M7kU6DNzNN0AptF8TaWEtts=
X-Received: by 2002:a17:90b:4a0c:: with SMTP id kk12mr312755pjb.147.1605608856185;
 Tue, 17 Nov 2020 02:27:36 -0800 (PST)
MIME-Version: 1.0
References: <20201113105952.11638-1-songmuchun@bytedance.com>
 <20201113105952.11638-10-songmuchun@bytedance.com> <e28c3bb8689d4cb7aee16052c1a059a9@hisilicon.com>
In-Reply-To: <e28c3bb8689d4cb7aee16052c1a059a9@hisilicon.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 17 Nov 2020 18:26:57 +0800
Message-ID: <CAMZfGtUp362p3X1zFak+uxvCmbW3+UG7n9rwg7-Nwdqv-SfSzA@mail.gmail.com>
Subject: Re: [External] RE: [PATCH v4 09/21] mm/hugetlb: Free the vmemmap
 pages associated with each hugetlb page
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "oneukum@suse.com" <oneukum@suse.com>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "almasrymina@google.com" <almasrymina@google.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "duanxiongchun@bytedance.com" <duanxiongchun@bytedance.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 17, 2020 at 5:55 PM Song Bao Hua (Barry Song)
<song.bao.hua@hisilicon.com> wrote:
>
>
>
> > -----Original Message-----
> > From: owner-linux-mm@kvack.org [mailto:owner-linux-mm@kvack.org] On
> > Behalf Of Muchun Song
> > Sent: Saturday, November 14, 2020 12:00 AM
> > To: corbet@lwn.net; mike.kravetz@oracle.com; tglx@linutronix.de;
> > mingo@redhat.com; bp@alien8.de; x86@kernel.org; hpa@zytor.com;
> > dave.hansen@linux.intel.com; luto@kernel.org; peterz@infradead.org;
> > viro@zeniv.linux.org.uk; akpm@linux-foundation.org; paulmck@kernel.org;
> > mchehab+huawei@kernel.org; pawan.kumar.gupta@linux.intel.com;
> > rdunlap@infradead.org; oneukum@suse.com; anshuman.khandual@arm.com;
> > jroedel@suse.de; almasrymina@google.com; rientjes@google.com;
> > willy@infradead.org; osalvador@suse.de; mhocko@suse.com
> > Cc: duanxiongchun@bytedance.com; linux-doc@vger.kernel.org;
> > linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> > linux-fsdevel@vger.kernel.org; Muchun Song <songmuchun@bytedance.com>
> > Subject: [PATCH v4 09/21] mm/hugetlb: Free the vmemmap pages associated
> > with each hugetlb page
> >
> > When we allocate a hugetlb page from the buddy, we should free the
> > unused vmemmap pages associated with it. We can do that in the
> > prep_new_huge_page().
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  arch/x86/include/asm/hugetlb.h          |   9 ++
> >  arch/x86/include/asm/pgtable_64_types.h |   8 ++
> >  mm/hugetlb.c                            |  16 +++
> >  mm/hugetlb_vmemmap.c                    | 188
> > ++++++++++++++++++++++++++++++++
> >  mm/hugetlb_vmemmap.h                    |   5 +
> >  5 files changed, 226 insertions(+)
> >
> > diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/huge=
tlb.h
> > index 1721b1aadeb1..c601fe042832 100644
> > --- a/arch/x86/include/asm/hugetlb.h
> > +++ b/arch/x86/include/asm/hugetlb.h
> > @@ -4,6 +4,15 @@
> >
> >  #include <asm/page.h>
> >  #include <asm-generic/hugetlb.h>
> > +#include <asm/pgtable.h>
> > +
> > +#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> > +#define vmemmap_pmd_huge vmemmap_pmd_huge
> > +static inline bool vmemmap_pmd_huge(pmd_t *pmd)
> > +{
> > +     return pmd_large(*pmd);
> > +}
> > +#endif
> >
> >  #define hugepages_supported() boot_cpu_has(X86_FEATURE_PSE)
> >
> > diff --git a/arch/x86/include/asm/pgtable_64_types.h
> > b/arch/x86/include/asm/pgtable_64_types.h
> > index 52e5f5f2240d..bedbd2e7d06c 100644
> > --- a/arch/x86/include/asm/pgtable_64_types.h
> > +++ b/arch/x86/include/asm/pgtable_64_types.h
> > @@ -139,6 +139,14 @@ extern unsigned int ptrs_per_p4d;
> >  # define VMEMMAP_START               __VMEMMAP_BASE_L4
> >  #endif /* CONFIG_DYNAMIC_MEMORY_LAYOUT */
> >
> > +/*
> > + * VMEMMAP_SIZE - allows the whole linear region to be covered by
> > + *                a struct page array.
> > + */
> > +#define VMEMMAP_SIZE         (1UL << (__VIRTUAL_MASK_SHIFT -
> > PAGE_SHIFT - \
> > +                                      1 + ilog2(sizeof(struct page))))
> > +#define VMEMMAP_END          (VMEMMAP_START + VMEMMAP_SIZE)
> > +
> >  #define VMALLOC_END          (VMALLOC_START + (VMALLOC_SIZE_TB <<
> > 40) - 1)
> >
> >  #define MODULES_VADDR                (__START_KERNEL_map +
> > KERNEL_IMAGE_SIZE)
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index f88032c24667..a0ce6f33a717 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1499,6 +1499,14 @@ void free_huge_page(struct page *page)
> >
> >  static void prep_new_huge_page(struct hstate *h, struct page *page, in=
t nid)
> >  {
> > +     free_huge_page_vmemmap(h, page);
> > +     /*
> > +      * Because we store preallocated pages on @page->lru,
> > +      * vmemmap_pgtable_free() must be called before the
> > +      * initialization of @page->lru in INIT_LIST_HEAD().
> > +      */
> > +     vmemmap_pgtable_free(page);
> > +
> >       INIT_LIST_HEAD(&page->lru);
> >       set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
> >       set_hugetlb_cgroup(page, NULL);
> > @@ -1751,6 +1759,14 @@ static struct page *alloc_fresh_huge_page(struct
> > hstate *h,
> >       if (!page)
> >               return NULL;
> >
> > +     if (vmemmap_pgtable_prealloc(h, page)) {
> > +             if (hstate_is_gigantic(h))
> > +                     free_gigantic_page(page, huge_page_order(h));
> > +             else
> > +                     put_page(page);
> > +             return NULL;
> > +     }
> > +
> >       if (hstate_is_gigantic(h))
> >               prep_compound_gigantic_page(page, huge_page_order(h));
> >       prep_new_huge_page(h, page, page_to_nid(page));
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index 332c131c01a8..937562a15f1e 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -74,6 +74,7 @@
> >  #include <linux/pagewalk.h>
> >  #include <linux/mmzone.h>
> >  #include <linux/list.h>
> > +#include <linux/bootmem_info.h>
> >  #include <asm/pgalloc.h>
> >  #include "hugetlb_vmemmap.h"
> >
> > @@ -86,6 +87,8 @@
> >   * reserve at least 2 pages as vmemmap areas.
> >   */
> >  #define RESERVE_VMEMMAP_NR           2U
> > +#define RESERVE_VMEMMAP_SIZE         (RESERVE_VMEMMAP_NR <<
> > PAGE_SHIFT)
> > +#define TAIL_PAGE_REUSE                      -1
> >
> >  #ifndef VMEMMAP_HPAGE_SHIFT
> >  #define VMEMMAP_HPAGE_SHIFT          HPAGE_SHIFT
> > @@ -97,6 +100,21 @@
> >
> >  #define page_huge_pte(page)          ((page)->pmd_huge_pte)
> >
> > +#define vmemmap_hpage_addr_end(addr, end)                             =
\
> > +({                                                                    =
\
> > +     unsigned long __boundary;                                        =
\
> > +     __boundary =3D ((addr) + VMEMMAP_HPAGE_SIZE) &
> > VMEMMAP_HPAGE_MASK; \
> > +     (__boundary - 1 < (end) - 1) ? __boundary : (end);               =
\
> > +})
> > +
> > +#ifndef vmemmap_pmd_huge
> > +#define vmemmap_pmd_huge vmemmap_pmd_huge
> > +static inline bool vmemmap_pmd_huge(pmd_t *pmd)
> > +{
> > +     return pmd_huge(*pmd);
> > +}
> > +#endif
> > +
> >  static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate =
*h)
> >  {
> >       return h->nr_free_vmemmap_pages;
> > @@ -158,6 +176,176 @@ int vmemmap_pgtable_prealloc(struct hstate *h,
> > struct page *page)
> >       return -ENOMEM;
> >  }
> >
> > +/*
> > + * Walk a vmemmap address to the pmd it maps.
> > + */
> > +static pmd_t *vmemmap_to_pmd(unsigned long page)
> > +{
> > +     pgd_t *pgd;
> > +     p4d_t *p4d;
> > +     pud_t *pud;
> > +     pmd_t *pmd;
> > +
> > +     if (page < VMEMMAP_START || page >=3D VMEMMAP_END)
> > +             return NULL;
> > +
> > +     pgd =3D pgd_offset_k(page);
> > +     if (pgd_none(*pgd))
> > +             return NULL;
> > +     p4d =3D p4d_offset(pgd, page);
> > +     if (p4d_none(*p4d))
> > +             return NULL;
> > +     pud =3D pud_offset(p4d, page);
> > +
> > +     if (pud_none(*pud) || pud_bad(*pud))
> > +             return NULL;
> > +     pmd =3D pmd_offset(pud, page);
> > +
> > +     return pmd;
> > +}
> > +
> > +static inline spinlock_t *vmemmap_pmd_lock(pmd_t *pmd)
> > +{
> > +     return pmd_lock(&init_mm, pmd);
> > +}
> > +
> > +static inline int freed_vmemmap_hpage(struct page *page)
> > +{
> > +     return atomic_read(&page->_mapcount) + 1;
> > +}
> > +
> > +static inline int freed_vmemmap_hpage_inc(struct page *page)
> > +{
> > +     return atomic_inc_return_relaxed(&page->_mapcount) + 1;
> > +}
> > +
> > +static inline int freed_vmemmap_hpage_dec(struct page *page)
> > +{
> > +     return atomic_dec_return_relaxed(&page->_mapcount) + 1;
> > +}
> > +
> > +static inline void free_vmemmap_page_list(struct list_head *list)
> > +{
> > +     struct page *page, *next;
> > +
> > +     list_for_each_entry_safe(page, next, list, lru) {
> > +             list_del(&page->lru);
> > +             free_vmemmap_page(page);
> > +     }
> > +}
> > +
> > +static void __free_huge_page_pte_vmemmap(struct page *reuse, pte_t *pt=
ep,
> > +                                      unsigned long start,
> > +                                      unsigned long end,
> > +                                      struct list_head *free_pages)
> > +{
> > +     /* Make the tail pages are mapped read-only. */
> > +     pgprot_t pgprot =3D PAGE_KERNEL_RO;
> > +     pte_t entry =3D mk_pte(reuse, pgprot);
> > +     unsigned long addr;
> > +
> > +     for (addr =3D start; addr < end; addr +=3D PAGE_SIZE, ptep++) {
> > +             struct page *page;
> > +             pte_t old =3D *ptep;
> > +
> > +             VM_WARN_ON(!pte_present(old));
> > +             page =3D pte_page(old);
> > +             list_add(&page->lru, free_pages);
> > +
> > +             set_pte_at(&init_mm, addr, ptep, entry);
> > +     }
> > +}
> > +
> > +static void __free_huge_page_pmd_vmemmap(struct hstate *h, pmd_t *pmd,
> > +                                      unsigned long addr,
> > +                                      struct list_head *free_pages)
> > +{
> > +     unsigned long next;
> > +     unsigned long start =3D addr + RESERVE_VMEMMAP_SIZE;
> > +     unsigned long end =3D addr + vmemmap_pages_size_per_hpage(h);
> > +     struct page *reuse =3D NULL;
> > +
> > +     addr =3D start;
> > +     do {
> > +             pte_t *ptep;
> > +
> > +             ptep =3D pte_offset_kernel(pmd, addr);
> > +             if (!reuse)
> > +                     reuse =3D pte_page(ptep[TAIL_PAGE_REUSE]);
> > +
> > +             next =3D vmemmap_hpage_addr_end(addr, end);
> > +             __free_huge_page_pte_vmemmap(reuse, ptep, addr, next,
> > +                                          free_pages);
> > +     } while (pmd++, addr =3D next, addr !=3D end);
> > +
> > +     flush_tlb_kernel_range(start, end);
> > +}
> > +
> > +static void split_vmemmap_pmd(pmd_t *pmd, pte_t *pte_p, unsigned long
> > addr)
>
> Hi Muchun,
>
> Are you going to restore the pmd mapping after you free the hugetlb? I me=
an,
> When you free continuous 128MB hugetlb pages with 2MB size, will you
> redo the PMD vmemmap since 2MB PMD can just contain the page struct of
> 128MB memory?

Now we only restore the pmd mapping for the 1GB HugeTLB page. For the
2MB HugeTLB page, we do not(I haven't figured out how to handle it graceful=
ly).

>
> If no, wouldn't it be simpler to only use base pages while populating vme=
mmap?
> I mean, once we enable the Kconfig option you add for VMEMMAP_FREE, we
> only use base pages to place "page struct" but not split PMD into base pa=
ges
> afterwards.
>
> One negative side effect might be that base pages are also used for those=
 pages
> which won't be hugetlb later. but if most pages of host will be hugetlb f=
or
> guest and SPDK, it shouldn't hurt too much.

Yeah, I agree with you. If the user uses a lot of HugeTLB pages(e.g.
SPDK/Guest),
it shouldn't hurt too much. And using base pages while populating vmemmap a=
lso
can decrease the overhead(of splitting PMD). In the end, if we don=E2=80=99=
t
come up with
a more suitable solution to deal with it(mentioned above for 2MB HugeTLB pa=
ge).
Maybe this is also an idea.

Thanks.

>
> Or at least this can be done for hugetlb reserved by cmdline?
>
> > +{
> > +     int i;
> > +     pgprot_t pgprot =3D PAGE_KERNEL;
> > +     struct mm_struct *mm =3D &init_mm;
> > +     struct page *page;
> > +     pmd_t old_pmd, _pmd;
> > +
> > +     old_pmd =3D READ_ONCE(*pmd);
> > +     page =3D pmd_page(old_pmd);
> > +     pmd_populate_kernel(mm, &_pmd, pte_p);
> > +
> > +     for (i =3D 0; i < VMEMMAP_HPAGE_NR; i++, addr +=3D PAGE_SIZE) {
> > +             pte_t entry, *pte;
> > +
> > +             entry =3D mk_pte(page + i, pgprot);
> > +             pte =3D pte_offset_kernel(&_pmd, addr);
> > +             VM_BUG_ON(!pte_none(*pte));
> > +             set_pte_at(mm, addr, pte, entry);
> > +     }
> > +
> > +     /* make pte visible before pmd */
> > +     smp_wmb();
> > +     pmd_populate_kernel(mm, pmd, pte_p);
> > +}
> > +
> > +static void split_vmemmap_huge_page(struct page *head, pmd_t *pmd)
> > +{
> > +     struct page *pte_page, *t_page;
> > +     unsigned long start =3D (unsigned long)head & VMEMMAP_HPAGE_MASK;
> > +     unsigned long addr =3D start;
> > +
> > +     list_for_each_entry_safe(pte_page, t_page, &head->lru, lru) {
> > +             list_del(&pte_page->lru);
> > +             VM_BUG_ON(freed_vmemmap_hpage(pte_page));
> > +             split_vmemmap_pmd(pmd++, page_to_virt(pte_page), addr);
> > +             addr +=3D VMEMMAP_HPAGE_SIZE;
> > +     }
> > +
> > +     flush_tlb_kernel_range(start, addr);
> > +}
> > +
> > +void free_huge_page_vmemmap(struct hstate *h, struct page *head)
> > +{
> > +     pmd_t *pmd;
> > +     spinlock_t *ptl;
> > +     LIST_HEAD(free_pages);
> > +
> > +     if (!free_vmemmap_pages_per_hpage(h))
> > +             return;
> > +
> > +     pmd =3D vmemmap_to_pmd((unsigned long)head);
> > +     BUG_ON(!pmd);
> > +
> > +     ptl =3D vmemmap_pmd_lock(pmd);
> > +     if (vmemmap_pmd_huge(pmd))
> > +             split_vmemmap_huge_page(head, pmd);
> > +
> > +     __free_huge_page_pmd_vmemmap(h, pmd, (unsigned long)head,
> > &free_pages);
> > +     freed_vmemmap_hpage_inc(pmd_page(*pmd));
> > +     spin_unlock(ptl);
> > +
> > +     free_vmemmap_page_list(&free_pages);
> > +}
> > +
> >  void __init hugetlb_vmemmap_init(struct hstate *h)
> >  {
> >       unsigned int order =3D huge_page_order(h);
> > diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> > index 2a72d2f62411..fb8b77659ed5 100644
> > --- a/mm/hugetlb_vmemmap.h
> > +++ b/mm/hugetlb_vmemmap.h
> > @@ -15,6 +15,7 @@
> >  void __init hugetlb_vmemmap_init(struct hstate *h);
> >  int vmemmap_pgtable_prealloc(struct hstate *h, struct page *page);
> >  void vmemmap_pgtable_free(struct page *page);
> > +void free_huge_page_vmemmap(struct hstate *h, struct page *head);
> >  #else
> >  static inline void hugetlb_vmemmap_init(struct hstate *h)
> >  {
> > @@ -28,5 +29,9 @@ static inline int vmemmap_pgtable_prealloc(struct hst=
ate
> > *h, struct page *page)
> >  static inline void vmemmap_pgtable_free(struct page *page)
> >  {
> >  }
> > +
> > +static inline void free_huge_page_vmemmap(struct hstate *h, struct pag=
e
> > *head)
> > +{
> > +}
> >  #endif /* CONFIG_HUGETLB_PAGE_FREE_VMEMMAP */
> >  #endif /* _LINUX_HUGETLB_VMEMMAP_H */
> > --
> > 2.11.0
> >
>
> Thanks
> Barry
>


--=20
Yours,
Muchun
