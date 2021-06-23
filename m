Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E7B3B1755
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 11:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhFWJ7e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 05:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhFWJ7e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 05:59:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35D5C061574;
        Wed, 23 Jun 2021 02:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bIbRJjhhKfu75t8tDhgINmW7gh8eq/IMXLJ3rJlZnPs=; b=IdB68v6jCaq3FDfkoizQaDHqfv
        LGZhN7uEpyB2HXS00qB8VexZj3dCWoyZPvr+0cq5rHpk4EHqmrIzy5FwBPAcd3MVbFjVKQVhGuvE0
        i3stacSwsQQrsY8KHdBZcHbgLbTiUyQ9qtT6mcECRFaOeRNl8QsNTOr+2DWY3mJHd46ufrjzMdXCy
        qCHdgfZcxYUyo3e4ud9i/4uHLZO1EofcePXtlZLtS3FmRgC1Hew0Q3FwaYO0IFptlo2wNxZ/wVSfl
        3G9igwKZc8KWiclhSr2RE1P90NL9tX7fxHlXdPqvLa9sKO6NZMbR3coCMS9nRR8m7kMs76b3yDzXt
        eJX+ZsGA==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvzcQ-00FHuI-EM; Wed, 23 Jun 2021 09:56:35 +0000
Date:   Wed, 23 Jun 2021 11:56:25 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 40/46] mm/lru: Add folio_add_lru()
Message-ID: <YNMFSW1YIO/zsH7W@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-41-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-41-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 01:15:45PM +0100, Matthew Wilcox (Oracle) wrote:
> Reimplement lru_cache_add() as a wrapper around folio_add_lru().
> Saves 159 bytes of kernel text due to removing calls to compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
