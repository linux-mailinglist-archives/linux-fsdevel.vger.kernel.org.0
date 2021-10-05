Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BD5422F38
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 19:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbhJERbk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 13:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbhJERbj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 13:31:39 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF81EC061753
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Oct 2021 10:29:47 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id 72so20609002qkk.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Oct 2021 10:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ud+GaEGwZiwrOpVpY1wb2/cj4dKQ202kMIqTrCh9s6A=;
        b=4apzZ78Dmauouvr8AX55cK3ZrrYYXF/yPHhalpqJ+ZkCdZQKrNNWuIR1Qqridlgaoe
         ibprPfcUlyWngf3rLsWXvO45UHkeZ8TtFpssBgKMOH9/sAWTCCUakd/lkRObH+ItdMYW
         US7uTspwM9CGv3dLS0C2JSv1f8pjzrwMsMCI0U0TstnTF7ufkBFFGtLboGW5WIgYEIBN
         PJdUoCJO22dewHk5NGo2NslBCwQx9vJvvzIhS+/S48nC8K5G9qrQc+MAcSEBVp42yhqd
         dDWN3KPSqlIub7cpCiAOajIjmUkKpfAhwpCDPc2W2hAKT48G41u4bcCdSqVD3gCCTUam
         1yWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ud+GaEGwZiwrOpVpY1wb2/cj4dKQ202kMIqTrCh9s6A=;
        b=afGw5uIZDgNZfJBop6KDoedZmqCnlayiJ6n5hxvs6yTZo7rUamkj4oM7wDWwcMr0J5
         UzDQ8MeHq+B1JreSjMfqK7SLvpUlEommPrDufGh0RPls/SLD7vA7vjpTqpeyD12/84LR
         PYSSHcDH8d3jNrSbWvy+yS+73WFGzM0YNxKtyyIT02kEtf7dUEkJowqoIz4DJsESEefw
         twqFkwAl1sE0SJdUTC+/iiODoUox1JYtCRKFPVNlTOV5egEjzoeZY6T+kDCVZs5A2g8D
         Edqe+dEDMv2Da0Jyqgvfl+R3feLKvELybsJKOpqxZ9sRezC8cMdhle+6VXwfW3lMfmZD
         wpzQ==
X-Gm-Message-State: AOAM530fwvtxdjApl1u5nuWKq3s1kEN1qbmlHmyaP4WjlELsaJuGUP3N
        2mNUezBWE/g4DBLU2HyQMxRMNg==
X-Google-Smtp-Source: ABdhPJxyc0Jh9E84hW2jNBokrOzi06YOGHMM5pjz7kxw/OGjRgOoSKSgD3hICBIMmvOrQvHC4tp6dw==
X-Received: by 2002:a37:301:: with SMTP id 1mr16077021qkd.510.1633454985658;
        Tue, 05 Oct 2021 10:29:45 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id w17sm9886778qkf.97.2021.10.05.10.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 10:29:44 -0700 (PDT)
Date:   Tue, 5 Oct 2021 13:29:43 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YVyLh+bnZzNeQkyb@cmpxchg.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <YVxYgQa1cECYMtOL@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVxYgQa1cECYMtOL@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 05, 2021 at 02:52:01PM +0100, Matthew Wilcox wrote:
> On Mon, Aug 23, 2021 at 05:26:41PM -0400, Johannes Weiner wrote:
> > One one hand, the ambition appears to substitute folio for everything
> > that could be a base page or a compound page even inside core MM
> > code. Since there are very few places in the MM code that expressly
> > deal with tail pages in the first place, this amounts to a conversion
> > of most MM code - including the LRU management, reclaim, rmap,
> > migrate, swap, page fault code etc. - away from "the page".
> > 
> > However, this far exceeds the goal of a better mm-fs interface. And
> > the value proposition of a full MM-internal conversion, including
> > e.g. the less exposed anon page handling, is much more nebulous. It's
> > been proposed to leave anon pages out, but IMO to keep that direction
> > maintainable, the folio would have to be translated to a page quite
> > early when entering MM code, rather than propagating it inward, in
> > order to avoid huge, massively overlapping page and folio APIs.
> 
> Here's an example where our current confusion between "any page"
> and "head page" at least produces confusing behaviour, if not an
> outright bug, isolate_migratepages_block():
> 
>                 page = pfn_to_page(low_pfn);
> ...
>                 if (PageCompound(page) && !cc->alloc_contig) {
>                         const unsigned int order = compound_order(page);
> 
>                         if (likely(order < MAX_ORDER))
>                                 low_pfn += (1UL << order) - 1;
>                         goto isolate_fail;
>                 }
> 
> compound_order() does not expect a tail page; it returns 0 unless it's
> a head page.  I think what we actually want to do here is:
> 
> 		if (!cc->alloc_contig) {
> 			struct page *head = compound_head(page);
> 			if (PageHead(head)) {
> 				const unsigned int order = compound_order(head);
> 
> 				low_pfn |= (1UL << order) - 1;
> 				goto isolate_fail;
> 			}
> 		}
> 
> Not earth-shattering; not even necessarily a bug.  But it's an example
> of the way the code reads is different from how the code is executed,
> and that's potentially dangerous.  Having a different type for tail
> and not-tail pages prevents the muddy thinking that can lead to
> tail pages being passed to compound_order().

Thanks for digging this up. I agree the second version is much better.

My question is still whether the extensive folio whitelisting of
everybody else is the best way to bring those codepaths to light.

The above isn't totally random. That code is a pfn walker which
translates from the basepage address space to an ambiguous struct page
object. There are more of those, but we can easily identify them: all
uses of pfn_to_page() and virt_to_page() indicate that the code needs
an audit for how exactly they're using the returned page.

The above instance of such a walker wants to deal with a higher-level
VM object: a thing that can be on the LRU, can be locked, etc. For
those instances the pattern is clear that the pfn_to_page() always
needs to be paired with a compound_head() before handling the page. I
had mentioned in the other subthread a pfn_to_normal_page() to
streamline this pattern, clarify intent, and mark the finished audit.

Another class are page table walkers resolving to an ambiguous struct
page right now. Those are also easy to identify, and AFAICS they all
want headpages, which is why I had mentioned a central compound_head()
in vm_normal_page().

Are there other such classes that I'm missing? Because it seems to me
there are two and they both have rather clear markers for where the
disambiguation needs to happen - and central helpers to put them in!

And it makes sense: almost nobody *actually* needs to access the tail
members of struct page. This suggests a pushdown and early filtering
in a few central translation/lookup helpers would work to completely
disambiguate remaining struct page usage inside MM code.

There *are* a few weird struct page usages left, like bio and sparse,
and you mentioned vm_fault as well in the other subthread. But it
really seems these want converting away from arbitrary struct page to
either something like phys_addr_t or a proper headpage anyway. Maybe a
tuple of headpage and subpage index in the fault case. Because even
after a full folio conversion of everybody else, those would be quite
weird in their use of an ambiguous struct page! Which struct members
are safe to access? What does it mean to lock a tailpage? Etc.

But it's possible I'm missing something. Are there entry points that
are difficult to identify both conceptually and code-wise? And which
couldn't be pushed down to resolve to headpages quite early? Those I
think would make the argument for the folio in the MM implementation.
