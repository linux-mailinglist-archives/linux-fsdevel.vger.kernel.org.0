Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267513A771E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 08:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhFOGd7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 02:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhFOGd7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 02:33:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2A3C061574;
        Mon, 14 Jun 2021 23:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l4ap9K14HzLuNaS/BB93x9SBcqR5Jq194sFXikh1T1c=; b=SQOeAsZve6bYiSpkDqA1s4BGBb
        cdHNM8jiOeoQE5l8DZwdGi7q7WCAtrtYhSiIQtItVydKqfTwUcf3858Up+9zRGBig449sqq8XIUM9
        v/6MK6fZrAEeG07nsJxyC4SIPh3c7OelDCZAgyMI1WTUuB82SW5CeYS4uiPi62JxY0LHKIw6kb48b
        /tdFsAGDCVBVRZKoi+V4kw6i3yGfnwxLwJB/Fk5sEc8vpho6eVzrqGqu1jXw7RpM182+Y+qEy9Oz6
        FG4tXCB1pIEtKySnSQGbDDSHYcDfLe+oqom1cVsFL9BM+K8ftMGY+O/PwwJsRrFTemAJ9/h6K39Yl
        4tRhj3Ng==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lt2bq-006AUI-HK; Tue, 15 Jun 2021 06:31:40 +0000
Date:   Tue, 15 Jun 2021 07:31:38 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v11 33/33] mm: Add folio_mapped()
Message-ID: <YMhJSp0dP36zIf0g@infradead.org>
References: <20210614201435.1379188-1-willy@infradead.org>
 <20210614201435.1379188-34-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614201435.1379188-34-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 14, 2021 at 09:14:35PM +0100, Matthew Wilcox (Oracle) wrote:
> This function is the equivalent of page_mapped().  It is slightly
> shorter as we do not need to handle the PageTail() case.  Reimplement
> page_mapped() as a wrapper around folio_mapped().  folio_mapped()
> is 13 bytes smaller than page_mapped(), but the page_mapped() wrapper
> is 30 bytes, for a net increase of 17 bytes of text.

I'd still prefer the code flow I suggested last time, but that really
is just style and nothing substantial, so:

Reviewed-by: Christoph Hellwig <hch@lst.de>
