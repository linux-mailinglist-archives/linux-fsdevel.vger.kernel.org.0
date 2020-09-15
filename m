Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC9F26AB6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 20:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgIOSEB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 14:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbgIOSDx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 14:03:53 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB53C06178A
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 11:03:52 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z19so2391774pfn.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 11:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nhPPje+UUTBY8kYUEvCGJHYilZbBe703Z6BQl0hi82o=;
        b=znz6kYk2M1HfniaapdTD5ndtoDBHFcJW8m8WFdFuJRD4CHnMx3DVnNgZbGlkGcfQyY
         /4/c6GGgxz1i1ALrxb0wjC/itd3L9/KDfk32rpsOmyXzHIf75v2j8TpIGouU0IfRo0A4
         hNrCHJ1HpCS84uJ8dU70fbB0EthZ+75cxB3hrWAgn2YAiDkXlwel6axWVgtX+SH0iVzV
         IiTWNsM7oRf3tuTa3LzvDQNw4zskrFBDebDPRIme32GBauJ3YzgwqMTKmEAngzw6nxtU
         plv5nAAPRqeytkF/yTH5+YyooJJ2tzFWevNGTmDPPZq/scJ0B7wyCnHC+ZI+OUqMHVp9
         olBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nhPPje+UUTBY8kYUEvCGJHYilZbBe703Z6BQl0hi82o=;
        b=OQrfPSE1uEsi6HlQfbsz3p+iBfF8tfmZFpDZUakG/OV8p/GhHvRGAZOPaerbNhZUqH
         rjqh/8l9nNS3vFZ0OVdLNhka3FQHN4Sni4PTaq74OIJOu9XCJ2aZI7bmDbGOg6zxdZ+x
         DeYnYKPqotERdkY7QAFWy6DM3KAVtHch+R4lVt3Hq/tMNaO2jw5n12Wa0vH1uAyHXArm
         fj/aqV0SK8kw2x32hIlAnggJdhDw4+SfKzTD3GuwNvHUgKaSDXuRx8+RVKZ086w2v1aH
         +OSOWLviWiY0mScb6OPohj+YJDQ8U8jmkjk8caDPqqwWqayZcRE1iC/YnNyEQE1I8DuD
         o0IQ==
X-Gm-Message-State: AOAM5316gu6BM6Tqk2rvqPbg4Zul94zaTtCPkXrWl7wKE7Al2xnJtWpX
        CSqJaTDDAEaI+tez3i4k42n0S26YxJ9Df+tlTUsmxw==
X-Google-Smtp-Source: ABdhPJxm8mfbd1RkNg+nNZEp7K1x8W811B13DkAefYfGlQ8VvBcsuWI2MpSoCr5ODfRzGBd9GbAXzfHNNbAMFtRvCl4=
X-Received: by 2002:a62:e40c:0:b029:13f:d777:f70e with SMTP id
 r12-20020a62e40c0000b029013fd777f70emr12683616pfh.2.1600193031738; Tue, 15
 Sep 2020 11:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200915125947.26204-1-songmuchun@bytedance.com>
 <20200915143241.GH5449@casper.infradead.org> <CAMZfGtW0PqU6SLihLABA8rU+FuBqm8NksDW=EkLXy1RZfYeDGA@mail.gmail.com>
 <20200915154213.GI5449@casper.infradead.org> <CAMZfGtVTjopGgFv4xCDcF1+iGeRva_ypH4EQWcDUFBdsfqhQbA@mail.gmail.com>
 <20200915173948.GK5449@casper.infradead.org>
In-Reply-To: <20200915173948.GK5449@casper.infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 16 Sep 2020 02:03:15 +0800
Message-ID: <CAMZfGtW3S8kGJwff6oH14QWPXKTuQEAGdYwcLRUZxuJ7q8s7sA@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 00/24] mm/hugetlb: Free some vmemmap
 pages of hugetlb page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de, almasrymina@google.com,
        David Rientjes <rientjes@google.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 16, 2020 at 1:39 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Sep 16, 2020 at 01:32:46AM +0800, Muchun Song wrote:
> > On Tue, Sep 15, 2020 at 11:42 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Tue, Sep 15, 2020 at 11:28:01PM +0800, Muchun Song wrote:
> > > > On Tue, Sep 15, 2020 at 10:32 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > > >
> > > > > On Tue, Sep 15, 2020 at 08:59:23PM +0800, Muchun Song wrote:
> > > > > > This patch series will free some vmemmap pages(struct page structures)
> > > > > > associated with each hugetlbpage when preallocated to save memory.
> > > > >
> > > > > It would be lovely to be able to do this.  Unfortunately, it's completely
> > > > > impossible right now.  Consider, for example, get_user_pages() called
> > > > > on the fifth page of a hugetlb page.
> > > >
> > > > Can you elaborate on the problem? Thanks so much.
> > >
> > > OK, let's say you want to do a 2kB I/O to offset 0x5000 of a 2MB page
> > > on a 4kB base page system.  Today, that results in a bio_vec containing
> > > {head+5, 0, 0x800}.  Then we call page_to_phys() on that (head+5) struct
> > > page to get the physical address of the I/O, and we turn it into a struct
> > > scatterlist, which similarly has a reference to the page (head+5).
> >
> > As I know, in this case, the get_user_pages() will get a reference
> > to the head page (head+0) before returning such that the hugetlb
> > page can not be freed. Although get_user_pages() returns the
> > page (head+5) and the scatterlist has a reference to the page
> > (head+5), this patch series can handle this situation. I can not
> > figure out where the problem is. What I missed? Thanks.
>
> You freed pages 4-511 from the vmemmap so they could be used for
> something else.  Page 5 isn't there any more.  So if you return head+5,
> then when we complete the I/O, we'll look for the compound_head() of
> head+5 and we won't find head.
>

We do not free pages 4-511 from the vmemmap. Actually, we only
free pages 128-511 from the vmemmap.

The 512 struct pages occupy 8 pages of physical memory. We only
free 6 physical page frames to the buddy. But we will create a new
mapping just like below. The virtual address of the freed pages will
remap to the second page frame. So the second page frame is
reused.

When a hugetlbpage is preallocated, we can change the mapping to
bellow.

   hugetlbpage                   struct page(8 pages)          page
frame(8 pages)
  +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
  |           |                     |     0     | -------------> |     0     |
  |           |                     |     1     | -------------> |     1     |
  |           |                     |     2     | -------------> +-----------+
  |           |                     |     3     | -----------------^ ^ ^ ^ ^
  |           |                     |     4     | -------------------+ | | |
  |     2M    |                     |     5     | ---------------------+ | |
  |           |                     |     6     | -----------------------+ |
  |           |                     |     7     | -------------------------+
  |           |                     +-----------+
  |           |
  |           |
  +-----------+

As you can see, we reuse the first tail page.

-- 
Yours,
Muchun
