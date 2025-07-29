Return-Path: <linux-fsdevel+bounces-56291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9624B155B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 01:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45FB518A6E09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 23:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FA72798FF;
	Tue, 29 Jul 2025 23:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkC3K1zy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617351624E1;
	Tue, 29 Jul 2025 23:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753830391; cv=none; b=b1ret7iaEHP7l9GAtItWeM9FroZBViud6gDy6yFUBqFgoRibXi9xoxKH0rYoTlzSPxYZ5t565rbJH24aJGDAdWyLGtZNh1e6fGev7AWprXW+mh84PTF8lJGkDEw94ySeT16V14kg2EQhFIDtKJ5MCr3HwZkxXPq0bDMAiGCh6h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753830391; c=relaxed/simple;
	bh=EGzTHz/g+TVoEg5tHXZx9p8xM/RYeUs/uASjKfOqQR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORRnGUuRpW83uB7ilX1oCDe8ryP4CbZKf/NtJwJA+dpsrfwDUFkadhtbfux9kch1LLxQpljFqubTqEji/TF86REGX2MaKmptFk+JDHabCHIyp+UbM2WjGnInSg54PSofnW7UHxMldOSrHf1mk1eROhXfhL991z4OoMLtq0tc0x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkC3K1zy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC30C4CEF6;
	Tue, 29 Jul 2025 23:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753830390;
	bh=EGzTHz/g+TVoEg5tHXZx9p8xM/RYeUs/uASjKfOqQR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QkC3K1zyPbHGXpUSv3dNVYbMuKO7XPGSIfxmU06ZtLqg64Du+Im3F8ERKEBIV36Vd
	 I3wukK2Ybar6Dtr+0NVGqXFJfxt7LCGb868Yw+iO/mcUQw66F/ciU5hx4Ga+tFwxnp
	 seB9hToAQYPvBQZ0DclPQ2kWJGw0KyKU/v1UCteCg28AXfDQESaqgWl6Nu1DhiU8YN
	 sS7CHrsh4yARvgKK9tNJRxXADnldcpn8a2fC10n+OO2bZQlxhW2bq732/cvuIjBeS4
	 5THTZm6XZOCnVKcjxZRvEBdgy+FluOKTkRYNEOR3rNpuiKoF8a7xmwqBC4qDA+p640
	 QVdrj/QUuWlKg==
Date: Tue, 29 Jul 2025 16:06:30 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, david@fromorbit.com, ebiggers@kernel.org,
	hch@lst.de, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH RFC 28/29] xfs: add fsverity traces
Message-ID: <20250729230630.GN2672049@frogsfrogsfrogs>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
 <20250728-fsverity-v1-28-9e5443af0e34@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728-fsverity-v1-28-9e5443af0e34@kernel.org>

On Mon, Jul 28, 2025 at 10:30:32PM +0200, Andrey Albershteyn wrote:
> Even though fsverity has traces, debugging issues with varying block
> sizes could a bit less transparent without read/write traces.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>

Looks fine to me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_fsverity.c |  8 ++++++++
>  fs/xfs/xfs_trace.h    | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
> 
> diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
> index dfe7b0bcd97e..4d3fd00237b1 100644
> --- a/fs/xfs/xfs_fsverity.c
> +++ b/fs/xfs/xfs_fsverity.c
> @@ -70,6 +70,8 @@ xfs_fsverity_get_descriptor(
>  	};
>  	int			error = 0;
>  
> +	trace_xfs_fsverity_get_descriptor(ip);
> +
>  	/*
>  	 * The fact that (returned attribute size) == (provided buf_size) is
>  	 * checked by xfs_attr_copy_value() (returns -ERANGE).  No descriptor
> @@ -267,6 +269,8 @@ xfs_fsverity_read_merkle(
>  	 */
>  	xfs_fsverity_adjust_read(&region);
>  
> +	trace_xfs_fsverity_read_merkle(XFS_I(inode), region.pos, region.length);
> +
>  	folio = iomap_read_region(&region);
>  	if (IS_ERR(folio))
>  		return ERR_PTR(-EIO);
> @@ -297,6 +301,8 @@ xfs_fsverity_write_merkle(
>  		.ops				= &xfs_buffered_write_iomap_ops,
>  	};
>  
> +	trace_xfs_fsverity_write_merkle(XFS_I(inode), region.pos, region.length);
> +
>  	if (region.pos + region.length > inode->i_sb->s_maxbytes)
>  		return -EFBIG;
>  
> @@ -309,6 +315,8 @@ xfs_fsverity_file_corrupt(
>  	loff_t			pos,
>  	size_t			len)
>  {
> +	trace_xfs_fsverity_file_corrupt(XFS_I(inode), pos, len);
> +
>  	xfs_inode_mark_sick(XFS_I(inode), XFS_SICK_INO_DATA);
>  }
>  
> diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
> index 50034c059e8c..4477d5412e53 100644
> --- a/fs/xfs/xfs_trace.h
> +++ b/fs/xfs/xfs_trace.h
> @@ -5979,6 +5979,52 @@ DEFINE_EVENT(xfs_freeblocks_resv_class, name, \
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
> 2.50.0
> 
> 

