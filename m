Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE24344A961
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 09:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244354AbhKIInA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 03:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244329AbhKIIm7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 03:42:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA5AC061764;
        Tue,  9 Nov 2021 00:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BSYDtyvtxeYO/3QhAbbeuQvbeug4v40pkj0aP/DoEd8=; b=gDTBWoIO6TQv0vujnnllbx8Hkt
        La4VlhI+jfAO1deCZd0J3l1kwnmGPEfHAf0M/b9uLT+slc9BqvxuvcZR8GVQ9GVTGTtenVErS0ZCe
        q5Ox/tYapOGoAg18MH9GXl4M96lCI/6dEzjpn+swqgsfk+mvKTTszbVfe98A+8YAknacLBNZIirYA
        /seP70EgsU4yR1cqoz+zy5V+O3t5KJ7wc1jiUSmfxFI4gIbT/HABK7uRxX2opBudqn+MzKDEqcF98
        o72Ed6sh9YlEpHyJpvM/CtakGIzsQmRX/W/rUMZWMhL4IDQr8ZmejOh0/w6R+8ALtbfbTRqRbZYnK
        5jnlfJzg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkMfs-0013QK-Vk; Tue, 09 Nov 2021 08:40:12 +0000
Date:   Tue, 9 Nov 2021 00:40:12 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Darrick J . Wong " <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 02/28] mm: Add functions to zero portions of a folio
Message-ID: <YYoz7FPK/vHdsV2Z@infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
 <20211108040551.1942823-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108040551.1942823-3-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 08, 2021 at 04:05:25AM +0000, Matthew Wilcox (Oracle) wrote:
> These functions are wrappers around zero_user_segments(), which means
> that zero_user_segments() can now be called for compound pages even when
> CONFIG_TRANSPARENT_HUGEPAGE is disabled.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

Related note: the inline !HIGHMEM version should switch to page_address
instead of kmap_local_page to make the code more obvious.
