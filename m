Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B5E47DF75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 08:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242523AbhLWHTP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 02:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbhLWHTO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:19:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBE3C061401
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Dec 2021 23:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NUThKfEp2/EPRFWq8DHaKQgr5SozQb0kG50VH9ntXZc=; b=aTfkkubaf98tTtfEnY1GtfqDso
        aNPF2aGnDhWtfAeaD7Wkn6lrZCLGWcDGGhc1QNcMFasXKbCUIUnP+dlW6P9cWYtPAcs5muHYU94uj
        FcmV01BEK/3EDi8QHQQeAkPNRNjBvxKx4WdEoIwwQiFDeEkOi0QoYnnXKV7DoDTR2/cJN5r/X+O6C
        5ESuGG4kcB+YhQuBS9vY7tYeuuMpkaZ9/VVu80lJ90CuDuRGST93pO3VrvfcMVPM+0KFZmxx2bkyO
        V0jqsF3NUKLJNruyGZwfoMJyRNGimi0nteg3V7JdhigZO7A11E3tsO77GzDZcbD9MO+MWXEjAhrFM
        VxOuV6Kg==;
Received: from 089144208226.atnat0017.highway.a1.net ([89.144.208.226] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0INd-00BxqG-DV; Thu, 23 Dec 2021 07:19:14 +0000
Date:   Thu, 23 Dec 2021 08:19:10 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 21/48] readahead: Convert page_cache_async_ra() to take a
 folio
Message-ID: <YcQi7mjAcyURDt4h@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-22-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-22-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:29AM +0000, Matthew Wilcox (Oracle) wrote:
> Using the folio here avoids checking whether it's a tail page.
> This patch mostly just enables some of the following patches.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
