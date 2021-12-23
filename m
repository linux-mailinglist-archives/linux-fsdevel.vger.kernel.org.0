Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B3447DF70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 08:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346736AbhLWHQ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 02:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346665AbhLWHQ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:16:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C72C061401
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Dec 2021 23:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M62TrzwRxO351s13wL0W7IRgVmliiZdiXgK9u1w5zLI=; b=laxybFTQwPErh+ckgr+McBjvJH
        CJ02rIf7LrdzZLXG6ZCfYTCJFQhlOJoCPvQ7Y7oMTHo27ciHlg0ybnbhck/74yXhGOzdCeuR0OhpU
        pFng2I75By+SLrLTfRm1MoDsDpHzJKqTsaXazSt2IrffgUNX9k2s9MGmho2U21myCNf/AR9+qYKKj
        TrqkX26otvvfZn0pSith0coh79jKMQADUyOES5nZHGmZcvD+pTeCA64tOHR/VJY4H1QNBgdHnWJWa
        IDK3G0YttIngRgX8Hp6fLGh3K0LLBVkAYHlKLbc+h5RA1L3yCiVkMzubE9eksQV1yogIAONH+mbkr
        k74/0APw==;
Received: from 089144208226.atnat0017.highway.a1.net ([89.144.208.226] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0ILQ-00BxkJ-EV; Thu, 23 Dec 2021 07:16:57 +0000
Date:   Thu, 23 Dec 2021 08:16:52 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 18/48] filemap: Convert filemap_read_page to take a folio
Message-ID: <YcQiZPviCJT/n991@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-19-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-19-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:26AM +0000, Matthew Wilcox (Oracle) wrote:
> One of the callers already had a folio; the other two grow by a few
> bytes, but filemap_read_page() shrinks by 50 bytes for a net reduction
> of 27 bytes.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
