Return-Path: <linux-fsdevel+bounces-73332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFB7D15BA8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 00:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01BDB3036AFD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 23:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29E629E115;
	Mon, 12 Jan 2026 23:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTRP67Dh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AA0223336;
	Mon, 12 Jan 2026 23:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768259246; cv=none; b=d3KiZ9NyjsQYyFFAd6xC2qnxLhSCA78dWesDcUIl9JHTLO6UKC5DY2yzq6LMunl2//R+NxXfziWr3J+a6lYE6iSQcktN1zdifQF8OEPq6T0wDHOXMPsovOYkW4T8fPcjF+uYlyAe2sgV5i+SJKw0UQ3Re1AxpPQnwErbVznUAMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768259246; c=relaxed/simple;
	bh=2e5I4mYop/xxj2YY719bBcpG6TTPkuUdCnMLvB/fepE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7f3GvO/+3Qw+3y8qn0FLqt6+mOVJrUKtGWAxnYIkJ00XqDDotqnJYmWbFa+DeQ1secHMGuYiy7MWJL3j19zxwed7NSIRDfKhQFjFhq4hmAAUcFC/StGBEVXHOZzK0bgaimHYZuW3gSGIofjFX3pyxFLfONMPrGvftb8QgVy6gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTRP67Dh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDABFC116D0;
	Mon, 12 Jan 2026 23:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768259246;
	bh=2e5I4mYop/xxj2YY719bBcpG6TTPkuUdCnMLvB/fepE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LTRP67DhTTBvYzbK4NXiagNFcYMgzB6WHGKaOvmwT0mCNLzTgZ1YdIEZP+jc/7t7t
	 E65pBD5843ArJ9pmqStWrybluuW5OK5JIA68Ao+c2XLHNSqU8E21NeLGrgaeoo5PZ5
	 VyFUQe5YhkZrBePpSgLAmtUtdGamEbby4b/8I4funGK/IlwTMfNDmbZfItoEX0HY9L
	 F3V0XXLbKtmURDXTusDk/wseZbN2rq7Tr5ee7tVx1qeNFh5mIlX39JHVbfIGCDwYk+
	 PTVTWX8YyQfLxUATLSseoht3ibn3V+S++2K6JbEbCCz8Dd+eBZ11d0NTqVZDPWAsRT
	 NhGHzMzDGBtqw==
Date: Mon, 12 Jan 2026 15:07:25 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org,
	aalbersh@kernel.org, david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 21/22] xfs: add fsverity traces
Message-ID: <20260112230725.GS15551@frogsfrogsfrogs>
References: <cover.1768229271.patch-series@thinky>
 <xvaenghd6d7rd5gnfbfm7zmp5dd4uqa2wchdxcfpxpp2cevp7i@a27fi4opexrk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xvaenghd6d7rd5gnfbfm7zmp5dd4uqa2wchdxcfpxpp2cevp7i@a27fi4opexrk>

On Mon, Jan 12, 2026 at 03:52:20PM +0100, Andrey Albershteyn wrote:
> Even though fsverity has traces, debugging issues with varying block
> sizes could be a bit less transparent without read/write traces.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/xfs/xfs_fsverity.c |  8 ++++++++
>  fs/xfs/xfs_trace.h    | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+), 0 deletions(-)
> 
> diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
> index f53a404578..06eac2561b 100644
> --- a/fs/xfs/xfs_fsverity.c
> +++ b/fs/xfs/xfs_fsverity.c
> @@ -102,6 +102,8 @@
>  	uint32_t		blocksize = i_blocksize(VFS_I(ip));
>  	xfs_fileoff_t		last_block;
>  
> +	trace_xfs_fsverity_get_descriptor(ip);
> +
>  	ASSERT(inode->i_flags & S_VERITY);
>  	error = xfs_bmap_last_extent(NULL, ip, XFS_DATA_FORK, &rec, &is_empty);
>  	if (error)
> @@ -330,6 +332,8 @@
>  	pgoff_t			offset =
>  			index | (XFS_FSVERITY_REGION_START >> PAGE_SHIFT);
>  
> +	trace_xfs_fsverity_read_merkle(XFS_I(inode), offset, PAGE_SIZE);
> +
>  	folio = __filemap_get_folio(inode->i_mapping, offset, FGP_ACCESSED, 0);
>  	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
>  		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, offset);
> @@ -358,6 +362,8 @@
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	loff_t			position = pos | XFS_FSVERITY_REGION_START;
>  
> +	trace_xfs_fsverity_write_merkle(XFS_I(inode), pos, size);
> +
>  	if (position + size > inode->i_sb->s_maxbytes)
>  		return -EFBIG;
>  
> @@ -370,6 +376,8 @@
>  	loff_t			pos,
>  	size_t			len)
>  {
> +	trace_xfs_fsverity_file_corrupt(XFS_I(inode), pos, len);
> +
>  	xfs_inode_mark_sick(XFS_I(inode), XFS_SICK_INO_DATA);
>  }
>  
> diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
> index f70afbf3cb..1ce4e10b6b 100644
> --- a/fs/xfs/xfs_trace.h
> +++ b/fs/xfs/xfs_trace.h
> @@ -5906,6 +5906,52 @@
>  DEFINE_FREEBLOCKS_RESV_EVENT(xfs_freecounter_reserved);
>  DEFINE_FREEBLOCKS_RESV_EVENT(xfs_freecounter_enospc);
>  
> +TRACE_EVENT(xfs_fsverity_get_descriptor,
> +	TP_PROTO(struct xfs_inode *ip),
> +	TP_ARGS(ip),
> +	TP_STRUCT__entry(
> +		__field(dev_t, dev)
> +		__field(xfs_ino_t, ino)
> +	),
> +	TP_fast_assign(
> +		__entry->dev = VFS_I(ip)->i_sb->s_dev;
> +		__entry->ino = ip->i_ino;
> +	),
> +	TP_printk("dev %d:%d ino 0x%llx",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->ino)
> +);
> +
> +DECLARE_EVENT_CLASS(xfs_fsverity_class,
> +	TP_PROTO(struct xfs_inode *ip, u64 pos, unsigned int length),
> +	TP_ARGS(ip, pos, length),
> +	TP_STRUCT__entry(
> +		__field(dev_t, dev)
> +		__field(xfs_ino_t, ino)
> +		__field(u64, pos)
> +		__field(unsigned int, length)
> +	),
> +	TP_fast_assign(
> +		__entry->dev = VFS_I(ip)->i_sb->s_dev;
> +		__entry->ino = ip->i_ino;
> +		__entry->pos = pos;
> +		__entry->length = length;
> +	),
> +	TP_printk("dev %d:%d ino 0x%llx pos %llx length %x",

pos and length should have '0x' before them since they're presented in
hexadecimal.

Otherwise this looks ok so
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D


> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->ino,
> +		  __entry->pos,
> +		  __entry->length)
> +)
> +
> +#define DEFINE_FSVERITY_EVENT(name) \
> +DEFINE_EVENT(xfs_fsverity_class, name, \
> +	TP_PROTO(struct xfs_inode *ip, u64 pos, unsigned int length), \
> +	TP_ARGS(ip, pos, length))
> +DEFINE_FSVERITY_EVENT(xfs_fsverity_read_merkle);
> +DEFINE_FSVERITY_EVENT(xfs_fsverity_write_merkle);
> +DEFINE_FSVERITY_EVENT(xfs_fsverity_file_corrupt);
> +
>  #endif /* _TRACE_XFS_H */
>  
>  #undef TRACE_INCLUDE_PATH
> 
> -- 
> - Andrey
> 
> 

