Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF67355651
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 16:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345010AbhDFOSe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 10:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbhDFOSb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 10:18:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15355C06174A;
        Tue,  6 Apr 2021 07:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J9Nv9IOG0QNz+4Jv7FRoXmiGuQ+az6VOieXESJEb6Gc=; b=lpA0f+RC9KFdg7gwzg1NeRmt4f
        NnjKmrT1rw6REyi1y2TOVazUZMB3s4wewOQaNexk0AhghRi81bkJtxKAf6b6GxRuD+GCuz6FgvK0u
        qEAJIzza+WRux4qaboZz73duL8MJVcPZQzSx8EICv+6Dx53o8E++9kFK5O9kGv5DpJfhHZWYYNq5U
        kTQpg48evIogBV+Ni1KMzz/sDUkbb5v/zYLMQqh79BOVHX+O9HnSf5qH8xLIlvzk/+9Ax8Nhx1+eX
        qi23hl2F2Rl6OurK4Vy1eba8MPSbuJZtrhrFbg6/BP3B4XpMtwm05WKslP8syIqssjCSkg11vCJih
        cOCzsFBg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTmUT-00Cv9U-5L; Tue, 06 Apr 2021 14:16:05 +0000
Date:   Tue, 6 Apr 2021 15:15:37 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 23/27] mm/writeback: Add wait_on_folio_writeback
Message-ID: <20210406141537.GV3062550@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210331184728.1188084-24-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331184728.1188084-24-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 07:47:24PM +0100, Matthew Wilcox (Oracle) wrote:
> wait_on_page_writeback_killable() only has one caller, so convert it to
> call wait_on_folio_writeback_killable().  For the wait_on_page_writeback()
> callers, add a compatibility wrapper around wait_on_folio_writeback().
> 
> Turning PageWriteback() into FolioWriteback() eliminates a call to
> compound_head() which saves 8 bytes and 15 bytes in the two functions.
> That is more than offset by adding the wait_on_page_writeback
> compatibility wrapper for a net increase in text of 15 bytes.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
