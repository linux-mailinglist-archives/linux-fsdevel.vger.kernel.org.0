Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645F13555BE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 15:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244278AbhDFNwQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 09:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238092AbhDFNwP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:52:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD24C06174A;
        Tue,  6 Apr 2021 06:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C0e14bdzzRZjl9cTeHAyigRgLdXDB1e3NIgfQJX8fhY=; b=rjVNJKMy9pMQw8UHJfmIxMhuOl
        QvwaBh/30Oc3OFFG92XSQUXTVrAdZiwHrvvLc/gCxBai8Ck+nkHMEtHRoepXhcm5t98NmAt1bESpE
        AY/90c5YsyLnmIqfxLABOMgV1U20+rAxT8SCJScJNnusrertCC6mIOjvLyhuVMAU/97j1W8BGD+uR
        /MsCbnoU7umXrVlfAcHf0n92RRSerPUhL84XgCnRLRUieWtbHSu6wN+95+WcIeN0TNo716CE0Mh9A
        vKDY4nOUDBNKL7/vkCD257zokFaRGDhN2z8LueXKAZtCqGaqNJ25jgEahB8upRa+ZDN1wvPlmbvJx
        q5CTYa5Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTm6z-00CtEQ-Ds; Tue, 06 Apr 2021 13:51:30 +0000
Date:   Tue, 6 Apr 2021 14:51:21 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 16/27] mm/filemap: Add unlock_folio
Message-ID: <20210406135121.GO3062550@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210331184728.1188084-17-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331184728.1188084-17-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 07:47:17PM +0100, Matthew Wilcox (Oracle) wrote:
> Convert unlock_page() to call unlock_folio().  By using a folio we
> avoid a call to compound_head().  This shortens the function from 39
> bytes to 25 and removes 4 instructions on x86-64.  Because we still
> have unlock_page(), it's a net increase of 24 bytes of text for the
> kernel as a whole, but any path that uses unlock_folio() will execute
> 4 fewer instructions.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
