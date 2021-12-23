Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2379B47DF73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 08:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242486AbhLWHSG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 02:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbhLWHSG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:18:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDF3C061401
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Dec 2021 23:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3/7sssQYWTlCPiVF5oBoe+shoREO+ig+BEZy4fBLL9k=; b=0oHvf1Gs0f611zBEEL7EOOYz4z
        0kETkVbHl8ydldS+pEEvqLGXkcK/yaCmNvS7PJ1WJ+/wJhBqukWl4AGvdeZfGl2A2jKIwGvKrNC++
        pF2RDz9tMDCws9Tunakm/Ts+BSXlUa6mRuV1R5ni57O1k2UF6x1mGxjsaK59Lr79L7MPlAr5e2awU
        Su+4+7BfJcwYo1rua9x3RBm0o2AceTHXWrQKtaJpCoLtqDYbHytGGgy+4lI/ofSuSGCw/HBcCwxP4
        LbRCkCXEeMrEVvzqFv+/jLBm6T0Vs497ZJNROoWUEAV/L0BFhMPxlECEBzH+rGnZmhmQvAwkrU9tg
        DUO1xKSQ==;
Received: from 089144208226.atnat0017.highway.a1.net ([89.144.208.226] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0IMX-00Bxmo-6b; Thu, 23 Dec 2021 07:18:05 +0000
Date:   Thu, 23 Dec 2021 08:17:59 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 19/48] filemap: Convert filemap_create_page to folio
Message-ID: <YcQip4LL5u1wdp3Y@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-20-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-20-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:27AM +0000, Matthew Wilcox (Oracle) wrote:
> This is all internal to filemap and saves 100 bytes of text.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
