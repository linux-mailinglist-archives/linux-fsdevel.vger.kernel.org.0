Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8335F47DF6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 08:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346681AbhLWHQK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 02:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346665AbhLWHQJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:16:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E43C061401
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Dec 2021 23:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3MhPbOkAZgtg0QEx7CyigJkf3+S+Yd4tDm8nvdtt2tg=; b=3f97ko0x6KxU2rvyv1nSgCEVJJ
        yz2R8cwnjG8q1NeeI9j7TzJvGI/WVbtqvuqmzJoGzRvpAXQpXdAhuquIMGn1TRQdXxTBd3plp3/sH
        kdqZk8uTVxiuHgFRYJigCwlkol/Itn7mOgQl3Zy5wiDVcSKc1fcwKUUv8cEkqvyVam+pYJ8WYqlDV
        Ypr0XMCvUpYiz2uajGzofu0GLYuCNmS2ItlzsUq/8RJo9WIHyKsUQTMtahySqVqDLnwT7B1XKxE8V
        cHbsSRX5lyWNx0lhBNvxVMltBEEu2EV8EPkalbAoyO/xdTdnDJIUZzUNR84mHLgosvDP4yUXFA/GV
        S+MIZ8Uw==;
Received: from 089144208226.atnat0017.highway.a1.net ([89.144.208.226] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0IKe-00BxiW-8l; Thu, 23 Dec 2021 07:16:09 +0000
Date:   Thu, 23 Dec 2021 08:16:03 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 17/48] filemap: Convert find_get_pages_contig to folios
Message-ID: <YcQhXNKTBvik9xlf@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-18-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-18-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:25AM +0000, Matthew Wilcox (Oracle) wrote:
> None of the callers of find_get_pages_contig() want tail pages.  They all
> use order-0 pages today, but if they were converted, they'd want folios.
> So just remove the call to find_subpage() instead of replacing it with
> folio_page().

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
