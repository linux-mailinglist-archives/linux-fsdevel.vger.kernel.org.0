Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C940443746
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 21:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhKBU2Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 16:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhKBU2P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 16:28:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C69C061714;
        Tue,  2 Nov 2021 13:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TwAdYSvQMjSkM+QbGzkxmC3xOEssRxXLA7w8gBqLwCI=; b=vtz5jC+fhEx+jAidmWR9mVihx5
        yawM+y2UNbGb3c++cN8NYK0a2SYFvhxdlPKHSktgkHLXJMx+6yM9KNwt2ZUyE8tdpJgYvM8lhxvbO
        Kv4Ft+9JCt279hDjGVezQKrMuDt50XkWhW5cwe+mFb/4vFNE66FGYE11XhNLJSLDGhK1SqrZeJSvn
        CLMHAloBtDWwd1Pa3DYPfngGgG9OHPk0KQfloEAnmV0Kk3niyBu+cVI5+RYooBok6vktETzZ4/mRW
        ATcmnTYSK6FEBMlPWTur/WvoRYf+1CxTJKVFgSDYTCAPQBVrWhM1t8F4Ldy5ehYz/Ls4t96yAuopn
        5kMeFWOA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mi0KM-004kCi-0z; Tue, 02 Nov 2021 20:24:30 +0000
Date:   Tue, 2 Nov 2021 20:24:14 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 03/21] block: Add bio_for_each_folio_all()
Message-ID: <YYGebqvswvJBdxuc@casper.infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-4-willy@infradead.org>
 <YYDlEmcpkTrph5HI@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYDlEmcpkTrph5HI@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 02, 2021 at 12:13:22AM -0700, Christoph Hellwig wrote:
> On Mon, Nov 01, 2021 at 08:39:11PM +0000, Matthew Wilcox (Oracle) wrote:
> > +static inline
> > +void bio_first_folio(struct folio_iter *fi, struct bio *bio, int i)
> 
> Please fix the weird prototype formatting here.

I dunno, it looks weirder this way:

-static inline
-void bio_first_folio(struct folio_iter *fi, struct bio *bio, int i)
+static inline void bio_first_folio(struct folio_iter *fi, struct bio *bio,
+               int i)

Anyway, I've made that change, but I still prefer it the way I had it.

> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
