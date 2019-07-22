Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B59AD70A65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 22:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732495AbfGVUMk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 16:12:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45226 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfGVUMj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 16:12:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bfLmWXV/nrrqXDOEWOu/R7DETbmXbOFW5IFOUQ6hF1c=; b=i9/KdvdmZnYp/DbQ0SSRUC0G8
        /lIlSLetqouYopvm9+jynzGVGTagW5Ivp+gXmk7iiVrSVAbUX05giuUT8x3IlcbB9QEk8HqAJyEoV
        nw11D5uo9lazOekAZSf5XLPXXeMJB2753CHTNmigMeLhoq+uT+of80Bk3V+pDFbAf8rBYIX4MXSOH
        dZVoXijMYBpxOgqz4K1peisUMGYHtxriCniswihBGybZHRY2dTvHGtkdCkCLx9ktnsAH7LVYX6Oat
        fCw38YMYeUA2/S/U48Ytr6eiBGsZJ93Jm/CWxe73h+jMKAipQw3hf+RX2KVorf8Ngo54twTtM0gGh
        02badTKsA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hpefi-0005Ut-NF; Mon, 22 Jul 2019 20:12:34 +0000
Date:   Mon, 22 Jul 2019 13:12:34 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] list.h: add list_pop and list_pop_entry helpers
Message-ID: <20190722201234.GG363@bombadil.infradead.org>
References: <20190722095024.19075-1-hch@lst.de>
 <20190722095024.19075-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722095024.19075-2-hch@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 22, 2019 at 11:50:13AM +0200, Christoph Hellwig wrote:
> We have a very common pattern where we want to delete the first entry
> from a list and return it as the properly typed container structure.
> 
> Add two helpers to implement this behavior.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

