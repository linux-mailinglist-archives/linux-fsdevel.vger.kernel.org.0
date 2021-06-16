Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3173A9985
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 13:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhFPLtW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 07:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhFPLtV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:49:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CACC061574;
        Wed, 16 Jun 2021 04:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XKAzWUGzB8MUdY5I3dCv45r+X3GXY2rgI1Q9SvG74FI=; b=upFT3Y6EMsHxlmi8HV2E5LAwgX
        nkRtu+HCFllCgWrpxAQ/40RgHFLJ7pKGei7X3liHxzmSpww2SsxRHwgKKZHzTEv2gHDgoDbcg4ql0
        4fZUd+I5WFeqtFTWamn8kU7wz3GKEuV/LntgOWHdkAcgcVs/d41oLk1QPW8wCfTcZSHsohb9pCGz+
        fbK+9fxzCNgAnILc5CtAkY7Wfq/LcKGt+/fdZf4rTyDtj32p3XlSVHRjVUgkwxrFRDPGsErNrKJcE
        eKL9bjt6pftr3wZ8nciCgwDA1r//vmO/TUx7HBcB84Xumq1eLmKO8HcwGSFu0/KR6WlmnKJ4kk2do
        YYDvECQQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltU0S-007zXc-La; Wed, 16 Jun 2021 11:47:00 +0000
Date:   Wed, 16 Jun 2021 12:46:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v11 24/33] mm/swap: Add folio_rotate_reclaimable()
Message-ID: <YMnkrOahSVOUCjRd@casper.infradead.org>
References: <20210614201435.1379188-25-willy@infradead.org>
 <20210614201435.1379188-1-willy@infradead.org>
 <815662.1623839222@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <815662.1623839222@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 16, 2021 at 11:27:02AM +0100, David Howells wrote:
> Matthew Wilcox (Oracle) <willy@infradead.org> wrote:
> 
> > +	    !folio_unevictable(folio) && folio_lru(folio)) {
> 
> Hmmm...  Would folio_lru() be better named folio_on_lru()?  folio_lru() sounds
> like it returns the folio's LRU.

That's folio_lru_list().  It's just that we have a bad habit of saying
"the lru" instead of "the lru list".
