Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84D52D10C4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 13:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgLGMnr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 07:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgLGMnq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:43:46 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF55CC0613D1
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Dec 2020 04:43:06 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id t7so9808271pfh.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Dec 2020 04:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A3Sz9EwcVm7/laPzVL4k5X0ZCii9fn78txSMeems5dA=;
        b=JH1WGkTnBnWyl6t3H5VvF0TMMz5/m82Bz7apzt7nnrxQ6aH4/fP93IcsAur6/PdbLE
         HkNrx5vI94hkp+cayxPCE/4C4LkA6r7wu5OI7yLoLUbIsfb4WeKrYpGZ21T6d8OY4+sb
         n1WmlSDul/HFojHtb+cYnMtW9O6zws4A+srhsGrH7W/ekiDGwDPDXVUA1C9vgL6I93QQ
         kjyfdZLpV3F2wck6ymYtgRgpnwrZvnt09+LuDaPRpFRzEBezmhyeSjHXFrDsP8mJHtst
         i6PktA4JsnKm0RCMil2nv5UdF97zXfOMCiBeAcqk4BPK+nLygAhjk6ySa4whcUBRezi7
         4vhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A3Sz9EwcVm7/laPzVL4k5X0ZCii9fn78txSMeems5dA=;
        b=Pu7kDTyZA4ipy266xSJj4hQKBuM/zaXl9vs5yNin2BXeEyyO90YPUY/DF45vZN2q6M
         IKeZuSec7llKEaSaXfVOu8ceVQN7aGfrzoWEQixuG43ehlTUZ84sc7glmkVIJqvVij9h
         9ljhcDVfr+X86ZBeDQDJ0dCjL+zTO6S2nWSvxFw2wkzfMkdoZ/mhCS//xAvL32i4dmnZ
         K0R5bZOosIbJjqysOjwrDqUhxbnHmKliy2VUtaYVVbG21OdcoIAngC2WqEvACUe+PKAF
         TIq2X61lHgm7a0xPPgeU7Abrj85onrtP3UDZ/mMm5a3vc26S+VKOzPjeXWjfYZjn5sDR
         kxEw==
X-Gm-Message-State: AOAM533eZCFKB1I6JijEzvFTskC5CQlJhAq0fjR/23iLKLN02JzpMDqZ
        cqE2vqk6rQm3ATnNRicykijqK1rs5+g+S1w3KanXrA==
X-Google-Smtp-Source: ABdhPJyYNVAE+tmn7JNGEOXOkwcqZO1ZbR7gnIDXJdT+G8tgPZRXcx7VJ7I/bEbnUunqR2+pYwcX4YYTWhsShd60dZ4=
X-Received: by 2002:a17:902:ed0d:b029:da:c83b:5f40 with SMTP id
 b13-20020a170902ed0db02900dac83b5f40mr16065185pld.20.1607344986256; Mon, 07
 Dec 2020 04:43:06 -0800 (PST)
MIME-Version: 1.0
References: <20201130151838.11208-1-songmuchun@bytedance.com>
 <20201130151838.11208-4-songmuchun@bytedance.com> <2ec1d360-c8c8-eb7b-2afe-b75ee61cfcea@redhat.com>
In-Reply-To: <2ec1d360-c8c8-eb7b-2afe-b75ee61cfcea@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 7 Dec 2020 20:42:29 +0800
Message-ID: <CAMZfGtVnw8aJWceLM1UerkAZzcjkObb-ZrCE_Jj6w3EUR=UN3Q@mail.gmail.com>
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

On Mon, Dec 7, 2020 at 8:19 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 30.11.20 16:18, Muchun Song wrote:
> > The purpose of introducing HUGETLB_PAGE_FREE_VMEMMAP is to configure
> > whether to enable the feature of freeing unused vmemmap associated
> > with HugeTLB pages. And this is just for dependency check. Now only
> > support x86.
>
> x86 - i386 and x86-64? (I assume the latter only ;) )

Yeah, you are right. Only the latter support SPARSEMEM_VMEMMAP.

>
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  arch/x86/mm/init_64.c |  2 +-
> >  fs/Kconfig            | 14 ++++++++++++++
> >  2 files changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> > index 0a45f062826e..0435bee2e172 100644
> > --- a/arch/x86/mm/init_64.c
> > +++ b/arch/x86/mm/init_64.c
> > @@ -1225,7 +1225,7 @@ static struct kcore_list kcore_vsyscall;
> >
> >  static void __init register_page_bootmem_info(void)
> >  {
> > -#ifdef CONFIG_NUMA
> > +#if defined(CONFIG_NUMA) || defined(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP)
> >       int i;
> >
>
> Why does this hunk belong into this patch? Looks like this should go
> into another patch.

Of course can. But Mike suggests that it is better to use it when
introducing a new config. Because this config depends on
HAVE_BOOTMEM_INFO_NODE. And register_page_bootmem_info
is aimed to register bootmem info. So maybe it is reasonable from
this point of view. What is your opinion?

>
> >       for_each_online_node(i)
> > diff --git a/fs/Kconfig b/fs/Kconfig
> > index 976e8b9033c4..4961dd488444 100644
> > --- a/fs/Kconfig
> > +++ b/fs/Kconfig
> > @@ -245,6 +245,20 @@ config HUGETLBFS
> >  config HUGETLB_PAGE
> >       def_bool HUGETLBFS
> >
> > +config HUGETLB_PAGE_FREE_VMEMMAP
> > +     def_bool HUGETLB_PAGE
> > +     depends on X86
> > +     depends on SPARSEMEM_VMEMMAP
> > +     depends on HAVE_BOOTMEM_INFO_NODE
> > +     help
> > +       When using HUGETLB_PAGE_FREE_VMEMMAP, the system can save up some
> > +       memory from pre-allocated HugeTLB pages when they are not used.
> > +       6 pages per 2MB HugeTLB page and 4094 per 1GB HugeTLB page.
>
> Calculations only apply to 4k base pages, no?

No, if the base page is not 4k, we also can free 6 pages.

For example:

If the base page size is 64k, the PMD huge page size is 512MB. We also
can free 6 pages(64k * 6) vmemmap. But maybe I should document this.

Thanks.

> (maybe generalize this a
> bit or mention 4k base pages - I'm pretty sure we'll see the "depends on
> X86" part fairly soon if this goes upstream)

Yeah, it can be easy to adapt to different architectures. :)

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
