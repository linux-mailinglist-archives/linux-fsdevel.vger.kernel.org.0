Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0FDC15ABAE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 16:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgBLPFl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 10:05:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43404 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbgBLPFl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 10:05:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R27uEzmvp31adlnkqQRzsQ6H2g7fBN8gFQSD+LxBf6E=; b=Hz/3Aibqu2QROGvLCaHh06rM8E
        Yfb6NbCsXryt/BFtAU9rfe0bem9ABTYfLoj6lbuCJw63ozFBFbWDItsSARxoIlDqsLdmhEOMgAAIQ
        qMiHHLAHg06nuQ8EvntsoYMO3ck9OwEBrhsZkglC9A2Kp2i+girvA4S6vF/FVH0OalUbyJhCvV4hc
        PM/6+R+g9sla1QNFkp3Obqlzokt5hcFu1aZKpcz3AqpxsTpuc5FCRaYZPsLrHc4jZIdBEJOwopD5X
        tS/jirDX6LwfWBfqHYJkFqdh+y1ERUCFp9Q/9qrwLv5BVxTwA1KWQtaH59zin/o5uZXT9DjAs8zAb
        Opd2LwwA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1ta8-0007QS-Qc; Wed, 12 Feb 2020 15:05:40 +0000
Date:   Wed, 12 Feb 2020 07:05:40 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/25] fs: Introduce i_blocks_per_page
Message-ID: <20200212150540.GE7778@bombadil.infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-11-willy@infradead.org>
 <20200212074453.GH7068@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212074453.GH7068@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 11:44:53PM -0800, Christoph Hellwig wrote:
> Looks good modulo some nitpicks below:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> > + * Context: Any context.
> 
> Does this add any value for a trivial helper like this?

I think it's good to put them in to remind people they should be putting
them in for more complex functions.  Just like the Return: section.

> > + * Return: The number of filesystem blocks covered by this page.
> > + */
> > +static inline
> > +unsigned int i_blocks_per_page(struct inode *inode, struct page *page)
> 
> static inline unisnged int
> i_blocks_per_page(struct inode *inode, struct page *page)

That's XFS coding style.  Linus has specifically forbidden that:

https://lore.kernel.org/lkml/1054519757.161606@palladium.transmeta.com/
