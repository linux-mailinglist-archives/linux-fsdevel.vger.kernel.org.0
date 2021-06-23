Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDEE33B191D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 13:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhFWLmm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 07:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhFWLml (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 07:42:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFA3C061574;
        Wed, 23 Jun 2021 04:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jGK9U4DdDhTnapEAkzMQa9BXuVanyBr75qSjp9gCCic=; b=fzHUSdynvSPD/EuKdmu1g+AnhF
        VxoW00t3XURKSmmS8da4p+dDSBE6jFkDpvbAiFmM1nQkxRa4wpQ31UuM/bFMBP1CJ6+7ypqS2DZWO
        Gq+yM0QMhQKfJkWktpiL1KfH0riBAgnTONY6KxOIPP5YniYEoasY2jf9FkmBM5pRRO8HIAUcB9XPo
        qLi0ryv1b0yuiSrXAWLPzBaMFzRTQIHD5iONYp3Zj536v06iQHVMnDPJ4HS75eAHu5O8jP9y5zI3Q
        xbYaF4ezJIdZVoILgUoSAWSEXNDnlI76b9vGfnjSs09vw1DqSJIP67fiJtNr7Dlhel//7VsWCeszj
        4p9/DCGQ==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lw1EI-00FN9b-Ae; Wed, 23 Jun 2021 11:39:46 +0000
Date:   Wed, 23 Jun 2021 13:39:37 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 45/46] mm/filemap: Add filemap_get_folio
Message-ID: <YNMdefqQ+Z17SCon@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-46-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-46-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>  /**
> - * pagecache_get_page - Find and get a reference to a page.
> + * __filemap_get_folio - Find and get a reference to a folio.

Maybe filemap_get_folio_flags is a better name? 

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
