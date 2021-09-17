Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B03F40F32A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 09:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbhIQHYn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 03:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhIQHYm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:24:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2A3C061574;
        Fri, 17 Sep 2021 00:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Su2JbNOBWAdugmlexGCP+EWgTV+hMrhBz8yWwCzAdmU=; b=UDmww1v6Ia17YC7Vfmv3jAYv1D
        sIdH4cCilgisYH/oqgE7ymsLI9vJu3UHH2L+tJ0VJObIGNLpQ5DUSfDltd7VzK2kcxw/5mhcbYlo0
        f0w8/dph7t8fBuSprOleEa0Ld6nbgvAPYDDRK6BkmiS1v1JWx7IyNeK16c9aPvf0zlafwS/OJJLXl
        LVoZRYxc0MkIUUylfQHREJ4OaXsiVyAm0H3K6eLZUB7L6PI5t0Hnt8cP3IMdsHTIoGI0OuzecVztB
        KRIO+CjejwavcEViChmDtxp9XTwrPZLUxryq0jwyQUkdCdZ3KnnVLYooNz53lkXI0hTd0SXvKhKC3
        FhaH9XMw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mR899-0000qX-Dr; Fri, 17 Sep 2021 07:19:28 +0000
Date:   Fri, 17 Sep 2021 08:18:55 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folio discussion recap
Message-ID: <YURBX6uBhsKYZAVP@infradead.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUIT2/xXwvZ4IErc@cmpxchg.org>
 <20210916025854.GE34899@magnolia>
 <YUN2vokEM8wgASk8@cmpxchg.org>
 <20210917052440.GJ1756565@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917052440.GJ1756565@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 17, 2021 at 03:24:40PM +1000, Dave Chinner wrote:
> Folios are not perfect, but they are here and they solve many issues
> we need solved. We're never going to have a perfect solution that
> everyone agrees with, so the real question is "are folios good
> enough?". To me the answer is a resounding yes.

Besides agreeing to all what you said, the other important part is:
even if we were to eventually go with Johannes grand plans (which I
disagree with in many apects), what is the harm in doing folios now?

Despite all the fuzz, the pending folio PR does nothing but add type
safety to compound pages.  Which is something we badly need, no matter
what kind of other caching grand plans people have.
