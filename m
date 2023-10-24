Return-Path: <linux-fsdevel+bounces-1103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6677D5525
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 17:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE3DF1C2085F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 15:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDFB30F83;
	Tue, 24 Oct 2023 15:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erysdHYc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EE330CFC
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 15:16:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3097AC43140;
	Tue, 24 Oct 2023 15:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698160598;
	bh=384E0IpiWf1c5LBlqx+nUImYpUlAfTxy1Pr+7exx5SA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=erysdHYcPRF40mcPCQwGtWi77Nepupkr5NleWyiCZintf3tRGrPKlCk+uDPq3Sng9
	 23Xgp1QCAo7oJrvsldW/oZrKzbcwIiAL+I0gvPiFRUCO+MXqoVfReiIJ0WqfN8ZuaF
	 rPnixqPbiIMQ47dHd6d8UdHc8ski22IxiXJTdorEVj683y08+gH4K8/ohj72EP5TZF
	 Afv4BZqTrgiQ/hVq6YntUdWVGbGbvVM1DJqTHlfJW+28IVitn+MvBzBXMJCCzz/jOB
	 wLo/w+aI0ttwawjttb/Bm83M+ZklQIdb7LPnghroApXjpozUL/Zyllaa/Z+gwVOlAc
	 NZ3U70CfpVK0Q==
Date: Tue, 24 Oct 2023 08:16:37 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 10/10] blkdev: comment fs_holder_ops
Message-ID: <20231024151637.GF11424@frogsfrogsfrogs>
References: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org>
 <20231024-vfs-super-freeze-v2-10-599c19f4faac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024-vfs-super-freeze-v2-10-599c19f4faac@kernel.org>

On Tue, Oct 24, 2023 at 03:01:16PM +0200, Christian Brauner wrote:
> Add a comment to @fs_holder_ops that @holder must point to a superblock.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  include/linux/blkdev.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 1bc776335ff8..abf71cce785c 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1480,6 +1480,11 @@ struct blk_holder_ops {
>  	int (*thaw)(struct block_device *bdev);
>  };
>  
> +/*
> + * For filesystems using @fs_holder_ops, the @holder argument passed to
> + * helpers used to open and claim block devices via
> + * bd_prepare_to_claim() must point to a superblock.
> + */
>  extern const struct blk_holder_ops fs_holder_ops;
>  
>  /*
> 
> -- 
> 2.34.1
> 

