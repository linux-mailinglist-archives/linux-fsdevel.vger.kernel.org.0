Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579753B171D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 11:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhFWJqZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 05:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhFWJqZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 05:46:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DECC061574;
        Wed, 23 Jun 2021 02:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7C0d0QSOIJgNPkF7EDaDfgv7IzlLb87TH4wXPlcx5ZE=; b=WTDIITegJkeMG6KLoyHK9Jtv2H
        zSsbg2Sm/WhsxcgkppxahEnW1BazGpNCW5gJ0gGPzjWBqOh6Ckz7Jj5zLb1IowDnVcGQdnOW79EN+
        UxcF/YPZxBstv1Wgbn6W6RPWxfQ6PbmQNRQ2iSnJjp4AHO596qitCfGqEgXpKfxaU05urAVomY/rv
        +mr9KpVhrMCeQO/gQr9tEXHX06ISPYoSbB1atdcPraKDAOzHyTz24o6te8XcnMwv6ZhToh0KHJ6Te
        5+Z/fj0Z7U9ASIUvXPlplToXvntd50CNLY8h7GpYUNm0pbmntNY7vJX40D07Dj+DMZ7YOYkD3Almo
        B2AMjHKQ==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvzPn-00FHFB-4E; Wed, 23 Jun 2021 09:43:39 +0000
Date:   Wed, 23 Jun 2021 11:43:20 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 31/46] mm/writeback: Add folio_clear_dirty_for_io()
Message-ID: <YNMCOE0C6f8Nfvl6@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-32-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-32-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 01:15:36PM +0100, Matthew Wilcox (Oracle) wrote:
> Transform clear_page_dirty_for_io() into folio_clear_dirty_for_io()
> and add a compatibility wrapper.  Also move the declaration to pagemap.h
> as this is page cache functionality that doesn't need to be used by the
> rest of the kernel.
> 
> Increases the size of the kernel by 79 bytes.  While we remove a few
> calls to compound_head(), we add a call to folio_nr_pages() to get the
> stats correct.

... for the eventual support of multi-page folios.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
