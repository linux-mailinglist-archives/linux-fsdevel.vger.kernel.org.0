Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C30A3CE994
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 19:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351047AbhGSQ56 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 12:57:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358989AbhGSQzO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 12:55:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 280546113B;
        Mon, 19 Jul 2021 17:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626716154;
        bh=NYmQ6IRkN/PxglP3djDkvgqrAEknbuBJU+iUM2YO1rE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ucVjyOviSaBpuw/7M2fEKs6WI3F51ULm8H1wvTSYV76JEBmCCABhLVsIoBXDU2QlM
         y2/nVH7CcofyuZif5/RyR1fLanVEcd8uG9WSh5b1v8Kvzwn/nhWWKBPG0iLwbsr91p
         n5kCHszSrLmhQS2cRCAwhGR2aoGQcQF9sP1zdX7thQMhVzj4ussWwZuJ/jqMQTjXpL
         ICCJGBYWd1YMHjAkw+O0MVGnSaRwR1EG++WvwypX0klpg5XTBAB810uNnYbqqLvXpD
         EGxz9RRgmZCQgDyVGxfFJPvRlUTQ21STN3t+VXOmZ0uwcLf4BLq6Lmj4rCkbHe+I8F
         yvnSVdnmo6FXw==
Date:   Mon, 19 Jul 2021 10:35:53 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: Re: [PATCH 07/27] iomap: mark the iomap argument to
 iomap_read_page_sync const
Message-ID: <20210719173553.GG22357@magnolia>
References: <20210719103520.495450-1-hch@lst.de>
 <20210719103520.495450-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719103520.495450-8-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 12:35:00PM +0200, Christoph Hellwig wrote:
> iomap_read_page_sync never modifies the passed in iomap, so mark
> it const.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index e47380259cf7e1..8c26cf7cbd72b0 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -535,7 +535,7 @@ iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
>  
>  static int
>  iomap_read_page_sync(loff_t block_start, struct page *page, unsigned poff,
> -		unsigned plen, struct iomap *iomap)
> +		unsigned plen, const struct iomap *iomap)
>  {
>  	struct bio_vec bvec;
>  	struct bio bio;
> -- 
> 2.30.2
> 
