Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E1947E047
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 09:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347046AbhLWIVU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 03:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbhLWIVT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:21:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A0AC061401
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 00:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E9qDu8a1KHVHERWuCf9i8t/57bX/IPf8ezgKIqcZYfY=; b=RpjW6SsWZNqcYKhJANMifUoB/R
        dVY0IWL3nrslZECqXAcozOfWtsipObgF6aoxvPrJyze0ASnOVlc2N3uc+TzEzdluU6WeO6aDB6sA+
        BGNuUFY6KEFy5yDWj0og6QXwkK/87uNrFxEBRRgavkXzTslFj+6PsAT3EcXAICoxOtGslyxwJPCbl
        s30OiVo969RgbfVgJPN5CYXiLYIObjT0eo0yD8tCyiRFMJzmjuE7yVACkkmo8oY2lllP6sqJAUTTm
        wm6Zs+t0ct6u7BzpVGMHjTnIPBcuZr5a0gekC6h/xboJlM7zQbUkn4wJLVsLHeOnKm9tF1+QwXNxN
        rBdBddJw==;
Received: from [46.183.103.8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0JLi-00CCTb-P6; Thu, 23 Dec 2021 08:21:19 +0000
Date:   Thu, 23 Dec 2021 09:21:16 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 30/48] filemap: Use a folio in filemap_page_mkwrite
Message-ID: <YcQxfAhLTKc4WW7G@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-31-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-31-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:38AM +0000, Matthew Wilcox (Oracle) wrote:
> This fixes a bug for tail pages.  They always have a NULL mapping, so
> the check would fail and we would never mark the folio as dirty.
> Ends up growing the kernel by 19 bytes although there will be fewer
> calls to compound_head() dynamically.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
