Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCE236E3EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 06:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236876AbhD2EEQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 00:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbhD2EEN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 00:04:13 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CF9C06138C
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 21:03:24 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id b21so5543690plz.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 21:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BgKRdomt1eM7oewQ+UA6utKIEhGUPS/zeW1fYoQll3U=;
        b=kVDAcgAuPe+/NbI2rxd0BlbgqIAyC8fhu/ek3Yb9xSySx4dsD7WKs3lRupAG0cMXtY
         FP5RzPf/gAMMOsonUOM2GPIJz2rw4Gt/gqhqxYBslfv4SyDlxQtGLfYWxW0EGFJVY12Q
         LKLGG5slmnuXOwaGHK3p2AoghFFOVcGS1DnaD11za2Cb2aEcxCxEdKfaXntmqxxo5rUj
         6H7r+htb+3yudEcWzZ0QDPcPU2DtrF3RxIqoQkQsaY/Pace5nTvXJYb04EDGggbVpq01
         8khI4ZnXRxLV4Rmf0HyBgUouxWa8zVv1sWHXzTqex/SkwOt9eSxKcYJ0nnamnyCkk1lI
         gWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BgKRdomt1eM7oewQ+UA6utKIEhGUPS/zeW1fYoQll3U=;
        b=BQiWVq8XUs+KVWGnareY6+OzIPSCXP0f8VDfcPnTQdbLDUeCAv/U6jsKVvvPs1f/1W
         nfVTltzgPou3K61jt04wiGzoz7IfBwxreKDBtrKqFg5D6bXIX2NeGJfEsMf60Kd68Fzx
         B0ug8tq5eKd0ppVNMd8Nk9oj4eq3RP1D1W8wbJIDemFk4QnLwVh5H6w8pGMoxmWuzrzy
         KzAwkd3PfOj4KaNbcEDcmAtkD3KsmzrxciywZJ/Bi6Arqtlw2Il1HY7JRh0b8jeZv9Cz
         V7uAI/F6eNQ6D4dH0oYDTN/eRJ8vKO4SJrbNYL9buU5PCbkbXv7fhzvYW8hXYh2Yuq8j
         I6FA==
X-Gm-Message-State: AOAM533HMKRrQLwC82r6jEVTOhVLWddoLiyG3cX059o3S+czkwcaPble
        DJQ6i22qxE5g+nPrO78w+c1yVy8gC+zWOXnND86JeQ==
X-Google-Smtp-Source: ABdhPJyKOjVYbyArfKUcKkdzEn5LiMhEGJaQDb94gqC4bSYk8kPeWBkXPfUoPD/pQRBUMMKbMO3L8y2/dyBk0IUHW94=
X-Received: by 2002:a17:902:8308:b029:e9:d69:a2f with SMTP id
 bd8-20020a1709028308b02900e90d690a2fmr33676088plb.20.1619669004051; Wed, 28
 Apr 2021 21:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210425070752.17783-1-songmuchun@bytedance.com>
 <ee3903ae-7033-7608-c7ed-1f16f0359663@oracle.com> <CAMZfGtVbB6YwUMg2ECpdmniQ_vt_3AwdVAuu0GdUJfzWZgQpyg@mail.gmail.com>
 <98f191e8-b509-e541-9d9d-76029c74d241@oracle.com>
In-Reply-To: <98f191e8-b509-e541-9d9d-76029c74d241@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 29 Apr 2021 12:02:46 +0800
Message-ID: <CAMZfGtUqE6OzWwK6o5h0j6qHPotfvbKpGbzYpSPLLhYH2nJiAw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v21 0/9] Free some vmemmap pages of HugeTLB page
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

On Thu, Apr 29, 2021 at 10:32 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 4/28/21 5:26 AM, Muchun Song wrote:
> > On Wed, Apr 28, 2021 at 7:47 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >>
> >> Thanks!  I will take a look at the modifications soon.
> >>
> >> I applied the patches to Andrew's mmotm-2021-04-21-23-03, ran some tests and
> >> got the following warning.  We may need to special case that call to
> >> __prep_new_huge_page/free_huge_page_vmemmap from alloc_and_dissolve_huge_page
> >> as it is holding hugetlb lock with IRQs disabled.
> >
> > Good catch. Thanks Mike. I will fix it in the next version. How about this:
> >
> > @@ -1618,7 +1617,8 @@ static void __prep_new_huge_page(struct hstate
> > *h, struct page *page)
> >
> >  static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
> >  {
> > +       free_huge_page_vmemmap(h, page);
> >         __prep_new_huge_page(page);
> >         spin_lock_irq(&hugetlb_lock);
> >         __prep_account_new_huge_page(h, nid);
> >         spin_unlock_irq(&hugetlb_lock);
> > @@ -2429,6 +2429,7 @@ static int alloc_and_dissolve_huge_page(struct
> > hstate *h, struct page *old_page,
> >         if (!new_page)
> >                 return -ENOMEM;
> >
> > +       free_huge_page_vmemmap(h, new_page);
> >  retry:
> >         spin_lock_irq(&hugetlb_lock);
> >         if (!PageHuge(old_page)) {
> > @@ -2489,7 +2490,7 @@ static int alloc_and_dissolve_huge_page(struct
> > hstate *h, struct page *old_page,
> >
> >  free_new:
> >         spin_unlock_irq(&hugetlb_lock);
> > -       __free_pages(new_page, huge_page_order(h));
> > +       update_and_free_page(h, new_page, false);
> >
> >         return ret;
> >  }
> >
> >
>
> Another option would be to leave the prep* routines as is and only
> modify alloc_and_dissolve_huge_page as follows:

OK. LGTM. I will use this. Thanks Mike.

>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 9c617c19fc18..f8e5013a6b46 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2420,14 +2420,15 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>
>         /*
>          * Before dissolving the page, we need to allocate a new one for the
> -        * pool to remain stable. Using alloc_buddy_huge_page() allows us to
> -        * not having to deal with prep_new_huge_page() and avoids dealing of any
> -        * counters. This simplifies and let us do the whole thing under the
> -        * lock.
> +        * pool to remain stable.  Here, we allocate the page and 'prep' it
> +        * by doing everything but actually updating counters and adding to
> +        * the pool.  This simplifies and let us do most of the processing
> +        * under the lock.
>          */
>         new_page = alloc_buddy_huge_page(h, gfp_mask, nid, NULL, NULL);
>         if (!new_page)
>                 return -ENOMEM;
> +       __prep_new_huge_page(h, new_page);
>
>  retry:
>         spin_lock_irq(&hugetlb_lock);
> @@ -2473,7 +2474,6 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>                  * Reference count trick is needed because allocator gives us
>                  * referenced page but the pool requires pages with 0 refcount.
>                  */
> -               __prep_new_huge_page(h, new_page);
>                 __prep_account_new_huge_page(h, nid);
>                 page_ref_dec(new_page);
>                 enqueue_huge_page(h, new_page);
> @@ -2489,7 +2489,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>
>  free_new:
>         spin_unlock_irq(&hugetlb_lock);
> -       __free_pages(new_page, huge_page_order(h));
> +       update_and_free_page(h, old_page, false);
>
>         return ret;
>  }
>
> --
> Mike Kravetz
