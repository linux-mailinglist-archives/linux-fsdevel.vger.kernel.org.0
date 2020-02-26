Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30054170560
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 18:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgBZREA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 12:04:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56246 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgBZREA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:04:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i01gqbt0jOHS7aGnKGoXT1IDiIj9QTdzfZHq4JAzLSo=; b=oqOxzjNkWmxBrz8Psl51Ce1Z8a
        CoUtrBZpVrG1/2uCCd01MozOk+KMmr0tyOUPJqIpBVm5PgJwu+LZ1c0sfkvxGyq53nig6YUxxSV1U
        EddKbm+YfV3Ef27L3Hi4/Llm6OFIZE3fFNI2XW8ZE8l6ZFJuF0XtiZxlnbzqNWcx7tIdf/jfCV3z8
        jQFdfdccS0VLC51pKU6fua8dOSbwQX8aY604bXJovdkgGT+n4JO9JEc49EazIugwXuoMxsLVHC3df
        Q5QSRHuHd8evZwjGnh2wbQMmYq1ugQZe9iV5XU7vQf0VmfR+nGwLM7LXyxH9I9qNyKWfQ9Chi+FMq
        jLUY6TLA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j706J-0006aV-Gx; Wed, 26 Feb 2020 17:03:59 +0000
Date:   Wed, 26 Feb 2020 09:03:59 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v8 14/25] mm: Document why we don't set PageReadahead
Message-ID: <20200226170359.GB22837@infradead.org>
References: <20200225214838.30017-1-willy@infradead.org>
 <20200225214838.30017-15-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225214838.30017-15-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 25, 2020 at 01:48:27PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> If the page is already in cache, we don't set PageReadahead on it.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
