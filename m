Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3063B44281E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 08:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhKBHUl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 03:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhKBHUj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:20:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70A7C061714;
        Tue,  2 Nov 2021 00:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Zi6VnL+0EM+4yp3q0IkIEP2KovAoGu2LYvkYPHRMqtM=; b=FMtrkv0CRp6kiioQFvf1gjYFio
        vDFWlXkT8YQmdKeR0eJhlHPh/Kz30DdicSA/4CH3lCJO+y9KD7rDUeGdTCV9Q1SfNSPio8DqU1sbA
        3FIjS9iMeH30hYcOTQBBskwnLN+Z6f1EXO+/oQJMm3kIbkAFZ3MsFTWy/pnsHtDKXpXEQR5LNFZNH
        N/ciJ41ko9Z3w/mTRdFzIUwMlkINdF5yIXkHJCu3sifl2q3AB5/PKIBcwbrYE7rlTUQMmCCcIxuPj
        bTUQJI+kwWTiU6ZUZnj8fbhd2ve7nTkfkFcloXWjrAVyESSeTKxlKwqpcrG93LLUlSejtckpRks6k
        ZiCPx8/A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mho3X-000kmU-Rm; Tue, 02 Nov 2021 07:18:03 +0000
Date:   Tue, 2 Nov 2021 00:18:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 11/21] iomap: Use folio offsets instead of page offsets
Message-ID: <YYDmKxDjf3UKk0mU@infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-12-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101203929.954622-12-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 01, 2021 at 08:39:19PM +0000, Matthew Wilcox (Oracle) wrote:
> Pass a folio around instead of the page, and make sure the offset
> is relative to the start of the folio instead of the start of a page.
> Also use size_t for offset & length to make it clear that these are byte
> counts, and to support >2GB folios in the future.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
