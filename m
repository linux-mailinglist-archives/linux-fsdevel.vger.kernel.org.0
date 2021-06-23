Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4DE3B1572
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 10:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhFWILp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 04:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbhFWILo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 04:11:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FECC061574;
        Wed, 23 Jun 2021 01:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G2/C+g7cEjGpxRxJL0ocYil2e3AYw7EKbSAba2DuXLU=; b=E1JC7m0IvmEH4Fz1HT1DKWxjeT
        zxoCiQiIjhKIB6c0yorUjccChfq6Go4cOfJoi0x7yf9TroVoErhgHg38Tp1V+gh35hjuisbcAp/Nz
        Dj6wcbBT/nnnv8edAHt5GAXryjqRMSg6vjk5VVXLGC9xRbqN3rOHNad3Op8OFyF+RfFPgOUXcZvIQ
        7q6bABrGTFM44I6k4Ib+2gwWLf1WkwirHDsi1Ezt4VySCgovI1akHTGXBsw3JFlhupcFBjEV6y5hb
        BsImcs/rP9rcpygb4RolH4EmeUgCuBuAATwdWQ/87vQs19VHo9424XBcZU3Nbn5Fcsyi3e4a/S/hB
        Pq5jwZaQ==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvxvq-00FBzP-Mu; Wed, 23 Jun 2021 08:08:31 +0000
Date:   Wed, 23 Jun 2021 10:08:21 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/46] mm/rmap: Add folio_mkclean()
Message-ID: <YNLr9Z9iPWhCpoQS@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-11-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-11-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 01:15:15PM +0100, Matthew Wilcox (Oracle) wrote:
> Transform page_mkclean() into folio_mkclean() and add a page_mkclean()
> wrapper around folio_mkclean().
> 
> folio_mkclean is 15 bytes smaller than page_mkclean, but the kernel
> is enlarged by 33 bytes due to inlining page_folio() into each caller.
> This will go away once the callers are converted to use folio_mkclean().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
