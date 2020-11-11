Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 656E32AE70B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 04:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgKKD2w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 22:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgKKD2w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 22:28:52 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC19C0613D3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2020 19:28:52 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id f18so546313pgi.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2020 19:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r3BEc/AcxRK2fgyz5arC0mp2ZjamSggoiwDFPHzDeFM=;
        b=L3KGqh9FA7CRMvMuluDNn1yrWpbYh9l/nhP2/JazcH9HggGmW4y80NLxhjP0T9GKkq
         xkMfnenxGtsg2F20N8LjeD9GIk8DqqxK4lh2DuEqcedd641cfWIb6CvMHrWQZToxc2hF
         ZaboK3GoLW4oPPSdWetfJ0Xs4ZfcCpHAyJSHdEq83hsrp6idro+N/J9Kl10Ue9wXRNWc
         WKoEmW2t18MuoeJ8AcbbQdo9qpHrA0xJ9wJysGo4MPQKeV5njYZXbbzEiQIPiKJRb4sv
         IeEpp7KW3yDsb4Pgi+Pq19hFxrukqNFbb3Cbn571RJXDmmb0PhG/i1FUGsioMaI+IAjP
         17mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r3BEc/AcxRK2fgyz5arC0mp2ZjamSggoiwDFPHzDeFM=;
        b=l8qKz8qqGMV6ez05JJF0xg7hIw9eVVNnknLgditpkwzYy666G+o7q2UJXyMPjwqRn9
         sLLsP69qxwQkmJqqDRWPz39VkZdaCiCqCA8+wmgEWg32iZuTV/Xr+JR7gF/CkPl8ol9A
         /9oMFCd1k6gcdyjXbl1vx/n5QKQpeKpKcM6h+x+IiiJYMLykL7d4t8e75ilESkoLtPgW
         59dvqlBL/sB84RzsT1TZh1sEG23fFnt+dTNWGaX88jEO1CMXK8G1RMZzMNO6DTNpvc6T
         AgKDr9peOztbQ2NnN8DoJgq2vj+XUaSkzOLF1ODm3EKbVLLHAKV9eVOfsWFq/iKObzxt
         kZYA==
X-Gm-Message-State: AOAM533CTMuk3beVnB1rHFyLMe2a6G4nyDVbc2YTdBvZRNDWYxJx7nH1
        YidOMF/l1jQGA+TKw8qz02q5kqgZE1BrNi8VINC0kA==
X-Google-Smtp-Source: ABdhPJyge7KPG4O/LDfk3XbDVrfOMI46A1+WfWZbvMnhVcpAif+MMWM7ip2u+Ce+OLWyjnbFzey3qwpStDLHcJAUAkY=
X-Received: by 2002:a62:e116:0:b029:18b:d325:153f with SMTP id
 q22-20020a62e1160000b029018bd325153fmr15902234pfh.2.1605065331686; Tue, 10
 Nov 2020 19:28:51 -0800 (PST)
MIME-Version: 1.0
References: <20201108141113.65450-1-songmuchun@bytedance.com>
 <20201108141113.65450-4-songmuchun@bytedance.com> <20201109135215.GA4778@localhost.localdomain>
 <ef564084-ea73-d579-9251-ec0440df2b48@oracle.com>
In-Reply-To: <ef564084-ea73-d579-9251-ec0440df2b48@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 11 Nov 2020 11:28:15 +0800
Message-ID: <CAMZfGtUx-Lpcbv4saLBH7p+pgwVNSJpZnFtmp6nuL1CiNNG+gg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 03/21] mm/hugetlb: Introduce a new
 config HUGETLB_PAGE_FREE_VMEMMAP
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

On Wed, Nov 11, 2020 at 3:31 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 11/9/20 5:52 AM, Oscar Salvador wrote:
> > On Sun, Nov 08, 2020 at 10:10:55PM +0800, Muchun Song wrote:
> >> The purpose of introducing HUGETLB_PAGE_FREE_VMEMMAP is to configure
> >> whether to enable the feature of freeing unused vmemmap associated
> >> with HugeTLB pages. Now only support x86.
> >>
> >> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >> ---
> >>  arch/x86/mm/init_64.c |  2 +-
> >>  fs/Kconfig            | 16 ++++++++++++++++
> >>  mm/bootmem_info.c     |  3 +--
> >>  3 files changed, 18 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> >> index 0a45f062826e..0435bee2e172 100644
> >> --- a/arch/x86/mm/init_64.c
> >> +++ b/arch/x86/mm/init_64.c
> >> @@ -1225,7 +1225,7 @@ static struct kcore_list kcore_vsyscall;
> >>
> >>  static void __init register_page_bootmem_info(void)
> >>  {
> >> -#ifdef CONFIG_NUMA
> >> +#if defined(CONFIG_NUMA) || defined(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP)
> >>      int i;
> >>
> >>      for_each_online_node(i)
> >> diff --git a/fs/Kconfig b/fs/Kconfig
> >> index 976e8b9033c4..21b8d39a9715 100644
> >> --- a/fs/Kconfig
> >> +++ b/fs/Kconfig
> >> @@ -245,6 +245,22 @@ config HUGETLBFS
> >>  config HUGETLB_PAGE
> >>      def_bool HUGETLBFS
> >>
> >> +config HUGETLB_PAGE_FREE_VMEMMAP
> >> +    bool "Free unused vmemmap associated with HugeTLB pages"
> >> +    default y
> >> +    depends on X86
> >> +    depends on HUGETLB_PAGE
> >> +    depends on SPARSEMEM_VMEMMAP
> >> +    depends on HAVE_BOOTMEM_INFO_NODE
> >> +    help
> >> +      There are many struct page structures associated with each HugeTLB
> >> +      page. But we only use a few struct page structures. In this case,
> >> +      it wastes some memory. It is better to free the unused struct page
> >> +      structures to buddy system which can save some memory. For
> >> +      architectures that support it, say Y here.
> >> +
> >> +      If unsure, say N.
> >
> > I am not sure the above is useful for someone who needs to decide
> > whether he needs/wants to enable this or not.
> > I think the above fits better in a Documentation part.
> >
> > I suck at this, but what about the following, or something along those
> > lines?
> >
> > "
> > When using SPARSEMEM_VMEMMAP, the system can save up some memory
> > from pre-allocated HugeTLB pages when they are not used.
> > 6 pages per 2MB HugeTLB page and 4095 per 1GB HugeTLB page.
> > When the pages are going to be used or freed up, the vmemmap
> > array representing that range needs to be remapped again and
> > the pages we discarded earlier need to be rellocated again.
> > Therefore, this is a trade-off between saving memory and
> > increasing time in allocation/free path.
> > "
> >
> > It would be also great to point out that this might be a
> > trade-off between saving up memory and increasing the cost
> > of certain operations on allocation/free path.
> > That is why I mentioned it there.
>
> Yes, this is somewhat a trade-off.
>
> As a config option, this is something that would likely be decided by
> distros.  I almost hate to suggest this, but is it something that an
> end user would want to decide?  Is this something that perhaps should
> be a boot/kernel command line option?

Yeah, it already has a boot/kernel command line option named
"hugetlb_free_vmemmap". We can refer to

  [PATCH v3 18/21] mm/hugetlb: Add a kernel parameter hugetlb_free_vmemmap

Thanks :)


>
> --
> Mike Kravetz



--
Yours,
Muchun
