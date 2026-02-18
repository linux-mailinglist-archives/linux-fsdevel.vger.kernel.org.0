Return-Path: <linux-fsdevel+bounces-77649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAekGPRHlmmCdQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 00:15:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6A215AD9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 00:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4DCE3036071
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 23:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B2A33A9E2;
	Wed, 18 Feb 2026 23:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIxyyw9C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3419533A9D8;
	Wed, 18 Feb 2026 23:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771456305; cv=none; b=g5fUv+Odf8GBIeb6cUtYCCcuv34ShbEl+i5xIWNX6et0lvWrHB3mrXZ1LdPH6IH3F9NtTYtqhAQcT4juEK+H8Z7kUMlTxLcU+QhteIYI5oBZngF8v/BaZBChsj0rSMMWlAyLB1ZBPssuzjQkET8fb/fig1L0cNLIOsUYWU4CR0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771456305; c=relaxed/simple;
	bh=LMUTAaHWZIxPdeSG5+9/icG15hb25cTmbBPhKgkK768=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A61kZXSI+3vDHPo3gK1eSmc+lEwORXmtg4jrQ9W0nxVh6iIgxQk0TrOS4xMkF/jHPuQm+aHNDdbAHseGr+o8AOnf9T83if75XGEeBdJOw9GaoGsWX6YCqwlud1xPX9YpG7fa5a4UaLjh2M3n+E5GogiGtM1X6mJXzypOvTGrAvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIxyyw9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB358C116D0;
	Wed, 18 Feb 2026 23:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771456304;
	bh=LMUTAaHWZIxPdeSG5+9/icG15hb25cTmbBPhKgkK768=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cIxyyw9CcdOGmDtJgrLVSiZRYOuIu6QKIWIcBdcU9RVnFId0Ryp+KQURWp7bwAqV3
	 uu9tm/wdoQenId2bN7f6SV2dWS+q/6Wd6A36DucBzrFEntnG0IAsr0ACKR9t7/Gq96
	 7+ChNiGe1l2CIiDh3iO89mxsR3+oEXwhW4VzbCf4QG+EJJ6uLbbD9MdygKNusMEaw4
	 0r1aLnt4IWyBqZ5jIBH923raDI4vGOn58t50n25wOZ30AvKqmtagD7wR3kK/Uf0MiP
	 f+sg9ghnmn5J7C7kEe/AAPvP6R5QDMt5lV0pOTiCwk0AIv8CzJJYqYO/fh3ZVVUp0o
	 dfxXzF9TKZvAg==
Date: Wed, 18 Feb 2026 15:11:44 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de
Subject: Re: [PATCH v3 20/35] xfs: introduce XFS_FSVERITY_REGION_START
 constant
Message-ID: <20260218231144.GK6467@frogsfrogsfrogs>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
 <20260217231937.1183679-21-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260217231937.1183679-21-aalbersh@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77649-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF6A215AD9A
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 12:19:20AM +0100, Andrey Albershteyn wrote:
> This is location of fsverity metadata in the file. This offset is used

"...in the ondisk file."

> to store data on disk. When metadata is read into pagecache they are
> shifted to the offset returned by fsverity_metadata_offset().
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>

(should all the ondisk format changes go in one patch?)

--D

> ---
>  fs/xfs/libxfs/xfs_fs.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
> index 12463ba766da..e9c92bc0e64b 100644
> --- a/fs/xfs/libxfs/xfs_fs.h
> +++ b/fs/xfs/libxfs/xfs_fs.h
> @@ -1106,4 +1106,28 @@ enum xfs_device {
>  #define BBTOB(bbs)	((bbs) << BBSHIFT)
>  #endif
>  
> +/*
> + * Merkle tree and fsverity descriptor location on disk, in bytes. While this
> + * offset is huge, when data is read into pagecache iomap uses offset returned
> + * by fsverity_metadata_offset(), which is just beyound EOF.
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
> + * The metadata is placed as follows:
> + *
> + *	[merkle tree...][descriptor.............desc_size]
> + *	^ (1 << 53)     ^ (block border)                 ^ (end of the block)
> + *	                ^--------------------------------^
> + *	                Can be FS_VERITY_MAX_DESCRIPTOR_SIZE
> + */
> +#define XFS_FSVERITY_REGION_START ((loff_t)1ULL << 53)
> +
>  #endif	/* __XFS_FS_H__ */
> -- 
> 2.51.2
> 
> 

