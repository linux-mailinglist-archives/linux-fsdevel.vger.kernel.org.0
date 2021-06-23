Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136793B1773
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 11:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhFWKBO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 06:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhFWKBM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 06:01:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64842C061574;
        Wed, 23 Jun 2021 02:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iH0tpXt8GJfX+4f0kNFBqSwnldGbSut7DrbyCImiM24=; b=rSen0Ki9x6jRV2vUrFJwY10Bs6
        h+RK02kZENkhklTfkRVFqZ5scaMyoZQJePFTC754jWSNjScqBbNf6V7FTt9FTv3CoS+5N05j3GP9t
        6MxuPaxWb0BGXqG49m1Sj/JrwFgRrVgTEnybs9MmZmMw90mxP+33Y+hhxjXgxG8Y9BwtSPK8r+XoV
        YlNPE3IMttoruC7jR+kCZQ648k8KJzBU+QqWxucyO0BosIojhfUyNSrYnO0MTNYSlqU+xz0Ol4FDC
        NHcKEKti0NMTxeOO/o6BE2Nl1Fk5HJIGrhvRB03oX5XFJ6RhUPUIIF+QDcTndJf2k2HbW9t2FwNto
        YipIJrDg==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvzdz-00FI2U-Lv; Wed, 23 Jun 2021 09:58:20 +0000
Date:   Wed, 23 Jun 2021 11:58:02 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 41/46] mm/page_alloc: Add folio allocation functions
Message-ID: <YNMFqhRS+GK2YK8h@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-42-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-42-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 01:15:46PM +0100, Matthew Wilcox (Oracle) wrote:
> +static inline
> +struct folio *__alloc_folio_node(gfp_t gfp, unsigned int order, int nid)

Weirdo prototype formatting.

Otherwise looks good (assuming we grow callers):

Reviewed-by: Christoph Hellwig <hch@lst.de>
