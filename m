Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EDD3CE990
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 19:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353710AbhGSQ5t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 12:57:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354333AbhGSQyz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 12:54:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EC826113A;
        Mon, 19 Jul 2021 17:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626716131;
        bh=ctaebXMBllXiQLQACsNI6rLNkFdU4WNfaBVmh0Lu2H8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lGARtMy7qP392pvtKMaN9slO8tp7u3jU1T7FtRmizgaxllz3pA2eIVTAspsTS3MDL
         zAzebTFuFR1CNRPPmMnd+oXz5FBMTdrc+7RC2dzYQvdmgOZCyf6uDhTh+gjtXjPaDo
         STutVxGkpuwfYoN9IaVsM2tLMcKeeISmrwbLp7+q+SItqxbEQoeKZOfzQqajbkudKN
         yT1CuH5w5PqGPZ6FUs7pgQeFSuz645p8GsjhKF7msocIQUIPqYhJovDU8mIwFDDKTj
         dVCczixBsbnp0oeUzFT0dT+w84lhxNLH5BuMh5psLoOCW0LhOcbuP4HSRN9sQJRvVV
         qeGaZW3/NuVPw==
Date:   Mon, 19 Jul 2021 10:35:30 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: Re: [PATCH 05/27] fsdax: mark the iomap argument to dax_iomap_sector
 as const
Message-ID: <20210719173530.GE22357@magnolia>
References: <20210719103520.495450-1-hch@lst.de>
 <20210719103520.495450-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719103520.495450-6-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 12:34:58PM +0200, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>

LGTM
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/dax.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index da41f9363568e0..4d63040fd71f56 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1005,7 +1005,7 @@ int dax_writeback_mapping_range(struct address_space *mapping,
>  }
>  EXPORT_SYMBOL_GPL(dax_writeback_mapping_range);
>  
> -static sector_t dax_iomap_sector(struct iomap *iomap, loff_t pos)
> +static sector_t dax_iomap_sector(const struct iomap *iomap, loff_t pos)
>  {
>  	return (iomap->addr + (pos & PAGE_MASK) - iomap->offset) >> 9;
>  }
> -- 
> 2.30.2
> 
