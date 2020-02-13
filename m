Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B255515C71C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 17:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388280AbgBMQHG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 11:07:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53228 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbgBMQHG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 11:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X1nymlWhVEjW0Qo9nj7m93jCKxtokjxu2wZUl3xLrPA=; b=RyydNb1toBhgI1v5d1HxivJ768
        1Ahg/bwaS1JKWZqNhJ7k9GXF5nBttTUabFi1gubqswXLafF7GL8jyS8mDYL4IQwit9J5qQ0hQr9jn
        nbOkBnayFxvHIlJp+NFhBKb9HbK132ZAh17USza8QFMR61wjLc3u8suX3VvAUU3eFcDwc8uB3scBm
        y0tZWnapKDj/XyGmxMAaNN0sNPHHAuho4d2iPQ0ZqewUC5YEc/zHNI06BmjzqhNqRSijhIqPYhU0x
        4likeOgbgosAl8syL5j/AXJWHXGamU0B5MUy1b3AXfbLi0boZTyi0jo5KQKPSq0BZzc8+fTdF2jCi
        PWtWcRzQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2H17-0008Dm-S2; Thu, 13 Feb 2020 16:07:05 +0000
Date:   Thu, 13 Feb 2020 08:07:05 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/25] fs: Introduce i_blocks_per_page
Message-ID: <20200213160705.GO7778@bombadil.infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-11-willy@infradead.org>
 <20200213154010.skb5ut6fixd36cxr@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213154010.skb5ut6fixd36cxr@box>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 13, 2020 at 06:40:10PM +0300, Kirill A. Shutemov wrote:
> On Tue, Feb 11, 2020 at 08:18:30PM -0800, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > This helper is useful for both large pages in the page cache and for
> > supporting block size larger than page size.  Convert some example
> > users (we have a few different ways of writing this idiom).
> 
> Maybe we should list what was converted and what wasn't. Like it's
> important to know that fs/buffer.c is not covered.

I don't know what could have been converted and wasn't ... I just went
looking for a few places that use idioms like this.  Happy to add some
more examples.
