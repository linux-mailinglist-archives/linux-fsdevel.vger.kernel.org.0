Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A717A27F813
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 04:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbgJAC6P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Sep 2020 22:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730238AbgJAC6P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Sep 2020 22:58:15 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47625C0613D1
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2020 19:58:15 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x123so3041735pfc.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2020 19:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mwzDXzGzheFaLtfSgxu27esE2z5Zeui3HFQefTnFb8g=;
        b=zgOeDmpJuU6J+m/pXdHtw3CZdp3/+XRjOtE4QzOo5btYMi5CLEyMdYXP4kSuNLz0eJ
         TFwUKsIYwfUQUmtI+2qMLoVZYgC7w7vkFssPY0ClvBK10qm7/mmR+KOvvl74hI+k/bB/
         1Fn6MN/yuQdtO3KDGy+7pAlMNut7JupiZLTCM25c9gbmkHd3h5qXV1x4slS9nd7QdC72
         Dse4DbSqwOSlALxNQ+/L/J27u5yzgeCl4uE/08Z0Z8ByPYub7ETutOqST4m2+qsy60+j
         uD8cO44bxV1JAX4MTkAqxwFpazo/MUwoaL01/QQ/iBZy7NVW7x5qhZin16ywUexEwRsu
         CdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mwzDXzGzheFaLtfSgxu27esE2z5Zeui3HFQefTnFb8g=;
        b=SqLkcUXYIAYUPdH/w/eiOghBtuHAp9cZWW72THruBw7CB8LNTIMKudWGWu19y6kUcO
         AMs+hlkvep04gHMdNZS1HSRIKR6ohijOsZr0q4rkXnImQ8ccPgZC1XPsSc3lLDo3E6g3
         JdRTfP+LKtLh71tWt21y/grhsC8XaRSjNE9ICE7spC7pOFHVxDFOgD3ZJ67A9xEuoYZz
         5YOD1UqjLHbQRzUlE1SSDK72Z1HCxhOCRIW9tEsH9MaoEU0+7Sk5APHw856I8O7deLnX
         Ruu6bfRYActX3tVRV6bSuX34uG5fG0Oj+PuaR8uWHqm/FOkBBExzIOpbiv1HJ73vqENY
         5AWA==
X-Gm-Message-State: AOAM530QKAZ3q5Vbm8OK83Fei6RFx5F7bJ8fK77dn6TnR4MkYc15ssud
        4n2q8vO/TCyDyz686o5agoZLm0i2+kZohWrG7hebwg==
X-Google-Smtp-Source: ABdhPJw54fMhnUTblVABuAoszldUwSDkq8h8waLyxfnj4UMJiylKdptjrq1mXx8p4IpIh0PDd6kd4W1ynwcS/DGmTZU=
X-Received: by 2002:aa7:8287:0:b029:142:2501:39ec with SMTP id
 s7-20020aa782870000b0290142250139ecmr4965310pfm.59.1601521094544; Wed, 30 Sep
 2020 19:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200915125947.26204-1-songmuchun@bytedance.com>
 <20200915125947.26204-6-songmuchun@bytedance.com> <b2811679-cd90-4685-2284-64490e7dfb7e@oracle.com>
In-Reply-To: <b2811679-cd90-4685-2284-64490e7dfb7e@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 1 Oct 2020 10:57:38 +0800
Message-ID: <CAMZfGtV99X7TbkortsFaUYQC-Zvq53ggwB_PBzqUBFyQ2Hkvpg@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 05/24] mm/hugetlb: Introduce
 nr_free_vmemmap_pages in the struct hstate
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
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 1, 2020 at 6:41 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 9/15/20 5:59 AM, Muchun Song wrote:
> > If the size of hugetlb page is 2MB, we need 512 struct page structures
> > (8 pages) to be associated with it. As far as I know, we only use the
> > first 3 struct page structures and only read the compound_dtor members
>
> Actually, the first 4 pages can be used if CONFIG_CGROUP_HUGETLB.

Right, thanks.

