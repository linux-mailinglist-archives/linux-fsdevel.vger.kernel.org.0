Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D142747E048
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 09:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347078AbhLWIV1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 03:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbhLWIV0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:21:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C0CC061401
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 00:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OLCohWYQNiq6XbGyU6bDh+OeTjydKhikdKhju4PwAmM=; b=U/Pgs58upE4aeMWT14CbnEs5SX
        rFlit95mkCL5ZDCTzLZu7qfuL/8AnwvsQ22W3fom3R4daYBZ9dFKBFF56s3xU+TOOJHjE+O5sa43c
        tjyrJMdQEB5XedWjVnZz4+ncNftOe2cC2qHR3wPXdD/slpAwsTRxTbnAYNu/bsQMN/86vpYvSoa2l
        +CmBaYEGq43FZu9NR9A73MnizQjiI3YoWV+4qD8CzV6gzIUZ3Q+5fUFM+kw4iXLdZnUVGx5iwXHT1
        fkmjbstbC8up2gYTKiZnFAzw3+HxFD8kPBMM4caJDjSwgJZ2uTsQjdHv6jTBBVrY/kCjdIoy1Aifi
        KGsYyUoQ==;
Received: from [46.183.103.8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0JLp-00CCWT-Ja; Thu, 23 Dec 2021 08:21:25 +0000
Date:   Thu, 23 Dec 2021 09:21:23 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 31/48] filemap: Add filemap_release_folio()
Message-ID: <YcQxg9zWeEnJV7gi@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-32-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-32-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:39AM +0000, Matthew Wilcox (Oracle) wrote:
> Reimplement try_to_release_page() as a wrapper around
> filemap_release_folio().

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
