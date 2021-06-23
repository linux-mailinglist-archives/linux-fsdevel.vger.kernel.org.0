Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3693B1564
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 10:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhFWIHM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 04:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhFWIHL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 04:07:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B92C061574;
        Wed, 23 Jun 2021 01:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ntTcJy13D/QGMMMLSGx0pXq4BTVvCy1aoIuDiVD+hKE=; b=cR5j9Rv0gIqJF9xMrbiZ81+aub
        40xBIlFdwnK4MYXt/FReoo71vYYW9FZdTJYOXEZ9vVc5VVKUWPIGTnJYclfSp5x1ScU28ODwP3otu
        Fpz3Rt61jEqM2S9uU5qQVieUvDW7NjFJwEVGtaBiNLPpQbwi4fdOaCh0rIUb7a1MU4XwW7khydA0Y
        W+l5Me7Ze4W+OQI+NHrMUCTYUCzF9GhKGCPL/6+obroM06pXdMNuvyqlkHcSUr235tlhgu3WM/CJ9
        sBhxjQmvt1mfauArsHnIujKWFvW71IIWmbqNUR4BIVlo5GK05uBmWgcb2Lcv3KWNjbK5nOMr0mAfU
        D+Jgq4LA==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvxre-00FBkl-Ly; Wed, 23 Jun 2021 08:04:09 +0000
Date:   Wed, 23 Jun 2021 10:04:01 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/46] mm/swap: Add folio_activate()
Message-ID: <YNLq8So+8AEIDEe8@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-9-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-9-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 01:15:13PM +0100, Matthew Wilcox (Oracle) wrote:
> This replaces activate_page() and eliminates lots of calls to
> compound_head().  Saves net 118 bytes of kernel text.  There are still
> some redundant calls to page_folio() here which will be removed when
> pagevec_lru_move_fn() is converted to use folios.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
