Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9633C70D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 14:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbhGMNCD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 09:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236449AbhGMNCD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 09:02:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EACBC0613DD;
        Tue, 13 Jul 2021 05:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nxAcv2j1eAtOyeVEwqJKCH7cpe8F3sW32yQHnBEh9S4=; b=QkBF61eScUV83eb84+fw9LH+bo
        wKTnfiTE+sBzDtQuu1H2K1Upyhml0uDAF1BKl3UtqFJ7MkmXYvsb/t8RUGr0vECqYehntmBz9UxaI
        D3wD5dq9cAxSddL3oL5uPTxT9ooO/pWuBqrSEix+5ZK54NegPLgZumBqy0Y4AKsXPTWqxiH2AOr1L
        PV5nF44rz3TL2LRn12PEV3iyiwzptKFeHTnt4XUyRvKHr7fGX+CY//z782ahhpsgfNBplMaze5TDY
        6BgBF29dwQRgDaP7UXzqztkzcEth2Gds4Ufo93Jtw7KcVzzXzPBkAOFo9GXIQBII9daCKCNTJ1Vwj
        7d/rmoyQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3Hzz-0017Av-0a; Tue, 13 Jul 2021 12:59:00 +0000
Date:   Tue, 13 Jul 2021 13:58:55 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v13 13/18] mm/memcg: Add folio_memcg_lock() and
 folio_memcg_unlock()
Message-ID: <YO2OD5SdBnzec0no@infradead.org>
References: <20210712194551.91920-1-willy@infradead.org>
 <20210712194551.91920-14-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712194551.91920-14-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 12, 2021 at 08:45:46PM +0100, Matthew Wilcox (Oracle) wrote:
> These are the folio equivalents of lock_page_memcg() and
> unlock_page_memcg().
> 
> lock_page_memcg() and unlock_page_memcg() have too many callers to be
> easily replaced in a single patch, so reimplement them as wrappers for
> now to be cleaned up later when enough callers have been converted to
> use folios.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
