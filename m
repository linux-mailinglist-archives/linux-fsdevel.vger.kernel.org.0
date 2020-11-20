Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9E42BA9A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 12:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgKTL5J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 06:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgKTL5I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 06:57:08 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D585AC0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2020 03:57:08 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id f18so7094420pgi.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2020 03:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0HATfyO4gy8O0ZQ5jHHmrKLiQEgDtfHpD05h/4ZZGaU=;
        b=zogu4RFWxSnWMmjlhO9tUVIrrKIEj4I7+aL54B7p9OPIs7mCTMKOZwK40HxeC+lf2v
         dwN5Q45vjBrAU1/Vw9Xbg3OZVBOHAckhT5wBgjXGy4/Pokx2i+hu7DHSGN9MKASyva1d
         FAga+WRJNW+vB9Blp7uYa698KvQ0hoDt3o7QWCFAGCAHLj/7my4NHkPbNbvdRzTWWDqX
         Ncs4VLgrgx21N2ZKT7kT/leyiSc+F44wkB1ECS3oiDwTe35zhiAiOwsF1rdIu/dQb2nx
         M+3VsB40Dcie/hgrZCj74fZxcmP5GFuBzP2IY3z+IxZB8G30DWyBMRUMDBufUrYUzeK3
         03FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0HATfyO4gy8O0ZQ5jHHmrKLiQEgDtfHpD05h/4ZZGaU=;
        b=lOiHS0E1YY51nJ+ffra7zhlDvgxFPgR6yjCRSZsYr1YbkS81nA0Dh801q7ngpPeVcV
         zbqIs5bH8bQcgFNmXQi1SZqr7xLys8AHkH3ZHzUZnu8iH395fXPaiIaMme3du6fvX1E8
         GH52k8Oikjp/ACKB0wCg4KU9WmRI6LLkU8nLfD7vxPqqdyr4gzTpnrbAcoE5Yuoj3zzG
         Rka8YrsiYuLTHnzTqqGmFvRxktreE06YkkSs6KFn7rjsVYwbXms6w8A7albGdiKQb0eE
         tTWnHbukv7FtpWIgOb/oNVocusTfIXn2jEIjIwijTgK5UAW1KQ9hx5gIKZ432g5x9GdC
         V30w==
X-Gm-Message-State: AOAM533ggpU4iGgUYh/h6Xb2opZ7qK+O9hrGXNpSkTZsVKbwQcUnkLtE
        ASh994IXwVY/mryRkJwfOKAVjmAjc6WBhPbzRYT8lA==
X-Google-Smtp-Source: ABdhPJysLesbqaepefZ43Fir9e7ymcgRNMVnacBD4NCUo1vSVUIHvrqwftTyZFDYpyODPgqNoFIyRqu2S2WC+mjZgq4=
X-Received: by 2002:a63:594a:: with SMTP id j10mr16411186pgm.341.1605873428424;
 Fri, 20 Nov 2020 03:57:08 -0800 (PST)
MIME-Version: 1.0
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120064325.34492-12-songmuchun@bytedance.com> <20201120081123.GC3200@dhcp22.suse.cz>
 <CAMZfGtWVxCPpL7=0dfHa7_qtakmGDMLP0twWoyM=gVou=HRmEg@mail.gmail.com>
 <20201120092826.GL3200@dhcp22.suse.cz> <CAMZfGtVPNdykd=E2bEje0GCdZT9ksLy2BdaRZ41eRDbGQp0_rg@mail.gmail.com>
 <20201120111033.GN3200@dhcp22.suse.cz>
In-Reply-To: <20201120111033.GN3200@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 20 Nov 2020 19:56:25 +0800
Message-ID: <CAMZfGtWY9+8BUafREoYSi9ATL6tO6F7LGANz-1KXXueoiFAO_g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 11/21] mm/hugetlb: Allocate the vmemmap
 pages associated with each hugetlb page
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

On Fri, Nov 20, 2020 at 7:10 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 20-11-20 17:37:09, Muchun Song wrote:
> > On Fri, Nov 20, 2020 at 5:28 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Fri 20-11-20 16:51:59, Muchun Song wrote:
> > > > On Fri, Nov 20, 2020 at 4:11 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Fri 20-11-20 14:43:15, Muchun Song wrote:
> > > > > [...]
> > > > > > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > > > > > index eda7e3a0b67c..361c4174e222 100644
> > > > > > --- a/mm/hugetlb_vmemmap.c
> > > > > > +++ b/mm/hugetlb_vmemmap.c
> > > > > > @@ -117,6 +117,8 @@
> > > > > >  #define RESERVE_VMEMMAP_NR           2U
> > > > > >  #define RESERVE_VMEMMAP_SIZE         (RESERVE_VMEMMAP_NR << PAGE_SHIFT)
> > > > > >  #define TAIL_PAGE_REUSE                      -1
> > > > > > +#define GFP_VMEMMAP_PAGE             \
> > > > > > +     (GFP_KERNEL | __GFP_NOFAIL | __GFP_MEMALLOC)
> > > > >
> > > > > This is really dangerous! __GFP_MEMALLOC would allow a complete memory
> > > > > depletion. I am not even sure triggering the OOM killer is a reasonable
> > > > > behavior. It is just unexpected that shrinking a hugetlb pool can have
> > > > > destructive side effects. I believe it would be more reasonable to
> > > > > simply refuse to shrink the pool if we cannot free those pages up. This
> > > > > sucks as well but it isn't destructive at least.
> > > >
> > > > I find the instructions of __GFP_MEMALLOC from the kernel doc.
> > > >
> > > > %__GFP_MEMALLOC allows access to all memory. This should only be used when
> > > > the caller guarantees the allocation will allow more memory to be freed
> > > > very shortly.
> > > >
> > > > Our situation is in line with the description above. We will free a HugeTLB page
> > > > to the buddy allocator which is much larger than that we allocated shortly.
> > >
> > > Yes that is a part of the description. But read it in its full entirety.
> > >  * %__GFP_MEMALLOC allows access to all memory. This should only be used when
> > >  * the caller guarantees the allocation will allow more memory to be freed
> > >  * very shortly e.g. process exiting or swapping. Users either should
> > >  * be the MM or co-ordinating closely with the VM (e.g. swap over NFS).
> > >  * Users of this flag have to be extremely careful to not deplete the reserve
> > >  * completely and implement a throttling mechanism which controls the
> > >  * consumption of the reserve based on the amount of freed memory.
> > >  * Usage of a pre-allocated pool (e.g. mempool) should be always considered
> > >  * before using this flag.
> > >
> > > GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_HIGH
> >
> > We want to free the HugeTLB page to the buddy allocator, but before that,
> > we need to allocate some pages as vmemmap pages, so here we cannot
> > handle allocation failures.
>
> Why cannot you simply refuse to shrink the pool size?
>
> > I think that we should replace the
> > __GFP_RETRY_MAYFAIL to __GFP_NOFAIL.
> >
> > GFP_KERNEL | __GFP_NOFAIL | __GFP_HIGH
> >
> > This meets our needs here. Thanks.
>
> Please read again my concern about the disruptive behavior or explain
> why it is desirable.

OK, I will come up with a solution which does not use the
__GFP_NOFAIL. Thanks.

>
> --
> Michal Hocko
> SUSE Labs



-- 
Yours,
Muchun
