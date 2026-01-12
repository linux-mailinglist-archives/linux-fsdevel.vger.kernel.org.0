Return-Path: <linux-fsdevel+bounces-73325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDB4D15977
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 23:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CD34303525E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 22:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B3D2BEFFE;
	Mon, 12 Jan 2026 22:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/xrlhDV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DF62BE64A;
	Mon, 12 Jan 2026 22:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768257579; cv=none; b=TOa2w9QgqLocr7BZ1hMJge+Y0o6qlIkC6h7K826ANpLeiwKSHedfC7pRqWZ4yKJ07Yij/kM/kb36kq2Nn3LSyr99mmFE+iM9Zj9nFLwszErHRfJr3XisNzdfjhmxfikfIPfSh72Kya0B4MpoHtHDVu+zq4DviQBiphGxr4hELzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768257579; c=relaxed/simple;
	bh=mQL8fhYWrJKPGQUsYkzkY1ONuJH1oc9hdTMhrRJr9RM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXpJeiIDhMq3oaXGxpNqxk0JdaUkWD3PWtJSRQiHSeQ6z+69xBOyt2PW3rnC8gnG/xDEyehhH7AzJd/3vlz+dt0OUXY+ugWD4RZMWF640jxqqzpKTZrPgppduTzFtxGGrgurZkeYLupzpzv2vqx0hLWlPhRdwfxpupXdAwWdVZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/xrlhDV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D3BC116D0;
	Mon, 12 Jan 2026 22:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768257579;
	bh=mQL8fhYWrJKPGQUsYkzkY1ONuJH1oc9hdTMhrRJr9RM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o/xrlhDVF3gRJkx0syePDGP7D6WpnOShg804CQJA6MFq4ShX9yu0ba8zDCDK7JSPY
	 FnWrdXY9VItasbGjNrL0uPN1D7qSSe/icbzxqjz26cLTFKJnah1Q2fOHXdPeqZTRPB
	 1KabrHRir7nu9MAHp8M7JjFNpifbgkIGilBPXq/vSqsimoDzboHExvTGVGiU8yypDQ
	 Xe2MrvQMzZK3C1+ONfNs0oTcG5hHTVDmRMnDlrfeZ7+RjCrsfUHW8pNkGzG+fJnqcN
	 DLCbonkujHvvQgcpB2ffIvVrOJhydqySC2XvAnYAbAdU05RPqvXvnUCK2qCvlf6YKd
	 wHTF9uR48Lqlg==
Date: Mon, 12 Jan 2026 14:39:38 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org,
	aalbersh@kernel.org, david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 11/22] xfs: add verity info pointer to xfs inode
Message-ID: <20260112223938.GM15551@frogsfrogsfrogs>
References: <cover.1768229271.patch-series@thinky>
 <7s5yzeey3dmnqwz4wkdjp4dwz2bi33c75aiqjjglfdpeh6o656@i32x5x3xfilp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7s5yzeey3dmnqwz4wkdjp4dwz2bi33c75aiqjjglfdpeh6o656@i32x5x3xfilp>

On Mon, Jan 12, 2026 at 03:51:10PM +0100, Andrey Albershteyn wrote:
> Add the fsverity_info pointer into the filesystem-specific part of the
> inode by adding the field xfs_inode->i_verity_info and configuring
> fsverity_operations::inode_info_offs accordingly.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>

I kinda don't like adding another pointer to struct xfs_inode but I
can't see a better solution.  Inodes can add or drop verity status
dynamically so we can't do this trick:

struct xfs_verity_inode {
	struct xfs_inode	hork;
	struct fsverity_info	dork;
};

and only allocate the xfs_verity_inode when needed.  Therefore,

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_icache.c | 3 +++
>  fs/xfs/xfs_inode.h  | 5 +++++
>  2 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index 23a920437f..872785c68a 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -130,6 +130,9 @@
>  	spin_lock_init(&ip->i_ioend_lock);
>  	ip->i_next_unlinked = NULLAGINO;
>  	ip->i_prev_unlinked = 0;
> +#ifdef CONFIG_FS_VERITY
> +	ip->i_verity_info = NULL;
> +#endif
>  
>  	return ip;
>  }
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index bd6d335571..f149cb1eb5 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -9,6 +9,7 @@
>  #include "xfs_inode_buf.h"
>  #include "xfs_inode_fork.h"
>  #include "xfs_inode_util.h"
> +#include <linux/fsverity.h>
>  
>  /*
>   * Kernel only inode definitions
> @@ -99,6 +100,10 @@
>  	spinlock_t		i_ioend_lock;
>  	struct work_struct	i_ioend_work;
>  	struct list_head	i_ioend_list;
> +
> +#ifdef CONFIG_FS_VERITY
> +	struct fsverity_info *i_verity_info;
> +#endif
>  } xfs_inode_t;
>  
>  static inline bool xfs_inode_on_unlinked_list(const struct xfs_inode *ip)
> 
> -- 
> - Andrey
> 
> 

