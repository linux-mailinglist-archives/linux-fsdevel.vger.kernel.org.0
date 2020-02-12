Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAB4715AF25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 18:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbgBLRyp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 12:54:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33400 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBLRyp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:54:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7XNKwAQCe0wWD09kLZnG/QEn+5bffeFhq6ruL0n9m7M=; b=qHhw+JIqRJlFPo9Hs7xaQi3qIj
        Jg2LHudVqRZys2sFoRHD7Qb/sJmBBUXyE6FarlkHqm6U+h7L4UcbNCd3FJMQ/zI4ajl25XX07JpIt
        Af13uKlDkd2uiD/27TuEMsRcgFliRvCXUGZvQBML2ahaeNR8AP5o34VVM0BfZeRBxmNZJXT1popJX
        BtQlWvxj8C5lMaDgDVN7JYbuUfXtA/McOdBV2QdrXUUuG0FC+FOT1eHpHpOWvLWoK+f0s5e59/r9m
        8DXpQAKt2Lo6Sncqwuc8HVMkcCy1T7qlYRhmOdVN9LecwtySaL05IeohtS9fhNHcu1+Jbmy133RHI
        fjtPt/XQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1wDl-0003lq-Ey; Wed, 12 Feb 2020 17:54:45 +0000
Date:   Wed, 12 Feb 2020 09:54:45 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/25] fs: Introduce i_blocks_per_page
Message-ID: <20200212175445.GB11424@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-11-willy@infradead.org>
 <20200212074453.GH7068@infradead.org>
 <20200212150540.GE7778@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212150540.GE7778@bombadil.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 12, 2020 at 07:05:40AM -0800, Matthew Wilcox wrote:
> > > + * Return: The number of filesystem blocks covered by this page.
> > > + */
> > > +static inline
> > > +unsigned int i_blocks_per_page(struct inode *inode, struct page *page)
> > 
> > static inline unisnged int
> > i_blocks_per_page(struct inode *inode, struct page *page)
> 
> That's XFS coding style.  Linus has specifically forbidden that:
> 
> https://lore.kernel.org/lkml/1054519757.161606@palladium.transmeta.com/

Not just xfs but lots of places.  But if you don't like that follow
the real Linus style we use elsewhere:

static inline unsigned int i_blocks_per_page(struct inode *inode,
		struct page *page)
