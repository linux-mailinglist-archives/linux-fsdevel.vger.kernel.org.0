Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99AF2B68D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 16:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgKQPf7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 10:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgKQPf7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:35:59 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3543AC0613CF
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2020 07:35:59 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id s2so10410436plr.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2020 07:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hptfVDhp17lNG0zTY32jtB2ORRoWKMoYJw0mGzRFDYU=;
        b=nUVsC2+9jIY0quFTo/Ulukf3VUuU1nHVOeXU3jB/pV+YhS7xXtH3IKlRvLx0ObzOWO
         DFe+fr+fz+KjwT+YERHo4TsJ045U5KRwFYrqEZMTpgVkgnS4iWksZ22Z5OEUFPxDKGMJ
         eLntD23iYtJBYmehuQcIvl5/VDMxMsP8LGOAU9xpC+D7nIzqpC7G81XgCsoXHYAuG9Mj
         RQ+oLGpJpCJeNThKY06vrzlCKBxi9S2nKqY8KayRRfjKM2sL2Hd/B17jOYFiP/d0hBKI
         SOAwSIxeumw6Fdu0RFV5flWlGtSmE4OL223//7brUSNLcCibmXJ41E+Sk7ZYDkc7oEQA
         ox0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hptfVDhp17lNG0zTY32jtB2ORRoWKMoYJw0mGzRFDYU=;
        b=QFrs8zeqmCFLd59j0PV4A5Y8nSeJMkzftJdPzZepv57NwFvNVRTEIPH0wesnV2ZN9d
         JxUvsA2R6cTMe+gfvjAN5l16q8yrk2M2NjuRY8PKp7TOk2GWy19S+Dj3+MhPTHhjcRAa
         MdfMcmeUf0xVeLs/A7q/UpOZaA9y8cGP/ZOyooT4wkcsX30ROdlAC1FkjJEf0DU94lHt
         yz+SmT/yWVHUgJHGirzooNhsAf26wqL3duxjvn/GgeOzepUtVQmYkbetkI83LKbz8md1
         Xfd8AWSXd5NWzjMKZ0KtGuiSWtSOE74kPDDtd8kn8Hfpm3D5SQVFaeOFyMg6SjZXZlQG
         HaTg==
X-Gm-Message-State: AOAM531PJuaP5PCnkx5i03TL5CjI/FFeWnybm0nutZ5Bsj+RYaRsEljJ
        mhKaAoWkcXSP5muAtn/k69PxMB7YxkhQ6UdbjO4ToA==
X-Google-Smtp-Source: ABdhPJwwhxoNvmlzPdAoSMicIpSAuvKb4FDamsz7ABcccu4oUhkRg96zse1OAo2A7X/R+bLoM37GT5VBN2K7h/qnIGg=
X-Received: by 2002:a17:902:c14b:b029:d6:ab18:108d with SMTP id
 11-20020a170902c14bb02900d6ab18108dmr93696plj.20.1605627358702; Tue, 17 Nov
 2020 07:35:58 -0800 (PST)
MIME-Version: 1.0
References: <20201108141113.65450-1-songmuchun@bytedance.com>
 <20201108141113.65450-4-songmuchun@bytedance.com> <20201109135215.GA4778@localhost.localdomain>
 <ef564084-ea73-d579-9251-ec0440df2b48@oracle.com> <20201110195025.GN17076@casper.infradead.org>
In-Reply-To: <20201110195025.GN17076@casper.infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 17 Nov 2020 23:35:19 +0800
Message-ID: <CAMZfGtU=NM3H6X3HzFHNPS8Eekk0RHQ3WqKVER23bK-aBD8CCQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 03/21] mm/hugetlb: Introduce a new
 config HUGETLB_PAGE_FREE_VMEMMAP
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
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
        Michal Hocko <mhocko@suse.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 11, 2020 at 3:50 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Nov 10, 2020 at 11:31:31AM -0800, Mike Kravetz wrote:
