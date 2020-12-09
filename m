Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670212D3EB1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 10:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbgLIJ0g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 04:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729225AbgLIJ0f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 04:26:35 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36FFC0617A6
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Dec 2020 01:25:51 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id t3so799876pgi.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Dec 2020 01:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dXhJecn2ypVF83qY85JZPNhQKUDimjCGcH0BANuxqD8=;
        b=btZEszo399nkRw0hQGx4M+kOmKh7hLcMACNMz9aihZjqLTbhaJ1SiNfiWEnnRwziq6
         LQAMzNVQWBRegOB1UJ38wyODwmjFmq97Xg702dKnZ1hxSMRRvAJScqM314jD3c9D3+A5
         28jwacShlzrw2crSNaf5KeYDHR1pph6kXdGCfAA/G24sWvdNLBGV5PLKcpqrqa9W1D2I
         vLrwrLcE076E+cvCo1ZVvPycwMbJk+oupiVfBTocPAmtsSpj/oClwnPkYodzcfthEST/
         qrfTPrSS6vkn4QNC0Fj9qlOHSWqnfjoKqu06jzvuSnNtE+3hhWXdk/3tjV28anSJqhGK
         DnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dXhJecn2ypVF83qY85JZPNhQKUDimjCGcH0BANuxqD8=;
        b=jEr9s29IHdwo563eb/eKhQWlE51V/MRIIY92e1ycVZZC9lZWW3QXiecXyGCXFCkDd0
         dojcQdtSVprNv/Gf6NJyDeIDMz7GjCQeyERDw+qlxH0goJGOOKuJY6jGqfHpQD8+re8J
         fEKHD6IDrbm8oqNxnDdSyNc7tpmnNkNnJU4opCqMAkavZCcUDk7Bn8FHIXjVoVXIAV7s
         ZwwykUWn9EVWItN8lOOY1wofdpTr4yxtaHCJC4RJn5R8oqUCGR9q3rTEDau8fSo2mfje
         X954Lr0F9bvJ3dXBSaDwBKjKfJoQNaSbiPbtklKMVtKehxvAC5KvqUBBrVnRSHlXQcGn
         DuTg==
X-Gm-Message-State: AOAM5334tklN16BtfyD5wBANDPcG4ZkkRm/+7CGZo+CzDOoyI9++AuM/
        C0iD/Y+oZkkWl+kp0IQm3NtKXiETMrYIrFWcPrQGDQ==
X-Google-Smtp-Source: ABdhPJwFLbBXb64wStSXcxtAKbqPsWO/Ku4ocEbgmI3UBNMsXCLDqKy1pLDkd8jG2nmEHH9Rn3i1dKvP2PftcKqDUlo=
X-Received: by 2002:a63:1203:: with SMTP id h3mr1140479pgl.273.1607505951447;
 Wed, 09 Dec 2020 01:25:51 -0800 (PST)
MIME-Version: 1.0
References: <20201130151838.11208-1-songmuchun@bytedance.com>
 <20201130151838.11208-6-songmuchun@bytedance.com> <17abb7bb-de39-7580-b020-faec58032de9@redhat.com>
 <CAMZfGtWepk0EXc_fCtS83gvhfKpMrXxP8k3oWwfhWKmPJ3jjwA@mail.gmail.com> <096ee806-b371-c22b-9066-8891935fbd5e@redhat.com>
