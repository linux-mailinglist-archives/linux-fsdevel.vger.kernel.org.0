Return-Path: <linux-fsdevel+bounces-11392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E62853652
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 17:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26C9A1C2370C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 16:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013C06024E;
	Tue, 13 Feb 2024 16:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9m5GsXK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5854CB65E;
	Tue, 13 Feb 2024 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842372; cv=none; b=CqQs/DlfNM3XWeViR1DeJ0+ehYCvRuX0LFTqCA+E+/jkmubikTeVN3r8LFWdcy8QP+plM62P4kf/eJmCOq99FdgsqAt5e6N1b+Xn1xRWm0ovWVmiTwoaRorjT//CuXZ3iuGE+b70CT/2nGnkfpgjiaTtimoFNdacoUDDJTludaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842372; c=relaxed/simple;
	bh=Fnf4xgH/e0W3UjNn3m69LYnKo5H+30NDIZsoXhuJPb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjbR6Dw7tGadx0PpVXIFy5ICQlrvp1lI+HI3mDWpOyaYctnRAh9UyncTh16Qld8lylSdmcHCHNhAGe7oG855UFLCUCQZh9HJwzlEj/8gRPhrtyyMZNUb//rbWIQDSzr8byMMA1F3zVQH4EVZXJRKP84kDMRWlYnP8IlLco8fJ/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9m5GsXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C27FC32784;
	Tue, 13 Feb 2024 16:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707842371;
	bh=Fnf4xgH/e0W3UjNn3m69LYnKo5H+30NDIZsoXhuJPb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O9m5GsXKbg9AI33fOqw69S5E2XdAleUnehXkybhM8JeSjXJaY+MMNYwiXbjJDsoQ/
	 G4Khoc5Kl0Ag58jKPk2up1CsZhP0muf2C1EnFEKcC47+PbJi4arFT65hLIruWd/yAP
	 dVei+hZ2iSBa0bKXjcm3HJD80IDiVA9Yg7w97HbwvBYKryADJUhyKYQKore2pbeJmi
	 Iw1lEcoX9nyYZYKG8RIu9iDVi6wP+OTVObhRGQTLdfFIWR2iaiuUqi7Sg06u0b7Xi/
	 4TtE9+M7WqhijaSF5o3u0Jw5P/hDetkVydUybJN0dSST6AdJQm0r9QFY2YX5iXW7TO
	 wlMe/UKFqinIg==
Date: Tue, 13 Feb 2024 08:39:30 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org,
	kbusch@kernel.org, chandan.babu@oracle.com, p.raghav@samsung.com,
	linux-kernel@vger.kernel.org, hare@suse.de, willy@infradead.org,
	linux-mm@kvack.org, david@fromorbit.com
Subject: Re: [RFC v2 13/14] xfs: add an experimental CONFIG_XFS_LBS option
Message-ID: <20240213163930.GU6184@frogsfrogsfrogs>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-14-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213093713.1753368-14-kernel@pankajraghav.com>

On Tue, Feb 13, 2024 at 10:37:12AM +0100, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Add an experimental CONFIG_XFS_LBS option to enable LBS support in XFS.
> Retain the ASSERT for PAGE_SHIFT if CONFIG_XFS_LBS is not enabled.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

With the changes I suggested in the next patch,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

(I think you ought to combine this patch and the next patch after
improving the EXPERIMENTAL log messaging.)

--D

> ---
>  fs/xfs/Kconfig     | 11 +++++++++++
>  fs/xfs/xfs_mount.c |  4 +++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/Kconfig b/fs/xfs/Kconfig
> index 567fb37274d3..6b0db2f7dc13 100644
> --- a/fs/xfs/Kconfig
> +++ b/fs/xfs/Kconfig
> @@ -216,3 +216,14 @@ config XFS_ASSERT_FATAL
>  	  result in warnings.
>  
>  	  This behavior can be modified at runtime via sysfs.
> +
> +config XFS_LBS
> +	bool "XFS large block size support (EXPERIMENTAL)"
> +	depends on XFS_FS
> +	help
> +	  Set Y to enable support for filesystem block size > system's
> +	  base page size.
> +
> +	  This feature is considered EXPERIMENTAL.  Use with caution!
> +
> +	  If unsure, say N.
> diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
> index bfbaaecaf668..596aa2cdefbc 100644
> --- a/fs/xfs/xfs_mount.c
> +++ b/fs/xfs/xfs_mount.c
> @@ -131,11 +131,13 @@ xfs_sb_validate_fsb_count(
>  	xfs_sb_t	*sbp,
>  	uint64_t	nblocks)
>  {
> -	ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);
>  	ASSERT(sbp->sb_blocklog >= BBSHIFT);
>  	unsigned long mapping_count;
>  	uint64_t bytes = nblocks << sbp->sb_blocklog;
>  
> +	if (!IS_ENABLED(CONFIG_XFS_LBS))
> +		ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);
> +
>  	mapping_count = bytes >> PAGE_SHIFT;
>  
>  	/* Limited by ULONG_MAX of page cache index */
> -- 
> 2.43.0
> 
> 

