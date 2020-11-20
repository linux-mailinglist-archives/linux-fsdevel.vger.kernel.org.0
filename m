Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58B52BA4BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 09:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgKTIgA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 03:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgKTIf7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 03:35:59 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBD4C0617A7
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2020 00:35:59 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id q5so7182386pfk.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2020 00:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v8+mXQPphnEalmROxh/i56omdGOqj/p5Ii14lIEaDXc=;
        b=y56aEgz7bs4GaAyDTrLBYqViMqxej7ZiXuaI4A7Y82jFPMu4C0G1GOGfoK39NqZu0J
         44J4qDdpeFais5XnAu7FsZJcejS94IyDqJ82BLgq3qHL5UQCXYnAx+Skwu70mXMBR8wa
         oLiZkB+NrihfcRK+/wCV6LpooBJm2feHkUJ5YPbEYncR4snTvn2gBbM7UDBjZJpKH4bZ
         WN4qbfLNOhGOpPwOJWEmAeC2caSUnlYcgrAdd/g89rcxcZWVCKAyo6Hl/SkOLm3xgqNh
         qgrNz1ZOOcNINEaj3vKcDr7HTjoSfbxrrexuEzTO4NwxqB72mRVdmdjJyyAGF1Ri7rBd
         yqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v8+mXQPphnEalmROxh/i56omdGOqj/p5Ii14lIEaDXc=;
        b=gb8zUdUzbOi6E7uz3p0mM0rcTsmKGvYnJpTBEyxYJ/fK9/ySQfqAXaLShfSscfJhNq
         RBNTdoH9hwVGD0YcJypP0tCPw/sFjpCC1gXtKGaKw3mPxcyAa7g4e3+FvMkxHICcxaEE
         cU+LpBXAHcJ8NNu5FYFtUwiFHIE725i9P4zmTrP3IneeS7rIhRV6+tSzNrDlXIyaV/iC
         BdxpVRge8dAcSjEWXgF8kWgGWSCMDuF06Lie9sALJs6hhFeFPSzDpNlIG+FYQNOgDff3
         1JX25YTwWFKARR2/cGglurOw5dj/TP1Pw8J6G3wLNcujYEKw5XEUbqy6mN20BgnxnvnG
         8lWw==
X-Gm-Message-State: AOAM533EuhxmxYMPf/yN7p0c5DyQYqGFaR23cutWsJ4TLlADaTlFVDMZ
        vibqL9QH4zaB6NAFbOQJiyf8pL56iw8kj1intINrSA==
X-Google-Smtp-Source: ABdhPJzY472bsCYM6XW2O521h+JXC9KpHBxbY6cz52QULFVtH4t2TDj/9BfSmdxmuvEjiO7bZe0KIe0KIZyLWMDKe0I=
X-Received: by 2002:a17:90b:88b:: with SMTP id bj11mr9288264pjb.229.1605861358891;
 Fri, 20 Nov 2020 00:35:58 -0800 (PST)
MIME-Version: 1.0
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120064325.34492-4-songmuchun@bytedance.com> <20201120074950.GB3200@dhcp22.suse.cz>
In-Reply-To: <20201120074950.GB3200@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 20 Nov 2020 16:35:16 +0800
Message-ID: <CAMZfGtWuCuuR+N8h-509BbDL8CN+s_djsodPN0Wb1+YHbF9PHw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 03/21] mm/hugetlb: Introduce a new
 config HUGETLB_PAGE_FREE_VMEMMAP
To:     Michal Hocko <mhocko@suse.com>
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
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 20, 2020 at 3:49 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 20-11-20 14:43:07, Muchun Song wrote:
> > The purpose of introducing HUGETLB_PAGE_FREE_VMEMMAP is to configure
> > whether to enable the feature of freeing unused vmemmap associated
> > with HugeTLB pages. Now only support x86.
>
> Why is the config option necessary? Are code savings with the feature
> disabled really worth it? I can see that your later patch adds a kernel
> command line option. I believe that is a more reasonable way to control
> the feature. I would argue that this should be an opt-in rather than
> opt-out though. Think of users of pre-built (e.g. distribution kernels)
> who might be interested in the feature. Yet you cannot assume that such
> a kernel would enable the feature with its overhead to all hugetlb
> users.

Now the config option may be necessary. Because the feature only
supports x86. While other architectures need some code to support
this feature. In the future, we will implement it on other architectures.
Then, we can remove this option.

Also, this config option is not optional. It is default by the
CONFIG_HUGETLB_PAGE. If the kernel selects the
CONFIG_HUGETLB_PAGE, the CONFIG_ HUGETLB_PAGE_FREE_VMEMMAP
is also selected. The user only can disable this feature by
boot command line :).

Thanks.

>
> That being said, unless there are huge advantages to introduce a
> config option I would rather not add it because our config space is huge
> already and the more we add the more future code maintainance that will
> add. If you want the config just for dependency checks then fine by me.

Yeah, it is only for dependency checks :)

>
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
> > +
> > +       When the pages are going to be used or freed up, the vmemmap array
> > +       representing that range needs to be remapped again and the pages
> > +       we discarded earlier need to be rellocated again.
> > +
> >  config MEMFD_CREATE
> >       def_bool TMPFS || HUGETLBFS
> >
> > --
> > 2.11.0
>
> --
> Michal Hocko
> SUSE Labs



--
Yours,
Muchun
