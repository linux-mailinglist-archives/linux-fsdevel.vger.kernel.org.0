Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0A83CF4C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 08:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241593AbhGTGJ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 02:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241250AbhGTGJw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 02:09:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF027C061762;
        Mon, 19 Jul 2021 23:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lMtcatGAyLABwHy0lFwp2XqMHE37vGNK4KvilrkVbV8=; b=t0kTfT+1W8U+XE7LNqb14lUUvc
        u3PVhyjAKrd03M9aIGVfPFzbq0ec6mYLLZH1yd3nA3sXo1yYS1ddJp844GJbeTv0cKoAR6tJDDvMq
        8RINMfMTRJ9gJA/uTWkPyS/NrOduxJMuBWoGLjyUQjd2Govtw8idxNC7GEs1kW/lDJ7WWGEdPkxuT
        0Yo5UBGy9uaKGgivknw47KJq0dxNPUWgduz5sK83Gip8rUEBwFWA/ftNce/bQ6zqY+uAtWb4bNOv/
        DRSKxq5Zq87/U6UjS5DgBuY7b8BxcV0FVNjL6ezH0rgY0tNe7yFMGv0shdQOdLlbjgzZ/yu9MxP48
        r6RWEOdA==;
Received: from [2001:4bb8:193:7660:5612:5e3c:ba3d:2b3c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5jZM-007q94-W9; Tue, 20 Jul 2021 06:49:47 +0000
Date:   Tue, 20 Jul 2021 08:49:32 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v15 03/17] iomap: Convert to_iomap_page to take a folio
Message-ID: <YPZx/MY2MHc90eUG@infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719184001.1750630-4-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 07:39:47PM +0100, Matthew Wilcox (Oracle) wrote:
> The big comment about only using a head page can go away now that
> it takes a folio argument.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

(all the iomap work is going to cause heavy clashes with the iomap_iter
work, but they should be mostly context, not really functional).
