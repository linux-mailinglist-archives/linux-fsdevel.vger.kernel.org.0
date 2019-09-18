Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3361B6FCB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 01:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbfIRXtZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 19:49:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60878 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfIRXtZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 19:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9B/jgHS7PD/DOi2AjcR19b+jtGzxXg3UqwFXdzQJuJ8=; b=RTaqfzBph/Z2r/rLphAOle23G
        lBBoCZ650sphFB2nq53YzVYS6suvjOIXb/E7nQWwuYJMk9lZOvQPEPUrX3xrLXHY4ZACCUtEiEhHw
        l9vJpF5r066Ojn5AZ5o3Ze5fsnGR6HCjgqCGSVYNchu+tlw8GH+OLnFdgdvfSdJC/0qT1TGI7pIwq
        MxUzTt/PfDpu8QqsHzMZWhueJ0mYoRq4Xy0s20ok1MPmn93vOjrtZh85pgn/84dFRM5BGhfNMCjfR
        eVlXrt51wfwnVUNlK7DEsKGgozND1UN1+dhy6KjDenYue5RC7iWLowhkRonYKJhR98jMVqmI3i5kL
        qAGVf4obA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iAjhM-00084W-UO; Wed, 18 Sep 2019 23:49:24 +0000
Date:   Wed, 18 Sep 2019 16:49:24 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/5] mm: Add file_offset_of_ helpers
Message-ID: <20190918234924.GE9880@bombadil.infradead.org>
References: <20190821003039.12555-1-willy@infradead.org>
 <20190821003039.12555-3-willy@infradead.org>
 <20190918211755.GC2229799@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918211755.GC2229799@magnolia>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 18, 2019 at 02:17:55PM -0700, Darrick J. Wong wrote:
> On Tue, Aug 20, 2019 at 05:30:36PM -0700, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > The page_offset function is badly named for people reading the functions
> > which call it.  The natural meaning of a function with this name would
> > be 'offset within a page', not 'page offset in bytes within a file'.
> > Dave Chinner suggests file_offset_of_page() as a replacement function
> > name and I'm also adding file_offset_of_next_page() as a helper for the
> > large page work.  Also add kernel-doc for these functions so they show
> > up in the kernel API book.
> > 
> > page_offset() is retained as a compatibility define for now.
> 
> No SOB?
> 
> Looks fine to me, and I appreciate the much less confusing name.  I was
> hoping for a page_offset conversion for fs/iomap/ (and not a treewide
> change because yuck), but I guess that can be done if and when this
> lands.

Sure, I'll do that once everything else has landed.
