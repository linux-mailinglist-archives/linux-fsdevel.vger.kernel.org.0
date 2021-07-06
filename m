Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A0D3BC5E3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jul 2021 07:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhGFFHx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jul 2021 01:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhGFFHx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jul 2021 01:07:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7912C061574;
        Mon,  5 Jul 2021 22:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2u08xJ4GVCg5E6zYepfgIn3nrX4Q5lyAh1bUx7RCxR0=; b=ozh9DwOY9a0I6YafQUa2oVwrkA
        lUB6RMraEPAnS3eae+QeaONZo/a2mwardNoEvYtoQMLPjfoU8IyXzwJqiJAAueeyv/e74pMG95Rsr
        V2Y/lOKtOGOk/4l7sCqLjUuCCAGGOMH3BMvA/TZbb9Z/bzbsC1y+1vIgCRLr6qHQiqjb4n6C6PZiU
        S3m/qmGcrGnXnvTLrtZoVhTxyvXlVw7/e+GU1kRfO5UkyF/SG09UHM2KXlIzIKURINVjK1PVv5hQP
        LtepAT0yiNI5nuIdc41YzbU5RvWVWtMMKMHyYGwkXhB1/J20otKCWJe7H1esUJYt7Zc0VT5UMyz0Y
        JQidHCig==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0dGC-00Aqnp-Eb; Tue, 06 Jul 2021 05:04:47 +0000
Date:   Tue, 6 Jul 2021 06:04:40 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com
Subject: Re: [PATCH v2 2/2] iomap: Permit pages without an iop to enter
 writeback
Message-ID: <YOPkaETeh5/x1M9e@infradead.org>
References: <20210705181824.2174165-1-agruenba@redhat.com>
 <20210705181824.2174165-3-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705181824.2174165-3-agruenba@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 05, 2021 at 08:18:24PM +0200, Andreas Gruenbacher wrote:
> Create an iop in the writeback path if one doesn't exist.  This allows
> us to avoid creating the iop in some cases.  The only current case we
> do that for is pages with inline data, but it can be extended to pages
> which are entirely within an extent.  It also allows for an iop to be
> removed from pages in the future (eg page split).
> 
> Co-developed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
