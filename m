Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F763442852
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 08:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhKBH3m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 03:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhKBH3l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:29:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6691C061714;
        Tue,  2 Nov 2021 00:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0ECuhMZnHhnPuG2L7P4nL71mpuX9MiFsJeBeA8Bt8YM=; b=ar1kgdAMnWAQeAtZ9m73TnlCsT
        Tcj976efGr3GKEvKLkVtAkUVstxveqKlUTqCqG8HYW35V61XDrWpPdsDBNs8ieKHZ35G7V8eOvRXB
        B9tiHeuWUuYg2uWsl+hiIkGVnns13YtcRQ/rgdEmYlzuNNBZFLBCCQ4mUWbD2cIcscOAjMKq00S0P
        1kv37Ax1kcB7gPSqydFIcxqPzVBx5Xt8dW8TElTZj3Ms+EfvhmO/ZbtegiSsuUFwH0i5KsKQJy+3i
        Ukra6Wbbn2sPRCamaqBvJhRw8Ak2/xrGLuMpZKkNcrDqMyRH7dMFWpHb6u7cCJCbs703G8ENd0229
        KAyxkBMQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhoCG-000mHi-N8; Tue, 02 Nov 2021 07:27:04 +0000
Date:   Tue, 2 Nov 2021 00:27:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 19/21] iomap: Convert iomap_migrate_page to use folios
Message-ID: <YYDoSKgTbCRSEw5S@infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-20-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101203929.954622-20-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 01, 2021 at 08:39:27PM +0000, Matthew Wilcox (Oracle) wrote:
> The arguments are still pages for now, but we can use folios internally
> and cut out a lot of calls to compound_head().

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
