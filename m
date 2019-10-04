Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAF11CC394
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2019 21:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbfJDTdD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Oct 2019 15:33:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35954 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfJDTdD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Oct 2019 15:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LHh/YQwQTy7byEfLDg0tl2YRDGuuUomeM/luIJJrsME=; b=BWP72EUXNPAivlKYRsOMtPtaw
        Kp+yyT1wO0BN8iWpVPl+wKzLz6FEMavN+iPUFllU1t7UN7k/TOU5TjN50/T5X8Avm/n6ZkoC9GsH7
        C7F0dR01CVPEPdLw6LgZuYdizR4Ul+FVlyZsh4h/NSlyWLYb51wNn1ziUt2QisHXe2+SOPRnWjxVf
        KIPKHdP/XPLB1+qhzkDpDsa9sMJ/Oad0sI4Slc6YCMXhsZFtLTbvyWcLsC9LJ9WnP30Dzix0gKsEY
        hrEEYiiu+NglwLFL5GWQ20TBs63WW4f6YrffxW1M4tFtHLs00SqLjbd7xne4o917PClzgzP/j/a/F
        zUEQoI0Sw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iGTK2-00063Z-9N; Fri, 04 Oct 2019 19:33:02 +0000
Date:   Fri, 4 Oct 2019 12:33:02 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/15] mm: Add file_offset_of_ helpers
Message-ID: <20191004193302.GL32665@bombadil.infradead.org>
References: <20190925005214.27240-1-willy@infradead.org>
 <20191002130753.7680-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002130753.7680-1-hdanton@sina.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Your mail program is still broken.  This shows up as a reply to the 0/15
email instead of as a reply to the 3/15 email.

On Wed, Oct 02, 2019 at 09:07:53PM +0800, Hillf Danton wrote:
> On Tue, 24 Sep 2019 17:52:02 -0700 From: Matthew Wilcox (Oracle)
> > +/**
> > + * file_offset_of_page - File offset of this page.
> > + * @page: Page cache page.
> > + *
> > + * Context: Any context.
> > + * Return: The offset of the first byte of this page.
> >   */
> > -static inline loff_t page_offset(struct page *page)
> > +static inline loff_t file_offset_of_page(struct page *page)
> >  {
> >  	return ((loff_t)page->index) << PAGE_SHIFT;
> >  }
> >  
> >  static inline loff_t page_file_offset(struct page *page)
> >  {
> >  	return ((loff_t)page_index(page)) << PAGE_SHIFT;
> 
> Would you like to specify the need to build a moon on the moon,
> with another name though?

I have no idea what you mean.  Is this an idiom in your native language,
perhaps?
