Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39C9405F2C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 00:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245368AbhIIWCk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 18:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244548AbhIIWCh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 18:02:37 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FF9C061574
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Sep 2021 15:01:27 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id m21so3612848qkm.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Sep 2021 15:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QZqkF9duxuzZ+biCr/DN+cOPkA95d4hYzGir/0bZtG8=;
        b=n4Yox4FllS4gAcO35Nu8s/ilFPO82gh8Gm/P3mDRND5oe2rctlncS/tr0y85Fs8npP
         98l5IbSFrFXrw+cwcb0zvs+hCkjsxur9V2MMDUGHT3XXfhEce73/5iWt2xplCy/3EJhh
         +2prmzstXNUANrptayppa1LTU1dcLX//fY9en1mSyyXXReAarLHQYYJ/9PUblzzl32wE
         WCEvZ5kvcljGt7MED2wLGtYBCaYZcdNBK5lTYlEhrMEneFSeEYCqWAkX/McDiRbDrXNq
         5rDknVoSQRALljSxiiu1jfnqPspcTcube+E4KtX+IPf4QLINfIOzYrHc0ANRy6ZvMxWa
         qOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QZqkF9duxuzZ+biCr/DN+cOPkA95d4hYzGir/0bZtG8=;
        b=SYri7oT4qdYj/n4ndN8zdeRzsvxxdutcqXCZnAcY21TdLBYBewwVM5klAKxVnoCCr8
         C6pDJUgebKV0vW7NhWybcTncZpyRyogEUfPx1ig4kY330vTE4LWrJMOIDe5FHCGxuHJs
         YDGEKKKnK+Alg0XM0p46jxRRtFOMa5PQgg1VlaKPgKFt35Gp2z/MVvc1h71pV5QprDhI
         0iIIX7Km749B9daOlJbXCnX7frbeMJ6yjzyASlLWnycV/t82iZBwN8iRsdUCSyk6Id3i
         8oH9dv6P81EnBW00eeiT4cWcVBOFo3zygsvCKSgZcPYBYJRGMtJbHEuN0KVTlS5v3kgT
         HL5Q==
X-Gm-Message-State: AOAM533urHUU4+aLLgGIiP7omKLP4SRgO57F64ptaF3FHIvgT914uz4O
        nSswBbDFOpnzbO0x9Aw0VcImiQ==
X-Google-Smtp-Source: ABdhPJykIZNFvzFm3FAQRsJZQ2IJ7iZMncXFjisKzYimm3AW6YNhcKNTkQC8pRrSlAuvO/m/7fW51Q==
X-Received: by 2002:a05:620a:2914:: with SMTP id m20mr5086687qkp.497.1631224886125;
        Thu, 09 Sep 2021 15:01:26 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id s8sm1868997qta.48.2021.09.09.15.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 15:01:25 -0700 (PDT)
Date:   Thu, 9 Sep 2021 18:03:17 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YTqEpTIbwRJmwCwL@cmpxchg.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YToBjZPEVN9Jmp38@infradead.org>
 <6b01d707-3ead-015b-eb36-7e3870248a22@suse.cz>
 <YTpPh2aaQMyHAi8m@cmpxchg.org>
 <YTpWBif8DCV5ovON@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTpWBif8DCV5ovON@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 09, 2021 at 07:44:22PM +0100, Matthew Wilcox wrote:
> On Thu, Sep 09, 2021 at 02:16:39PM -0400, Johannes Weiner wrote:
> > My objection is simply to one shared abstraction for both. There is
> > ample evidence from years of hands-on production experience that
> > compound pages aren't the way toward scalable and maintainable larger
> > page sizes from the MM side. And it's anything but obvious or
> > self-evident that just because struct page worked for both roles that
> > the same is true for compound pages.
> 
> I object to this requirement.  The folio work has been going on for almost
> a year now, and you come in AT THE END OF THE MERGE WINDOW to ask for it
> to do something entirely different from what it's supposed to be doing.
> If you'd asked for this six months ago -- maybe.  But now is completely
> unreasonable.

I asked for exactly this exactly six months ago.

On March 22nd, I wrote this re: the filesystem interfacing:

: So I think transitioning away from ye olde page is a great idea. I
: wonder this: have we mapped out the near future of the VM enough to
: say that the folio is the right abstraction?
:
: What does 'folio' mean when it corresponds to either a single page or
: some slab-type object with no dedicated page?
:
: If we go through with all the churn now anyway, IMO it makes at least
: sense to ditch all association and conceptual proximity to the
: hardware page or collections thereof. Simply say it's some length of
: memory, and keep thing-to-page translations out of the public API from
: the start. I mean, is there a good reason to keep this baggage?

It's not my fault you consistently dismissed and pushed past this
question and then send a pull request anyway.

> I don't think it's a good thing to try to do.  I think that your "let's
> use slab for this" idea is bonkers and doesn't work.

Based on what exactly?

You can't think it's that bonkers when you push for replicating
slab-like grouping in the page allocator.

Anyway, it was never about how larger pages will pan out in MM. It was
about keeping some flexibility around the backing memory for cache
entries, given that this is still an unsolved problem. This is not a
crazy or unreasonable request, it's the prudent thing to do given the
amount of open-ended churn and disruptiveness of your patches.

It seems you're not interested in engaging in this argument. You
prefer to go off on tangents and speculations about how the page
allocator will work in the future, with seemingly little production
experience about what does and doesn't work in real life; and at the
same time dismiss the experience of people that deal with MM problems
hands-on on millions of machines & thousands of workloads every day.

> And I really object to you getting in the way of my patchset which
> has actual real-world performance advantages

So? You've gotten in the way of patches that removed unnecessary
compound_head() call and would have immediately provided some of these
same advantages without hurting anybody - because the folio will
eventually solve them all anyway.

We all balance immediate payoff against what we think will be the
right thing longer term.

Anyway, if you think I'm bonkers, just ignore me. If not, maybe lay
off the rhetorics, engage in a good-faith discussion and actually
address my feedback?
