Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64882D11CC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 14:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgLGNXf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 08:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgLGNXe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 08:23:34 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EC8C0613D1
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Dec 2020 05:22:54 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id t7so9927768pfh.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Dec 2020 05:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0to9OB/whgv3qi9ufsQ+EKxpPLl37hR48TuYHnONOzs=;
        b=TthrRXTSO0r6XRrwG3mgwoHswcmwD0e5xJ0kpAYE36Qk4eW2ixqIQnJ2gD+ZhBuuV4
         As1vKJEOjlV9/bdfYHKaQGaFV1pr51FxZQVryIP6rEhe9GUskhHasg+09ZD0kAuiGwzz
         /5qQI6+2sBcah5HizF/kGLbyHPDn0bj2QyXxAsLqoN5ptTQf1sjZYEZKVRW3/dcYoYS2
         60VtDaQbpT/WnbLR8s4qMmvIkMtz81cMXkbBDn6CF71YXFN/BMq6dlgMzppe7UAPoJTM
         PdPvbIAOBcIFA1xlph+JEA+k94vtyOzo5aP9jWVjpGS3rnze/MtchkpOp6xgYhfLwsjv
         BdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0to9OB/whgv3qi9ufsQ+EKxpPLl37hR48TuYHnONOzs=;
        b=rPXt+k/Ah/oZVJkpfIUYRaeGilsDhh6QsPMhgkqPyCXVuWWESjLnEomt1EV/qzdffg
         WtsADz8jRK+M15pgtKHyb/MnVIrLduPwWdPT1ps/jswX5iltENQd447WWLWRTGqUbAtP
         SMdvLnt96ccek5JkELNITl8pbyI1kDhkS1gdZX/xyF51A2henDrYGbIleZmLsUQPVt4k
         5e6I9mAwc1c4N5aKu5+hLPPshMRqBDyJmf97Vs9G4K3FcocrnpVIY2hVqZsSEIYmiixg
         x0MWUUsy+s+YSLQYiG8wOdPnlhXz9OqbAcDps92Mu7gRPOZTCzgZ4/dTiVVz/eZcl1vk
         3l+Q==
X-Gm-Message-State: AOAM531qTTwpzStfYz4VmwSNwlibdWjjR1ebcd938jVH4MF6Zb4PopH4
        +Ooswe/2P/ZPDlIqkUziRT2NxDOW7Y2TuXViankAxQ==
X-Google-Smtp-Source: ABdhPJz1TKVgB8tDVH4DF5F75OY3VOXP48xOAa+s6tWfhnAlLp8FuLCfgyBvpB66zoppS+m0y+RKaMoCQpgm0vrtUqM=
X-Received: by 2002:a17:902:76c8:b029:d9:d6c3:357d with SMTP id
 j8-20020a17090276c8b02900d9d6c3357dmr16165559plt.34.1607347374167; Mon, 07
 Dec 2020 05:22:54 -0800 (PST)
MIME-Version: 1.0
References: <20201130151838.11208-1-songmuchun@bytedance.com>
 <20201130151838.11208-4-songmuchun@bytedance.com> <2ec1d360-c8c8-eb7b-2afe-b75ee61cfcea@redhat.com>
 <CAMZfGtVnw8aJWceLM1UerkAZzcjkObb-ZrCE_Jj6w3EUR=UN3Q@mail.gmail.com> <ebff035a-a32b-cd7b-f4c1-332ddc1ceaa4@redhat.com>
In-Reply-To: <ebff035a-a32b-cd7b-f4c1-332ddc1ceaa4@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 7 Dec 2020 21:22:17 +0800
Message-ID: <CAMZfGtVoRYedj9wF2_EbEpP2WJrBo5qzt0XtnWSEF+Bb8QZOXQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v7 03/15] mm/hugetlb: Introduce a new
 config HUGETLB_PAGE_FREE_VMEMMAP
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

On Mon, Dec 7, 2020 at 8:47 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 07.12.20 13:42, Muchun Song wrote:
> > On Mon, Dec 7, 2020 at 8:19 PM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 30.11.20 16:18, Muchun Song wrote:
> >>> The purpose of introducing HUGETLB_PAGE_FREE_VMEMMAP is to configure
> >>> whether to enable the feature of freeing unused vmemmap associated
> >>> with HugeTLB pages. And this is just for dependency check. Now only
> >>> support x86.
> >>
> >> x86 - i386 and x86-64? (I assume the latter only ;) )
> >
> > Yeah, you are right. Only the latter support SPARSEMEM_VMEMMAP.
> >
> >>
> >>>
> >>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >>> ---
> >>>  arch/x86/mm/init_64.c |  2 +-
> >>>  fs/Kconfig            | 14 ++++++++++++++
> >>>  2 files changed, 15 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> >>> index 0a45f062826e..0435bee2e172 100644
> >>> --- a/arch/x86/mm/init_64.c
> >>> +++ b/arch/x86/mm/init_64.c
> >>> @@ -1225,7 +1225,7 @@ static struct kcore_list kcore_vsyscall;
> >>>
> >>>  static void __init register_page_bootmem_info(void)
> >>>  {
> >>> -#ifdef CONFIG_NUMA
> >>> +#if defined(CONFIG_NUMA) || defined(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP)
> >>>       int i;
> >>>
> >>
> >> Why does this hunk belong into this patch? Looks like this should go
> >> into another patch.
> >
> > Of course can. But Mike suggests that it is better to use it when
> > introducing a new config. Because this config depends on
> > HAVE_BOOTMEM_INFO_NODE. And register_page_bootmem_info
> > is aimed to register bootmem info. So maybe it is reasonable from
> > this point of view. What is your opinion?
> >
>
> Ah, I see. Maybe mention in the patch description, because the
> "Introduce a new config HUGETLB_PAGE_FREE_VMEMMAP" part left me
> clueless. Stumbling over this change only left me rather clueless.

OK, I will improve the commit log. Thanks.

>
> >>
> >>>       for_each_online_node(i)
> >>> diff --git a/fs/Kconfig b/fs/Kconfig
> >>> index 976e8b9033c4..4961dd488444 100644
> >>> --- a/fs/Kconfig
> >>> +++ b/fs/Kconfig
> >>> @@ -245,6 +245,20 @@ config HUGETLBFS
> >>>  config HUGETLB_PAGE
> >>>       def_bool HUGETLBFS
> >>>
> >>> +config HUGETLB_PAGE_FREE_VMEMMAP
> >>> +     def_bool HUGETLB_PAGE
> >>> +     depends on X86
> >>> +     depends on SPARSEMEM_VMEMMAP
> >>> +     depends on HAVE_BOOTMEM_INFO_NODE
> >>> +     help
> >>> +       When using HUGETLB_PAGE_FREE_VMEMMAP, the system can save up some
> >>> +       memory from pre-allocated HugeTLB pages when they are not used.
> >>> +       6 pages per 2MB HugeTLB page and 4094 per 1GB HugeTLB page.
> >>
> >> Calculations only apply to 4k base pages, no?
> >
> > No, if the base page is not 4k, we also can free 6 pages.
> >
> > For example:
> >
> > If the base page size is 64k, the PMD huge page size is 512MB. We also
>
> Note that 2MB huge pages on arm64 with 64k base pages are possible as
> well. Also, I think powerpc always has 16MB huge pages, independent of
> base page sizes.

I see now. Now only support x86-64, you are right, I should point out the base
page size. When supporting more architectures in the future. We can update
the message here. :)

Thanks.

>
>
> --
> Thanks,
>
> David / dhildenb
>


-- 
Yours,
Muchun
