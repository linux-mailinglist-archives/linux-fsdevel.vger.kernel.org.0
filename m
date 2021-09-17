Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E686741009D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 23:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239733AbhIQVOg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 17:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhIQVOg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 17:14:36 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30EEC061574;
        Fri, 17 Sep 2021 14:13:13 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id r21so9940966qtw.11;
        Fri, 17 Sep 2021 14:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7y2hlBvrXziI3IvJBrIxyx+hcslOAnsyk0h3WElgiQM=;
        b=YhUzpzg0wYgXhTIQgYtpVQo+Di+Z9+TAbAQY1M2JcfS7RmVqDtKpqT0AChc3ODGbcb
         GRvUx8gveyi9adfSYVUeXWxkaIXhCpXRt6+l2NWCabX3r2j+LqMx+6d8fDDEXI72fy9j
         w3I/J7K+x6lns6moYBks/jiCqKmEjvWtQbvpSmVTlV3gl5iGS3IPT3MZyNI5G04SvG5u
         rlNIuYdHIoAaO6aC0HbpjK0hPOcjW1jX8hhWeA8I8Z0wQ5bUe2yfNCOhZyGbzV5f5EyV
         YFQ8vGl94WSsxA1Ah/smYcGKbTFLQlTHEkyp/3fLCrVH8CKHKEddBflPF8JhzKsNy/bl
         CWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7y2hlBvrXziI3IvJBrIxyx+hcslOAnsyk0h3WElgiQM=;
        b=bunjlFDCLVlbHOKbcWL26QJFexgG7DcMeYNqFzDZD3H3/xnRxDcl3AqayfZMWxfDSM
         S0Zf7NDHeD6yNEh7NrQi4Tlo8XgLn5/L7KJWe/Iv0vCj1OUoHvW3LnTUL4zUjXuyWsvJ
         ZM9Ee9t8TnlGItB4AIZp8G2H/c8JtWNvBmmoKvGw8dIOYuh99ShwkLiWNf7JjVRP2lB7
         wghqpxj9osxGv9UQNLIPB9IYwNbi2x17y7nLuj1QdNGlkIcl+weWcoUAJXqVYK3OR7eG
         Y0GIFa3nZSTnVMFHpcdqzO15fWlj0MsaMfxzFVhOpK2iHkTNFxNKb8Z48gAsurKE//5z
         zCSw==
X-Gm-Message-State: AOAM533Dg8LCepzlICoB8BtClwcdUaclLGtOiLf8+Fabjhi5csY2uq54
        R95AR4kCMB5OmJVfrDg/M8v/ik5y4QVE
X-Google-Smtp-Source: ABdhPJycdfl7F3ccjTutXpAnulSbeVr4KJYDT9+KCiiUwwpDuj35k/zIHcKcPugbVWRZukA41a7uSQ==
X-Received: by 2002:ac8:570f:: with SMTP id 15mr12568002qtw.335.1631913192909;
        Fri, 17 Sep 2021 14:13:12 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o4sm4933735qti.24.2021.09.17.14.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 14:13:12 -0700 (PDT)
Date:   Fri, 17 Sep 2021 17:13:10 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folio discussion recap
Message-ID: <YUUE5qB9CW9qiAcN@moria.home.lan>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUIT2/xXwvZ4IErc@cmpxchg.org>
 <20210916025854.GE34899@magnolia>
 <YUN2vokEM8wgASk8@cmpxchg.org>
 <20210917052440.GJ1756565@dread.disaster.area>
 <YUTC6O0w3j7i8iDm@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUTC6O0w3j7i8iDm@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Snipped, reordered:

On Fri, Sep 17, 2021 at 12:31:36PM -0400, Johannes Weiner wrote:
> 2. Are compound pages a scalable, future-proof allocation strategy?
> 
> For 2), nobody knows the answer to this. Nobody. Anybody who claims to
> do so is full of sh*t. Maybe compound pages work out, maybe they
> don't. We can talk a million years about larger page sizes, how to
> handle internal fragmentation, the difficulties of implementing a
> chunk cache, but it's completely irrelevant because it's speculative.

Calling it compound pages here is a misnomer, and it confuses the discussion.
The question is really about whether we should start using higher order
allocations for data in the page cache, and perhaps a better way of framing that
question is: should we continue to fragment all our page cache allocations up
front into individual pages?

But I don't think this really the blocker.

> 1. Is the folio a good descriptor for all uses of anon and file pages
>    inside MM code way beyond the page cache layer YOU care about?
> 
> For some people the answers are yes, for others they are a no.

The anon page conversion does seem to be where all the disagreement is coming
from.

So my ask, to everyone involved is - if anonymous pages are dropped from the
folio patches, do we have any other real objections to the patch series?

It's an open question as to how much anonymous pages are like file pages, and if
we continue down the route of of splitting up struct page into separate types
whether anonymous pages should be the same time as file pages.

Also, it appears even file pages aren't fully converted to folios in Willy's
patch set - grepping around reveals plenty of references to struct page left in
fs/. I think that even if anonymous pages are going to become folios it's a
pretty reasonable ask for that to wait a cycle or two and see how the conversion
of file pages fully plays out.

Also: it's become pretty clear to me that we have crappy communications between
MM developers and filesystem developers. Internally both teams have solid
communications - I know in filesystem land we all talk to each other and are
pretty good at working colaboratively, and it sounds like the MM team also has
good internal communications. But we seem to have some problems with tackling
issues that cross over between FS and MM land, or awkwardly sit between them.

Perhaps this is something we could try to address when picking conference topics
in the future. Johannes also mentioned a monthly group call the MM devs schedule
- I wonder if it would be useful to get something similar going between MM and
interested parties in filesystem land.
