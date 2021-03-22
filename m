Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9346B343763
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 04:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhCVD0Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Mar 2021 23:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhCVDZu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Mar 2021 23:25:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9821BC061574;
        Sun, 21 Mar 2021 20:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P72qzGDKAlZd08W3lP8UYDEYbOwiROYYMfl9MNHa8u0=; b=hjfkcSn0/SSn274T0yvdeKLsd3
        GfQiDVlf2WSNKe6S4ojs8lcQ242XLIqaXbNfYR7jkr8eD9UWH5Lw824MJRGixpkbqPkW9Xa6SHwrn
        6AWAa4CjIEiisZdaN0z0At/lWbyKzLooWH6x8rqPHH1ZY1cF7qAiS2FLfkFC7kPrD2dDulJlrQl2f
        rA/MA1eQMkPOj2g6XS1dkDoaeAqgee+FeEZKBCn8XKLL0up3bBe+xDK2lrBaeZk/24EPAA7pu/vfS
        xA51Wi9YY4+rdPJCdJq3qLiFGXIl6oO/SFptJ/AyqHRfvCPfajVwTC59xGQe73bLXq5kcIHRa6c5I
        Mqle4zWA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOBBu-007vD1-0H; Mon, 22 Mar 2021 03:25:26 +0000
Date:   Mon, 22 Mar 2021 03:25:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: Re: [PATCH v5 00/27] Memory Folios
Message-ID: <20210322032517.GC1719932@casper.infradead.org>
References: <20210320054104.1300774-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210320054104.1300774-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 20, 2021 at 05:40:37AM +0000, Matthew Wilcox (Oracle) wrote:
> Current tree at:
> https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/folio
> 
> (contains another ~100 patches on top of this batch, not all of which are
> in good shape for submission)

I've fixed the two buildbot bugs.  I also resplit the docs work, and
did a bunch of other things to the patches that I haven't posted yet.

I'll send the first three patches as a separate series tomorrow,
and then the next four as their own series, then I'll repost the
rest (up to and including "Convert page wait queues to be folios")
later in the week.
