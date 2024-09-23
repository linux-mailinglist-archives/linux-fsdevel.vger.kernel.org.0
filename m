Return-Path: <linux-fsdevel+bounces-29875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA65D97EF0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 18:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09AA51C215ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 16:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D79F19E99C;
	Mon, 23 Sep 2024 16:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQawS487"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0748914A8B;
	Mon, 23 Sep 2024 16:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727108307; cv=none; b=QN1E2Wngs3H8Y50p0xmbPqmJsqOmMR7uFMYbvJEYpSIsYL/L0S0aeVIxchqm4Gg7NNMrRaiS3I5EpYVTsu2rowGOzMbwxhcp3G1l10z7k7+xcbJ3vCLib8jMhEVyP1PvUq10bRbSz2KJP+MFv4KwjCbavHBAErLYHwFDr5jXQ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727108307; c=relaxed/simple;
	bh=eEgFqBzCsBkWvGuUpkX21h61NUmjQHM417YMdvt+lbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIFvea9KVqP1EX00eyxb0ua1G3XxqSPDoFnVwu/1BV0/O1dRKYQzw6m5occsXlYu6f3Dmrp7qL2KQjWkcCQ0TRVBRMn2xDSRG9kyQDfMTLQeFi9ttkUSdnqqJR7IcCvB4AZNxSiJNCgY+OynX+QjU5Dos3BTZLBbUo1ykyu6z28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQawS487; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C384C4CEC4;
	Mon, 23 Sep 2024 16:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727108306;
	bh=eEgFqBzCsBkWvGuUpkX21h61NUmjQHM417YMdvt+lbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kQawS4876m5Jt6OeFQ8ZgiEflae+m9mmHPLp72DOKjMVgNKwgb0JMQVb3ZwlmLWD7
	 lKpALrPwV2pqtdq4RBaA9PYWWYXe6hbZPnSuqs484HuM+TdnkdxE8DVIF/Itq8uhnz
	 kqDhH95f3sHd/Fa1upMwaUJ5dV3m+C6RpzEwVQs/4Sv6hGSQUXS/IJ6AFGBXfYA13p
	 JAYySf+yaKFArdIJ4KCkUvRjAzLHhajsmIPGjp0UNldCY/lMX0ixoOZYaQOf73AaIB
	 DdbrCHOYFe+DK9Gx5VCxKUljboFuEPLOh2zWD3OqSAF0JgZZ+pxEtcANmxd05Gc56c
	 5DtaARPYlAyeg==
Date: Mon, 23 Sep 2024 09:18:25 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/10] iomap: remove
 iomap_file_buffered_write_punch_delalloc
Message-ID: <20240923161825.GE21877@frogsfrogsfrogs>
References: <20240923152904.1747117-1-hch@lst.de>
 <20240923152904.1747117-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923152904.1747117-3-hch@lst.de>

