Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C949F3B17A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 12:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhFWKDh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 06:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbhFWKDg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 06:03:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE9DC061574;
        Wed, 23 Jun 2021 03:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2v4uEP++5JJGh/Cecuuj25n5lvEBDUCx9ktcIuPvk0U=; b=DnusiPtDjy8hMd3/kYn5N6DqdJ
        UpnxrBHQ1VphAoh7HBINUYvyfCVU+UL9Avda7gid1jlkH3CXXOO8BnWbLCYYB3l6l4tKvFRzcvGDw
        CK8F7boaYvMyBBAkK7bqO6D9/sZvPQ7TgL0nHw2y12TQF44LmoAEBBEwIT8BsjOiZ6xCeuDGPc1Oz
        IPZCKSV6OgOWRpUpNSjLJ5tqaTrknFom9J0n7fTKE46WzK7bL+EHoREVbRsx1cWMQ7py9vSI+wn4R
        UQE3NxuigzCWKhS3OKvDoILpQSx73AuY4s+JnyfK1B6UNxGlC1Z7Tkdy9wE56UuXow5TmRhILIfMf
        +LGQv8vQ==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvzex-00FI7C-EP; Wed, 23 Jun 2021 09:59:24 +0000
Date:   Wed, 23 Jun 2021 11:59:02 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 42/46] mm/filemap: Add filemap_alloc_folio
Message-ID: <YNMF5hJz6ICx3dcu@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-43-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-43-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 01:15:47PM +0100, Matthew Wilcox (Oracle) wrote:
> Reimplement __page_cache_alloc as a wrapper around filemap_alloc_folio
> to allow filesystems to be converted at our leisure.  Increases
> kernel text size by 133 bytes, mostly in cachefiles_read_backing_file().
> pagecache_get_page() shrinks by 32 bytes, though.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
