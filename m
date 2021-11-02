Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C99442842
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 08:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhKBHZ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 03:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhKBHZZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:25:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEB0C061714;
        Tue,  2 Nov 2021 00:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iTKh4saGUlQkXy+heeRTvCLSt1VBUzO1qgicCFWnDEc=; b=VF48yiTFziz3tA2Ix+pBSrWqLR
        FaZMhbjlc64almtoSeXtWC/bKH+87CXgsuTtSIJOlRuXu1ldTJiBP4xrEU/uvvsIQBdqntsVxgf5w
        9x48u+aLHriPNtJNBp+xDmdv6aVMYkxnvYskFgRPruyAG+y0qtQiJaz+Dk/4OFyuTtpyhZ0k/+I6M
        buSCMEeDMYh/xw9HObooKv0Iec8E8XYrXu7wVQCPxQmzvVmANYzok+bFeWUuOVu08xbcdK9jxGnh+
        Q1UqKsrMJnEQCG9NHrbU9QzXDpIqdtcF4cqoXqkZDj/rVHnVkPs/tJV5xDK+NZSnh76AUSx6wuh5u
        lD79WL7Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mho8A-000lfn-1B; Tue, 02 Nov 2021 07:22:50 +0000
Date:   Tue, 2 Nov 2021 00:22:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 16/21] iomap: Convert iomap_write_end_inline to take a
 folio
Message-ID: <YYDnSl8j46A62+mC@infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-17-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101203929.954622-17-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 01, 2021 at 08:39:24PM +0000, Matthew Wilcox (Oracle) wrote:
> This conversion is only safe because iomap only supports writes to inline
> data which starts at the beginning of the file.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
