Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5D747DF82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 08:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346763AbhLWHXI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 02:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346746AbhLWHXI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:23:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE86DC061401
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Dec 2021 23:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/ItJOoIw7Ux1Rxd8oimz02WNG2LrwsYeAFnEtw93uJY=; b=ja/QAMr1gnzwN4Ib01ShPsQXKk
        jMILeizYKUSAChqgtaCot3ogXoJrO7g3+wwy8g/M8rZ/HDVBrcuQGXuk0LgAvA2pY73rfyiMcGpVF
        afv1UexXKnIbqmM21iNnZiAa17lnOH9eAxN7Cpo9S9fd5mUNVegijZl7LHvIju+0hplC/xAA5ETYf
        psW9372fFlHLM5B8oC+KvXoelZ9MBHE43p34lrMICRzf2q2/4gnZYKams54NKKoDLgd/5g5aGi5e9
        9Wod7+SgwAu6GNVLxnBZuRXPODYsMrLskwTmPODUlx4BmwPVzoWNkMPWUt+pmOkwQx0GNnKoZrEPf
        hlX+zt1g==;
Received: from 089144208226.atnat0017.highway.a1.net ([89.144.208.226] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0IRL-00BxuQ-3b; Thu, 23 Dec 2021 07:23:07 +0000
Date:   Thu, 23 Dec 2021 08:19:58 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 22/48] readahead: Convert page_cache_ra_unbounded to
 folios
Message-ID: <YcQjHhrFWDUFE4vu@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-23-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-23-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:30AM +0000, Matthew Wilcox (Oracle) wrote:
> This saves 99 bytes of kernel text.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
