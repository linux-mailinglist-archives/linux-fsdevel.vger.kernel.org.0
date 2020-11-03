Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E061C2A486F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 15:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgKCOl1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 09:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbgKCOkR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 09:40:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C915FC0613D1
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 06:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wdOqezQ3bAAIxDJtizX0HENDbmQT7EOU/T2lyZVw0AI=; b=vOG+1OuH8OL+FDt5N86n/4dege
        hPYyXHDHp7QWmSlGzQKiEp83LYXq1qtUxKmllHYOGGI7N0RyplM7YB0UtGg16qKjWE4gFl2y0+4kW
        3kFPy2tesuOBxQ6fN0e+9D8KNhYRWpydh+NrLdm+Npxq/Qf7ub5TrvSf6ou3LIaD0SfYi4iUPZL/j
        4cnoggC9IeEZmCP06DkctSprsH2JoBOts1INXXm+aakNnO0k7rrN2+Rcb6KO0CLgAGSOpBCRfuaki
        q+lUaR+/yYWlNn/mS57PLJcofyqxFk7V9S60jeyU3zT+kUhE0NsQpxi+35y9u3UFTLI7OrKqd62CD
        BBS8+mqQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZxTq-0002yf-PL; Tue, 03 Nov 2020 14:40:14 +0000
Date:   Tue, 3 Nov 2020 14:40:14 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/19] mm/filemap: Rename generic_file_buffered_read
 subfunctions
Message-ID: <20201103144014.GV27442@casper.infradead.org>
References: <20201029193405.29125-1-willy@infradead.org>
 <20201029193405.29125-6-willy@infradead.org>
 <20201103141601.4szfbauqg33xbyzm@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103141601.4szfbauqg33xbyzm@box>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 03, 2020 at 05:16:01PM +0300, Kirill A. Shutemov wrote:
> On Thu, Oct 29, 2020 at 07:33:51PM +0000, Matthew Wilcox (Oracle) wrote:
> > generic_file_buffered_read_readpage -> gfbr_read_page
> > generic_file_buffered_read_pagenotuptodate -> gfbr_update_page
> > generic_file_buffered_read_no_cached_page -> gfbr_create_page
> > generic_file_buffered_read_get_pages -> gfbr_get_pages
> 
> Oh.. I hate this. "gfbr" is something you see in a spoon of letter soup.
> 
> Maybe just drop few of these words? "buffered_read_" or "file_read_"?

gfbr became filemap.  See [PATCH 00/17] Refactor generic_file_buffered_read