> > On 11/9/20 5:52 AM, Oscar Salvador wrote:
> > > On Sun, Nov 08, 2020 at 10:10:55PM +0800, Muchun Song wrote:
> > >> The purpose of introducing HUGETLB_PAGE_FREE_VMEMMAP is to configure
> > >> whether to enable the feature of freeing unused vmemmap associated
> > >> with HugeTLB pages. Now only support x86.
> > >>
> > >> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > >> ---
> > >>  arch/x86/mm/init_64.c |  2 +-
> > >>  fs/Kconfig            | 16 ++++++++++++++++
> > >>  mm/bootmem_info.c     |  3 +--
> > >>  3 files changed, 18 insertions(+), 3 deletions(-)
> > >>
> > >> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> > >> index 0a45f062826e..0435bee2e172 100644
> > >> --- a/arch/x86/mm/init_64.c
> > >> +++ b/arch/x86/mm/init_64.c
> > >> @@ -1225,7 +1225,7 @@ static struct kcore_list kcore_vsyscall;
> > >>
> > >>  static void __init register_page_bootmem_info(void)
> > >>  {
> > >> -#ifdef CONFIG_NUMA
> > >> +#if defined(CONFIG_NUMA) || defined(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP)
> > >>    int i;
> > >>
> > >>    for_each_online_node(i)
> > >> diff --git a/fs/Kconfig b/fs/Kconfig
> > >> index 976e8b9033c4..21b8d39a9715 100644
> > >> --- a/fs/Kconfig
> > >> +++ b/fs/Kconfig
> > >> @@ -245,6 +245,22 @@ config HUGETLBFS
> > >>  config HUGETLB_PAGE
> > >>    def_bool HUGETLBFS
> > >>
> > >> +config HUGETLB_PAGE_FREE_VMEMMAP
> > >> +  bool "Free unused vmemmap associated with HugeTLB pages"
> > >> +  default y
> > >> +  depends on X86
> > >> +  depends on HUGETLB_PAGE
> > >> +  depends on SPARSEMEM_VMEMMAP
> > >> +  depends on HAVE_BOOTMEM_INFO_NODE
> > >> +  help
> > >> +    There are many struct page structures associated with each HugeTLB
> > >> +    page. But we only use a few struct page structures. In this case,
> > >> +    it wastes some memory. It is better to free the unused struct page
> > >> +    structures to buddy system which can save some memory. For
> > >> +    architectures that support it, say Y here.
> > >> +
> > >> +    If unsure, say N.
> > >
> > > I am not sure the above is useful for someone who needs to decide
> > > whether he needs/wants to enable this or not.
> > > I think the above fits better in a Documentation part.
> > >
> > > I suck at this, but what about the following, or something along those
> > > lines?
> > >
> > > "
> > > When using SPARSEMEM_VMEMMAP, the system can save up some memory
> > > from pre-allocated HugeTLB pages when they are not used.
> > > 6 pages per 2MB HugeTLB page and 4095 per 1GB HugeTLB page.
> > > When the pages are going to be used or freed up, the vmemmap
> > > array representing that range needs to be remapped again and
> > > the pages we discarded earlier need to be rellocated again.
> > > Therefore, this is a trade-off between saving memory and
> > > increasing time in allocation/free path.
> > > "
> > >
> > > It would be also great to point out that this might be a
> > > trade-off between saving up memory and increasing the cost
> > > of certain operations on allocation/free path.
> > > That is why I mentioned it there.
> >
> > Yes, this is somewhat a trade-off.
> >
> > As a config option, this is something that would likely be decided by
> > distros.  I almost hate to suggest this, but is it something that an
> > end user would want to decide?  Is this something that perhaps should
> > be a boot/kernel command line option?
>
> I don't like config options.  I like boot options even less.  I don't
> know how to describe to an end-user whether they should select this
> or not.  Is there a way to make this not a tradeoff?  Or make the
> tradeoff so minimal as to be not worth describing?  (do we have numbers
> for the worst possible situation when enabling this option?)
>
> I haven't read through these patches in detail, so maybe we do this
> already, but when we free the pages to the buddy allocator, do we retain
> the third page to use for the PTEs (and free pages 3-7), or do we allocate
> a separate page for the PTES and free pages 2-7?

Sorry for missing this reply. It is a good idea. I will start an investigation
and implement this. Thanks Matthew.



-- 
Yours,
Muchun
