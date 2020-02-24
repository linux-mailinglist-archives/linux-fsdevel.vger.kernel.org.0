Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 548F416B354
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 22:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgBXVyn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 16:54:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39946 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbgBXVyn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:54:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5MRTbwLPWhsz+OCfhc7KfndlpxpBjNwdciDoRgQ9Kiw=; b=UH81cZnwNAU0qj0U69UGyTcrTv
        s3U/2WEoUZteazt25hpIrP9mx2czSA73w1KKBo7jGQ2t7egu9fl8mN83EDjcSVbHFMPIlC0nz0jrE
        /sHO9tWieo1tWKMbYptvT/SEf3+uUhXvREH+sjpmBlq0Ix+GchDHn+n+UAer2XM6ls7irhVTLYsw4
        dfhQXNPHta9xRzxr9BLoaH+QyGz14ciyXbQ/Bf67V8Mwsvu0zvUzAj17rcatmJ0byo4OM++Tk9PJC
        fnSZ2gijdW6WE7VdnNAWYFBO6aYhYQh8JMyM4jVzhoj3AKirlrfCJSKYf4NtObVE2kjUhSCTXIPzv
        kIxJP4xQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6LgY-0004om-8r; Mon, 24 Feb 2020 21:54:42 +0000
Date:   Mon, 24 Feb 2020 13:54:42 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-mm@kvack.org, ocfs2-devel@oss.oracle.com,
        linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [Cluster-devel] [PATCH v7 13/24] fs: Convert mpage_readpages to
 mpage_readahead
Message-ID: <20200224215442.GB16051@infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-14-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219210103.32400-14-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 19, 2020 at 01:00:52PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Implement the new readahead aop and convert all callers (block_dev,
> exfat, ext2, fat, gfs2, hpfs, isofs, jfs, nilfs2, ocfs2, omfs, qnx6,
> reiserfs & udf).  The callers are all trivial except for GFS2 & OCFS2.

Looks sensible:

Reviewed-by: Christoph Hellwig <hch@lst.de>
