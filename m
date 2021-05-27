Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79629392964
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 10:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbhE0IWD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 04:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbhE0IWB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 04:22:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0585CC061574;
        Thu, 27 May 2021 01:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g49sK0BaWO1ncZGcxG01VvzKJZgdLBdmNCuIE34Ov5g=; b=DtdTeZ+pckjlf8fAisbFEbNNno
        h7l5vQCH38rZ13QRrYXGddBmR+fHXScVzLgE4C2PhfZU9pQ7stDQN5O0luHUba9UIYekGYjoe4B8U
        XcBITWAa23uqAC+QQGgWFbrkgSeEcwEQ6dR9htF8RTangpxR+z1XwTYvAub7LaWKkGKi8ZB0DO6Zs
        wVY6xuaTBzNjjjxoqZf2j2pQpZcGQnu9sBnWuLQTeaRz57a57y97IDMHWwErtBvQEhcS45F0W/MvV
        y5if6Qr1sRji/4ib1oRK4MJ2LI8FH/EYnLtG3+2BsyJLNor19X0eE80ZZnPaQGwBKV6VFTG5deXFT
        HJ72TUWg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lmBFH-005KEM-TH; Thu, 27 May 2021 08:20:00 +0000
Date:   Thu, 27 May 2021 09:19:59 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 24/33] mm/swap: Add folio_rotate_reclaimable
Message-ID: <YK9WL233cSDFXohV@infradead.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-25-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511214735.1836149-25-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 11, 2021 at 10:47:26PM +0100, Matthew Wilcox (Oracle) wrote:
> Move the declaration into mm/internal.h and rename
> rotate_reclaimable_page() to folio_rotate_reclaimable().  This eliminates
> all five of the calls to compound_head() in this function, saving 75 bytes
> at the cost of adding 14 bytes to its one caller, end_page_writeback().
> Net 61 bytes savings.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

