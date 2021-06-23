Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F133B1632
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 10:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhFWIut (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 04:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhFWIu3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 04:50:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEA9C061756;
        Wed, 23 Jun 2021 01:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M9F8mCIj4S0MvLdVHR7/mG/7dfK1HG/42QHJ9bt57Mw=; b=QgT7SsfZnH11MtnYoWG+JXh1Os
        vdQeZo22TK21CfDJjWwvMc+YDcoiH4H/YHEnqClzEtN00dP2YeAJub+W4bjQHj40J2G4vTMSeH4JH
        6LSWbrrcdcGo1z72aQs95PEA1Ur28FLtPb8yX6kwzqnOJa2y0ca65ScwTqAHrOsQ7RuGdzv5SE3m0
        YLA5n2oydCIHu76H+Z+dTMJy5bd5v5gDLj2ICzKyGTaJGXNXru8IiUDlfuU4WCdrV44VVC2xWiAhT
        aaQ4q/VYVxWBmVs79lqQd2/toQM8a7/U9mARJ7GHDivgx8vR5pRCw5nPvhAakEprZg/WgQMTjqANN
        vZ5j60Qg==;
Received: from 089144193030.atnat0002.highway.a1.net ([89.144.193.30] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvyXZ-00FEAL-PC; Wed, 23 Jun 2021 08:47:27 +0000
Date:   Wed, 23 Jun 2021 10:45:11 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 23/46] mm/writeback: Change __wb_writeout_inc() to
 __wb_writeout_add()
Message-ID: <YNL0l6AOT2RogKS7@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-24-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-24-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 01:15:28PM +0100, Matthew Wilcox (Oracle) wrote:
> Allow for accounting N pages at once instead of one page at a time.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
