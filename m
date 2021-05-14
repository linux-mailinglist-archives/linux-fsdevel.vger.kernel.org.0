Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BBB380BBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 16:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhENO04 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 10:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbhENO0z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 10:26:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F4EC061574;
        Fri, 14 May 2021 07:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BbcGrR529XTR3me89zOS66XctwsLFXUqyNVxsijFVkA=; b=FXPIqBrVRdxBveCAtq5gzhNS7K
        +FET6VNdNKzgbUGdOJ4e/myYq/uROyc1j1AXL0peur5NgF+nRGnku3KSgkNkN0UVNpWSpMnNYAxEu
        Sp5oEo4L+LowPkd2orBdknBGHQg4AfW5ddsqdeXMFIANC5iRTDt3gelgvnBZFvEeDAGbFt2hWpjZq
        xk86PMqAKQB+L60Ve2GTJUIdCVR/KdASMa1ZZeDOfuL1fSx4MlXjhycD0hxzavWQmRSj0eOdvNirW
        O8WDyoJt5ewuHKSyFjJIo9+B+FQdoIIv2vqtEAZcEvUrQTH0ft3WE2U+Ld6NP+tIyrTBWj+odZ94Q
        zimReI3A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lhYjq-00ARDU-Nf; Fri, 14 May 2021 14:25:01 +0000
Date:   Fri, 14 May 2021 15:24:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v10 07/33] mm: Add folio_get
Message-ID: <YJ6IGgToV1wSv1gg@casper.infradead.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-8-willy@infradead.org>
 <88a265ab-9ecd-18b7-c150-517a5c2e5041@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88a265ab-9ecd-18b7-c150-517a5c2e5041@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 14, 2021 at 01:56:46PM +0200, Vlastimil Babka wrote:
> Nitpick: function names in subject should IMHO also end with (). But not a
> reason for resend all patches that don't...

Hm, I thought it was preferred to not do that.  I can fix it
easily enough when I go through and add the R-b.

