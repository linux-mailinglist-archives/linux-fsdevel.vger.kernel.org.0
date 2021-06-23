Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3734B3B1524
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 09:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhFWHxd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 03:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhFWHxd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 03:53:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE4AC061574;
        Wed, 23 Jun 2021 00:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kHCdvgaykiK2wb98YNK1uUUlwxt692indgWbyHeYWFs=; b=YmeKFIJ/DCFbT1KbHftaoz2wfd
        361D88y490vqN+ar2ZXz3oqNmMVNk4XmLq1ilNk3y4P2MI4YmfONbdWpb7AaG2N83mGrJjQ2DaTTy
        CFEHYnTJROtBI+arGH1bnT6jgjjbDEz08xH85Ju44gkFbJRT0h4qpttZThaEru0JFhiRMFmsdrEy9
        SHOgXYJbttO/0Ojw6PQOBcOTMonIRbNRfNWHuPDWI//AIZciTs97eFVHSeSP8fw1oNREAEtbB6u9O
        5eaZMmWXrKbzS6qnqYzvs8QCtfYaBq9NMrmuF7IL+5RK2JAGgefznWZdWrCRXtOASVyyzqwlZlew+
        hH0bOkrQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvxdz-00FB1g-Dk; Wed, 23 Jun 2021 07:50:05 +0000
Date:   Wed, 23 Jun 2021 08:49:55 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/46] mm: Add folio_to_pfn()
Message-ID: <YNLno34yXpRNnMRj@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 01:15:06PM +0100, Matthew Wilcox (Oracle) wrote:
> The pfn of a folio is the pfn of its head page.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Maybe add a kerneldoc comment stating that?
