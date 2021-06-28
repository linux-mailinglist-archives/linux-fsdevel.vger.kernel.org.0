Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35E93B5910
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 08:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhF1GYx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 02:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhF1GYx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 02:24:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6C8C061574;
        Sun, 27 Jun 2021 23:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VSsqQEp1WXFodl078mceGS44th1ZKo/aF0XDPZZ2Tcg=; b=QdwZdGg3j+z6Dm6AzMGqoPOdKB
        STViCsfUG5LlsQiTEzIiB1KCSidtIA35CI2nNppfCeJqj2nxuStGwikeyKajGSCthOxCArEZqJ1zz
        IqGb2hoESRLOxS+YjPyKB+iUSJpmtlolyX9LRkrFrcjpNlliznJiTE0eYZAF8WcA9o/Kwh8JwIvMR
        MnpRGINmpt9mNyMaOTSsENwsSY1Ukg1R/5p3Og5GJ+j3yZI744XRg7sKKPhfPMHV6JvnVBUzhLzbK
        jDWjwTehNGInf5Rbu2FL4Ez6V8ZSUtOtcl+J30WILnnK+9IlByQswZeoweluclC06LIePV22520aA
        z/Ev1mBg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxkdh-002eSv-4o; Mon, 28 Jun 2021 06:21:11 +0000
Date:   Mon, 28 Jun 2021 07:21:01 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/46] mm: Add arch_make_folio_accessible()
Message-ID: <YNlqTb3gUG6dVq3t@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-6-willy@infradead.org>
 <YNLqJXTG6HwKRvdh@infradead.org>
 <YNSraZoSxNTCZf5b@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNSraZoSxNTCZf5b@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 24, 2021 at 04:57:29PM +0100, Matthew Wilcox wrote:
> On Wed, Jun 23, 2021 at 10:00:37AM +0200, Christoph Hellwig wrote:
> > On Tue, Jun 22, 2021 at 01:15:10PM +0100, Matthew Wilcox (Oracle) wrote:
> > > As a default implementation, call arch_make_page_accessible n times.
> > > If an architecture can do better, it can override this.
> > > 
> > > Also move the default implementation of arch_make_page_accessible()
> > > from gfp.h to mm.h.
> > 
> > Can we wait with introducing arch hooks until we have an actual user
> > lined up?
> 
> This one gets used in __folio_end_writeback() which is patch 24 in this
> series.

With arch hook I mean the ifdef to allow the architeture to override
the folio function.  Same for the previous patch, btw.
