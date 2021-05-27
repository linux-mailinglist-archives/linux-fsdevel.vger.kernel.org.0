Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABE139297B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 10:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbhE0IZq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 04:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbhE0IZq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 04:25:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA616C061574;
        Thu, 27 May 2021 01:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E1xzz5XBeK0+jmx6JpZ8HhcM7SbFDuyJ66vXDC0KF7M=; b=Uj4Kq1zZ5pDNLxl6PM+aQoy95h
        8gqeAfIHKEStURdKJcD5atHDTQu9KEgbzzv48pJhgcH91E29vOHHXaRWtWkyRNzPMvKa144vjf/QG
        7lL6Yi++t2fP2WPuKwSHHUup6VKFU8UaJZV4XEsbisML5LeGfvyLRpdntKyQaqhMB0aW77GDFqLGe
        7qgAeIomyX3su2CX0cwRAsLXpxGvnHDdRwV2XkFVph8t0JIh8QtSCoADRxQwGj8KOmCFCdLkO+Edd
        w+18jW7n2WMzmXSV9rMeAkHKHp6J1utY6QjpcUhLEfhwmK2852O3IBRZMEqs5pUArksh8YKyp4ioC
        aq0fl8Qw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lmBJ5-005KY4-37; Thu, 27 May 2021 08:23:57 +0000
Date:   Thu, 27 May 2021 09:23:55 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 32/33] fs/netfs: Add folio fscache functions
Message-ID: <YK9XG3Xdensn4YeR@infradead.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-33-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511214735.1836149-33-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 11, 2021 at 10:47:34PM +0100, Matthew Wilcox (Oracle) wrote:
> Match the page writeback functions by adding
> folio_start_fscache(), folio_end_fscache(), folio_wait_fscache() and
> folio_wait_fscache_killable().  Also rewrite the kernel-doc to describe
> when to use the function rather than what the function does, and include
> the kernel-doc in the appropriate rst file.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks fine, but doesn't actually seem to be needed for this series.
I'd move it closer to actual users of the new helpers.

Otherwise:

Reviewed-by: Christoph Hellwig <hch@lst.de>
