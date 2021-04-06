Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD72355592
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 15:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344695AbhDFNoz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 09:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237873AbhDFNoy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:44:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B17C06174A;
        Tue,  6 Apr 2021 06:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oCPXDXtMqE1iBbjtGFhAKOgXXmbi1VeB5Pwnd1OKQHk=; b=HyhqlYamzLQm+qtvlwj6xlPxsh
        NRyXUpypC31oDyOZifkLLQUAf7aAokbqInobLmt1MHCc9ChAkafGqDul7uuae0v9vTHySHQeCa8q9
        GdpMmjgCRLqdn4JPL6woBwwwIUZlg8rok/2TodmONzck+4da+uddu3J88b+SuvvX2ZSR623HZjoqt
        aMTKE0kk+X868hgAUANH1Lg/x8Pi1DwEJEuh05c6XBE+ZZovN+HuXs/OIRUzocuuuPBB6jNG5P72/
        etD8LUjGSmqQqGt7MKWZqCoozjDqMx79EESHUH8g/NSP7aJrMRI4GJea7yfS65u5ndLM7+1lsG09p
        E+GZgkeg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTlxz-00CsSK-1D; Tue, 06 Apr 2021 13:42:39 +0000
Date:   Tue, 6 Apr 2021 14:42:03 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 12/27] mm/filemap: Add folio_offset and
 folio_file_offset
Message-ID: <20210406134203.GK3062550@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210331184728.1188084-13-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331184728.1188084-13-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 07:47:13PM +0100, Matthew Wilcox (Oracle) wrote:
> These are just wrappers around their page counterpart.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
