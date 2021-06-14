Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872B03A66A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 14:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbhFNMfM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 08:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbhFNMfL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 08:35:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DCDC061574;
        Mon, 14 Jun 2021 05:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZZKvIEpsaGYUMFQ3fgpTkT5VsdH4goR4WcL96t1S438=; b=ORVU0RUBdzzZwfhSwmynH8ckhU
        rpBKtHq7boJ9Nileky+klBSkC8A6BeUJXRzslqfq6khT0wWC4mqzz+aZmUVfCD6lIytp1KmIPNex9
        Nc7iyDeoiQY5TzwTMydnzxSImGI6Xq2ghn1vXxJDPMk7avO2vVIx8jdH4U6+pRjzXlmpcTRfvhvG6
        LM4A85lnby3/xwY1LSuXpXGenWYd/6+2UdBJHfKMkLOCh5d/XB97Kx4I1y8/Q0CorvK513Obz2CLs
        Pawgn7oeabJGnzOzSonuhqvXdqLbySUAudKGBF2Z6SBV382kjUPkn2ZLvaq+G5jQBFTzkE4q3Xl+k
        nJd7c/vg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lslli-005Pl9-28; Mon, 14 Jun 2021 12:32:44 +0000
Date:   Mon, 14 Jun 2021 13:32:42 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] fs: unexport __set_page_dirty
Message-ID: <YMdMaqC0DP26h+Gq@casper.infradead.org>
References: <20210614061512.3966143-1-hch@lst.de>
 <20210614061512.3966143-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614061512.3966143-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 14, 2021 at 08:15:10AM +0200, Christoph Hellwig wrote:
> __set_page_dirty is only used by built-in code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

You might also want to do the equivalent of this:

https://git.infradead.org/users/willy/pagecache.git/commitdiff/19b3bf0d1a51f41ce5450fdd863969c3d32dfe12
