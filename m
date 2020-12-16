Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9B12DB9D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 04:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbgLPDyH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 22:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgLPDyH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 22:54:07 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2007AC061793
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 19:53:27 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id c12so16193282pgm.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 19:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=au0l4ODmUzLyBniSivZ0fFaGBE1KkNQntC4U8UGGvjw=;
        b=HitdVFCAOtsQCu8zvH8qmYCPYzX3PeWE6fktkqoxytKqigp9RNcBtKks+keo8Yodhe
         7n2W+zAZoxAU4Tv95vdUIkIlQdX026OWKMsoJ3ppouGncBTXSDspdPZOCIrOikVZDyU8
         4jRAVH5o5rPy3FMNBjZjWHRGTxZN/ZhutryDrs7J7hZvQTTx+0V1XZ/YuUyYYG6J5l3Z
         sBGcqxKFdhI1BPQlkPIA3xbuPw8Ei4eAmwXNRW3dpQrUt/nhnSQVAG49+VgbfX5v0xQp
         ehKe8JCYXykuOj/3p2DI8pyPmKR7kJdfjaGrJ+tUNMC+pSiHLi+oNmry3uWmDnXCrC9X
         vjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=au0l4ODmUzLyBniSivZ0fFaGBE1KkNQntC4U8UGGvjw=;
        b=FR64VSA/O9FsiBhQMw1iADmk1/mzAGk4pHn7dXbUAbQ9DpDLCJ+s81RbYqGPO0ecEO
         VX6QS9OhoancE9GGhhLecD4LwyXhoN1ffPuLp4olAPGkyxX4Q7W6l9L61vLYABdJMfKF
         BWxQnHHKEmg9skw7CVy5YyhC0hoTMVhMNXPSqfEQc0KDs0clO+fY+ZAd0GAeY+Qm38Yk
         AZYFfwd6qQyi4tuOTEygcFTjxmyoukLB+JptHcP37dVBfKR1o3FeC2hO3BJD9J/k914G
         3GqB4dIOnuFp47PpadJd86ub12aDhAJeYWlbOfoDqdRgo8g+I2AUGuDSRrcZJ/cW6txZ
         VbLA==
X-Gm-Message-State: AOAM533MqoNmOM512zVW2ONG58IdyqzeJYF3rV6Hoi5w5nK2BU8d+vMi
        o2+OXdQ31rT6nJdiahGh1cXQx1B1SOXjSUp7Y3704rHIjuh3rA==
X-Google-Smtp-Source: ABdhPJxhomQrUSLQh8uMb9UuwA9CmbPbyO9SWshT6Q/hiYWWgqBvJj56FQvMJ2tmDKyx4NK5BlBrXhKdVumTZXHNy/0=
X-Received: by 2002:aa7:979d:0:b029:1a4:3b76:a559 with SMTP id
 o29-20020aa7979d0000b02901a43b76a559mr15688095pfp.49.1608090806411; Tue, 15
 Dec 2020 19:53:26 -0800 (PST)
MIME-Version: 1.0
References: <20201213154534.54826-1-songmuchun@bytedance.com>
 <20201213154534.54826-3-songmuchun@bytedance.com> <7cfe44aa-3753-82d9-6630-194f1532e186@oracle.com>
 <e9abb112-7654-6157-6782-9ccb4a9cd87e@oracle.com>
In-Reply-To: <e9abb112-7654-6157-6782-9ccb4a9cd87e@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 16 Dec 2020 11:52:50 +0800
Message-ID: <CAMZfGtU9c3DmZzrGxh2oo-GMjamP5VFLerZf_FCCx7A8KO6NQA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v9 02/11] mm/hugetlb: Introduce a new
 config HUGETLB_PAGE_FREE_VMEMMAP
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
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
        David Hildenbrand <david@redhat.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 16, 2020 at 11:45 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 12/15/20 5:03 PM, Mike Kravetz wrote:
> > On 12/13/20 7:45 AM, Muchun Song wrote:
> >> diff --git a/fs/Kconfig b/fs/Kconfig
> >> index 976e8b9033c4..4c3a9c614983 100644
> >> --- a/fs/Kconfig
> >> +++ b/fs/Kconfig
> >> @@ -245,6 +245,21 @@ config HUGETLBFS
> >>  config HUGETLB_PAGE
> >>      def_bool HUGETLBFS
> >>
> >> +config HUGETLB_PAGE_FREE_VMEMMAP
> >> +    def_bool HUGETLB_PAGE
> >> +    depends on X86_64
> >> +    depends on SPARSEMEM_VMEMMAP
> >> +    depends on HAVE_BOOTMEM_INFO_NODE
> >> +    help
> >> +      When using HUGETLB_PAGE_FREE_VMEMMAP, the system can save up some
> >> +      memory from pre-allocated HugeTLB pages when they are not used.
> >> +      6 pages per HugeTLB page of the pmd level mapping and (PAGE_SIZE - 2)
> >> +      pages per HugeTLB page of the pud level mapping.
> >> +
> >> +      When the pages are going to be used or freed up, the vmemmap array
> >> +      representing that range needs to be remapped again and the pages
> >> +      we discarded earlier need to be rellocated again.
> >
> > I see the previous discussion with David about wording here.  How about
> > leaving the functionality description general, and provide a specific
> > example for x86_64?  As mentioned we can always update when new arch support
> > is added.  Suggested text?
> >
> >       The option HUGETLB_PAGE_FREE_VMEMMAP allows for the freeing of
> >       some vmemmap pages associated with pre-allocated HugeTLB pages.
> >       For example, on X86_64 6 vmemmap pages of size 4KB each can be
> >       saved for each 2MB HugeTLB page.  4094 vmemmap pages of size 4KB
> >       each can be saved for each 1GB HugeTLB page.
> >
> >       When a HugeTLB page is allocated or freed, the vmemmap array
> >       representing the range associated with the page will need to be
> >       remapped.  When a page is allocated, vmemmap pages are freed
> >       after remapping.  When a page is freed, previously discarded
> >       vmemmap pages must be allocated before before remapping.
>
> Sorry, I am slowly coming up to speed with discussions when I was away.
>
> It appears vmemmap is not being mapped with huge pages if the boot option
> hugetlb_free_vmemmap is on.   Is that correct?

Right.

>
> If that is correct, we should document the trade off of increased page
> table pages needed to map vmemmap vs the savings from freeing struct page
> pages.  If a user/sysadmin only uses a small number of hugetlb pages (as
> a percentage of system memory) they could end up using more memory with
> hugetlb_free_vmemmap on as opposed to off.  Perhaps, it should be part of
> the documentation for hugetlb_free_vmemmap?  If this is true, and people

Right, it is better to document it around hugetlb_free_vmemmap.
This should be a part of pathe #8. Thanks.


> think this should be documented, I can try to come up with something.
>
> --
> Mike Kravetz



-- 
Yours,
Muchun
