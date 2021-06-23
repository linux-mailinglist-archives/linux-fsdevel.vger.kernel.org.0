Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D75A3B1555
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 10:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbhFWIEk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 04:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhFWIEk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 04:04:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC98C061574;
        Wed, 23 Jun 2021 01:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W4wOdEsFwAzwNqc6xQD7Wr3IXC3zhQDqWh0/GXAHyBw=; b=a+iBkoB2d10FrM/Zvl1CNf437H
        w0T02K3nF6bcoBTQxMlIjzhWNC1jy9nGhW99VNCGAGS5BdsEqd6yVy3n6WD/0sE4ciI3+3HuO2Ul+
        pdp3jucwtlhtBGt6eCkAjYXkPmDQ1gUcyOTKgW5Y64KkkZ72GKwnAKiSoZ+G8BuQsixFuaFwyXRHl
        cqInYxLV88D5Z1Zy9Bn42at7Da+p8+heT9h2QwRCaPX8WqCuQFi7KDdoEe+HdXadMdeNaEwxJnv2O
        pyygb5RzfsI4NtHqBXrRJBXAGwRfksH7WHIOHhMlSmUmUgfLTF108ihxoNznC2uu90aI/kvy56C2T
        2KFfaaig==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvxoM-00FBXV-S5; Wed, 23 Jun 2021 08:00:51 +0000
Date:   Wed, 23 Jun 2021 10:00:37 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/46] mm: Add arch_make_folio_accessible()
Message-ID: <YNLqJXTG6HwKRvdh@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-6-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 01:15:10PM +0100, Matthew Wilcox (Oracle) wrote:
> As a default implementation, call arch_make_page_accessible n times.
> If an architecture can do better, it can override this.
> 
> Also move the default implementation of arch_make_page_accessible()
> from gfp.h to mm.h.

Can we wait with introducing arch hooks until we have an actual user
lined up?
