Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE1C3B3794
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 22:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbhFXUMC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 16:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbhFXUMB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 16:12:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2EBC061574;
        Thu, 24 Jun 2021 13:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TslytEABRAuGLwApOpB2eV0hV6tM9WN7rQO1mwwAm9Q=; b=VnuZe33ZCG6YtDDCyvIW38X5hK
        SA8usqSLWqIuP4suL8eBPp7llFhujIG+ExUb1xRWBhvH0dYWCtKVwHzRo82/DRZHoQirtqpjwr2XX
        CTBP4XE77K4V9+MVCLVbLETVyb5RgL4D1Lep2BK2dZHFOLQViSMJcPMgJlR7gc0Modq2Ik8UUca4J
        qtlP02qsK08DKGd2qoMgLv0nrVpAwptaNcvQm4sBT0Dvo+fNGvhaYP/AnB6m/YbUA3GbMXGAdC2dS
        erKQ8K1RhmF9MZGOK9pBJ6W7CbNK70VNwa7maqEDCZieRQHvIBDH0cnqfiWCfzlDgAWZqJKKQqnV2
        8ngaGEPQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwVf8-00Gx5E-4j; Thu, 24 Jun 2021 20:09:27 +0000
Date:   Thu, 24 Jun 2021 21:09:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 31/46] mm/writeback: Add folio_clear_dirty_for_io()
Message-ID: <YNTmcnc5iV12re0L@casper.infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-32-willy@infradead.org>
 <YNMCOE0C6f8Nfvl6@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNMCOE0C6f8Nfvl6@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 11:43:20AM +0200, Christoph Hellwig wrote:
> On Tue, Jun 22, 2021 at 01:15:36PM +0100, Matthew Wilcox (Oracle) wrote:
> > Transform clear_page_dirty_for_io() into folio_clear_dirty_for_io()
> > and add a compatibility wrapper.  Also move the declaration to pagemap.h
> > as this is page cache functionality that doesn't need to be used by the
> > rest of the kernel.
> > 
> > Increases the size of the kernel by 79 bytes.  While we remove a few
> > calls to compound_head(), we add a call to folio_nr_pages() to get the
> > stats correct.
> 
> ... for the eventual support of multi-page folios.

Added.
