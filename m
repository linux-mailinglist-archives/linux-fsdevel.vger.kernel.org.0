Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D5647E054
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 09:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347109AbhLWIWp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 03:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347092AbhLWIWm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:22:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638FDC061401
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 00:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WB99hQjlYx/fIxwM22LJtlMqmRnzOW8jUWcXmx6bn/g=; b=J4a/F44lYGq+VKI5YCLkF6FvRp
        +4haApX0QPWPIrJWmbKI33daWFeE4Aymjp3z//SgU371HzcqZTk4/R7Bv794DgOy5aZCONXxYSlJr
        UZxwDHrOJQa353W3lsb6Uex4aCse/8IGvETnMBSVRRyGznzFdtUKTU3WtNq9DNQmBHdZyws6x3QNW
        nSXIo8UkiuetMnYLfT4fmLrJ4pyXFGMTL7lSMsf1rPUsaIQbkQ0T87JB8DQvRAiagCqm1xjZFltLX
        36yTQy88eP5TTgkSbkvI6FsBkU1encKxEZkidezoDds5tqVzzz4KIzvdpFr882L3paabqaaYR5XYJ
        ZWHEbJyQ==;
Received: from [46.183.103.8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0JN3-00CCzi-Gk; Thu, 23 Dec 2021 08:22:41 +0000
Date:   Thu, 23 Dec 2021 09:22:39 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 45/48] truncate: Convert invalidate_inode_pages2_range to
 folios
Message-ID: <YcQxzxBJUvZzNoTm@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-46-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-46-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:53AM +0000, Matthew Wilcox (Oracle) wrote:
> If we're going to unmap a folio, we have to be sure to unmap the entire
> folio, not just the part of it which lies after the search index.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
