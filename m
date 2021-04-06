Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E019355517
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 15:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344454AbhDFN2R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 09:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243904AbhDFN2Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:28:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E484C06174A;
        Tue,  6 Apr 2021 06:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T/T0StS85vOojn+8VsGj+oRfQclCL8/+0N+T1Ix+gjc=; b=v0GFXjLk7blqGLuzSOraf1z6ki
        GNb7HOREoXZ6+IL1EwgE8Dk4Ehbq/kFsU9nLYqsPDr9Z7bOKUKaKOGSJECeNP1kUhtoZ3BqpsUKT3
        oPe57cFOpocHvjAMigSifAcLpvF9q47zZ1VQ0celd5e0ieBnfUy+aZHYTZ7E4DXmSBSdbotZvl/Zc
        5wVe3C/FyjeRfazG8x19smQs5+ldwtAMtbwdJgTS/bORXHnreWDhFacoW6g234mxW+pZmF71gbHim
        RwzT20R0G+W4xQBCs0311dOw5Cux9P42xs0aMnGZOyoFljXW19KiHu3ueyrhdh5w56yhYn5nrPkEi
        j8AK8i3Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTljM-00CrFF-GP; Tue, 06 Apr 2021 13:26:58 +0000
Date:   Tue, 6 Apr 2021 14:26:56 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v6 04/27] mm/debug: Add VM_BUG_ON_FOLIO and
 VM_WARN_ON_ONCE_FOLIO
Message-ID: <20210406132656.GC3062550@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210331184728.1188084-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331184728.1188084-5-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 07:47:05PM +0100, Matthew Wilcox (Oracle) wrote:
> These are the folio equivalents of VM_BUG_ON_PAGE and VM_WARN_ON_ONCE_PAGE.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Zi Yan <ziy@nvidia.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
