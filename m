Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8D339295E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 10:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbhE0ITk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 04:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbhE0ITj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 04:19:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A01FC061574;
        Thu, 27 May 2021 01:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B/tl9w+rfqog5taif3OisHljWZpnb1WzaL56wltt7qk=; b=EsQTaCh1Igz1rhrCPP9PAhsQmO
        f8Bxix7c2PhTrmPjtk6RG6oy5WgFp6CoWaWylYEaFLXBIdF6rglxwvlacn2THjYO1aJjaeuIAijDJ
        3sjEhCB6kKYe5OgGn5EME8lfUXiuNrl00I3gvAGcZ387UvwEN1ccD2oUWz4Eq5s8UcauXF3GGpYFr
        DtFrjG11rMV0w8asj5kL8l+INtJwmiCr4//ickvdjujqBCXgi7WeB7OiaNDUw0knoLB7eP1oHZvU4
        CSs+mvl0jkoOtEWOMDFnkgiABKX4lZAd1MmDaXd0Ncmq2lrtZZKkJDIuuxmwQT9pZbJmN9AObe//8
        aM0cfFKA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lmBCs-005K8t-Jy; Thu, 27 May 2021 08:17:35 +0000
Date:   Thu, 27 May 2021 09:17:30 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 10/33] mm: Add folio_young and folio_idle
Message-ID: <YK9VmrgNkGjkI2y6@infradead.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-11-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511214735.1836149-11-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 11, 2021 at 10:47:12PM +0100, Matthew Wilcox (Oracle) wrote:
> Idle page tracking is handled through page_ext on 32-bit architectures.
> Add folio equivalents for 32-bit and move all the page compatibility
> parts to common code.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
