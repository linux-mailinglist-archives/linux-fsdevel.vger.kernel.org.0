Return-Path: <linux-fsdevel+bounces-27615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAE5962D88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 18:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96651286A00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 16:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEE61A3BB3;
	Wed, 28 Aug 2024 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrrZj6Ls"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252211A38D5;
	Wed, 28 Aug 2024 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724862013; cv=none; b=eATWO4IC7G/WzdgP2Np5bqAMM6zrih3CJkMvDkfwC7MRrO8RGVWeC7FSIn1lMkzS42enbk2x2Hoa72A2NWplaM52CpZjEYpFS50cmTZt8i3D46cHtA0YxY5pLtWW/AjKy3/+sM/A3MJbZJ16UI3LGeOlIrjyZIDwIxNq3SLUN1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724862013; c=relaxed/simple;
	bh=mMItOfZO4JBTBLfmqKRhRxLBxbZYHsZE/yKPWb0wP+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQbOgGffHZd5hYtdWCQL/duII3gt2f3vf1Z7Ll9Z/nmSkMdO+WodTDouP+QLVU2yC7vYgFpfmJxfXDFYNY71Qab9Dx27NtX9IE8nFfZk7D4Dcllh9g28LdmFFP0v4omJd/F+2n8pGjn3fBVIPIySDYuL/23f09vr50UnqCxRgsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrrZj6Ls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA28C568D0;
	Wed, 28 Aug 2024 16:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724862012;
	bh=mMItOfZO4JBTBLfmqKRhRxLBxbZYHsZE/yKPWb0wP+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FrrZj6Lss/iUMgBC0HyOlm1XBU2cbvrkdphOXnCwL36Y708VSF8sjqpmwWzixxO/g
	 pfcdS8CPdLAKZw1Pci8XtUFc4Cu63jZFyhP79ZItMcG5JW09S55bo4dL2VoW7E/cvF
	 SbpXnXXblbZVD/Z4GXIThDw9xP/rEC2Y+MZc2b3PN9eHeIAMxo4tEKJrKMhfUm403W
	 6ZF9QR08iB3stAVSqbES47cIgTPGf5tZP4saP4A5YZ1Z0Nt1x/MEnOL12cPvxkyMge
	 KUu0IIR9yO4sC0mXbN/g9ek10WFCcSocJDzlgVqOADPNf1RjWFH44KqCl1/XJIRp6X
	 eq3pVY4pMAdSA==
Date: Wed, 28 Aug 2024 09:20:11 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/3] fs: reformat the statx definition
Message-ID: <20240828162011.GK1977952@frogsfrogsfrogs>
References: <20240828051149.1897291-1-hch@lst.de>
 <20240828051149.1897291-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828051149.1897291-2-hch@lst.de>

On Wed, Aug 28, 2024 at 08:11:01AM +0300, Christoph Hellwig wrote:
> The comments after the declaration are becoming rather unreadable with
> long enough comments.  Move them into lines of their own.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Space for full sentences, what luxury! ;)
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  include/uapi/linux/stat.h | 95 +++++++++++++++++++++++++++++----------
>  1 file changed, 72 insertions(+), 23 deletions(-)
> 
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index 887a2528644168..8b35d7d511a287 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -98,43 +98,92 @@ struct statx_timestamp {
>   */
>  struct statx {
>  	/* 0x00 */
> -	__u32	stx_mask;	/* What results were written [uncond] */
> -	__u32	stx_blksize;	/* Preferred general I/O size [uncond] */
> -	__u64	stx_attributes;	/* Flags conveying information about the file [uncond] */
> +	/* What results were written [uncond] */
> +	__u32	stx_mask;
> +
> +	/* Preferred general I/O size [uncond] */
> +	__u32	stx_blksize;
> +
> +	/* Flags conveying information about the file [uncond] */
> +	__u64	stx_attributes;
> +
>  	/* 0x10 */
> -	__u32	stx_nlink;	/* Number of hard links */
> -	__u32	stx_uid;	/* User ID of owner */
> -	__u32	stx_gid;	/* Group ID of owner */
> -	__u16	stx_mode;	/* File mode */
> +	/* Number of hard links */
> +	__u32	stx_nlink;
> +
> +	/* User ID of owner */
> +	__u32	stx_uid;
> +
> +	/* Group ID of owner */
> +	__u32	stx_gid;
> +
> +	/* File mode */
> +	__u16	stx_mode;
>  	__u16	__spare0[1];
> +
>  	/* 0x20 */
> -	__u64	stx_ino;	/* Inode number */
> -	__u64	stx_size;	/* File size */
> -	__u64	stx_blocks;	/* Number of 512-byte blocks allocated */
> -	__u64	stx_attributes_mask; /* Mask to show what's supported in stx_attributes */
> +	/* Inode number */
> +	__u64	stx_ino;
> +
> +	/* File size */
> +	__u64	stx_size;
> +
> +	/* Number of 512-byte blocks allocated */
> +	__u64	stx_blocks;
> +
> +	/* Mask to show what's supported in stx_attributes */
> +	__u64	stx_attributes_mask;
> +
>  	/* 0x40 */
> -	struct statx_timestamp	stx_atime;	/* Last access time */
> -	struct statx_timestamp	stx_btime;	/* File creation time */
> -	struct statx_timestamp	stx_ctime;	/* Last attribute change time */
> -	struct statx_timestamp	stx_mtime;	/* Last data modification time */
> +	/* Last access time */
> +	struct statx_timestamp	stx_atime;
> +
> +	/* File creation time */
> +	struct statx_timestamp	stx_btime;
> +
> +	/* Last attribute change time */
> +	struct statx_timestamp	stx_ctime;
> +
> +	/* Last data modification time */
> +	struct statx_timestamp	stx_mtime;
> +
>  	/* 0x80 */
> -	__u32	stx_rdev_major;	/* Device ID of special file [if bdev/cdev] */
> +	/* Device ID of special file [if bdev/cdev] */
> +	__u32	stx_rdev_major;
>  	__u32	stx_rdev_minor;
> -	__u32	stx_dev_major;	/* ID of device containing file [uncond] */
> +
> +	/* ID of device containing file [uncond] */
> +	__u32	stx_dev_major;
>  	__u32	stx_dev_minor;
> +
>  	/* 0x90 */
>  	__u64	stx_mnt_id;
> -	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
> -	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
> +
> +	/* Memory buffer alignment for direct I/O */
> +	__u32	stx_dio_mem_align;
> +
> +	/* File offset alignment for direct I/O */
> +	__u32	stx_dio_offset_align;
> +
>  	/* 0xa0 */
> -	__u64	stx_subvol;	/* Subvolume identifier */
> -	__u32	stx_atomic_write_unit_min;	/* Min atomic write unit in bytes */
> -	__u32	stx_atomic_write_unit_max;	/* Max atomic write unit in bytes */
> +	/* Subvolume identifier */
> +	__u64	stx_subvol;
> +
> +	/* Min atomic write unit in bytes */
> +	__u32	stx_atomic_write_unit_min;
> +
> +	/* Max atomic write unit in bytes */
> +	__u32	stx_atomic_write_unit_max;
> +
>  	/* 0xb0 */
> -	__u32   stx_atomic_write_segments_max;	/* Max atomic write segment count */
> +	/* Max atomic write segment count */
> +	__u32   stx_atomic_write_segments_max;
> +
>  	__u32   __spare1[1];
> +
>  	/* 0xb8 */
>  	__u64	__spare3[9];	/* Spare space for future expansion */
> +
>  	/* 0x100 */
>  };
>  
> -- 
> 2.43.0
> 
> 

