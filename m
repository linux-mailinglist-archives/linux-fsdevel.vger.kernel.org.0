Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B9033F6B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 18:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhCQRX6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 13:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhCQRXb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 13:23:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AB3C06174A;
        Wed, 17 Mar 2021 10:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VjkGq4o46IxCddXbjgtdiOkMjQXv081kHe8HpX/+37w=; b=HJm1s168ZeLvCNM3qnX/wxZG8s
        43QF+GVdGN0kE+jnx2c2YOIPhv45wW1TvVJgoURgFHfqeMQNw76wq5X4ZozcldmEOgD33lKSijtvq
        tivBwk8FGh42lXlvePWyX7rU1szy8DFUEbwr1TybVTtgym8Tanz1RCWu+RBpTma368SrSyNuNRUrB
        rseV7pQGseXOazr77yDUHyk/at1/gkNX3AswAzIr+YO5SumGy2WZ2itocLpmJdp4lpm5HbNQoY1l2
        6J+c4QZBNNeVCedTleRbFUokI3fcd4vjujT4iNyVljRhZsm8mCsIKRFWGNnsAB2ZTfMz+qT5uYUD3
        4io5ZVzQ==;
Received: from [2001:4bb8:18c:bb3:e3eb:4a4b:ba2f:224b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMZsX-001uHN-Og; Wed, 17 Mar 2021 17:22:52 +0000
Date:   Wed, 17 Mar 2021 18:22:40 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 09/25] mm: Add folio_index, folio_page and
 folio_contains
Message-ID: <YFI64JKvt27bc2kh@infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
 <20210305041901.2396498-10-willy@infradead.org>
 <20210313123716.a4f9403e9f6ebbd719dac2a8@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210313123716.a4f9403e9f6ebbd719dac2a8@linux-foundation.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 13, 2021 at 12:37:16PM -0800, Andrew Morton wrote:
> On Fri,  5 Mar 2021 04:18:45 +0000 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> 
> > folio_index() is the equivalent of page_index() for folios.  folio_page()
> > finds the page in a folio for a page cache index.  folio_contains()
> > tells you whether a folio contains a particular page cache index.
> > 
> 
> copy-paste changelog into each function's covering comment?

Yes, I think documenting all these helpers would be very useful.  The
lack of good commens on some of the page related existing helpers has
driven me insane sometimes.
