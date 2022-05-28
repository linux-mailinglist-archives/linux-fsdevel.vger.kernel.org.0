Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBEF536B00
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 May 2022 07:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343606AbiE1F7W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 May 2022 01:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiE1F7S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 May 2022 01:59:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00D02A7
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 22:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xyCDK9DP8eofvsC1zCeXyiacUzLYcZRCqrNJb0EEkaY=; b=pUCnxfNgL0UZxOGcVXjW8yEEzk
        LAXpAwfmaFYiL6USOBxMBtUmUlk5kF1dWz6SDf7XpSV+y5NNDBnvLVwEHFLd1mKZiQ52OKKNt/tt7
        jXEKH+i7RJnv6OO8TG9ZskW13dT31honILgscMwq6wMGrQd3RCmYoMyau8ghMd5Rj+Gw2A4SBoRtZ
        Y7VpfEUQRp0PJrqVfZFFxHzBtGk3a+8sirunF70j5qVjGCxXh9dpaz1t9VJtyz0A/7FVJxIpVgdhx
        jI+xP/eip7WRq2Z4K98qLjuuG7rQEhFB9A3XjothUc2mA5rCbp9oyM8W5ydPanrl/qIXc11T60U0W
        Bdvm3TUg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nupTp-001Wbn-Bb; Sat, 28 May 2022 05:59:17 +0000
Date:   Fri, 27 May 2022 22:59:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 15/24] jfs: Remove check for PageUptodate
Message-ID: <YpG6NZPxbIIfuqYg@infradead.org>
References: <20220527155036.524743-1-willy@infradead.org>
 <20220527155036.524743-16-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527155036.524743-16-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 27, 2022 at 04:50:27PM +0100, Matthew Wilcox (Oracle) wrote:
> Pages returned from read_mapping_page() are always uptodate, so
> this check is unnecessary.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
