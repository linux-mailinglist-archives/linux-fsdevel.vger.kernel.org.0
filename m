Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A493CF4F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 08:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241731AbhGTGSy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 02:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243070AbhGTGRo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 02:17:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61437C061574;
        Mon, 19 Jul 2021 23:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hkCeS3d3DzM6X5it85/II9q/xV8Q+YyicN3JK3AIkcY=; b=ON9/BWXulkxGtghSvHPjG41NJ3
        m+7vnF8DfFO0VTYvtCShHZrh1LEQQ0X+p9w2z6oIaDtBDzV3vbHm957uxwR5ZE+lr78hUE2Q9DhwF
        xDjmcG7BHs2ui7Vfi1qvmKH8aDGcSQt265VjsSgdO6QFk9bhAF4GUHlKb3jV9p5b2s+nIIgg2VPsQ
        otbfp/r08dupe4SsjI+FU4U8TCUoGQTWkyOEPoF0MMScouxbQqeFkbi8qVO/ABvFmqDe1wOjAVpo/
        1U8B7/L9V2cNUF2KfHHPbIbiNbQ7m4fQeIb1fiFpX3++7ICSHBWTvGgnH+zFKtALxa7UJ49iJG7rG
        TLY/JIUg==;
Received: from [2001:4bb8:193:7660:5612:5e3c:ba3d:2b3c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5jgh-007qaT-7d; Tue, 20 Jul 2021 06:57:22 +0000
Date:   Tue, 20 Jul 2021 08:57:06 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v15 08/17] iomap: Pass the iomap_page into
 iomap_set_range_uptodate
Message-ID: <YPZzwkcNP0NQEv6+@infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-9-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719184001.1750630-9-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 07:39:52PM +0100, Matthew Wilcox (Oracle) wrote:
> All but one caller already has the iomap_page, and we can avoid getting
> it again.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

In general reloading it from a single pointer should be faster than
passing an extra argument.  What is the rationale here?
