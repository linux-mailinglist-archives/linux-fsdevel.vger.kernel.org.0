Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFBD355629
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 16:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344882AbhDFONh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 10:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344891AbhDFONZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 10:13:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF99FC06174A;
        Tue,  6 Apr 2021 07:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pZwMcf5iEm9vQedhznNSrB1eoBlpxK0vTkFxcd3+VS4=; b=fCLis4aRjdezyDv5mCGo2tcDKb
        /AR6CsS8iGBK+ThwUJMuULlVAdDQeN+Rmlex9MFGZisePOqgXNQc75EAcPGIrjJBLtp+JgHU7uY2B
        2emgSSuq+jO6ayyxTR85dlGVBsWYGiw7GGtEcZHtZMhMVSlG6oc47q4iVx/orrKOTHVwXApxp25z3
        SsBTeJkKze3KLs5dfdAJ0SM58KVMz2trc2ExJhm/OMdoqxgWfP7oGHKdvJMkgeat/ID0uyHa0qB5j
        BYo2KlA3pI3KSXUxBX0dl1BwiVWQ/blR2F9+joYd/hnqH37P27I0WFubF503vmc6Tgk+H6/kAaLXl
        r/dvou2Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTmQp-00Cukf-Ls; Tue, 06 Apr 2021 14:12:11 +0000
Date:   Tue, 6 Apr 2021 15:11:51 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 21/27] mm/filemap: Add wait_on_folio_locked
Message-ID: <20210406141151.GT3062550@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210331184728.1188084-22-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331184728.1188084-22-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 07:47:22PM +0100, Matthew Wilcox (Oracle) wrote:
> Also add wait_on_folio_locked_killable().  Turn wait_on_page_locked()
> and wait_on_page_locked_killable() into wrappers.  This eliminates a
> call to compound_head() from each call-site, reducing text size by 200
> bytes for me.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
