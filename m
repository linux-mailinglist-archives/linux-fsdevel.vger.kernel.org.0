Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B533B1901
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 13:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhFWLeA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 07:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbhFWLeA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 07:34:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1169CC061756;
        Wed, 23 Jun 2021 04:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nr51oxoXOse8+0HctYzGgI91ZnJJczBmgfx3fw83CwY=; b=U9piStg8JkBL5HYU3anvGC5AxX
        +MAK7WmSIDRkJv9p/7UV4vy/U4HFxkjSKjdC65dgCtGadzw7HDOMCgc/TsC526zBlwQ8jVFU3mWTF
        SK+5VaONZkuWHA9aqZlJ0/pTIUKMXxNgJ85JoIZuHRim/6j4oQGLX4Mcrr4IRbocblAuI2s8X4JDf
        UR56jcU7AvQK8K1XXjW7vSu3gnFBwp6pH5DOlATd4bGwzdPGMtqVZLA93bB0zWhjmuo7KvCPxkUK1
        3GZwohCBrkR5yv/HoC7Vta7FKeeHF1Vt3h3D3SRVPTuwXIl/bbS0ICwWHiQznUYUvlMq+isJLlB/4
        y2n2w7kw==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lw154-00FMfW-NV; Wed, 23 Jun 2021 11:30:17 +0000
Date:   Wed, 23 Jun 2021 13:30:04 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 43/46] mm/filemap: Add filemap_add_folio
Message-ID: <YNMbPBIngFe2VOzc@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-44-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-44-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 01:15:48PM +0100, Matthew Wilcox (Oracle) wrote:
> Pages being added to the page cache should already be folios, so
> just cast the page to a folio in the add_to_page_cache_lru() wrapper.
> Saves 96 bytes of text.

modulo the casting:

Reviewed-by: Christoph Hellwig <hch@lst.de>
