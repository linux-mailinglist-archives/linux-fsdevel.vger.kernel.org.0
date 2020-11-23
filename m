Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C184F2C036E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 11:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgKWKhP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 05:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgKWKhP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 05:37:15 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7EFC0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 02:37:13 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id v5so10477827pff.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 02:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4eFIlDBCGuePrKXo7ssxRUnh/an23uWR8hRv/nfBrew=;
        b=UTFKQgOoJYizpumITmdB9VlaPcXqQMrksxuklKmUZv6ApbQDov2zF5scuZArYl6A6Y
         yd++i3f42p9lH3up/PA2WaDRuPwQVAlAVGj44ZMj/p0UxW8aMb/UDXzHAF/8F7bjBa92
         bNWPUY6R2T4umft7PJYwJOFOPTOsAdzFQfZAkD+cIEIIb//UmiUZGZ33v4AVzaZhwBTj
         td+K9uJO9oe3itDjbfRgjBVVceT1Wxzx39v5xAZ9+5rFZiJf0ZCiTgQdV7Do5bTaS6It
         MOItu/J02q00pSJgoJsVqQaJlPL3pCB/UEdDyK5E5dY97QGYQUJWZ/U/NsRTqHV7m9pk
         Gz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4eFIlDBCGuePrKXo7ssxRUnh/an23uWR8hRv/nfBrew=;
        b=SWyP5jvU/ighVcaktIhaP8GludqcDLpg1Wl0gFCycErDgxB4fYNCqYd6xrOrPWnIbD
         jEUXwAOd2PEwiklh47DHrnNL1djJ2bxkzcK0hjB2yzzRKRO36zjTrZgUigtTatf0HDbn
         5bDiYYMu76mD/KVv9qvZOn+r7xtAM/z4IwWXntc2E0HlePfnl3Tet3G4+wLb/LaQbRgL
         KglN1burcUIGrkOf54Hy7+00nh8FMzRpictPt/RyOyR93W0dufB+v+1Dn1UHvn5J3XPh
         5RtVisiLOiv8WjH/d6Jk+4F2NMBLQ9vARUJeHaRZfpMKzfR++m/3fdlOltklLsNpNyqP
         Y1Rg==
X-Gm-Message-State: AOAM531Edjn7qhxqt41SNLxOt6QSWbUHXz9sW2jQYgU3cFegakEBO7ce
        1kMz9rbyOmth9HBTHQhEeXiOIziTXbJMYOPrgCT4lQ==
X-Google-Smtp-Source: ABdhPJz8PxEYWSwkBesY8S8Gp7xJgr4OI3mDgYlO5QJdSzdxdF6WwhS7tyxFNc2WD1b+YhcyppNVwief6iy0SpHqQSI=
X-Received: by 2002:a63:fe0c:: with SMTP id p12mr26221772pgh.31.1606127833192;
 Mon, 23 Nov 2020 02:37:13 -0800 (PST)
MIME-Version: 1.0
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120084202.GJ3200@dhcp22.suse.cz> <CAMZfGtWJXni21J=Yn55gksKy9KZnDScCjKmMasNz5XUwx3OcKw@mail.gmail.com>
 <20201120131129.GO3200@dhcp22.suse.cz> <CAMZfGtWNDJWWTtpUDtngtgNiOoSd6sJpdAB6MnJW8KH0gePfYA@mail.gmail.com>
 <20201123074046.GB27488@dhcp22.suse.cz> <CAMZfGtV9WBu0OVi0fw4ab=t4zzY-uVn3amsa5ZHQhZBy88exFw@mail.gmail.com>
 <20201123094344.GG27488@dhcp22.suse.cz>
In-Reply-To: <20201123094344.GG27488@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 23 Nov 2020 18:36:33 +0800
Message-ID: <CAMZfGtUjsAKuQ_2NijKGPZYX7OBO_himtBDMKNkYb_0_o5CJGA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 00/21] Free some vmemmap pages of
 hugetlb page
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

