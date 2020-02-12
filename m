Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE2D15AF95
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 19:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgBLSSM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 13:18:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41994 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgBLSSL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 13:18:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4+pGNKZQNPPjUYhUfxAE2vdkfqWETPzu/0lbzblOiLM=; b=qC1Fti8lZ0koII3U5Sa2TjOM28
        nosTSzdm25oQSeIMGq07AVlCw20djEBGUpWliyiKQwITDdQcoaxm1uXqtkNjwxfTpJNhiOtI8jhOb
        r7GEIlGzU7vqitlAbk9aJYzHnlfzWJw31vQC/Z3Til1uih5qj+enBDV26fhdRz3DdCxYbTIaNuUIX
        2OnWR1DrQfnRApPtzcldB3qtqOzSKFM+aq41f9gck471QDMk1xCwWxmFurCQfy00JF0ZQaamhxAYP
        Bw2GDAtxWrBD9CBq026AuSAIvMitA8b0oUDL/p3WShFpcX4ybJFYzF5XIQaHgMzYrROtQoZVzZ4bv
        WrZl7SaA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1waR-0004Q0-E1; Wed, 12 Feb 2020 18:18:11 +0000
Date:   Wed, 12 Feb 2020 10:18:11 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v5 04/13] mm: Add readahead address space operation
Message-ID: <20200212181811.GC9756@infradead.org>
References: <20200211010348.6872-1-willy@infradead.org>
 <20200211010348.6872-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211010348.6872-5-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 10, 2020 at 05:03:39PM -0800, Matthew Wilcox wrote:
> +struct readahead_control {
> +	struct file *file;
> +	struct address_space *mapping;
> +/* private: use the readahead_* accessors instead */
> +	pgoff_t start;
> +	unsigned int nr_pages;
> +	unsigned int batch_count;

We often use __ prefixes for the private fields to make that a little
more clear.
