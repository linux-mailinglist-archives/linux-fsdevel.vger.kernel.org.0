Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3188F3555AE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 15:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344734AbhDFNt5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 09:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344723AbhDFNt4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:49:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D55EC06174A;
        Tue,  6 Apr 2021 06:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/0tyEUyGTkdIV/FVI1c6IIm5ijvOB5mIuhQU5x2R3uw=; b=oOcuFDU425YtZcSW2RxHA6vgNL
        KFgmHgXjwCUZLpMnb0Fw4gmjuE19l4hYXWF4dUMJ1enUNR1J40G3NW3+zfCCV+EmtHpVUx2rUKspP
        rg/q9DhO8zBROiLqszSUdU0zptIjzuLukpaMwjhkKPL3j0JXgTzQr1goqNcvJTeDUraSJ64CJA1I1
        6Xqhc2W7wpwoLJvDoMDgVBCQvL8kP2ZqPs6TVFP+EP5bnXc6WSzqycBzMIXhg5fttqV4nWD24lU/a
        ekPJ+T6gLDD4agBaFjnYkw1+5To7ndIwtDr87b/ZuUPwEyw/OOOyEt089xWe5lqXMj4TXy5lmUHB7
        RjrS7IdQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTm4E-00Ct1q-3h; Tue, 06 Apr 2021 13:48:50 +0000
Date:   Tue, 6 Apr 2021 14:48:30 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 15/27] mm/memcg: Add folio wrappers for various
 functions
Message-ID: <20210406134830.GN3062550@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210331184728.1188084-16-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331184728.1188084-16-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 07:47:16PM +0100, Matthew Wilcox (Oracle) wrote:
> Add new wrapper functions folio_memcg(), lock_folio_memcg(),
> unlock_folio_memcg(), mem_cgroup_folio_lruvec() and
> count_memcg_folio_event()

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
