Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374DA3CF4DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 08:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbhGTGO7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 02:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241676AbhGTGOu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 02:14:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D45C061762;
        Mon, 19 Jul 2021 23:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u1N/L+FFzCGLI0rRnV8NE/QG2gSD2xtSormnXpW3dWk=; b=DghLfFONiZmkKs8BTR2W1z8ig5
        1eU14nWP0VPiadDKRsLEtDwvGe7fPkt+02SvHJ+1vOTVKgYu3PLcALJRRJRDk9CF+oJru4lghd5Ip
        7TGpVmzHNMuZ38u/wGcVhn7TnqB8JEJT0OVOSLkTOjylat7Wk6ZxBA/cJqKvGjTkDNxVxZU3ENrht
        TXTuiuwboTfP0hUWTsZJ8Yw4XbPsg5A8vszbizYbHMdrVatRf+vzhDbAmtNKYbdKnRNNMFf1ILEP9
        uOGkkTQN0wRDcV12Q1TQAb02rixtbv4fybT6jy913akGTZpMx5wA1t9gEn5osMbeG/5eOZSRjsf16
        SVhRTsOA==;
Received: from [2001:4bb8:193:7660:5612:5e3c:ba3d:2b3c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5je1-007qOA-LD; Tue, 20 Jul 2021 06:54:27 +0000
Date:   Tue, 20 Jul 2021 08:54:20 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v15 06/17] iomap: Convert iomap_releasepage to use a folio
Message-ID: <YPZzHNKGWldM3PJq@infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-7-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719184001.1750630-7-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 07:39:50PM +0100, Matthew Wilcox (Oracle) wrote:
> This is an address_space operation, so its argument must remain as a
> struct page, but we can use a folio internally.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
