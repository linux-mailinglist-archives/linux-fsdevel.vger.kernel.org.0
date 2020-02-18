Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44A34162DC1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 19:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgBRSHG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 13:07:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54132 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgBRSHG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Pn35WD/SGb/hEmN5G17Et9ONi7a6rOQaFI3XMcXM0wA=; b=FWczdyZ6al4dPQ/m9t0m/LCa+1
        vqIgr8GP5pmHvuTPTdbwJi2deyVRCIS1cAlvjkZ6prV/Mxt4VWOieAPVhDOwQykC9pzPZrPCd2uzB
        XMZSSylVvOiRjjTOGDWzMTbjQZFl0Y/F0t9xCLtPOVGzc897I41nZ5J7pDxsAAum/l9q1/l+5+W7p
        oP9dQGw0iXfzlqyOnEPzqweMBy7oOtaa55SPOp7NkwtZvS1X37yJr+KHuBohN2NH45ZqETGH8erlf
        dru06NXfUYwBtdgO0xzLVlGd9RYL7KfJbbXMeqbcuUSbHR/TehiFxRXHDctYV2r0gQme3Ie5fyBgR
        GSSUnZBQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j47Gz-0004xH-TA; Tue, 18 Feb 2020 18:07:05 +0000
Date:   Tue, 18 Feb 2020 10:07:05 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/25] fs: Add zero_user_large
Message-ID: <20200218180705.GA24185@bombadil.infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-14-willy@infradead.org>
 <20200214135248.zqcqx3erb4pnlvmu@box>
 <20200214160342.GA7778@bombadil.infradead.org>
 <20200218141634.zhhjgtv44ux23l3l@box>
 <20200218161349.GS7778@bombadil.infradead.org>
 <20200218171052.lwd56nr332qjgs5j@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218171052.lwd56nr332qjgs5j@box>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 08:10:52PM +0300, Kirill A. Shutemov wrote:
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Thanks

> > +#if defined(CONFIG_HIGHMEM) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
> > +void zero_user_segments(struct page *page, unsigned start1, unsigned end1,
> > +               unsigned start2, unsigned end2);
> > +#else /* !HIGHMEM || !TRANSPARENT_HUGEPAGE */
> 
> This is a neat trick. I like it.
> 
> Although, it means non-inlined version will never get tested :/

I worry about that too, but I don't really want to incur the overhead on
platforms people actually use.

