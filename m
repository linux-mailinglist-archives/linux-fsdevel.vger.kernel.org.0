Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF25247DF83
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 08:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346736AbhLWHYE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 02:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242486AbhLWHYD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:24:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F90C061401
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Dec 2021 23:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4p5M7JkAw5amGFSXQ2pkXaMFujxDGzfSE5Ayq8qb12k=; b=uyk/cjM9n+IBC+wCCjME+9IvVd
        3XHhashqhSQSTP6L/lXL/VHoZ/n82YfEZ1vPFKW/qIPOGuEKA6XqrRNEO5lQe5O4p/r4EiF4sf2Kt
        J+jhFKM5eAmEUtMU4JsvgCnqL9wx4nTxK4PkcnJdmL9v9oz8urnau/SICVAIZb3znAppwPQ9xHZAk
        ASMY7Fgl4A3ZT9yD5vhRrfn6jYMULuahC0iSU8swPe9UCk4MVPIkqZjlfwV5AY3WpAnyUCnwmFqr0
        fNQNrIoZbEMvz5xqjttEYFqoaPhQ2SMxh8Y3eYh3ppBdDpopehoVJ/5C7uDxOY3RftmNdiJv7wPAc
        LFQOjMRg==;
Received: from 089144208226.atnat0017.highway.a1.net ([89.144.208.226] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0ISH-00By2h-Q9; Thu, 23 Dec 2021 07:24:03 +0000
Date:   Thu, 23 Dec 2021 08:23:56 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 23/48] filemap: Convert do_async_mmap_readahead to take a
 folio
Message-ID: <YcQkDOwU90rRwVsz@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-24-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-24-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:31AM +0000, Matthew Wilcox (Oracle) wrote:
> Call page_cache_async_ra() directly instead of indirecting through
> page_cache_async_readahead().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