On Mon, Sep 23, 2024 at 05:28:16PM +0200, Christoph Hellwig wrote:
> Currently iomap_file_buffered_write_punch_delalloc can be called from
> XFS either with the invalidate lock held or not.  To fix this while
> keeping the locking in the file system and not the iomap library
> code we'll need to life the locking up into the file system.
> 
> To prepare for that, open code iomap_file_buffered_write_punch_delalloc
> in the only caller, and instead export iomap_write_delalloc_release.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  .../filesystems/iomap/operations.rst          |  2 +-
>  fs/iomap/buffered-io.c                        | 85 ++++++-------------
>  fs/xfs/xfs_iomap.c                            | 16 +++-
>  include/linux/iomap.h                         |  6 +-
>  4 files changed, 46 insertions(+), 63 deletions(-)
> 
> diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
> index 8e6c721d233010..b93115ab8748ae 100644
> --- a/Documentation/filesystems/iomap/operations.rst
> +++ b/Documentation/filesystems/iomap/operations.rst
> @@ -208,7 +208,7 @@ The filesystem must arrange to `cancel
>  such `reservations
>  <https://lore.kernel.org/linux-xfs/20220817093627.GZ3600936@dread.disaster.area/>`_
>  because writeback will not consume the reservation.
> -The ``iomap_file_buffered_write_punch_delalloc`` can be called from a
> +The ``iomap_write_delalloc_release`` can be called from a
>  ``->iomap_end`` function to find all the clean areas of the folios
>  caching a fresh (``IOMAP_F_NEW``) delalloc mapping.
>  It takes the ``invalidate_lock``.
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 884891ac7a226c..237aeb883166df 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1149,6 +1149,32 @@ static void iomap_write_delalloc_scan(struct inode *inode,
>   * have dirty data still pending in the page cache - those are going to be
>   * written and so must still retain the delalloc backing for writeback.
>   *
> + * When a short write occurs, the filesystem may need to remove reserved space
> + * that was allocated in ->iomap_begin from it's ->iomap_end method. For

"When a short write occurs, the filesystem may need to remove space
reservations created in ->iomap_begin.

> + * filesystems that use delayed allocation, we need to punch out delalloc
> + * extents from the range that are not dirty in the page cache. As the write can
> + * race with page faults, there can be dirty pages over the delalloc extent
> + * outside the range of a short write but still within the delalloc extent
> + * allocated for this iomap.
> + *
> + * The punch() callback *must* only punch delalloc extents in the range passed
> + * to it. It must skip over all other types of extents in the range and leave
> + * them completely unchanged. It must do this punch atomically with respect to
> + * other extent modifications.

Can a failing buffered write race with a write fault to the same file
range?

write() thread:			page_mkwrite thread:
---------------			--------------------
take i_rwsem
->iomap_begin
create da reservation
lock folio
fail to write
unlock folio
				take invalidation lock
				lock folio
				->iomap_begin
				sees da reservation
				mark folio dirty
				unlock folio
				drop invalidation lock
->iomap_end
take invalidation lock
iomap_write_delalloc_release
drop invalidation lock

Can we end up in this situation, where the write fault thinks it has a
dirty page backed by a delalloc reservation, yet the delalloc
reservation gets removed by the delalloc punch logic?  I think the
answer to my question is that this sequence is impossible because the
write fault dirties the folio so the iomap_write_delalloc_release does
nothing, correct?

Unrelated question about iomap_write_begin: Can we get rid of the
!mapping_large_folio_support if-body just prior to __iomap_get_folio?
filemap_get_folio won't return large folios if
!mapping_large_folio_support, so I think the separate check in iomap
isn't needed anymore?

This push-down looks fine though, so
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> + *
> + * The punch() callback may be called with a folio locked to prevent writeback
> + * extent allocation racing at the edge of the range we are currently punching.
> + * The locked folio may or may not cover the range being punched, so it is not
> + * safe for the punch() callback to lock folios itself.
> + *
> + * Lock order is:
> + *
> + * inode->i_rwsem (shared or exclusive)
> + *   inode->i_mapping->invalidate_lock (exclusive)
> + *     folio_lock()
> + *       ->punch
> + *         internal filesystem allocation lock
> + *
>   * As we are scanning the page cache for data, we don't need to reimplement the
>   * wheel - mapping_seek_hole_data() does exactly what we need to identify the
>   * start and end of data ranges correctly even for sub-folio block sizes. This
> @@ -1177,7 +1203,7 @@ static void iomap_write_delalloc_scan(struct inode *inode,
>   * require sprinkling this code with magic "+ 1" and "- 1" arithmetic and expose
>   * the code to subtle off-by-one bugs....
>   */
> -static void iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
> +void iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
>  		loff_t end_byte, unsigned flags, struct iomap *iomap,
>  		iomap_punch_t punch)
>  {
> @@ -1243,62 +1269,7 @@ static void iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
>  out_unlock:
>  	filemap_invalidate_unlock(inode->i_mapping);
>  }
> -
> -/*
> - * When a short write occurs, the filesystem may need to remove reserved space
> - * that was allocated in ->iomap_begin from it's ->iomap_end method. For
> - * filesystems that use delayed allocation, we need to punch out delalloc
> - * extents from the range that are not dirty in the page cache. As the write can
> - * race with page faults, there can be dirty pages over the delalloc extent
> - * outside the range of a short write but still within the delalloc extent
> - * allocated for this iomap.
> - *
> - * This function uses [start_byte, end_byte) intervals (i.e. open ended) to
> - * simplify range iterations.
> - *
> - * The punch() callback *must* only punch delalloc extents in the range passed
> - * to it. It must skip over all other types of extents in the range and leave
> - * them completely unchanged. It must do this punch atomically with respect to
> - * other extent modifications.
> - *
> - * The punch() callback may be called with a folio locked to prevent writeback
> - * extent allocation racing at the edge of the range we are currently punching.
> - * The locked folio may or may not cover the range being punched, so it is not
> - * safe for the punch() callback to lock folios itself.
> - *
> - * Lock order is:
> - *
> - * inode->i_rwsem (shared or exclusive)
> - *   inode->i_mapping->invalidate_lock (exclusive)
> - *     folio_lock()
> - *       ->punch
> - *         internal filesystem allocation lock
> - */
> -void iomap_file_buffered_write_punch_delalloc(struct inode *inode,
> -		loff_t pos, loff_t length, ssize_t written, unsigned flags,
> -		struct iomap *iomap, iomap_punch_t punch)
> -{
> -	loff_t			start_byte;
> -	loff_t			end_byte;
> -
> -	if (iomap->type != IOMAP_DELALLOC)
> -		return;
> -
> -	/* If we didn't reserve the blocks, we're not allowed to punch them. */
> -	if (!(iomap->flags & IOMAP_F_NEW))
> -		return;
> -
> -	start_byte = iomap_last_written_block(inode, pos, written);
> -	end_byte = round_up(pos + length, i_blocksize(inode));
> -
> -	/* Nothing to do if we've written the entire delalloc extent */
> -	if (start_byte >= end_byte)
> -		return;
> -
> -	iomap_write_delalloc_release(inode, start_byte, end_byte, flags, iomap,
> -			punch);
> -}
> -EXPORT_SYMBOL_GPL(iomap_file_buffered_write_punch_delalloc);
> +EXPORT_SYMBOL_GPL(iomap_write_delalloc_release);
>  
>  static loff_t iomap_unshare_iter(struct iomap_iter *iter)
>  {
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 1e11f48814c0d0..30f2530b6d5461 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1227,8 +1227,20 @@ xfs_buffered_write_iomap_end(
>  	unsigned		flags,
>  	struct iomap		*iomap)
>  {
> -	iomap_file_buffered_write_punch_delalloc(inode, offset, length, written,
> -			flags, iomap, &xfs_buffered_write_delalloc_punch);
> +	loff_t			start_byte, end_byte;
> +
> +	/* If we didn't reserve the blocks, we're not allowed to punch them. */
> +	if (iomap->type != IOMAP_DELALLOC || !(iomap->flags & IOMAP_F_NEW))
> +		return 0;
> +
> +	/* Nothing to do if we've written the entire delalloc extent */
> +	start_byte = iomap_last_written_block(inode, offset, written);
> +	end_byte = round_up(offset + length, i_blocksize(inode));
> +	if (start_byte >= end_byte)
> +		return 0;
> +
> +	iomap_write_delalloc_release(inode, start_byte, end_byte, flags, iomap,
> +			xfs_buffered_write_delalloc_punch);
>  	return 0;
>  }
>  
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index e62df5d93f04de..137e0783faa224 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -290,9 +290,9 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf,
>  
>  typedef void (*iomap_punch_t)(struct inode *inode, loff_t offset, loff_t length,
>  		struct iomap *iomap);
> -void iomap_file_buffered_write_punch_delalloc(struct inode *inode, loff_t pos,
> -		loff_t length, ssize_t written, unsigned flag,
> -		struct iomap *iomap, iomap_punch_t punch);
> +void iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
> +		loff_t end_byte, unsigned flags, struct iomap *iomap,
> +		iomap_punch_t punch);
>  
>  int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  		u64 start, u64 len, const struct iomap_ops *ops);
> -- 
> 2.45.2
> 

