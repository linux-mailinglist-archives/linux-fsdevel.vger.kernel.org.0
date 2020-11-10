Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D892ADE36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 19:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbgKJSZS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 13:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgKJSZR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:25:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A72C0613CF
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2020 10:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gxTWVrKCu8fGIsjS7YDvqum7aOq90Rdj1IzGnbiADLQ=; b=lTYD3pHcXSAttpgS82rgafuvio
        BeEI7h8PZ6Pdb4kzOSja8QJ8qxZC+893goPRVsfHzqPnxI9r5LK+H0QL8YItwaC5uV8R1REmpxDkf
        igUchFqJXjZMsCzZde95sd69vss9UxxQRTQL7uCcpyxmiGZyBe0hmuoqu7HW97Q2Yx8kM6wUfR1sm
        fuMl8GygcVW34wUgsUrcSZkgJ+f9X/oUibnBx7FFUFHoaNsOSydcupNj8N4UYAgs8lx3p+xGFz5XD
        KzIrH+IV7usQPOlJpbfo6XdfegUgbyod6NSsQPJtkqosGxBn9jT+/uKH7HxRPK5KlXFpZwwjWBGz/
        Cb9HxbFg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcYKR-0001z3-M9; Tue, 10 Nov 2020 18:25:15 +0000
Date:   Tue, 10 Nov 2020 18:25:15 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        kent.overstreet@gmail.com
Subject: Re: [PATCH v3 03/18] mm/filemap: Convert filemap_get_pages to take a
 pagevec
Message-ID: <20201110182515.GK17076@casper.infradead.org>
References: <20201110033703.23261-1-willy@infradead.org>
 <20201110033703.23261-4-willy@infradead.org>
 <20201110182118.GB28701@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110182118.GB28701@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 10, 2020 at 07:21:18PM +0100, Christoph Hellwig wrote:
> On Tue, Nov 10, 2020 at 03:36:48AM +0000, Matthew Wilcox (Oracle) wrote:
> > Using a pagevec lets us keep the pages and the number of pages together
> > which simplifies a lot of the calling conventions.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> I hate the > 80 char lines in a few spots, but otherwise this looks good:

They're all gone by the end of this series.  It's just less churn to
ignore the 80 columns limit for the intermediate patches.

> Reviewed-by: Christoph Hellwig <hch@lst.de>
