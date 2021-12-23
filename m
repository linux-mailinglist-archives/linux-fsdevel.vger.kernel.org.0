Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B9147E04A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 09:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347078AbhLWIVl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 03:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347046AbhLWIVk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:21:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DFEC061401
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 00:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1dsLd9zhPlZNL01WcjcKRjiBxxpLDAQR+vu5OM7fh90=; b=ZJjZYF/jrYYYz9JCjSfgMBxyu1
        PlXgkCYfbqHCNGaeKwz/oGfhNZje67aPq9Er1FEGeUr41Y6U1q4uJtZ1Q73M335osLZiNtOR8ftrb
        +u/AOA/zAJPhPezpYvv/JThyu6t/Urw4VudkY7rXDEWhICWO7FLbcNUbFHqdfOLmDP14kpGccVMhE
        H2M9TvIhPI+w92UHEvA7ucQgD86RsBAfUGEMjwZr5OWipLOulYCcm8IWH6tONumyB61fjUrJsmdFM
        Yt2jlpQt/pf9dq/9sebRYK26zZPRrzrU7wmCOcYL/xyZ/cdVThxrpT9vS3vm1Whzjg6YSVyYysnX4
        ghGoUl0g==;
Received: from [46.183.103.8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0JM2-00CCb6-PH; Thu, 23 Dec 2021 08:21:39 +0000
Date:   Thu, 23 Dec 2021 09:21:36 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 35/48] truncate,shmem: Add truncate_inode_folio()
Message-ID: <YcQxkMzOUPZMv/4O@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-36-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-36-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:43AM +0000, Matthew Wilcox (Oracle) wrote:
> Convert all callers of truncate_inode_page() to call
> truncate_inode_folio() instead, and move the declaration to mm/internal.h.
> Move the assertion that the caller is not passing in a tail page to
> generic_error_remove_page().  We can't entirely remove the struct page
> from the callers yet because the page pointer in the pvec might be a
> shadow/dax/swap entry instead of actually a page.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
