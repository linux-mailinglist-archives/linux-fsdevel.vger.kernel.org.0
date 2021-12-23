Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC9147E04B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 09:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347092AbhLWIVr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 03:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347046AbhLWIVq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:21:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B42CC061401
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 00:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yxcI42FY7uF3+Lc7kon6/Ji0Ooyvxwrf1ZYOuY//PjQ=; b=rqVXtvHWztcY9g00A8nQdWPfIQ
        uXt+Zu/MVCXxQgxP9tH+s1XnNdyNod4D6JnpdSxMO0+75aBXIXf6I1eSbDA6aXkLkXz9E4AXscK3i
        58lRmd4jxPGWGtLncTUGhp/dOijGtGFbDMmjyDoE0vYUi+zldCyR1oyCtO7bhuPrns9bqMaINx2Fg
        lShZL1tqsLizpIFwMMCIvm4qsrRCyazQm1+wVBiim6Ujn/Novq/x/cANTN99o3lnlCzJW/92s3bb3
        z8wC76E2QLjIShazz3IB7WbqFTTwh7am40iWA+HgRU+hQYqFxDCxBFSwznVXHAE+Vyz0eJ7OdQbde
        nJ27gmKw==;
Received: from [46.183.103.8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0JM9-00CCdZ-Df; Thu, 23 Dec 2021 08:21:45 +0000
Date:   Thu, 23 Dec 2021 09:21:42 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 36/48] truncate: Skip known-truncated indices
Message-ID: <YcQxlgwuCT4nkL0d@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-37-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-37-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:44AM +0000, Matthew Wilcox (Oracle) wrote:
> If we've truncated an entire folio, we can skip over all the indices
> covered by this folio.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
