Return-Path: <linux-fsdevel+bounces-53685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8056AF603D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 19:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 381343A5D14
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 17:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5810B30114C;
	Wed,  2 Jul 2025 17:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFplulPf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A711A2F5095;
	Wed,  2 Jul 2025 17:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751478081; cv=none; b=MMOZu/U3WECZpWuY47A7byjSG1gvsG5a3XlgrbUyNKdybim15H18G9VpqUbqOYIUvsrlmXKChaNl2gDUDHUwwvbnwaLHEcwunvkL0YZAp/z6cdPBAFWpKZADdW2iyye3V+vA4NOE615/PxSBRltQZeBMylqRpOFPPEx+JCcWMaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751478081; c=relaxed/simple;
	bh=8pzl2yK7FAOvJ11IohviAo18YvVaxddxmunXi97oR9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6j2+jvO6kPhi05lpoyfE0pOepc+o+LzwDNQ0YaC5TMO+feKaiVGXddNJDEvsx58lscRDvCo/nogkEYgCZadXNgIdB+RKYk2hiqcaBux4+v7f/9tLFVehqhdpyw5JI1uAbFHto+1mQWElOCA1ijdw9BY2kMEtX/QZgOVrw3d3n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFplulPf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB6BC4CEEE;
	Wed,  2 Jul 2025 17:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751478081;
	bh=8pzl2yK7FAOvJ11IohviAo18YvVaxddxmunXi97oR9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IFplulPfHcJ9j53FqzIO5ovhjO4x8YZKmJaM/AHk1BsnRroT/IWRkFKfxRp5Am5oJ
	 ZQEISbQVpPrD3uKv/bJb7gvpQGodtO/KiqIPCb20ygKfG5ePDLD9UvWTcCRHowHc/0
	 pj4c66+gb7Jjdeab8E9P9jkjbiDA0cfm3+U9k3C5iK/4pC9y7+sr1gdgK58lZpTwt2
	 mAqF+Wd5D3Dwy5lSJvTyWV5Do9hWETSv+eSKCo2401/yPsg5i58Ki4gV2/knhi+Yfw
	 DwsnWSMrrHl0ntZLmhoqg0U/rfitO13kPDddt5eehr8LQ2SNkmxIjk1OAHpVIdKQp7
	 6BtiFZ7YbBjuw==
Date: Wed, 2 Jul 2025 10:41:20 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de, miklos@szeredi.hu,
	brauner@kernel.org, anuj20.g@samsung.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v3 07/16] iomap: rename iomap_writepage_map to
 iomap_writeback_folio
Message-ID: <20250702174120.GA10009@frogsfrogsfrogs>
References: <20250624022135.832899-1-joannelkoong@gmail.com>
 <20250624022135.832899-8-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624022135.832899-8-joannelkoong@gmail.com>

On Mon, Jun 23, 2025 at 07:21:26PM -0700, Joanne Koong wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> ->writepage is gone, and our naming wasn't always that great to start
> with.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Yesssssss
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index c262f883f9f9..c6bbee68812e 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1586,7 +1586,7 @@ static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
>   * If the folio is entirely beyond i_size, return false.  If it straddles
>   * i_size, adjust end_pos and zero all data beyond i_size.
>   */
> -static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
> +static bool iomap_writeback_handle_eof(struct folio *folio, struct inode *inode,
>  		u64 *end_pos)
>  {
>  	u64 isize = i_size_read(inode);
> @@ -1638,7 +1638,7 @@ static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
>  	return true;
>  }
>  
> -static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
> +static int iomap_writeback_folio(struct iomap_writepage_ctx *wpc,
>  		struct folio *folio)
>  {
>  	struct iomap_folio_state *ifs = folio->private;
> @@ -1656,7 +1656,7 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  
>  	trace_iomap_writepage(inode, pos, folio_size(folio));
>  
> -	if (!iomap_writepage_handle_eof(folio, inode, &end_pos)) {
> +	if (!iomap_writeback_handle_eof(folio, inode, &end_pos)) {
>  		folio_unlock(folio);
>  		return 0;
>  	}
> @@ -1741,7 +1741,7 @@ iomap_writepages(struct iomap_writepage_ctx *wpc)
>  		return -EIO;
>  
>  	while ((folio = writeback_iter(mapping, wpc->wbc, folio, &error)))
> -		error = iomap_writepage_map(wpc, folio);
> +		error = iomap_writeback_folio(wpc, folio);
>  
>  	/*
>  	 * If @error is non-zero, it means that we have a situation where some
> -- 
> 2.47.1
> 
> 

