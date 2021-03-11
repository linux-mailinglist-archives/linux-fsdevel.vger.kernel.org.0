Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F09336B1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 05:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhCKE1T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 23:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhCKE1K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 23:27:10 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C06C061761
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Mar 2021 20:27:10 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so8711665pjv.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Mar 2021 20:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wdHJK3DnjapBMDB3J4nzxo9opMMpuJCwZjO8+x8sSxg=;
        b=AVptnHxhFF2lfdrbogOfvyXoS+iA20CjdW0Y3g3Im2CA4FDVur+gpc9RDSc4nV8vpn
         DJJIGc6sd1ZnOt8Sf45R27jnkdEnwUytHhendjXcAGSizUGRxZkm8dnkfY1ouBOlLkjH
         qjVoz1+1VCtqTyybwJiF+PCpTZrfH5mlgFw3xD4vqnk3MVVxtSMjeLHW8amWMPkzsSCj
         NgSJFKW0TdWpZG9lcIERXexLuv01GSqWVrmA5bHD8rB/WqvoucKuDEH1jyfei/KIPRp8
         SHwFwaL37o+276bp2p4UFrR6ft87rIemm+HhxvpUz9VzglEUjUMd/BvET7TfwvSGfBdF
         i/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wdHJK3DnjapBMDB3J4nzxo9opMMpuJCwZjO8+x8sSxg=;
        b=p21WXCirOAVpTj0svy/tHswva6Bk3qGI13Xi1qL9FgouH9IkrlHZMJxMEQNKGCdmyL
         pg4e1KAvC0YHjQzBNotYobgE7LfbTM1lvcCigIMEWLoj0dtGiBcf1bRTzXpw6eEXs+AO
         +kiNP1iCO41OxaObdr3RytIfbW8Z19q9roukTSSQFDRSkARwdNOAfbQc/ECzIogbKjE4
         yXVp/jJ9ACbr00OgbSELcKgdfcJGKqO9Vs7hRHoRUGfnPVOxS2IcOIy2v6oVlRGlFF8p
         prxpk7sVOWlqfg+js0Nn8fyz7fT+/RtrsFzhSkyhPYUhhiES6COcapX85Qtc8zomuMSy
         1NhQ==
X-Gm-Message-State: AOAM532wm/KvY1AZR79qEnA+HnHm/k7hHZ/LLvu9fVI/8H85IIgnhGNj
        nB/Nz891n1GThFVpzZ4XbIMSZwkKuJLSGQTw0OItow==
X-Google-Smtp-Source: ABdhPJyFtT1jcfBftxM1fBYo/GZ7Tgw6kfQp8Ydlw2Ya/FFTN4zt3q/TTwrXarOyu5SWEbQXYC+mJdl4VJaaDNvgL/g=
X-Received: by 2002:a17:90a:901:: with SMTP id n1mr7048144pjn.147.1615436830045;
 Wed, 10 Mar 2021 20:27:10 -0800 (PST)
MIME-Version: 1.0
References: <20210308102807.59745-1-songmuchun@bytedance.com>
 <20210308102807.59745-5-songmuchun@bytedance.com> <YEjji9oAwHuZaZEt@dhcp22.suse.cz>
In-Reply-To: <YEjji9oAwHuZaZEt@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 11 Mar 2021 12:26:32 +0800
Message-ID: <CAMZfGtVjLOF27VMVJ5fF8CDJRpZ0t7fWpmMHB9D-ipMK6b=POg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v18 4/9] mm: hugetlb: alloc the vmemmap
 pages associated with each HugeTLB page
To:     Michal Hocko <mhocko@suse.com>
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
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 10, 2021 at 11:19 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 08-03-21 18:28:02, Muchun Song wrote:
> [...]
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
>
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
> > +              * The refcount can possibly be increased by memory-failure or
> > +              * soft_offline handlers.
>
> This comment could be more helpful. I believe you want to say this
>                 /*
>                  * HWpoisoning code can increment the reference
>                  * count here. If there is a race then bail out
>                  * the holder of the additional reference count will
>                  * free up the page with put_page.

Right. I will reuse this. Thanks.

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
> [...]
> > @@ -1447,7 +1486,7 @@ void free_huge_page(struct page *page)
> >       /*
> >        * Defer freeing if in non-task context to avoid hugetlb_lock deadlock.
> >        */
> > -     if (!in_task()) {
> > +     if (in_atomic()) {
>
> As I've said elsewhere in_atomic doesn't work for CONFIG_PREEMPT_COUNT=n.
> We need this change for other reasons and so it would be better to pull
> it out into a separate patch which also makes HUGETLB depend on
> PREEMPT_COUNT.
>
> [...]
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
>
> This is quite ugly and confusing. update_and_free_page is careful to do
> the proper counters accounting and now you just override it partially.
> Why cannot we rely on update_and_free_page do the right thing?

Dissolving path is special here. Since update_and_free_page failed,
the number of surplus pages was incremented.  Surplus pages are
the number of pages greater than max_huge_pages.  Since we are
incrementing max_huge_pages, we should decrement (undo) the
addition to surplus_huge_pages and surplus_huge_pages_node[nid].


>
> --
> Michal Hocko
> SUSE Labs
