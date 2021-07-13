Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823063C70DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 15:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbhGMNGY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 09:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236276AbhGMNGY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 09:06:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDFEC0613DD;
        Tue, 13 Jul 2021 06:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JYBnZ/UoKQnWGfv6A36EmkLu9KZZfuRPPECPY/WoAvE=; b=DDKMLNyhTcSdr3WYSYlxuLzqxW
        4Yya9zmjvw5wL//vjQbDFT69j15KyI4WG7KsyRB+X7hENue5GHGDhAFjpU+ePrPv1y3oUsqbW/YAj
        0IU7pF28y3B3DadQa3pBmlMt9GNdOjUQ+pebiGozRebKPogHKs43K1TW3LJvKZ27Qb7fQrivT+H1r
        sD/cwzv6e1fIOsqDnwVsgIsVrR1K6s/Cl4T9Bsmt5jdCLB1sPBTvVzp8Rel+rTsXpiP9WcKx+SBiX
        iJRpkTcj9jSbXIR5qiI6NZDqHxeWXLyvmaiZ15vbqqwrGw06QILwh8zKEoyyI9zDvA0Ddvolp4OAx
        DN67Lslg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3I40-0017Ni-PX; Tue, 13 Jul 2021 13:03:09 +0000
Date:   Tue, 13 Jul 2021 14:03:04 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v13 16/18] mm/memcg: Add folio_lruvec_lock() and similar
 functions
Message-ID: <YO2PCM9h8sFaHK14@infradead.org>
References: <20210712194551.91920-1-willy@infradead.org>
 <20210712194551.91920-17-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712194551.91920-17-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 12, 2021 at 08:45:49PM +0100, Matthew Wilcox (Oracle) wrote:
> These are the folio equivalents of lock_page_lruvec() and similar
> functions.  Also convert lruvec_memcg_debug() to take a folio.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
