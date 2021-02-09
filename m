Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC1F3149B1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 08:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhBIHsi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 02:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhBIHsS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 02:48:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE1DC061786
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Feb 2021 23:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9+2wj3sFWXa7cItv7AOJKD/27fGB2jpqYG8mZfzfFGw=; b=a3cA45XmDA8UgKJ3H4roGYwqbd
        dLMdpG19eXEjBJeiSQn/H/k8GcKA+JrwA0K1T/+OngILSeqjk3eOwAI/xZOvp50ubF6RqVmd6KQnt
        MA/MPCamEiYrh02hI0Vj/1sYcaAFMd4PQarYTwgAQfyQHO2Kvo0EAbMTD0x+6SL1V0UHfDiXv9MJB
        lnnEJdXp0py6n4a4iJYXBFzOmWJhcERlcEowgft7sCIoLFZO1OPzrbYIbmf5YAMhAeOE0peh1WqCK
        No4BLN4Tq77NXTDw7TfJMX/jpp6j6QkGyXDjUh90rInsUX2BfZ8AlibHaDcobVAsP5wba9xvAHEeY
        DmRY0R0w==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l9Nk3-0077bt-AO; Tue, 09 Feb 2021 07:47:23 +0000
Date:   Tue, 9 Feb 2021 07:47:23 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        hch@infradead.org, akpm@linux-foundation.org
Subject: Re: [PATCH 1/3] mm: provide filemap_range_needs_writeback() helper
Message-ID: <20210209074723.GA1696555@infradead.org>
References: <20210209023008.76263-1-axboe@kernel.dk>
 <20210209023008.76263-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209023008.76263-2-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +extern bool filemap_range_needs_writeback(struct address_space *,
> +					  loff_t lstart, loff_t lend);

no need for the extern.
