Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2423B1711
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 11:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhFWJlb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 05:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhFWJla (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 05:41:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07976C061574;
        Wed, 23 Jun 2021 02:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nfS9E0d+Qm2GE0xaDNgwLpysOhCCYQAZpjFDdw/jAv0=; b=M3lmg5ZWFPBLg1jJmGp7VVd2Iv
        y97xriDeEyibE1BbQlqWFpvH2gPFXIYvdTwVVM8QlIPe4Xnh40hODfz2WtYc8sr0cVdnOM6Sa+sVK
        x1WQTicwDhQ3cN4tJ4vm0D+F1jpi06uL4uUcENLLZbiVvQLdcK42TsODdaBH/ygwr+nwj6HWUvdg2
        JldVHKA7TXRFu4c5dSjLiCXsAhD4ZfTLd7t5kkJ3Nc5cdhfa9vcwFLc7xdqdn5ReNpEyADaz5iDU6
        DVrvEoTrXw38/h/sAi2DZIWh5e7x+gcLmmbFcYK7B3tGvaR7HVgSmcJ2sZ/ob2CpyfP3RVTyh2cHE
        humfjhMw==;
Received: from 089144193030.atnat0002.highway.a1.net ([89.144.193.30] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvzL4-00FH2h-W7; Wed, 23 Jun 2021 09:38:38 +0000
Date:   Wed, 23 Jun 2021 11:36:14 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 29/46] mm/writeback: Add folio_account_cleaned()
Message-ID: <YNMAju9hE/3A+6NZ@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-30-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-30-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 01:15:34PM +0100, Matthew Wilcox (Oracle) wrote:
> Get the statistics right; compound pages were being accounted as a
> single page.

Maybe reword this a little to document the existing function that got
it wrong, and why it did not matter before.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
