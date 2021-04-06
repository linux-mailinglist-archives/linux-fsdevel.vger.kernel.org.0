Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C443555DE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 15:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344811AbhDFN6g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 09:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234701AbhDFN6f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:58:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A19C06174A;
        Tue,  6 Apr 2021 06:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xdVYuW+gbiOxbxB3U0bNC9sVbHKkGQf7dwoQZGExKhc=; b=f2t37RoJlqsBWWtrooL30jycBF
        W1dHpBPK3mMoOjz9PBOz8+c9HTnI82yJ7QjqteYXeTAwQEQ0JhAZ6dS1Ua3S2AyJdHMUJ/nxgKD/+
        CDYPRWODGkkshW+jSh+0NClqFx8WKgf4v0qqcBvXHJS6NNf5onKza36rE6h9QCUkjdA16gTAv+76O
        RxGyvZDivjlqwnstHpTZ5vypMVd/uLER8ZHYSWsLb0c8g7I+WqVHzHdt19/5vnmoRsv7IfOfSwFGA
        JY4B9wh/nKTu6NXHnDGy9SuIkVlhwpcnNgFGu5J2d4WChMG+++srgp1oLBR1quy55/BxwLjHCsKGo
        i3+q7wcg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTmCr-00CtiQ-JT; Tue, 06 Apr 2021 13:57:32 +0000
Date:   Tue, 6 Apr 2021 14:57:25 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 20/27] mm/filemap: Add __lock_folio_or_retry
Message-ID: <20210406135725.GS3062550@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210331184728.1188084-21-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331184728.1188084-21-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 07:47:21PM +0100, Matthew Wilcox (Oracle) wrote:
> Convert __lock_page_or_retry() to __lock_folio_or_retry().  This actually
> saves 4 bytes in the only caller of lock_page_or_retry() (due to better
> register allocation) and saves the 20 byte cost of calling page_folio()
> in __lock_folio_or_retry() for a total saving of 24 bytes.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
