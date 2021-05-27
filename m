Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE83839293A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 10:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbhE0ILB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 04:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbhE0ILA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 04:11:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2912DC061574;
        Thu, 27 May 2021 01:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BSxyA6mHD0RmgeugIFmOasLIdKwDRkfeOVlBlTrLl10=; b=EyYpDORZHnC1ZDNMaNueS+nB22
        bjb+BAkBhFfMqA1YB8BvolwZmG9mP0Fka4sd4Kg8iuy9PJaP/2KkO3GJsHeKjE9WAXOHhArV2WhYa
        CSQkU4fFeu1aJnXjSukT8z0+6xo75HNsOa+C4pYXeCQSuEBH/yhtPt1oH7jlz1jX0DUipTdUoIk6b
        bztDe5wHneFBWVMQ+Ls/ZPd/JjIaP2AceqOIoNV6nfJICsLnZqmu+ruZkg1i9jah6fmkoJQexNDZl
        l6nn6rg/1FDD27nhTzKoMqNEuJOBqi/Q/XqgTEI1v9ZYEq4AJUIDZPv+swFnmZ1o9/JPJk9AYJEVi
        CX0M3m8A==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lmB4o-005Jh8-P9; Thu, 27 May 2021 08:09:13 +0000
Date:   Thu, 27 May 2021 09:09:10 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v10 01/33] mm: Introduce struct folio
Message-ID: <YK9TptJ72hfaYc/w@infradead.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511214735.1836149-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 11, 2021 at 10:47:03PM +0100, Matthew Wilcox (Oracle) wrote:
> A struct folio is a new abstraction to replace the venerable struct page.
> A function which takes a struct folio argument declares that it will
> operate on the entire (possibly compound) page, not just PAGE_SIZE bytes.
> In return, the caller guarantees that the pointer it is passing does
> not point to a tail page.

I still hate the overlay that must match struct page with passion and
think it is going to come back and bytes us.

But we really need to get out of the compound page mess and move forward
with large page suppot in the page cache.

So:

Reluctantly-Acked-by: Christoph Hellwig <hch@lst.de>
