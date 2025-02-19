Return-Path: <linux-fsdevel+bounces-42127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54965A3CC53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 23:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2363B3B1FB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 22:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4D3259495;
	Wed, 19 Feb 2025 22:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vbj8SKe2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E465B17CA12;
	Wed, 19 Feb 2025 22:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740004248; cv=none; b=N2WbcAUkPLBSxuY0B3x8cpjVJPZZr8VfWpVeehWLSBZX81LROlAFA+ofVaRyYDeSrk7dQ7Ka0GKUzeRP2OsO+kLxIqJeM65zf1+KTsujOKtbW2i8cioXY/qy390WBFzwhM8wHFzS8XyfBMhw5ViQ+tNHxmDPoyjBKXeI8E7v0g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740004248; c=relaxed/simple;
	bh=jjXzhAJFCVknuEOs7lhzhEMjYucW7O2PWAuVmdDll9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUvO2dfu4FdBEbQxEWzSk/kUsUMyZXEz/1QUTELctLdaAZpPqwbtdMECoAUlN9XGSl46Rcmaf5g/hWUgkjexfq82BEWoBplLSXaUZ1YttjjolbaGoyPrRrP1K6ih3JsgqVjGQAWr5cNmId8d2h1IgjifSimufL8bQRR4K9Heggs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vbj8SKe2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61DDC4CED1;
	Wed, 19 Feb 2025 22:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740004247;
	bh=jjXzhAJFCVknuEOs7lhzhEMjYucW7O2PWAuVmdDll9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vbj8SKe2fFYn39VDW5cP4hGsYkJL4RddWqZ0wWwW7EplSvQoCTJqrfqu7GKNCqB7a
	 Cs+cSxVxXzVvhHASw022tKt/DQq17zJorkTNrGK1tSas9cHaoNChIFUzypIblnTySB
	 XwuoJzh1WZf1olnS99z6Qi4GFcDr7evxvujykBALKNYcHRr/uY7i5Knq002mjbpijh
	 A5HX0X6T0HFKzIHy8WOFLXmD8MM6j9Flyl718CZVYApUHz5HlpikORFD1c7nyt6l1n
	 56VAtPqnkN9T1BS8rbcJKDzCo7vO/PEIfY0QbOnCzHyaJY19OFVlUf7Y9HG8jUZPMQ
	 OWLC6F/o+OIhg==
Date: Wed, 19 Feb 2025 14:30:47 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 11/12] iomap: rename iomap_iter processed field to
 status
Message-ID: <20250219223047.GF21808@frogsfrogsfrogs>
References: <20250219175050.83986-1-bfoster@redhat.com>
 <20250219175050.83986-12-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219175050.83986-12-bfoster@redhat.com>

