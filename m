Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8945E1907DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Mar 2020 09:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgCXIku (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 04:40:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33290 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgCXIku (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 04:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yann1UJ6E2VSa2Ey9do+WcXl7l36OBhp3PfHyqllino=; b=FvZ8B03FLHuCWauhakrJWvuqXJ
        IAzx6qcf0+KoM/Z+p0yevvoMHHcWXQd9G+DAEZNcSZ1PohZsfWqg7Rw8JYFMdxVa2hk3Aua7cWVy9
        bj2fR+gtIJvIcSYNs5397dHwzgh2FBbNb56PWa6jkU1Iw3oKPx/J3WQxg55XrNsblo0PVJ12GyJSa
        BmA06eJTfdo1vrvDdR2Og9lyQs8H2LUK6mI6Q4WkVyMDVlKZCnd7wev6oDgUbb9yMva78kGzeBNfN
        c1CvGrF4NltPJwnVGtyzRY9Rzval5a35nIeyFwo3yMb4VctCeyII/9pxOThd+SaREhiuXiK4wmjej
        8zONTRrA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGf7B-0003Xw-12; Tue, 24 Mar 2020 08:40:49 +0000
Date:   Tue, 24 Mar 2020 01:40:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v10 12/25] mm: Move end_index check out of readahead loop
Message-ID: <20200324084049.GB32036@infradead.org>
References: <20200323202259.13363-1-willy@infradead.org>
 <20200323202259.13363-13-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323202259.13363-13-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 23, 2020 at 01:22:46PM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> By reducing nr_to_read, we can eliminate this check from inside the loop.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