In-Reply-To: <096ee806-b371-c22b-9066-8891935fbd5e@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 9 Dec 2020 17:25:14 +0800
Message-ID: <CAMZfGtU-zpPRkSikcYZUhKvWhpwZ+cspXNhoaok9e6MCE2pk-g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v7 05/15] mm/bootmem_info: Introduce {free,prepare}_vmemmap_page()
To:     David Hildenbrand <david@redhat.com>
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
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 9, 2020 at 4:50 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 09.12.20 08:36, Muchun Song wrote:
> > On Mon, Dec 7, 2020 at 8:39 PM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 30.11.20 16:18, Muchun Song wrote:
> >>> In the later patch, we can use the free_vmemmap_page() to free the
> >>> unused vmemmap pages and initialize a page for vmemmap page using
> >>> via prepare_vmemmap_page().
> >>>
> >>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >>> ---
> >>>  include/linux/bootmem_info.h | 24 ++++++++++++++++++++++++
> >>>  1 file changed, 24 insertions(+)
> >>>
> >>> diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
> >>> index 4ed6dee1adc9..239e3cc8f86c 100644
> >>> --- a/include/linux/bootmem_info.h
> >>> +++ b/include/linux/bootmem_info.h
> >>> @@ -3,6 +3,7 @@
> >>>  #define __LINUX_BOOTMEM_INFO_H
> >>>
> >>>  #include <linux/mmzone.h>
> >>> +#include <linux/mm.h>
> >>>
> >>>  /*
> >>>   * Types for free bootmem stored in page->lru.next. These have to be in
> >>> @@ -22,6 +23,29 @@ void __init register_page_bootmem_info_node(struct pglist_data *pgdat);
> >>>  void get_page_bootmem(unsigned long info, struct page *page,
> >>>                     unsigned long type);
> >>>  void put_page_bootmem(struct page *page);
> >>> +
> >>> +static inline void free_vmemmap_page(struct page *page)
> >>> +{
> >>> +     VM_WARN_ON(!PageReserved(page) || page_ref_count(page) != 2);
> >>> +
> >>> +     /* bootmem page has reserved flag in the reserve_bootmem_region */
> >>> +     if (PageReserved(page)) {
> >>> +             unsigned long magic = (unsigned long)page->freelist;
> >>> +
> >>> +             if (magic == SECTION_INFO || magic == MIX_SECTION_INFO)
> >>> +                     put_page_bootmem(page);
> >>> +             else
> >>> +                     WARN_ON(1);
> >>> +     }
> >>> +}
> >>> +
> >>> +static inline void prepare_vmemmap_page(struct page *page)
> >>> +{
> >>> +     unsigned long section_nr = pfn_to_section_nr(page_to_pfn(page));
> >>> +
> >>> +     get_page_bootmem(section_nr, page, SECTION_INFO);
> >>> +     mark_page_reserved(page);
> >>> +}
> >>
> >> Can you clarify in the description when exactly these functions are
> >> called and on which type of pages?
> >>
> >> Would indicating "bootmem" in the function names make it clearer what we
> >> are dealing with?
> >>
> >> E.g., any memory allocated via the memblock allocator and not via the
> >> buddy will be makred reserved already in the memmap. It's unclear to me
> >> why we need the mark_page_reserved() here - can you enlighten me? :)
> >
> > Sorry for ignoring this question. Because the vmemmap pages are allocated
> > from the bootmem allocator which is marked as PG_reserved. For those bootmem
> > pages, we should call put_page_bootmem for free. You can see that we
> > clear the PG_reserved in the put_page_bootmem. In order to be consistent,
> > the prepare_vmemmap_page also marks the page as PG_reserved.
>
> I don't think that really makes sense.
>
> After put_page_bootmem() put the last reference, it clears PG_reserved
> and hands the page over to the buddy via free_reserved_page(). From that
> point on, further get_page_bootmem() would be completely wrong and
> dangerous.
>
> Both, put_page_bootmem() and get_page_bootmem() rely on the fact that
> they are dealing with memblock allcoations - marked via PG_reserved. If
> prepare_vmemmap_page() would be called on something that's *not* coming
> from the memblock allocator, it would be completely broken - or am I
> missing something?
>
> AFAIKT, there should rather be a BUG_ON(!PageReserved(page)) in
> prepare_vmemmap_page() - or proper handling to deal with !memblock
> allocations.
>

I want to allocate some pages as the vmemmap when
we free a HugeTLB page to the buddy allocator. So I use
the prepare_vmemmap_page() to initialize the page (which
allocated from buddy allocator) and make it as the vmemmap
of the freed HugeTLB page.

Any suggestions to deal with this case?

I have a solution to address this. When the pages allocated
from the buddy as vmemmap pages,  we do not call
prepare_vmemmap_page().

When we free some vmemmap pages of a HugeTLB
page, if the PG_reserved of the vmemmap page is set,
we call free_vmemmap_page() to free it to buddy,
otherwise call free_page(). What is your opinion?

>
> And as I said, indicating "bootmem" as part of the function names might
> make it clearer that this is not for getting any vmemmap pages (esp.
> allocated when hotplugging memory).

Agree. I am doing that for the next version.

>
> --
> Thanks,
>
> David / dhildenb
>


-- 
Yours,
Muchun
