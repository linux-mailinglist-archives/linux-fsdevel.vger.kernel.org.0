Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC5217A855
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2020 15:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgCEO6b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Mar 2020 09:58:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40086 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgCEO6b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Mar 2020 09:58:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qOdWZjojfTuKiVHuyqqILpTUp3oLUWDNcvu8AeOy5+g=; b=JtnShwmjXvXIZuWEpk8tiQgGhu
        PeYE+eqVe5g1HClFlcEK1DK8E6NQCJnPbtk0BYDofz8OHyoND5B0FrV2Dt3PbgdU2pttT5Xnui+Ew
        Sb6r3bT1v5ET4kJrknXnmdq/v2Uv2sxXFtmp6kDaPhak5A9OqTSzrNzEClGply/ZOnUM8DONYNSQK
        LQND9GbpS6b/OKUdp7CCUNNzcmmRDKBtjpM2dEJFxM5Dsu2hc6R6fZ6viAcbSJwIPj0Zi++7FT9UJ
        kxelG6XSySeSpJSoj2zURbvI85ashmzU01V6ckFwwusklIxCvkhtW2gIkJ6/Fu76RNOLrKvIX0C74
        cXqsDqJw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9rxH-0002Ln-1g; Thu, 05 Mar 2020 14:58:31 +0000
Date:   Thu, 5 Mar 2020 06:58:31 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v3] iomap: Remove pgoff from tracepoints
Message-ID: <20200305145831.GA8974@infradead.org>
References: <20200304175429.GI29971@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304175429.GI29971@bombadil.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 04, 2020 at 09:54:29AM -0800, Matthew Wilcox wrote:
> From: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> The 'pgoff' displayed by the tracepoints wasn't a pgoff at all; it
> was a byte offset from the start of the file.  We already emit that in
> the form of the 'offset', so we can just remove pgoff.  That means we
> can remove 'page' as an argument to the tracepoint, and rename this
> type of tracepoint from being a page class to being a range class.
> 
> Fixes: 0b1b213fcf3a ("xfs: event tracing support")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
