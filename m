Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93FAF2B6A08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 17:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgKQQ3t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 11:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgKQQ3t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 11:29:49 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCA9C0617A6
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2020 08:29:47 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id gi3so773222pjb.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2020 08:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A3QTWUzTvUT9gxMoshGLtqPLDCXqi6pfAh27cLWuKoY=;
        b=oF6O0GItwqng2CH4SIbYH2aWyQ0yc6lC98D8jhxQh/Z/K6wGgSrCp+VelucrtJYIN+
         yfrPeJi0WnWoX5NjeJg7eGFqFQH7j+0A/kup3R4Gpm/Na2hqHBDTwGnqDR8yqmKMDFxB
         jWQsbr+qnzpVfnxrIHMriUpUcKtH1Ei4VI4pdgcMN8m7OKjz1fLIvEICdudJz+MTX8Hb
         pur0CMetqz1ZfpjWZf0ixQoiXRCmCJ970vKWlb7PggfovGKJFPkHgRalGrdCYI7ATCYB
         EHeAV57hqAfhxZP2iYYglDOS2Q99Zw+xdno1A/n+4pWJdBqnLMHxUGUnCQa1wcQUc5t9
         OL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A3QTWUzTvUT9gxMoshGLtqPLDCXqi6pfAh27cLWuKoY=;
        b=Zu2sdgBB9tLMviiA583ZVwt1o6Y4T4DAiuGYuD3zcsDthuBIDFLR8ESXVh4ivKC2U6
         ooZupDbEX6qpyOTAGQxzsiXMNWB4apX04QK7F/JiVDzVTjmMiJLSZpK+ARCexZ5XWZcl
         U6PsCpEoLTc77CJhz+LWMZCvVhLqFguYCJ+J0MWXl9gbKaNpxpKblfR2LRU+1j9TA1aj
         lrSVGy+BGrtkpYy2ZW0F+20onwT1IU+ipOGBpkFx3H8APsElvtJa/bwVKBO4xS96+gNf
         8SRBPG3w9DEn1XL4saetSM3Usw/vXFUZf43KvecY6/aTD7AtHQD+g4Pw5KDp0Luvpd+o
         zZIg==
X-Gm-Message-State: AOAM530Re4Q2dhx8QUj0n3MzJfLn8R7XZsZ3zOk411btJE/5piapvRBf
        Rvz2mNCMksI7do/ssymPxx/PqNhewVaOqNgiYI1SBg==
X-Google-Smtp-Source: ABdhPJyKdXILrrCSaxnUg7OSQj7ryLePl/Z4V9HWSFy1zzwaaUm05L7FiTmkFJslcslXKPtsd9XP4QPPRhSICbNSWHs=
X-Received: by 2002:a17:902:c14b:b029:d6:ab18:108d with SMTP id
 11-20020a170902c14bb02900d6ab18108dmr314927plj.20.1605630587256; Tue, 17 Nov
 2020 08:29:47 -0800 (PST)
MIME-Version: 1.0
References: <20201113105952.11638-1-songmuchun@bytedance.com>
 <349168819c1249d4bceea26597760b0a@hisilicon.com> <CAMZfGtUVDJ4QHYRCKnPTkgcKGJ38s2aOOktH+8Urz7oiVfimww@mail.gmail.com>
 <714ae7d701d446259ab269f14a030fe9@hisilicon.com>
