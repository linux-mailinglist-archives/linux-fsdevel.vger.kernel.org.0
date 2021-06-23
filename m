Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0739D3B1560
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 10:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhFWIGe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 04:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhFWIGd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 04:06:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CC7C061574;
        Wed, 23 Jun 2021 01:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2y3OIa+QLTVGS+2NplfTD0tYhb0SHUMhfsCjmhkEzy0=; b=nn1t9K3/J+jNiEzXFSfWmjiFWn
        iaij1kuBW8kV91EHzFlxTq1uXYS1aC1tfqtmWDahyOAZIYONKoRQRBJXkEmLg4VXG60Ec7GEwpYHM
        sen6dojTk5yosIDDmo8gc1rG8v/mPRFM/NcOwD7bUAFPUvNpbzxYApPrfZWFwL5yuvGD7TLaT+bo6
        XezWnYuKzU62L47pHiBD4OjzPyX2zIlMEX9WtuGHCSi94Sod4juNJxBLQm6il3YhDpuErJUFmpZwh
        ESIaj9P0qTiC1+gZkzYoAqUVK3stKej4XxZr4h/heGx40krPJzYYYWHrtvIUVPe8/YBAP+gTMeTGR
        cj1m26rw==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvxpl-00FBdn-PD; Wed, 23 Jun 2021 08:02:30 +0000
Date:   Wed, 23 Jun 2021 10:02:04 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/46] mm/workingset: Convert workingset_activation to
 take a folio
Message-ID: <YNLqfMjYHxXxCqPj@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-8-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 01:15:12PM +0100, Matthew Wilcox (Oracle) wrote:
> This function already assumed it was being passed a head page.  No real
> change here, except that thp_nr_pages() compiles away on kernels with
> THP compiled out while folio_nr_pages() is always present.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
