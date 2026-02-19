Return-Path: <linux-fsdevel+bounces-77730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONGeFhRKl2m2wQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 18:36:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB196161489
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 18:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E50E3015441
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 17:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9732234F48F;
	Thu, 19 Feb 2026 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoB6Lh1+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B5C30498E;
	Thu, 19 Feb 2026 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771522571; cv=none; b=jVawKmLybNTLFz2394jG5WqVZZYmcvR/xAoFvn+YnlyEspLPpmvJab4LPDMTc1om9vmodlOS1P2+B48cKxVg/bDFgEyxzPvUCLQuJ4SmI7iESwg0yW7b8QJ32MQaQSAFsakDNXzyhS6Sc0oXqcdHsshmPjFN+KaqFDxjdGrLMQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771522571; c=relaxed/simple;
	bh=JUm8FA1Niv7aalJAIktAIGkvmXq2pSlV4DnBVqE7wls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wmt13hAQORoLByIE5uBiwJ7QweU5t/yNN1J2LSTtdvcTlC+/OMzKpMg92BMhj7QtmB3DzSRr5ZDRlHtamkG/av2Ta0TUPZI4sHLKA9XHSAUGwZpK3ohtMzLHBNgkhKFU7katURVKKdCEu4VWh5DcIAoqVzTWcGP3Fi60F/X9xHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoB6Lh1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29B6C4CEF7;
	Thu, 19 Feb 2026 17:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771522571;
	bh=JUm8FA1Niv7aalJAIktAIGkvmXq2pSlV4DnBVqE7wls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WoB6Lh1+ibCySqnjTQsSNEenibPi8bL3ceThVE63FZ5n4F1L0vV+Psogn963OVrAO
	 K691BaF9z7aJejZguCUI7mlXzzbTLlwYqtzATYmnsOJZC443vss0t32e7yDTOV86in
	 acJ0r6T3Q09osGkSy7PYvDSApv20WdMT6BAMECBkhsJIUvk+65uQvtSocrS/vZuw+D
	 4IS0D/GsmsPBSOMB6Li7Vt6VFdBMkTT+DCGsVOexarSYg4mvXCz4MGKT752FDplD0T
	 lyJ7DIbMJKgtdZY9Drr5ak3XSv1kFfUjtez3aDUTs4bc1M2zeQJpqBV5JcPpSvKGsE
	 MvNPUmYtyBtMw==
Date: Thu, 19 Feb 2026 09:36:10 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de
Subject: Re: [PATCH v3 34/35] xfs: add fsverity traces
Message-ID: <20260219173610.GM6490@frogsfrogsfrogs>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
 <20260217231937.1183679-35-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217231937.1183679-35-aalbersh@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77730-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB196161489
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 12:19:34AM +0100, Andrey Albershteyn wrote:
> Even though fsverity has traces, debugging issues with varying block
> sizes could be a bit less transparent without read/write traces.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/xfs/xfs_fsverity.c | 10 ++++++++++
>  fs/xfs/xfs_trace.h    | 46 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
> index d89512d59328..69f1c22e1ba8 100644
> --- a/fs/xfs/xfs_fsverity.c
> +++ b/fs/xfs/xfs_fsverity.c
> @@ -176,6 +176,8 @@ xfs_fsverity_get_descriptor(
>  	uint32_t		blocksize = i_blocksize(VFS_I(ip));
>  	xfs_fileoff_t		last_block_offset;
>  
> +	trace_xfs_fsverity_get_descriptor(ip);
> +
>  	ASSERT(inode->i_flags & S_VERITY);
>  	error = xfs_bmap_last_extent(NULL, ip, XFS_DATA_FORK, &rec, &is_empty);
>  	if (error)
> @@ -419,6 +421,8 @@ xfs_fsverity_read_merkle(
>  		(fsverity_metadata_offset(inode) >> PAGE_SHIFT);
>  	pgoff_t			idx = index + metadata_idx;
>  
> +	trace_xfs_fsverity_read_merkle(XFS_I(inode), idx, PAGE_SIZE);
> +
>  	return generic_read_merkle_tree_page(inode, idx);
>  }
>  
> @@ -435,6 +439,8 @@ xfs_fsverity_readahead_merkle_tree(
>  		(fsverity_metadata_offset(inode) >> PAGE_SHIFT);
>  	pgoff_t			idx = index + metadata_idx;
>  
> +	trace_xfs_fsverity_read_merkle(XFS_I(inode), idx, PAGE_SIZE);
> +
>  	generic_readahead_merkle_tree(inode, idx, nr_pages);
>  }
>  
> @@ -456,6 +462,8 @@ xfs_fsverity_write_merkle(
>  	const char		*p;
>  	unsigned int		i;
>  
> +	trace_xfs_fsverity_write_merkle(XFS_I(inode), position, size);
> +
>  	if (position + size > inode->i_sb->s_maxbytes)
>  		return -EFBIG;
>  
> @@ -487,6 +495,8 @@ xfs_fsverity_file_corrupt(
>  	loff_t			pos,
>  	size_t			len)
>  {
> +	trace_xfs_fsverity_file_corrupt(XFS_I(inode), pos, len);
> +
>  	xfs_inode_mark_sick(XFS_I(inode), XFS_SICK_INO_DATA);
>  }
>  
> diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
> index f70afbf3cb19..a5562921611a 100644
> --- a/fs/xfs/xfs_trace.h
> +++ b/fs/xfs/xfs_trace.h
> @@ -5906,6 +5906,52 @@ DEFINE_EVENT(xfs_freeblocks_resv_class, name, \
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

I wonder if @length ought to be size_t instead of unsigned int?
Probably doesn't matter at this point, fsverity isn't going to send huge
multigigabyte IOs.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

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
> +	TP_printk("dev %d:%d ino 0x%llx pos 0x%llx length 0x%x",
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
> -- 
> 2.51.2
> 
> 

