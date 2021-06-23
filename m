Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992BA3B16BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 11:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhFWJXS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 05:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhFWJXR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 05:23:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5B8C061574;
        Wed, 23 Jun 2021 02:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MP6Lr2ugSjgt2W5qflvD/XdOl7j43g4NIrRBMnDIbmE=; b=NOG5S5QrLtOTIwuMNFl211SEoi
        xHAsheCHPTX5XSj+hYWOPDYjjenbo2uh+u40l3147rX22hvAV4wLSJ04bo4+JpKNyVghn36Ul2C33
        6wEUvVYOhLs2cy1kBhbcg88zIwIbMxoznBOco7SSxis5nnSQXoZN+PAUHDdzIrN9K16hJT86cSa4U
        D73LDUp0jkP5H8/F+IP004mhyMFLsTvAZZIQoMvKzfQEfHg9OkOlwLNExIDUYGs+CjXs0cEEj/n2u
        DS8A3hTL7rMP0DPPogxg7Qb95QKF5II5Wy5iRs9DrcS/5V92IEzCUqVaTkcnPKw5hGZLOCLfPVaEl
        X/kFqHOg==;
Received: from 089144193030.atnat0002.highway.a1.net ([89.144.193.30] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvz3Q-00FFsr-20; Wed, 23 Jun 2021 09:20:22 +0000
Date:   Wed, 23 Jun 2021 11:18:04 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 25/46] mm/writeback: Add folio_start_writeback()
Message-ID: <YNL8TGV2vgHcmmwX@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-26-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-26-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +static inline void set_page_writeback_keepwrite(struct page *page)
>  {
> +	folio_start_writeback_keepwrite(page_folio(page));
>  }
>  
> +static inline bool test_set_page_writeback(struct page *page)
>  {
> +	return set_page_writeback(page);
>  }

Shouldn't these be in folio-compat.c as well?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
