Return-Path: <linux-fsdevel+bounces-73327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1C6D159B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 23:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E0F6230092AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 22:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E76C28EA72;
	Mon, 12 Jan 2026 22:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3/runZt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72671A262D;
	Mon, 12 Jan 2026 22:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768257992; cv=none; b=j/6CZzmt5hpqR4hmUxjPeyAiE0XLLMi44gl1P4N+oYGn0hiEWnUA1hVaBFBqYX1rWBsow1PyfYmeCbNtNF2d2RGSdTp9scCZwaYIwsSjzAd3Jl8Z/ge2+JZv19u6MBhxH+DMNSGDy8cjLJ0HjHpoF+JLYDu/RWaFvqtXEsBmKXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768257992; c=relaxed/simple;
	bh=iNQTSqr/yX+5fPiD/T7eoYR8uzRJaKzQCMc0vUnPTF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbKESyleR+YKLwaWmhpAOoDfy4zJt2d2D7GGW38w9qypTUSpsX+Vfu7m9H7L2HiVx05RXUoA6YLK8F+CenC3ioqsXNhvhptauM3iUibaokzQT7tNaaGfBZDATk+RxNDo6JrddQkX2a8d8xG0L2lx/6XSJ5sFKmdSmk3Q+CKNMQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3/runZt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551FFC116D0;
	Mon, 12 Jan 2026 22:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768257992;
	bh=iNQTSqr/yX+5fPiD/T7eoYR8uzRJaKzQCMc0vUnPTF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b3/runZtFD/TT74tkgSNOZRA960YcdsDHYN5lfdRwekzTbdxwPmAXhYq+FPn6z2E8
	 D4UDv9C2LhvX+XPjvZfSZj3eN89uRSDC/GIe7Sc3iqbxI+W8qGUausZh6UGXjSgqHT
	 xi6eUg6k/Wep/0DSC4LVq74XBn8GaWNxWSJEXVdaF1OitNm1Lc3Rdzw99gyLrf9o8u
	 m2AM9IrIYzly+bPBqodVRlXC9F0xOS5TrkpxswS46mGt05oBIgM8tv3R839QwLR1/m
	 dPeeLkHLB9mLY0Crnb1k/lufFLHGm+CU9Jl9H8+Ght7auIk+zk262L1EmFIL5qmT7u
	 yXKjenTKx9ywA==
Date: Mon, 12 Jan 2026 14:46:31 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org,
	aalbersh@kernel.org, david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 13/22] xfs: introduce XFS_FSVERITY_REGION_START
 constant
Message-ID: <20260112224631.GO15551@frogsfrogsfrogs>
References: <cover.1768229271.patch-series@thinky>
 <qwtd222f5dtszwvacl5ywnommg2xftdtunco2eq4sni4pyyps7@ritrh57jm2eg>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qwtd222f5dtszwvacl5ywnommg2xftdtunco2eq4sni4pyyps7@ritrh57jm2eg>

On Mon, Jan 12, 2026 at 03:51:25PM +0100, Andrey Albershteyn wrote:
> This constant defines location of fsverity metadata in page cache of
> an inode.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/xfs/libxfs/xfs_fs.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+), 0 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
> index 12463ba766..b73458a7c2 100644
> --- a/fs/xfs/libxfs/xfs_fs.h
> +++ b/fs/xfs/libxfs/xfs_fs.h
> @@ -1106,4 +1106,26 @@
>  #define BBTOB(bbs)	((bbs) << BBSHIFT)
>  #endif
>  
> +/* Merkle tree location in page cache. We take memory region from the inode's

Dumb nit: new line after opening the multiline comment.

/*
 * Merkle tree location in page cache...

also, isn't (1U<<53) the location of the Merkle tree ondisk in addition
to its location in the page cache?

That occurs to me, what happens on 32-bit systems where the pagecache
can only address up to 16T of data?  Maybe we just don't allow fsverity
on 32-bit xfs.

> + * address space for Merkle tree.
> + *
> + * At maximum of 8 levels with 128 hashes per block (32 bytes SHA-256) maximum
> + * tree size is ((128^8 − 1)/(128 − 1)) = 567*10^12 blocks. This should fit in 53
> + * bits address space.
> + *
> + * At this Merkle tree size we can cover 295EB large file. This is much larger
> + * than the currently supported file size.
> + *
> + * For sha512 the largest file we can cover ends at 1 << 50 offset, this is also
> + * good.
> + *
> + * The metadata is stored on disk as follows:
> + *
> + *	[merkle tree...][descriptor.............desc_size]
> + *	^ (1 << 53)     ^ (block border)                 ^ (end of the block)
> + *	                ^--------------------------------^
> + *	                Can be FS_VERITY_MAX_DESCRIPTOR_SIZE
> + */
> +#define XFS_FSVERITY_REGION_START (1ULL << 53)

Is this in fsblocks or in bytes?  I think the comment should state that
explicitly.

--D

> +
>  #endif	/* __XFS_FS_H__ */
> 
> -- 
> - Andrey
> 
> 

