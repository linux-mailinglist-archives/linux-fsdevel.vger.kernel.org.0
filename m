Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7989847E044
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 09:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243081AbhLWIU6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 03:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbhLWIU5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:20:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D027EC061401
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 00:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tcKK6pN/UwwEGFWmWI6SYXxz2S5qH87i2zAJdNfp5M0=; b=W7HxXeBAGCHTo1iajzN6yUGoB6
        ZE//PMrVb/USOxXWyUq7lN+ix80IJHZPMnUPosyjsggl+XBGYQaNj2+0k5xwH1tXYj+xA/K6z3d8t
        tZKOdho62FFRQkh6+PZ7pGbT77LSaz4HRP1FYc21dgCfcOn8fpvkBhYNkk/hFwOHFUAv0Rb/a9hcP
        hsDH4SDGhfjCnpJdrTSXF3x76bv8WPISuedhO0e323cwswsrzEloPTwxkr+BExBsgy9gE6LVHX245
        LioVcA0gVT1RzhHR/l+ittDaQC5pi12Y1MQkU9uTJK784+fq2jqvUu9EUm9GjlYTDaXl7Duk/lz2K
        ItyBaRwQ==;
Received: from [46.183.103.8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0JLM-00CCKH-Qg; Thu, 23 Dec 2021 08:20:57 +0000
Date:   Thu, 23 Dec 2021 09:20:53 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 28/48] filemap: Use folios in next_uptodate_page
Message-ID: <YcQxZcooEt5lRPjK@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-29-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-29-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:36AM +0000, Matthew Wilcox (Oracle) wrote:
> This saves 105 bytes of text.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
