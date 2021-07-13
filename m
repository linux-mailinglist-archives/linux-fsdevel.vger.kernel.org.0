Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BCB3C70D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 15:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbhGMNDN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 09:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236205AbhGMNDN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 09:03:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A484C0613DD;
        Tue, 13 Jul 2021 06:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1V2jvMd6fkqgaw3BDHpPrRymG8iF/gqgfe5cZeoE7o4=; b=aASw1OG0HXB2Ba8ksyTd2aNaF4
        tbpIX+LCSBAiUPfKx2svBBM1WYcflGAi9Pj9I/u8f6S7y7VANyU4HAGiUY+S7azJQI2vJbRT0zLcs
        qdy7KzDflj1lahfNLXDjh/9Hw3zrZXkLqCWO9QHSFPcrHuJdlsah3/WhQuWj7TGN9NyC9CilmREo0
        youe0hjbL/NkmoFBsjgbg6kt/zWvr7OB2dhOwAwTuIx2/rhaP8p6bD+V/rFO7xgL7Fu9Wk0ElbMvy
        UeXIGX6AvJXiONZ9xfuQP+R7FPlrQJsKto92FVM7TSQxbFcY2qanIOfCB96A+rWlHNk3vtqYDh8k1
        k6WidyAA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3I14-0017FY-1y; Tue, 13 Jul 2021 13:00:06 +0000
Date:   Tue, 13 Jul 2021 14:00:02 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v13 14/18] mm/memcg: Convert mem_cgroup_move_account() to
 use a folio
Message-ID: <YO2OUsXpXlOL3UrG@infradead.org>
References: <20210712194551.91920-1-willy@infradead.org>
 <20210712194551.91920-15-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712194551.91920-15-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 12, 2021 at 08:45:47PM +0100, Matthew Wilcox (Oracle) wrote:
> This saves dozens of bytes of text by eliminating a lot of calls to
> compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
