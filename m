Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A5C2889E5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 15:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731486AbgJINgF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 09:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgJINgF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 09:36:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2648CC0613D2;
        Fri,  9 Oct 2020 06:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4zcQLlvX1W3uQckN8sC5yZKmOZfSHdP1zxo1/ieXfYI=; b=e0ZExvcWDCTTDKroRSJi2pyYbV
        aGIhraqXzk3rhWNFeLzu3lbatZ0I9lyPnOjUuPuPnEyvB1r2Gu9o/8T2YQGkpP4cJLVuKEQvHiSvz
        15PIRSHfe3AO+Q7Lpo0Rl4bWzU9HtIJFp2MSL/eLHupMOj8R9NMIqDy74chMk3q6R7Trc5Wv3azK+
        l17DFsiZnnC0sYNExKFsS8ddMIOJ7csZKwP4wGq+fhyqIvtl/RVLwZTn2LaEwR1OMu5lOwtRbcGsq
        DdvKeY9gX/tcWNmVHktSo2z5yqsA4uHA10dZTXDvXLK1S7xkfSJHyJReuGjQyGpW55HeP87yT6HPF
        5JE7eQPQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQsYu-0002eg-9k; Fri, 09 Oct 2020 13:35:56 +0000
Date:   Fri, 9 Oct 2020 14:35:56 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com,
        mhocko@kernel.org, akpm@linux-foundation.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v8 2/2] xfs: avoid transaction reservation recursion
Message-ID: <20201009133556.GT20115@casper.infradead.org>
References: <20201009125127.37435-1-laoar.shao@gmail.com>
 <20201009125127.37435-3-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009125127.37435-3-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 09, 2020 at 08:51:27PM +0800, Yafang Shao wrote:
> PF_FSTRANS which is used to avoid transaction reservation recursion, is
> dropped since commit 9070733b4efa ("xfs: abstract PF_FSTRANS to
> PF_MEMALLOC_NOFS") and commit 7dea19f9ee63 ("mm: introduce
> memalloc_nofs_{save,restore} API") and replaced by PF_MEMALLOC_NOFS which
> means to avoid filesystem reclaim recursion. That change is subtle.
> Let's take the exmple of the check of WARN_ON_ONCE(current->flags &
> PF_MEMALLOC_NOFS)) to explain why this abstraction from PF_FSTRANS to
> PF_MEMALLOC_NOFS is not proper.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
