Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412CE44285B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 08:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhKBHaZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 03:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhKBHaZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:30:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A22AC061714;
        Tue,  2 Nov 2021 00:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2pzVrj3KgNRJSfwqecJlS+yDSqGzz8+/uIWD40ya7Oc=; b=sUwsQIAmrzIgMMT4X50/yhEmVo
        Tm8HBPcT+iwr8N5eNjVTXKeDn7tIcpFE66El5nBvM9CG9TyQnQ9rEYknLplaK597QTSE0LQ2lKY9B
        ml/3l2Eidy6gC6akywufb7XtuYQnR/9975/n1n+TVjaanhi3EG3+8Yn6/9uRQgroSjZJDdKOx7X4K
        wSIytga43+/0qRlE4Ky/DqzDQN7iHAZmU3BAgZ/CU3smjvKgmb15pq3+2sZKTNb+Lmu7QGBd5em1j
        jQT7BfJYmbzOjjl1JxnSMb9trK795UXWSpPp9TDEPrQtFs082m5621mgpiAqqO1zhTp+7+xTO3xJL
        JR+JFwkQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhoD0-000mPl-8b; Tue, 02 Nov 2021 07:27:50 +0000
Date:   Tue, 2 Nov 2021 00:27:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 21/21] xfs: Support multi-page folios
Message-ID: <YYDoduRUjSwPouEJ@infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-22-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101203929.954622-22-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 01, 2021 at 08:39:29PM +0000, Matthew Wilcox (Oracle) wrote:
> Now that iomap has been converted, XFS is multi-page folio safe.
> Indicate to the VFS that it can now create multi-page folios for XFS.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
