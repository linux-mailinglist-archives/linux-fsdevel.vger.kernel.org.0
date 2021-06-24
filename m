Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818E43B39DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 01:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbhFXXxI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 19:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhFXXxI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 19:53:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F65BC061574;
        Thu, 24 Jun 2021 16:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QrDKKmi2jhhfzOeBzeGjVF68+wOp3Rw/4GYCckMy6O0=; b=EfowUAHjP6rvRkIOaO+mR4InfD
        GejD3d/O+OyWxQPJMl2kq/YpZoKjLm1p0OBREnlf3p1ZTuYTey5653em5WZyoO5nTe3Z8s4j1C6A0
        IHyyxgR29GT5bL2/6o5mNB0RLlpOyjLgE4erh834BsEOLXfWNsMwCyVnSsaVS5ru+ndWnFkNNcJL0
        iOPa5zzpnqhvMsXS40UQ443a0enMggojGVMuhJ+aX5wsnkcYATa0Rmu3DXlNAxeo181LjD3ASdSeH
        nDnFvpDocBIBgzRJdBpZcR/GSRLcZt9Kb/zKd6uyo1oPfBuZORVpY7DsJzT2q8qzlgwIRw/wwaGDv
        QsZS3h9g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwZ70-00H7b7-Td; Thu, 24 Jun 2021 23:50:27 +0000
Date:   Fri, 25 Jun 2021 00:50:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 38/46] mm: Add folio_evictable()
Message-ID: <YNUaPk72xxGvIGNE@casper.infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-39-willy@infradead.org>
 <YNMEviOojARovw7T@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNMEviOojARovw7T@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 11:54:06AM +0200, Christoph Hellwig wrote:
> > + * Reasons folio might not be evictable:
> > + * 1. page's mapping marked unevictable
> > + * 2. page is part of an mlocked VMA
> 
> s/page/folio/?

Thanks.

 * Reasons folio might not be evictable:
 * 1. folio's mapping marked unevictable
 * 2. One of the pages in the folio is part of an mlocked VMA

> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