> /*
>  * Minimum page order trackable by hugetlb cgroup.
>  * At least 4 pages are necessary for all the tracking information.
>  * The second tail page (hpage[2]) is the fault usage cgroup.
>  * The third tail page (hpage[3]) is the reservation usage cgroup.
>  */
> #define HUGETLB_CGROUP_MIN_ORDER        2
>
> However, this still easily fits within the first page of struct page
> structures.
>
> > of the remaining struct page structures. For tail page, the value of
> > compound_dtor is the same. So we can reuse first tail page. We map the
> > virtual addresses of the remaining 6 tail pages to the first tail page,
> > and then free these 6 pages. Therefore, we need to reserve at least 2
> > pages as vmemmap areas.
>
> I got confused the first time I read the above sentences.  Perhaps it
> should be more explicit with something like:
>
> For tail pages, the value of compound_dtor is the same. So we can reuse
> first page of tail page structs. We map the virtual addresses of the
> remaining 6 pages of tail page structs to the first tail page struct,
> and then free these 6 pages. Therefore, we need to reserve at least 2
> pages as vmemmap areas.

Sorry for my poor English. Thanks for your suggestions. I can apply this.

>
> It still does not sound great, but hopefully avoids some confusion.
> --
> Mike Kravetz
>
> > So we introduce a new nr_free_vmemmap_pages field in the hstate to
> > indicate how many vmemmap pages associated with a hugetlb page that we
> > can free to buddy system.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  include/linux/hugetlb.h |  3 +++
> >  mm/hugetlb.c            | 35 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 38 insertions(+)
> >
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index d5cc5f802dd4..eed3dd3bd626 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -492,6 +492,9 @@ struct hstate {
> >       unsigned int nr_huge_pages_node[MAX_NUMNODES];
> >       unsigned int free_huge_pages_node[MAX_NUMNODES];
> >       unsigned int surplus_huge_pages_node[MAX_NUMNODES];
> > +#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> > +     unsigned int nr_free_vmemmap_pages;
> > +#endif
> >  #ifdef CONFIG_CGROUP_HUGETLB
> >       /* cgroup control files */
> >       struct cftype cgroup_files_dfl[7];
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 81a41aa080a5..f1b2b733b49b 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1292,6 +1292,39 @@ static inline void destroy_compound_gigantic_page(struct page *page,
> >                                               unsigned int order) { }
> >  #endif
> >
> > +#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> > +#define RESERVE_VMEMMAP_NR   2U
> > +
> > +static inline unsigned int nr_free_vmemmap(struct hstate *h)
> > +{
> > +     return h->nr_free_vmemmap_pages;
> > +}
> > +
> > +static void __init hugetlb_vmemmap_init(struct hstate *h)
> > +{
> > +     unsigned int order = huge_page_order(h);
> > +     unsigned int vmemmap_pages;
> > +
> > +     vmemmap_pages = ((1 << order) * sizeof(struct page)) >> PAGE_SHIFT;
> > +     /*
> > +      * The head page and the first tail page not free to buddy system,
> > +      * the others page will map to the first tail page. So there are
> > +      * (@vmemmap_pages - RESERVE_VMEMMAP_NR) pages can be freed.
> > +      */
> > +     if (vmemmap_pages > RESERVE_VMEMMAP_NR)
> > +             h->nr_free_vmemmap_pages = vmemmap_pages - RESERVE_VMEMMAP_NR;
> > +     else
> > +             h->nr_free_vmemmap_pages = 0;
> > +
> > +     pr_info("HugeTLB: can free %d vmemmap pages for %s\n",
> > +             h->nr_free_vmemmap_pages, h->name);
> > +}
> > +#else
> > +static inline void hugetlb_vmemmap_init(struct hstate *h)
> > +{
> > +}
> > +#endif
> > +
> >  static void update_and_free_page(struct hstate *h, struct page *page)
> >  {
> >       int i;
> > @@ -3285,6 +3318,8 @@ void __init hugetlb_add_hstate(unsigned int order)
> >       snprintf(h->name, HSTATE_NAME_LEN, "hugepages-%lukB",
> >                                       huge_page_size(h)/1024);
> >
> > +     hugetlb_vmemmap_init(h);
> > +
> >       parsed_hstate = h;
> >  }
> >
> >



-- 
Yours,
Muchun
