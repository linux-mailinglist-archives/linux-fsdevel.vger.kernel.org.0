Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AAC355507
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 15:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242738AbhDFN0b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 09:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbhDFN0a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:26:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD827C06174A;
        Tue,  6 Apr 2021 06:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yLQEUWZT1XSeAQkeR3cfw6pf3DcF2KEDCtA81qZh9xg=; b=ILKZ7h2woBaci/H3otBzPqhadO
        lGkc5KKB4qKrcIYUCttzX6XUSoGVWsdRAZeKNbJ6edidY6frFba5m4ByMZK75o6Cu7ZW35m9SjOYM
        KhEsdv4YewbDuBCix/BlXp9mr4DKV3bfvhWRm6sIrEqFnfkUS7nZVrAmfJRxdw65icSurIa9YGY3u
        EhB4zrtkGRmnO293i5VPuSvnPb8UQ9179ZdNq8JPL95FQ9527uCg5wZQV471luuv1Xk49wqu+2QvU
        bFWWYBM0dBVCI2jS2YFIww5KXJRbx5zO9XgblWmrcLTOKEOfXvYYzzhtjpWyniTWCB5u5ur9Ziq4P
        AE/rMvBQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTlhs-00CrAh-98; Tue, 06 Apr 2021 13:25:36 +0000
Date:   Tue, 6 Apr 2021 14:25:24 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 03/27] mm/vmstat: Add functions to account folio
 statistics
Message-ID: <20210406132524.GB3062550@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210331184728.1188084-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331184728.1188084-4-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 07:47:04PM +0100, Matthew Wilcox (Oracle) wrote:
> Allow page counters to be more readily modified by callers which have
> a folio.  Name these wrappers with 'stat' instead of 'state' as requested
> by Linus here:

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
