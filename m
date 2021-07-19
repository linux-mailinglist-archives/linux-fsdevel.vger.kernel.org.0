Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4893CE992
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 19:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353736AbhGSQ5y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 12:57:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355858AbhGSQzF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 12:55:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A1286113E;
        Mon, 19 Jul 2021 17:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626716144;
        bh=ZghwYSjgYvCm6XwkQ3nFC/zAMdMRI/NSmSKvpNwNsSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qk+Wgbz9Gf4L8i+Omnpvv6j3D138WkcPi3wZUMTa+v5510cqwAdQR+OqZ/NG4uABZ
         E97x38Mbtn1OH7BAw+cTaK2Vv8vlUO790H+TQqHxvfeDTl8onvlPQ2eEKMS8kNboSd
         KD5ncqfNVwkv/ydE9fAHbrb5wlfJUEaq/VTQJPvadr3619jYQcjRoedz9YR5IQlqFu
         Xxt+rC+NXxcA93Ntbp9q872yGrSvs/L/cR+GwOh1qrl86rD0v4lV3rlHLzr2T0XYTt
         HY2RsyrAtxDiipFdNNMQBYj44DgJfxFVBr6BIzmqVgZXYw3DfNtv0Ku6dqHDUOSm0w
         WtB4m0WcLNzIA==
Date:   Mon, 19 Jul 2021 10:35:43 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: Re: [PATCH 06/27] iomap: mark the iomap argument to
 iomap_read_inline_data const
Message-ID: <20210719173543.GF22357@magnolia>
References: <20210719103520.495450-1-hch@lst.de>
 <20210719103520.495450-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719103520.495450-7-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 12:34:59PM +0200, Christoph Hellwig wrote:
> iomap_read_inline_data never modifies the passed in iomap, so mark
> it const.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 75310f6fcf8401..e47380259cf7e1 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -207,7 +207,7 @@ struct iomap_readpage_ctx {
>  
>  static void
>  iomap_read_inline_data(struct inode *inode, struct page *page,
> -		struct iomap *iomap)
> +		const struct iomap *iomap)
>  {
>  	size_t size = i_size_read(inode);
>  	void *addr;
> -- 
> 2.30.2
> 
