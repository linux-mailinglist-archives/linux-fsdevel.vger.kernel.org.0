Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A804D3B15CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 10:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhFWI2G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 04:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhFWI2F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 04:28:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FE7C061574;
        Wed, 23 Jun 2021 01:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nkXQEJ9ObbpqmOvY85IoSmKVLOHgeVa9IcxyNhc7GBM=; b=slmBXPq3uGYWJaJ+Krh3XtiCNV
        yUJ3PaLbugbR+/PwsiL1KRajQzZEPFgMGr6qJsM5fsztVnvFgCwKuqEsBVdqf0zLB786WxyY1Y3wu
        QVLm1+3tMmGBT/inCNU0BmjqYbw7yp5OT0MJ9L//ahYkw9AUPSLKPZlghnUcV9ZCaxXOSAtlymIwK
        FPRi//YfSXUMg1FXQ0m978c+HTcDXIa4+PYJbEDa9hYIbcumiF4MFuTeIhgUHJM+Bmh+tVr9X0L75
        AjjLC4QWalWMqpp2P3hvtIUC0j+2XBRZ+Zylp8qw3rtKo9epae0kvWcQKIeKFJP957tVOdB5e3KvF
        ZFWvF11w==;
Received: from 089144193030.atnat0002.highway.a1.net ([89.144.193.30] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvyC2-00FCxC-JP; Wed, 23 Jun 2021 08:25:13 +0000
Date:   Wed, 23 Jun 2021 10:22:55 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 18/46] mm/migrate: Add folio_migrate_mapping()
Message-ID: <YNLvX0ODZ8eQPFpK@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-19-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-19-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 01:15:23PM +0100, Matthew Wilcox (Oracle) wrote:
> Reimplement migrate_page_move_mapping() as a wrapper around
> folio_migrate_mapping().  Saves 193 bytes of kernel text.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