On Mon, Nov 23, 2020 at 5:43 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 23-11-20 16:53:53, Muchun Song wrote:
> > On Mon, Nov 23, 2020 at 3:40 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Fri 20-11-20 23:44:26, Muchun Song wrote:
> > > > On Fri, Nov 20, 2020 at 9:11 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Fri 20-11-20 20:40:46, Muchun Song wrote:
> > > > > > On Fri, Nov 20, 2020 at 4:42 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > > > >
> > > > > > > On Fri 20-11-20 14:43:04, Muchun Song wrote:
> > > > > > > [...]
> > > > > > >
> > > > > > > Thanks for improving the cover letter and providing some numbers. I have
> > > > > > > only glanced through the patchset because I didn't really have more time
> > > > > > > to dive depply into them.
> > > > > > >
> > > > > > > Overall it looks promissing. To summarize. I would prefer to not have
> > > > > > > the feature enablement controlled by compile time option and the kernel
> > > > > > > command line option should be opt-in. I also do not like that freeing
> > > > > > > the pool can trigger the oom killer or even shut the system down if no
> > > > > > > oom victim is eligible.
> > > > > >
> > > > > > Hi Michal,
> > > > > >
> > > > > > I have replied to you about those questions on the other mail thread.
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > > > >
> > > > > > > One thing that I didn't really get to think hard about is what is the
> > > > > > > effect of vmemmap manipulation wrt pfn walkers. pfn_to_page can be
> > > > > > > invalid when racing with the split. How do we enforce that this won't
> > > > > > > blow up?
> > > > > >
> > > > > > This feature depends on the CONFIG_SPARSEMEM_VMEMMAP,
> > > > > > in this case, the pfn_to_page can work. The return value of the
> > > > > > pfn_to_page is actually the address of it's struct page struct.
> > > > > > I can not figure out where the problem is. Can you describe the
> > > > > > problem in detail please? Thanks.
> > > > >
> > > > > struct page returned by pfn_to_page might get invalid right when it is
> > > > > returned because vmemmap could get freed up and the respective memory
> > > > > released to the page allocator and reused for something else. See?
> > > >
> > > > If the HugeTLB page is already allocated from the buddy allocator,
> > > > the struct page of the HugeTLB can be freed? Does this exist?
> > >
> > > Nope, struct pages only ever get deallocated when the respective memory
> > > (they describe) is hotremoved via hotplug.
> > >
> > > > If yes, how to free the HugeTLB page to the buddy allocator
> > > > (cannot access the struct page)?
> > >
> > > But I do not follow how that relates to my concern above.
> >
> > Sorry. I shouldn't understand your concerns.
> >
> > vmemmap pages                 page frame
> > +-----------+   mapping to   +-----------+
> > |           | -------------> |     0     |
> > +-----------+                +-----------+
> > |           | -------------> |     1     |
> > +-----------+                +-----------+
> > |           | -------------> |     2     |
> > +-----------+                +-----------+
> > |           | -------------> |     3     |
> > +-----------+                +-----------+
> > |           | -------------> |     4     |
> > +-----------+                +-----------+
> > |           | -------------> |     5     |
> > +-----------+                +-----------+
> > |           | -------------> |     6     |
> > +-----------+                +-----------+
> > |           | -------------> |     7     |
> > +-----------+                +-----------+
> >
> > In this patch series, we will free the page frame 2-7 to the
> > buddy allocator. You mean that pfn_to_page can return invalid
> > value when the pfn is the page frame 2-7? Thanks.
>
> No I really mean that pfn_to_page will give you a struct page pointer
> from pages which you release from the vmemmap page tables. Those pages
> might get reused as soon sa they are freed to the page allocator.

We will remap vmemmap pages 2-7 (virtual addresses) to page
frame 1. And then we free page frame 2-7 to the buddy allocator.
Then accessing the struct page pointer that returned by pfn_to_page
will be reflected on page frame 1. I think that here is no problem.

Thanks.

> --
> Michal Hocko
> SUSE Labs



-- 
Yours,
Muchun