In-Reply-To: <714ae7d701d446259ab269f14a030fe9@hisilicon.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 18 Nov 2020 00:29:07 +0800
Message-ID: <CAMZfGtWNa=abZdN6HmWE1VBFHfGCbsW9D0zrN-F5zrhn6s=ErA@mail.gmail.com>
Subject: Re: [External] RE: [PATCH v4 00/21] Free some vmemmap pages of
 hugetlb page
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "oneukum@suse.com" <oneukum@suse.com>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "almasrymina@google.com" <almasrymina@google.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "duanxiongchun@bytedance.com" <duanxiongchun@bytedance.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 17, 2020 at 7:08 PM Song Bao Hua (Barry Song)
<song.bao.hua@hisilicon.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Muchun Song [mailto:songmuchun@bytedance.com]
> > Sent: Tuesday, November 17, 2020 11:50 PM
> > To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> > Cc: corbet@lwn.net; mike.kravetz@oracle.com; tglx@linutronix.de;
> > mingo@redhat.com; bp@alien8.de; x86@kernel.org; hpa@zytor.com;
> > dave.hansen@linux.intel.com; luto@kernel.org; peterz@infradead.org;
> > viro@zeniv.linux.org.uk; akpm@linux-foundation.org; paulmck@kernel.org;
> > mchehab+huawei@kernel.org; pawan.kumar.gupta@linux.intel.com;
> > rdunlap@infradead.org; oneukum@suse.com; anshuman.khandual@arm.com;
> > jroedel@suse.de; almasrymina@google.com; rientjes@google.com;
> > willy@infradead.org; osalvador@suse.de; mhocko@suse.com;
> > duanxiongchun@bytedance.com; linux-doc@vger.kernel.org;
> > linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> > linux-fsdevel@vger.kernel.org
> > Subject: Re: [External] RE: [PATCH v4 00/21] Free some vmemmap pages of
> > hugetlb page
> >
> > On Tue, Nov 17, 2020 at 6:16 PM Song Bao Hua (Barry Song)
> > <song.bao.hua@hisilicon.com> wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: owner-linux-mm@kvack.org [mailto:owner-linux-mm@kvack.org] On
> > > > Behalf Of Muchun Song
> > > > Sent: Saturday, November 14, 2020 12:00 AM
> > > > To: corbet@lwn.net; mike.kravetz@oracle.com; tglx@linutronix.de;
> > > > mingo@redhat.com; bp@alien8.de; x86@kernel.org; hpa@zytor.com;
> > > > dave.hansen@linux.intel.com; luto@kernel.org; peterz@infradead.org;
> > > > viro@zeniv.linux.org.uk; akpm@linux-foundation.org; paulmck@kernel.org;
> > > > mchehab+huawei@kernel.org; pawan.kumar.gupta@linux.intel.com;
> > > > rdunlap@infradead.org; oneukum@suse.com;
> > anshuman.khandual@arm.com;
> > > > jroedel@suse.de; almasrymina@google.com; rientjes@google.com;
> > > > willy@infradead.org; osalvador@suse.de; mhocko@suse.com
> > > > Cc: duanxiongchun@bytedance.com; linux-doc@vger.kernel.org;
> > > > linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> > > > linux-fsdevel@vger.kernel.org; Muchun Song
> > <songmuchun@bytedance.com>
> > > > Subject: [PATCH v4 00/21] Free some vmemmap pages of hugetlb page
> > > >
> > > > Hi all,
> > > >
> > > > This patch series will free some vmemmap pages(struct page structures)
> > > > associated with each hugetlbpage when preallocated to save memory.
> > > >
> > > > Nowadays we track the status of physical page frames using struct page
> > > > structures arranged in one or more arrays. And here exists one-to-one
> > > > mapping between the physical page frame and the corresponding struct
> > page
> > > > structure.
> > > >
> > > > The HugeTLB support is built on top of multiple page size support that
> > > > is provided by most modern architectures. For example, x86 CPUs normally
> > > > support 4K and 2M (1G if architecturally supported) page sizes. Every
> > > > HugeTLB has more than one struct page structure. The 2M HugeTLB has
> > 512
> > > > struct page structure and 1G HugeTLB has 4096 struct page structures. But
> > > > in the core of HugeTLB only uses the first 4 (Use of first 4 struct page
> > > > structures comes from HUGETLB_CGROUP_MIN_ORDER.) struct page
> > > > structures to
> > > > store metadata associated with each HugeTLB. The rest of the struct page
> > > > structures are usually read the compound_head field which are all the same
> > > > value. If we can free some struct page memory to buddy system so that we
> > > > can save a lot of memory.
> > > >
> > > > When the system boot up, every 2M HugeTLB has 512 struct page
> > structures
> > > > which size is 8 pages(sizeof(struct page) * 512 / PAGE_SIZE).
> > > >
> > > >    hugetlbpage                  struct pages(8 pages)          page
> > > > frame(8 pages)
> > > >   +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
> > > >   |           |                     |     0     | -------------> |
> > 0
> > > > |
> > > >   |           |                     |     1     | -------------> |
> > 1
> > > > |
> > > >   |           |                     |     2     | -------------> |
> > 2
> > > > |
> > > >   |           |                     |     3     | -------------> |
> > 3
> > > > |
> > > >   |           |                     |     4     | -------------> |
> > 4
> > > > |
> > > >   |     2M    |                     |     5     | -------------> |
> > > > 5     |
> > > >   |           |                     |     6     | -------------> |
> > 6
> > > > |
> > > >   |           |                     |     7     | -------------> |
> > 7
> > > > |
> > > >   |           |                     +-----------+
> > > > +-----------+
> > > >   |           |
> > > >   |           |
> > > >   +-----------+
> > > >
> > > >
> > > > When a hugetlbpage is preallocated, we can change the mapping from
> > above
> > > > to
> > > > bellow.
> > > >
> > > >    hugetlbpage                  struct pages(8 pages)          page
> > > > frame(8 pages)
> > > >   +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
> > > >   |           |                     |     0     | -------------> |
> > 0
> > > > |
> > > >   |           |                     |     1     | -------------> |
> > 1
> > > > |
> > > >   |           |                     |     2     | ------------->
> > > > +-----------+
> > > >   |           |                     |     3     | -----------------^ ^
> > ^ ^
> > > > ^
> > > >   |           |                     |     4     | -------------------+
> > | |
> > > > |
> > > >   |     2M    |                     |     5     |
> > ---------------------+ |
> > > > |
> > > >   |           |                     |     6     |
> > -----------------------+ |
> > > >   |           |                     |     7     |
> > -------------------------+
> > > >   |           |                     +-----------+
> > > >   |           |
> > > >   |           |
> > > >   +-----------+
> > > >
> > > > For tail pages, the value of compound_head is the same. So we can reuse
> > > > first page of tail page structs. We map the virtual addresses of the
> > > > remaining 6 pages of tail page structs to the first tail page struct,
> > > > and then free these 6 pages. Therefore, we need to reserve at least 2
> > > > pages as vmemmap areas.
> > > >
> > > > When a hugetlbpage is freed to the buddy system, we should allocate six
> > > > pages for vmemmap pages and restore the previous mapping relationship.
> > > >
> > > > If we uses the 1G hugetlbpage, we can save 4088 pages(There are 4096
> > pages
> > > > for
> > > > struct page structures, we reserve 2 pages for vmemmap and 8 pages for
> > page
> > > > tables. So we can save 4088 pages). This is a very substantial gain. On our
> > > > server, run some SPDK/QEMU applications which will use 1024GB
> > hugetlbpage.
> > > > With this feature enabled, we can save ~16GB(1G hugepage)/~11GB(2MB
> > > > hugepage)
> > >
> > > Hi Muchun,
> > >
> > > Do we really save 11GB for 2MB hugepage?
> > > How much do we save if we only get one 2MB hugetlb from one 128MB
> > mem_section?
> > > It seems we need to get at least one page for the PTEs since we are splitting
> > PMD of
> > > vmemmap into PTE?
> >
> > There are 524288(1024GB/2MB) 2MB HugeTLB pages. We can save 6 pages for
> > each
> > 2MB HugeTLB page. So we can save 3145728 pages. But we need to split PMD
> > page
> > table for every one 128MB mem_section and every section need one page
> > as PTE page
> > table. So we need 8192(1024GB/128MB) pages as PTE page tables.
> > Finally, we can save
> > 3137536(3145728-8192) pages which is 11.97GB.
>
> The worst case I can see is that:
> if we get 100 hugetlb with 2MB size, but the 100 hugetlb comes from different
> mem_section, we won't save 11.97GB. we only save 5/8 * 16GB=10GB.
>
> Anyway, it seems 11GB is in the middle of 10GB and 11.97GB,
> so sounds sensible :-)
>
> ideally, we should be able to free PageTail if we change struct page in some way.
> Then we will save much more for 2MB hugetlb. but it seems it is not easy.

Now for the 2MB HugrTLB page, we only free 6 vmemmap pages.
But your words woke me up. Maybe we really can free 7 vmemmap
pages. In this case, we can see 8 of the 512 struct page structures
has beed set PG_head flag. If we can adjust compound_head()
slightly and make compound_head() return the real head struct
page when the parameter is the tail struct page but with PG_head
flag set. I will start an investigation and a test.

Thanks.

>
> Thanks
> Barry



-- 
Yours,
Muchun
