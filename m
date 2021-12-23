Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC13747E049
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 09:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347081AbhLWIVe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 03:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbhLWIVc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:21:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DF8C061401
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 00:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lty7hDr9w4xjVIuMp+6zLsTciTFLjhqe3Mw/weGUnNo=; b=BXYjNeqGdvQt27izW4q/p25NRP
        TmMNX2WUfc5nCqfSwK67MgVt2byEBPTuVU7miO9KCt+fUqfzprLpFCTXy/p8zdCO4z1/s0z4VJ44F
        K0FxP8OU03OFUCVcGA+RSicdYwNnNMaPcyf61qDd86Dw4nD/0zGS9JguYvt74WB+ycNINR7sQTmTC
        PYSHrnZUl7pYdjnJ/rsRsKNnHsV2Eg24O98ur+gIM+UIyp7FKM7EPf2h3kMsQxRUmKeLRwB8JJmoJ
        1txkck/Vys4pu2LJlCnTwo+xrNOW7xZhUySPm4d1a1xvZTveoVBnoX1NfUv/+ZG/F3i3IgEyzDyKJ
        Qq5FaK8g==;
Received: from [46.183.103.8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0JLv-00CCZ0-Dj; Thu, 23 Dec 2021 08:21:31 +0000
Date:   Thu, 23 Dec 2021 09:21:28 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 32/48] truncate: Add truncate_cleanup_folio()
Message-ID: <YcQxiF67LsevQaaj@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-33-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-33-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:40AM +0000, Matthew Wilcox (Oracle) wrote:
> Convert both callers of truncate_cleanup_page() to use
> truncate_cleanup_folio() instead.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
