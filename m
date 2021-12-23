Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B5247DF29
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 07:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238781AbhLWGuV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 01:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhLWGuV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 01:50:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303EFC061401
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Dec 2021 22:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FXulMOdUSWeHSqwXEyniid+5V6MWFeV/fkkj9Viv3EM=; b=mI8mSZuTBPNqYl9udtoIbqtxQD
        OYFOAgEEYHp6MuyxoOHYKMidLFY3WYCwN4xbPmLtlKkXimshPZ1C9h5YpHOX9bT53XDV3OOCKuZiF
        sAi7LD1zDInFJlwxHHnxf78UqHAnwv4oNI0KovZKvypW61dfcSmhJqkjOQz5wONoyhb5PPqI+UPBl
        a+xvyz+TbIxcDg1N1vO6qatzipjm2pcePB8jnZT7no9aVR73C8ygJusEwpv9f1+6uHyTnlDYRt1EC
        JzONMPwrgmKG0xnTnrX5Ytjpf8qUX1GEqfYm7PvukXRDbfYW9J3LTwF1kmFvHkGVs6Yxk1os+rkmO
        zU9VqPaA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0Hvg-00Bwjq-QP; Thu, 23 Dec 2021 06:50:20 +0000
Date:   Wed, 22 Dec 2021 22:50:20 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 02/48] fs/writeback: Convert inode_switch_wbs_work_fn to
 folios
Message-ID: <YcQcLPS1uEYHIYfY@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-3-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:10AM +0000, Matthew Wilcox (Oracle) wrote:
> This gets the statistics correct by modifying the counters by the
> number of pages in the folio instead of by 1.

We can't actually hit this for a multi-page folio yet, can we?
So this should be more of a prep patch?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
