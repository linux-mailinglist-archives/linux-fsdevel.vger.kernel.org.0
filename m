Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828043B1728
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 11:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhFWJsb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 05:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhFWJsb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 05:48:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46F0C061574;
        Wed, 23 Jun 2021 02:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=khCasmlkejpumD279zcfaqNu3XL64faTBEo9YCLmsQw=; b=XdX6uHxix0ciDFV5WCzveVqlRj
        j1vq6L0tsUjHoHd58Lb1qLNZ6u5TIDAjz1I0yW98UYCLn4SNhTLVAvSS4TUyou2qCh/EUUkbkytgA
        uJxaLxBVfdAw1CzDt7l69rYlgTQjDdT0C5+03rfmNi8C6H3gcz6W2CJz3yFH/XXBLl4RxQAc2VrG8
        39m9LQriksqttoFZU5B22eASbyNZVSsv6wjExC7N9lARqxVIG4aD1ye9Re2ZX+8KadpqSs0Y6Gjvr
        eCSLdqEpxBnJ28jnG5Am8e+FhMnX0H0VpbP+hc5s9WA7WUVHFBYjKhNufR1a+a9rNKYI3wW3ZvvYf
        bJ+mHScQ==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvzRh-00FHKo-MH; Wed, 23 Jun 2021 09:45:30 +0000
Date:   Wed, 23 Jun 2021 11:45:20 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 33/46] mm/writeback: Add folio_redirty_for_writepage()
Message-ID: <YNMCsMwbT+BOaYaA@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-34-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-34-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 01:15:38PM +0100, Matthew Wilcox (Oracle) wrote:
> Reimplement redirty_page_for_writepage() as a wrapper around
> folio_redirty_for_writepage().  Account the number of pages in the
> folio, add kernel-doc and move the prototype to writeback.h.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