On Wed, Feb 19, 2025 at 12:50:49PM -0500, Brian Foster wrote:
> The iter.processed field name is no longer appropriate now that
> iomap operations do not return the number of bytes processed. Rename
> the field to iter.status to reflect that a success or error code is
> expected.
> 
> Also change the type to int as there is no longer a need for an s64.
> This reduces the size of iomap_iter by 8 bytes due to a combination
> of smaller type and reduction in structure padding. While here, fix
> up the return types of various _iter() helpers to reflect the type
> change.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Aha, this is the answer to my question from the first patch.
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/dax.c               | 20 ++++++++++----------
>  fs/iomap/buffered-io.c | 42 +++++++++++++++++++++---------------------
>  fs/iomap/direct-io.c   |  2 +-
>  fs/iomap/fiemap.c      |  6 +++---
>  fs/iomap/iter.c        | 12 ++++++------
>  fs/iomap/seek.c        |  8 ++++----
>  fs/iomap/swapfile.c    |  4 ++--
>  fs/iomap/trace.h       |  8 ++++----
>  include/linux/iomap.h  |  7 +++----
>  9 files changed, 54 insertions(+), 55 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 44701865ca94..cab3c5abe5cb 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1258,7 +1258,7 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
>  }
>  #endif /* CONFIG_FS_DAX_PMD */
>  
> -static s64 dax_unshare_iter(struct iomap_iter *iter)
> +static int dax_unshare_iter(struct iomap_iter *iter)
>  {
>  	struct iomap *iomap = &iter->iomap;
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> @@ -1328,7 +1328,7 @@ int dax_file_unshare(struct inode *inode, loff_t pos, loff_t len,
>  
>  	iter.len = min(len, size - pos);
>  	while ((ret = iomap_iter(&iter, ops)) > 0)
> -		iter.processed = dax_unshare_iter(&iter);
> +		iter.status = dax_unshare_iter(&iter);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(dax_file_unshare);
> @@ -1356,12 +1356,12 @@ static int dax_memzero(struct iomap_iter *iter, loff_t pos, size_t size)
>  	return ret;
>  }
>  
> -static s64 dax_zero_iter(struct iomap_iter *iter, bool *did_zero)
> +static int dax_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  {
>  	const struct iomap *iomap = &iter->iomap;
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  	u64 length = iomap_length(iter);
> -	s64 ret;
> +	int ret;
>  
>  	/* already zeroed?  we're done. */
>  	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
> @@ -1416,7 +1416,7 @@ int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>  	int ret;
>  
>  	while ((ret = iomap_iter(&iter, ops)) > 0)
> -		iter.processed = dax_zero_iter(&iter, did_zero);
> +		iter.status = dax_zero_iter(&iter, did_zero);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(dax_zero_range);
> @@ -1588,7 +1588,7 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		iomi.flags |= IOMAP_NOWAIT;
>  
>  	while ((ret = iomap_iter(&iomi, ops)) > 0)
> -		iomi.processed = dax_iomap_iter(&iomi, iter);
> +		iomi.status = dax_iomap_iter(&iomi, iter);
>  
>  	done = iomi.pos - iocb->ki_pos;
>  	iocb->ki_pos = iomi.pos;
> @@ -1759,7 +1759,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  
>  	while ((error = iomap_iter(&iter, ops)) > 0) {
>  		if (WARN_ON_ONCE(iomap_length(&iter) < PAGE_SIZE)) {
> -			iter.processed = -EIO;	/* fs corruption? */
> +			iter.status = -EIO;	/* fs corruption? */
>  			continue;
>  		}
>  
> @@ -1773,7 +1773,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  
>  		if (!(ret & VM_FAULT_ERROR)) {
>  			u64 length = PAGE_SIZE;
> -			iter.processed = iomap_iter_advance(&iter, &length);
> +			iter.status = iomap_iter_advance(&iter, &length);
>  		}
>  	}
>  
> @@ -1889,7 +1889,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  		ret = dax_fault_iter(vmf, &iter, pfnp, &xas, &entry, true);
>  		if (ret != VM_FAULT_FALLBACK) {
>  			u64 length = PMD_SIZE;
> -			iter.processed = iomap_iter_advance(&iter, &length);
> +			iter.status = iomap_iter_advance(&iter, &length);
>  		}
>  	}
>  
> @@ -2079,7 +2079,7 @@ int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
>  				min(src_iter.len, dst_iter.len), same);
>  		if (status < 0)
>  			return ret;
> -		src_iter.processed = dst_iter.processed = status;
> +		src_iter.status = dst_iter.status = status;
>  	}
>  	return ret;
>  }
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index ddc82dab6bb5..2b86978010bb 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -366,7 +366,7 @@ static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
>  		pos >= i_size_read(iter->inode);
>  }
>  
> -static loff_t iomap_readpage_iter(struct iomap_iter *iter,
> +static int iomap_readpage_iter(struct iomap_iter *iter,
>  		struct iomap_readpage_ctx *ctx)
>  {
>  	const struct iomap *iomap = &iter->iomap;
> @@ -441,10 +441,10 @@ static loff_t iomap_readpage_iter(struct iomap_iter *iter,
>  	return iomap_iter_advance(iter, &length);
>  }
>  
> -static loff_t iomap_read_folio_iter(struct iomap_iter *iter,
> +static int iomap_read_folio_iter(struct iomap_iter *iter,
>  		struct iomap_readpage_ctx *ctx)
>  {
> -	loff_t ret;
> +	int ret;
>  
>  	while (iomap_length(iter)) {
>  		ret = iomap_readpage_iter(iter, ctx);
> @@ -470,7 +470,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
>  	trace_iomap_readpage(iter.inode, 1);
>  
>  	while ((ret = iomap_iter(&iter, ops)) > 0)
> -		iter.processed = iomap_read_folio_iter(&iter, &ctx);
> +		iter.status = iomap_read_folio_iter(&iter, &ctx);
>  
>  	if (ctx.bio) {
>  		submit_bio(ctx.bio);
> @@ -489,10 +489,10 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
>  }
>  EXPORT_SYMBOL_GPL(iomap_read_folio);
>  
> -static loff_t iomap_readahead_iter(struct iomap_iter *iter,
> +static int iomap_readahead_iter(struct iomap_iter *iter,
>  		struct iomap_readpage_ctx *ctx)
>  {
> -	loff_t ret;
> +	int ret;
>  
>  	while (iomap_length(iter)) {
>  		if (ctx->cur_folio &&
> @@ -542,7 +542,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
>  	trace_iomap_readahead(rac->mapping->host, readahead_count(rac));
>  
>  	while (iomap_iter(&iter, ops) > 0)
> -		iter.processed = iomap_readahead_iter(&iter, &ctx);
> +		iter.status = iomap_readahead_iter(&iter, &ctx);
>  
>  	if (ctx.bio)
>  		submit_bio(ctx.bio);
> @@ -902,10 +902,10 @@ static bool iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
>  	return __iomap_write_end(iter->inode, pos, len, copied, folio);
>  }
>  
> -static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
> +static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  {
>  	ssize_t total_written = 0;
> -	long status = 0;
> +	int status = 0;
>  	struct address_space *mapping = iter->inode->i_mapping;
>  	size_t chunk = mapping_max_folio_size(mapping);
>  	unsigned int bdp_flags = (iter->flags & IOMAP_NOWAIT) ? BDP_ASYNC : 0;
> @@ -1025,7 +1025,7 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
>  		iter.flags |= IOMAP_NOWAIT;
>  
>  	while ((ret = iomap_iter(&iter, ops)) > 0)
> -		iter.processed = iomap_write_iter(&iter, i);
> +		iter.status = iomap_write_iter(&iter, i);
>  
>  	if (unlikely(iter.pos == iocb->ki_pos))
>  		return ret;
> @@ -1259,7 +1259,7 @@ void iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
>  }
>  EXPORT_SYMBOL_GPL(iomap_write_delalloc_release);
>  
> -static loff_t iomap_unshare_iter(struct iomap_iter *iter)
> +static int iomap_unshare_iter(struct iomap_iter *iter)
>  {
>  	struct iomap *iomap = &iter->iomap;
>  	u64 bytes = iomap_length(iter);
> @@ -1319,7 +1319,7 @@ iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
>  
>  	iter.len = min(len, size - pos);
>  	while ((ret = iomap_iter(&iter, ops)) > 0)
> -		iter.processed = iomap_unshare_iter(&iter);
> +		iter.status = iomap_unshare_iter(&iter);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(iomap_file_unshare);
> @@ -1338,7 +1338,7 @@ static inline int iomap_zero_iter_flush_and_stale(struct iomap_iter *i)
>  	return filemap_write_and_wait_range(mapping, i->pos, end);
>  }
>  
> -static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
> +static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  {
>  	u64 bytes = iomap_length(iter);
>  	int status;
> @@ -1411,7 +1411,7 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>  	    filemap_range_needs_writeback(mapping, pos, pos + plen - 1)) {
>  		iter.len = plen;
>  		while ((ret = iomap_iter(&iter, ops)) > 0)
> -			iter.processed = iomap_zero_iter(&iter, did_zero);
> +			iter.status = iomap_zero_iter(&iter, did_zero);
>  
>  		iter.len = len - (iter.pos - pos);
>  		if (ret || !iter.len)
> @@ -1430,20 +1430,20 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>  
>  		if (srcmap->type == IOMAP_HOLE ||
>  		    srcmap->type == IOMAP_UNWRITTEN) {
> -			s64 proc;
> +			s64 status;
>  
>  			if (range_dirty) {
>  				range_dirty = false;
> -				proc = iomap_zero_iter_flush_and_stale(&iter);
> +				status = iomap_zero_iter_flush_and_stale(&iter);
>  			} else {
>  				u64 length = iomap_length(&iter);
> -				proc = iomap_iter_advance(&iter, &length);
> +				status = iomap_iter_advance(&iter, &length);
>  			}
> -			iter.processed = proc;
> +			iter.status = status;
>  			continue;
>  		}
>  
> -		iter.processed = iomap_zero_iter(&iter, did_zero);
> +		iter.status = iomap_zero_iter(&iter, did_zero);
>  	}
>  	return ret;
>  }
> @@ -1463,7 +1463,7 @@ iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
>  }
>  EXPORT_SYMBOL_GPL(iomap_truncate_page);
>  
> -static loff_t iomap_folio_mkwrite_iter(struct iomap_iter *iter,
> +static int iomap_folio_mkwrite_iter(struct iomap_iter *iter,
>  		struct folio *folio)
>  {
>  	loff_t length = iomap_length(iter);
> @@ -1499,7 +1499,7 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
>  	iter.pos = folio_pos(folio);
>  	iter.len = ret;
>  	while ((ret = iomap_iter(&iter, ops)) > 0)
> -		iter.processed = iomap_folio_mkwrite_iter(&iter, folio);
> +		iter.status = iomap_folio_mkwrite_iter(&iter, folio);
>  
>  	if (ret < 0)
>  		goto out_unlock;
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index b3599f8d12ac..a84bba651e14 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -696,7 +696,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  
>  	blk_start_plug(&plug);
>  	while ((ret = iomap_iter(&iomi, ops)) > 0) {
> -		iomi.processed = iomap_dio_iter(&iomi, dio);
> +		iomi.status = iomap_dio_iter(&iomi, dio);
>  
>  		/*
>  		 * We can only poll for single bio I/Os.
> diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
> index 8a0d8b034218..6776b800bde7 100644
> --- a/fs/iomap/fiemap.c
> +++ b/fs/iomap/fiemap.c
> @@ -39,7 +39,7 @@ static int iomap_to_fiemap(struct fiemap_extent_info *fi,
>  			iomap->length, flags);
>  }
>  
> -static loff_t iomap_fiemap_iter(struct iomap_iter *iter,
> +static int iomap_fiemap_iter(struct iomap_iter *iter,
>  		struct fiemap_extent_info *fi, struct iomap *prev)
>  {
>  	u64 length = iomap_length(iter);
> @@ -78,7 +78,7 @@ int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fi,
>  		return ret;
>  
>  	while ((ret = iomap_iter(&iter, ops)) > 0)
> -		iter.processed = iomap_fiemap_iter(&iter, fi, &prev);
> +		iter.status = iomap_fiemap_iter(&iter, fi, &prev);
>  
>  	if (prev.type != IOMAP_HOLE) {
>  		ret = iomap_to_fiemap(fi, &prev, FIEMAP_EXTENT_LAST);
> @@ -114,7 +114,7 @@ iomap_bmap(struct address_space *mapping, sector_t bno,
>  	while ((ret = iomap_iter(&iter, ops)) > 0) {
>  		if (iter.iomap.type == IOMAP_MAPPED)
>  			bno = iomap_sector(&iter.iomap, iter.pos) >> blkshift;
> -		/* leave iter.processed unset to abort loop */
> +		/* leave iter.status unset to abort loop */
>  	}
>  	if (ret)
>  		return 0;
> diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
> index e4dfe64029cc..6ffc6a7b9ba5 100644
> --- a/fs/iomap/iter.c
> +++ b/fs/iomap/iter.c
> @@ -9,7 +9,7 @@
>  
>  static inline void iomap_iter_reset_iomap(struct iomap_iter *iter)
>  {
> -	iter->processed = 0;
> +	iter->status = 0;
>  	memset(&iter->iomap, 0, sizeof(iter->iomap));
>  	memset(&iter->srcmap, 0, sizeof(iter->srcmap));
>  }
> @@ -54,7 +54,7 @@ static inline void iomap_iter_done(struct iomap_iter *iter)
>   * function must be called in a loop that continues as long it returns a
>   * positive value.  If 0 or a negative value is returned, the caller must not
>   * return to the loop body.  Within a loop body, there are two ways to break out
> - * of the loop body:  leave @iter.processed unchanged, or set it to a negative
> + * of the loop body:  leave @iter.status unchanged, or set it to a negative
>   * errno.
>   */
>  int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
> @@ -86,8 +86,8 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
>  	}
>  
>  	/* detect old return semantics where this would advance */
> -	if (WARN_ON_ONCE(iter->processed > 0))
> -		iter->processed = -EIO;
> +	if (WARN_ON_ONCE(iter->status > 0))
> +		iter->status = -EIO;
>  
>  	/*
>  	 * Use iter->len to determine whether to continue onto the next mapping.
> @@ -95,8 +95,8 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
>  	 * advanced at all (i.e. no work was done for some reason) unless the
>  	 * mapping has been marked stale and needs to be reprocessed.
>  	 */
> -	if (iter->processed < 0)
> -		ret = iter->processed;
> +	if (iter->status < 0)
> +		ret = iter->status;
>  	else if (iter->len == 0 || (!advanced && !stale))
>  		ret = 0;
>  	else
> diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
> index 83c687d6ccc0..04d7919636c1 100644
> --- a/fs/iomap/seek.c
> +++ b/fs/iomap/seek.c
> @@ -10,7 +10,7 @@
>  #include <linux/pagemap.h>
>  #include <linux/pagevec.h>
>  
> -static loff_t iomap_seek_hole_iter(struct iomap_iter *iter,
> +static int iomap_seek_hole_iter(struct iomap_iter *iter,
>  		loff_t *hole_pos)
>  {
>  	loff_t length = iomap_length(iter);
> @@ -47,7 +47,7 @@ iomap_seek_hole(struct inode *inode, loff_t pos, const struct iomap_ops *ops)
>  
>  	iter.len = size - pos;
>  	while ((ret = iomap_iter(&iter, ops)) > 0)
> -		iter.processed = iomap_seek_hole_iter(&iter, &pos);
> +		iter.status = iomap_seek_hole_iter(&iter, &pos);
>  	if (ret < 0)
>  		return ret;
>  	if (iter.len) /* found hole before EOF */
> @@ -56,7 +56,7 @@ iomap_seek_hole(struct inode *inode, loff_t pos, const struct iomap_ops *ops)
>  }
>  EXPORT_SYMBOL_GPL(iomap_seek_hole);
>  
> -static loff_t iomap_seek_data_iter(struct iomap_iter *iter,
> +static int iomap_seek_data_iter(struct iomap_iter *iter,
>  		loff_t *hole_pos)
>  {
>  	loff_t length = iomap_length(iter);
> @@ -93,7 +93,7 @@ iomap_seek_data(struct inode *inode, loff_t pos, const struct iomap_ops *ops)
>  
>  	iter.len = size - pos;
>  	while ((ret = iomap_iter(&iter, ops)) > 0)
> -		iter.processed = iomap_seek_data_iter(&iter, &pos);
> +		iter.status = iomap_seek_data_iter(&iter, &pos);
>  	if (ret < 0)
>  		return ret;
>  	if (iter.len) /* found data before EOF */
> diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
> index 4395e46a4dc7..9ea185e58ca7 100644
> --- a/fs/iomap/swapfile.c
> +++ b/fs/iomap/swapfile.c
> @@ -94,7 +94,7 @@ static int iomap_swapfile_fail(struct iomap_swapfile_info *isi, const char *str)
>   * swap only cares about contiguous page-aligned physical extents and makes no
>   * distinction between written and unwritten extents.
>   */
> -static loff_t iomap_swapfile_iter(struct iomap_iter *iter,
> +static int iomap_swapfile_iter(struct iomap_iter *iter,
>  		struct iomap *iomap, struct iomap_swapfile_info *isi)
>  {
>  	u64 length = iomap_length(iter);
> @@ -169,7 +169,7 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
>  		return ret;
>  
>  	while ((ret = iomap_iter(&iter, ops)) > 0)
> -		iter.processed = iomap_swapfile_iter(&iter, &iter.iomap, &isi);
> +		iter.status = iomap_swapfile_iter(&iter, &iter.iomap, &isi);
>  	if (ret < 0)
>  		return ret;
>  
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> index 4118a42cdab0..9eab2c8ac3c5 100644
> --- a/fs/iomap/trace.h
> +++ b/fs/iomap/trace.h
> @@ -207,7 +207,7 @@ TRACE_EVENT(iomap_iter,
>  		__field(u64, ino)
>  		__field(loff_t, pos)
>  		__field(u64, length)
> -		__field(s64, processed)
> +		__field(int, status)
>  		__field(unsigned int, flags)
>  		__field(const void *, ops)
>  		__field(unsigned long, caller)
> @@ -217,17 +217,17 @@ TRACE_EVENT(iomap_iter,
>  		__entry->ino = iter->inode->i_ino;
>  		__entry->pos = iter->pos;
>  		__entry->length = iomap_length(iter);
> -		__entry->processed = iter->processed;
> +		__entry->status = iter->status;
>  		__entry->flags = iter->flags;
>  		__entry->ops = ops;
>  		__entry->caller = caller;
>  	),
> -	TP_printk("dev %d:%d ino 0x%llx pos 0x%llx length 0x%llx processed %lld flags %s (0x%x) ops %ps caller %pS",
> +	TP_printk("dev %d:%d ino 0x%llx pos 0x%llx length 0x%llx status %d flags %s (0x%x) ops %ps caller %pS",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev),
>  		   __entry->ino,
>  		   __entry->pos,
>  		   __entry->length,
> -		   __entry->processed,
> +		   __entry->status,
>  		   __print_flags(__entry->flags, "|", IOMAP_FLAGS_STRINGS),
>  		   __entry->flags,
>  		   __entry->ops,
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index d832a540cc72..29b72a671104 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -213,9 +213,8 @@ struct iomap_ops {
>   *	It is updated at the same time as @pos.
>   * @iter_start_pos: The original start pos for the current iomap. Used for
>   *	incremental iter advance.
> - * @processed: The number of bytes the most recent iteration needs iomap_iter()
> - *	to advance the iter, zero if the iter was already advanced, or a
> - *	negative errno for an error during the operation.
> + * @status: Status of the most recent iteration. Zero on success or a negative
> + *	errno on error.
>   * @flags: Zero or more of the iomap_begin flags above.
>   * @iomap: Map describing the I/O iteration
>   * @srcmap: Source map for COW operations
> @@ -225,7 +224,7 @@ struct iomap_iter {
>  	loff_t pos;
>  	u64 len;
>  	loff_t iter_start_pos;
> -	s64 processed;
> +	int status;
>  	unsigned flags;
>  	struct iomap iomap;
>  	struct iomap srcmap;
> -- 
> 2.48.1
> 
> 

