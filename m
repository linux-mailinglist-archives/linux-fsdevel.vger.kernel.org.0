Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B4535556C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 15:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344604AbhDFNlX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 09:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344599AbhDFNlW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:41:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FFAC06174A;
        Tue,  6 Apr 2021 06:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5WGX/4XZK0Rd6sfw0XR95V1AU8BPKD/yOGchifwvwPA=; b=CZ5VIwmvVukE8OEo4nVv3ytYTX
        0OI2EcBX6Qoh15sl5XcaW25p/FUvJHCl87q+PMSGhBHKkDRDsXr0uGIko2amI5WFQxYvc5d7FHE9a
        vgfyRSh7GgeqNy5MyDyuTTTtIOoXpTj8Ov25WMnRV8a/+0TQd0KNt5B/OQ9HqGg3RPv3z93VpPXxy
        kDjDSyDidmlZF/WIBRBuElkAhFIOdzqJ2DAZCPRs+U1l5WmC1jYZ+XT1mD+0OSZSYgAR6Zx1V87E5
        X8N9TNAAwIgzHjLqH7D2IgIwPwyhO1RXofZX13MN+87LrT1U/QZfypjJhVQBWPGb4NpOhmzTr/pqN
        SpF3c6EQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTlwA-00CsJS-PO; Tue, 06 Apr 2021 13:40:17 +0000
Date:   Tue, 6 Apr 2021 14:40:10 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 11/27] mm/filemap: Add folio_next_index
Message-ID: <20210406134010.GJ3062550@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210331184728.1188084-12-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331184728.1188084-12-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 07:47:12PM +0100, Matthew Wilcox (Oracle) wrote:
> This helper returns the page index of the next folio in the file (ie
> the end of this folio, plus one).

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
