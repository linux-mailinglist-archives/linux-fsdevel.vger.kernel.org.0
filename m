Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14FEE417D83
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Sep 2021 00:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344944AbhIXWKg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 18:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344932AbhIXWKe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 18:10:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F2FC061571;
        Fri, 24 Sep 2021 15:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K0aUY6geVtaUrVfiEquZHnhrylfB5RLBx1nuZ8fUEbM=; b=BiBW/iAZMl3+JQqTlfAypM4W4N
        u3bXUUSUTNrgaWy+MdYVoJZH4t6N8QyDUnmmFUn97ejTKu9sTIHtYvbqNuZvLjiTrDUnrc953dYiq
        nrKLem/S0pbWRftsvSSDBdJoGDOQwy3zAHg3YWdADHLxX1bGTZiILQjt6P6W+6i5Rkjo9f+KELE5R
        iNNziPBgexYL8LouIhKycTYVy88GqByEeFEzounbKbi3mQsv0QXVQsEbEZa+RXsrnJcSLe17418Fr
        6z+rkzfK5sqE9wpsK0IvIdj966dj9+3f0X5V0WCHxqPI5n4B8qfKUtNSbtq8MRi2LOhhccv6WC0nu
        7HiMky+g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mTtM5-007drd-Ch; Fri, 24 Sep 2021 22:07:55 +0000
Date:   Fri, 24 Sep 2021 23:07:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     hch@lst.de, trond.myklebust@primarydata.com,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        darrick.wong@oracle.com, viro@zeniv.linux.org.uk,
        jlayton@kernel.org, torvalds@linux-foundation.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/9] mm: Make swap_readpage() void
Message-ID: <YU5MLZ3GGATE70zX@casper.infradead.org>
References: <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
 <163250390413.2330363.3248359518033939175.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163250390413.2330363.3248359518033939175.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 24, 2021 at 06:18:24PM +0100, David Howells wrote:
> None of the callers of swap_readpage() actually check its return value and,
> indeed, the operation may still be in progress, so remove the return value.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
