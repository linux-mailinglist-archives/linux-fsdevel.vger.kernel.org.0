Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0717647DF42
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 08:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346684AbhLWHB0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 02:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242432AbhLWHB0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:01:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA547C061401
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Dec 2021 23:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/CMtbYj6USmF5qUKJhuW8hpYZe5rclAvhrvRXp1De84=; b=is3iCqgQJFgA8rB4U9Wh/TUSSk
        +LS+AiVa+De/HeLJYN9bgGSOKio/dgFgI0aCQwaZj9gVUn9zhHuJ6xceUH3S1ttxVC48CXWjKhMO6
        csEpn+FfL8MYTUPdInycGiqSgNQ53QfzfuBnjZRCkmeFTjH0GdK3HAsHRUUzVBgQt8zOdX3yYcG3Y
        EIcBFkHz4gcHRrB+guY68dKe06vS5uf5/jOzCocaQrQoA17PBAIwS8/1Eu5XW5f05csJUfe3cqrtf
        u4f3DJT8NvmHP6npKmQPH1+0YTdEc9/uL34ts4rD0AnAJA0rSSa6Qtx1lGWlKiUpaFdg0VVXppbHi
        aumwU2YQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0I6P-00Bx7e-Ka; Thu, 23 Dec 2021 07:01:25 +0000
Date:   Wed, 22 Dec 2021 23:01:25 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 10/48] filemap: Convert page_cache_delete to take a folio
Message-ID: <YcQexdCice8ut21m@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-11-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-11-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:18AM +0000, Matthew Wilcox (Oracle) wrote:
> It was already assuming a head page, so this is a straightforward
> conversion.  Convert the one caller to call page_folio(), even though
> it must currently be passing in a head page.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
