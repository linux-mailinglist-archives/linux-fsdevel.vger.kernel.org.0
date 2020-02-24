Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6F8B16B29D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 22:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgBXVeW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 16:34:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60768 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbgBXVeW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:34:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h9cf10iCtPnLTwQuBkW69J+FxlKeKDa7FzCrtD5etU0=; b=SH4Zm1WNzfTYIq/DSOIWvy23AR
        DPI2x856EKO69cJRpJCTmsHgo0z6UGzPyz8tuDkedAoWSDrmd0XLvyNGo0ZFn23cYKzgxrSIbnVPs
        y+Dq9RA/hLxGChXr6yzrG/KoBeSqmn87OHIzV4YnKWpzMEuTbLGzyg3OlF6Q4W6VvIlLj/mkRqHZ3
        pgfbWw+L5oQzWZ4yKnwYZlV3vdfGyNuccDRKRJWYeVANIZD9sqM66SjndKE/I0CLgxxmJluCB3AZg
        Pkxzvi+K8MiCbR8OJgHI/Qj/Uxh1mGjYn/DviBficxtzsXL/izjjUx90L69WAIKw2tupIeOWUnpjz
        3ONnfXdw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6LMr-0004Ee-Q4; Mon, 24 Feb 2020 21:34:21 +0000
Date:   Mon, 24 Feb 2020 13:34:21 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v7 04/24] mm: Move readahead nr_pages check into
 read_pages
Message-ID: <20200224213421.GC13895@infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219210103.32400-5-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 19, 2020 at 01:00:43PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Simplify the callers by moving the check for nr_pages and the BUG_ON
> into read_pages().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
