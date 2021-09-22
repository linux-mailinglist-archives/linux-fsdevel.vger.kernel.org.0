Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B987414D51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 17:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbhIVPrl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 11:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhIVPrk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 11:47:40 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D547CC061574;
        Wed, 22 Sep 2021 08:46:10 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id u21so3069441qtw.8;
        Wed, 22 Sep 2021 08:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wVGktONlyuLsWAH2exvLKeS5CnFnKlgLM/sI96OfsNs=;
        b=RsvJWdyEk4lgnjYlT+5aTgeWpdCg9TY9iCo4rvHUm3ntJ8Yxss8iPsFarkKFVBWQXP
         kzDE/SSKgkRL9uvrxYdZERgjUWlIFZuUAlX/xuuR9+fYNVfo1cSpAT+3QCwx/UdAO9sD
         mnJRJ2KMDRbiDhzpKCajxToxgkICsGf6UNdrmuif94uwD2f2zFu11TojoW9+R5wG0ZR1
         xeT+ZpweVDQyYMNeJZzqf3xyE8qDkpaw7Mth6VyPxo0O96lQ0GC+kaPbmlZECWHtfBvl
         ZupaI/Pa56VXmGl+p61hLnk6bpbPr5mZMGdAu9+13IwdlY/pJzAf0lnln6MgQEHV2Zuw
         kJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wVGktONlyuLsWAH2exvLKeS5CnFnKlgLM/sI96OfsNs=;
        b=hVwrkW1qDBDLeYf7atX2WtSOJDchdkSfmtEcC5G4auW3xWwLkgE9hGuE/DQFegj/eQ
         /AK6cBpZ97rHffCHoRuefgEsrOJx6OkTxUZ4v6SCmOKXvqr5gnO3bHlH7PfbH8GWq6Sq
         3GJ0d1pix4FImprozsUbHxdWIe2Ne6nZccPbVP4Trznl3zOU052oRxd29x0lym/ZA3xW
         CoW3awuXzmMuJmxdqn+xfORXsvLUoLUrXo6zA4Zgwxyax6v9taKD/KxKUU81pfuumYJ0
         YTrkbROqqlgu6rkYHkzKRC9IAZH94MEuRu746tIn4OdSP84fIG+S0tQTrXqiOJwUx5Zf
         UVAw==
X-Gm-Message-State: AOAM5335cokmOZpoj0aAG2s9UFZF07/YvoJqvrHY5XxbzlllvAsK4PW4
        Eviy4weed3Hc8ny3ij2tYw==
X-Google-Smtp-Source: ABdhPJztTNAUbBMNBlNnPXcMDhxgBdw9YffnsLygCsPZLbtbKSwLXYYq+eWEbgddnxnskOXGS63pPg==
X-Received: by 2002:ac8:6683:: with SMTP id d3mr141145qtp.291.1632325570011;
        Wed, 22 Sep 2021 08:46:10 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id a3sm552437qkh.67.2021.09.22.08.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 08:46:09 -0700 (PDT)
Date:   Wed, 22 Sep 2021 11:46:04 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
Message-ID: <YUtPvGm2RztJdSf1@moria.home.lan>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUfvK3h8w+MmirDF@casper.infradead.org>
 <YUo20TzAlqz8Tceg@cmpxchg.org>
 <YUpC3oV4II+u+lzQ@casper.infradead.org>
 <YUpKbWDYqRB6eBV+@moria.home.lan>
 <YUpNLtlbNwdjTko0@moria.home.lan>
 <YUtHCle/giwHvLN1@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUtHCle/giwHvLN1@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 22, 2021 at 11:08:58AM -0400, Johannes Weiner wrote:
> On Tue, Sep 21, 2021 at 05:22:54PM -0400, Kent Overstreet wrote:
> >  - it's become apparent that there haven't been any real objections to the code
> >    that was queued up for 5.15. There _are_ very real discussions and points of
> >    contention still to be decided and resolved for the work beyond file backed
> >    pages, but those discussions were what derailed the more modest, and more
> >    badly needed, work that affects everyone in filesystem land
> 
> Unfortunately, I think this is a result of me wanting to discuss a way
> forward rather than a way back.
> 
> To clarify: I do very much object to the code as currently queued up,
> and not just to a vague future direction.
> 
> The patches add and convert a lot of complicated code to provision for
> a future we do not agree on. The indirections it adds, and the hybrid
> state it leaves the tree in, make it directly more difficult to work
> with and understand the MM code base. Stuff that isn't needed for
> exposing folios to the filesystems.
> 
> As Willy has repeatedly expressed a take-it-or-leave-it attitude in
> response to my feedback, I'm not excited about merging this now and
> potentially leaving quite a bit of cleanup work to others if the
> downstream discussion don't go to his liking.
> 
> Here is the roughly annotated pull request:

Thanks for breaking this out, Johannes.

So: mm/filemap.c and mm/page-writeback.c - I disagree about folios not really
being needed there. Those files really belong more in fs/ than mm/, and the code
in those files needs folios the most - especially filemap.c, a lot of those
algorithms have to change from block based to extent based, making the analogy
with filesystems.

I think it makes sense to drop the mm/lru stuff, as well as the mm/memcg,
mm/migrate and mm/workingset and mm/swap stuff that you object to - that is, the
code paths that are for both file + anonymous pages, unless Matthew has
technical reasons why that would break the rest of the patch set.

And then, we really should have a pow wow and figure out what our options are
going forward. I think we have some agreement now that not everything is going
to be a folio going forwards (Matthew already split out his slab conversion to a
new type) - so if anonymous pages aren't becoming folios, we should prototype
some stuff and see where that helps and hurts us.

> As per the other email I still think it would have been good to have a
> high-level discussion about the *legitimate* entry points and data
> structures that will continue to deal with tail pages down the
> line. To scope the actual problem that is being addressed by this
> inverted/whitelist approach - so we don't annotate the entire world
> just to box in a handful of page table walkers...

That discussion can still happen... and there's still the potential to get a lot
more done if we're breaking open struct page and coming up with new types. I got
Matthew on board with what you wanted, re: using the slab allocator for larger
allocations
