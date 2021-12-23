Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF55147DF4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 08:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346712AbhLWHGT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 02:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhLWHGT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:06:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308C0C061401
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Dec 2021 23:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y/84oVzGF2KOypSOX9kOAvd+hGM27YO+mLJgT3OpLkU=; b=AW5FNcBGNoQEpSKviEPI/uAauf
        BQJbbiQiIMkA9Y+ovp6US6EX4WITBHXsNxbIR3ixa79GX4RykbJI62bEJnye8/HOiS6wVaVnpWTMm
        3ddqjLii+ZObFUcb4t/ZYrVL7MaxPEPBC1GWP6HdFEGh8409qUMxYEy4OD4r1dHVN1IRJBqISB94L
        rWLrOYANmOXfzUI0hH0YEtx1BVzoMMlqUCcvXCg92/nRKN7HkYyt6FKfQEBLxmeJ31IJtPW8nAQgn
        JlgRAKjjRRx/OpxHvPhqS1gPdPwZBlHIHpEFhT1LsBjW4noNdoqJmW3OU8laQWMSLNbSRLIyyV3m9
        YfSMAsdA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0IB8-00BxHf-QC; Thu, 23 Dec 2021 07:06:18 +0000
Date:   Wed, 22 Dec 2021 23:06:18 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 13/48] filemap: Add filemap_remove_folio and
 __filemap_remove_folio
Message-ID: <YcQf6oSjNTC0LGu9@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-14-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-14-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:21AM +0000, Matthew Wilcox (Oracle) wrote:
> Reimplement __delete_from_page_cache() as a wrapper around
> __filemap_remove_folio() and delete_from_page_cache() as a wrapper
> around filemap_remove_folio().  Remove the EXPORT_SYMBOL as
> delete_from_page_cache() was not used by any in-tree modules.
> Convert page_cache_free_page() into filemap_free_folio().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
