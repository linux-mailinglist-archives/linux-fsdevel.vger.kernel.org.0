Return-Path: <linux-fsdevel+bounces-43260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DF4A4FF2D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 13:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D953AF2F4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 12:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B102459EF;
	Wed,  5 Mar 2025 12:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBrBCpG/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C3A2459C5;
	Wed,  5 Mar 2025 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741179453; cv=none; b=gjXhSW/TnztPUbl00DpLScGp9G/wLKtt9VeET7902XDisz/suBccnF4kVk51SGzHyxKdY2xKddmbREtGBj3/iTokikvdIjywfbdhkFUpH5KqvlO21HpQSlw7M/1XhGu5qLw8CwGLIwYI6Z/6/ReLwEWSKuVkOvxO2dVLDvdPmro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741179453; c=relaxed/simple;
	bh=Ljvfdb0OsdRdRE+6YawQZ3FbQxKnmX+JvjYq/i/gwvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uzb4zPINriQgb9mMWQ17hV4sL60Qbdm7DhPZbGT2THuVkwEz1CoxdeIyv1Bj7tzWq69WXvi0FgXtBCWTh3380ePDfZ8mBe/1qsJqvowWFakZhw7QQS3aRLrElQ9ETc/LWb2K5h8s+m3ivBCJ6e2Ju8KI5DUoSPhYKeJXmAEVNs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBrBCpG/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18B9C4CEE7;
	Wed,  5 Mar 2025 12:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741179452;
	bh=Ljvfdb0OsdRdRE+6YawQZ3FbQxKnmX+JvjYq/i/gwvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gBrBCpG/iSg6fOVDefcq0ifue0Bnw+h3Bhgt2Daiyb48AVpjDDsYF9oEb0ZBh4RbP
	 bJ+mglNsFOI37wx0ghPu9VUMD5x5ZL7xMOaf9BH9wLpKNBhBM5saCHdryYnPgMeTrZ
	 R7+0x+qehwQgjXZIJOGJVwgDfyhgaNTJIgApXhDzV59XX8mH/gXLZhWyBXQg7epcEu
	 WcOHGPi/P4n09VESMF80rVi/8CeLBNirh45pXAu6vMpKi3dwaaHFlz+LRn7FpfRnoF
	 eu547QqsPzxQFljudQ8OwPAmxBN7Fadfmg7NEhiqQcu3B0lKiVVmXtCP15QHA/WYY5
	 IvvDYXFyIfJLA==
Date: Wed, 5 Mar 2025 13:57:26 +0100
From: Carlos Maiolino <cem@kernel.org>
To: brauner@kernel.org
Cc: brauner@kernel.org, djwong@kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com, 
	ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu, 
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 02/12] iomap: Rename IOMAP_ATOMIC -> IOMAP_ATOMIC_HW
Message-ID: <mefv3axgsk567xwwwuoonvo7bncvdgu547ycvin5zjlztslotm@qu4fxqi3fave>
References: <20250303171120.2837067-1-john.g.garry@oracle.com>
 <UQF0E8blbU4wMo9RdB7-nRkNAIJHtPkzDsTrQEOkNRLjG2CGbKe97G8XenXN1DSkhoWhipJrN956Enqgk9Ewkg==@protonmail.internalid>
 <20250303171120.2837067-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303171120.2837067-3-john.g.garry@oracle.com>

Hi Christian,
On Mon, Mar 03, 2025 at 05:11:10PM +0000, John Garry wrote:
> In future xfs will support a SW-based atomic write, so rename
> IOMAP_ATOMIC -> IOMAP_ATOMIC_HW to be clear which mode is being used.
> 
> Also relocate setting of IOMAP_ATOMIC_HW to the write path in
> __iomap_dio_rw(), to be clear that this flag is only relevant to writes.
> 
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: John Garry <john.g.garry@oracle.com>

I pushed the patches in this series into this branch:
git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git xfs-6.15-atomicwrites

Do you plan to send the iomap patches in this series yourself or is it ok with
you if they go through xfs tree?

Cheers,
Carlos

> ---
>  Documentation/filesystems/iomap/operations.rst |  4 ++--
>  fs/ext4/inode.c                                |  2 +-
>  fs/iomap/direct-io.c                           | 18 +++++++++---------
>  fs/iomap/trace.h                               |  2 +-
>  include/linux/iomap.h                          |  2 +-
>  5 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
> index d1535109587a..0b9d7be23bce 100644
> --- a/Documentation/filesystems/iomap/operations.rst
> +++ b/Documentation/filesystems/iomap/operations.rst
> @@ -514,8 +514,8 @@ IOMAP_WRITE`` with any combination of the following enhancements:
>     if the mapping is unwritten and the filesystem cannot handle zeroing
>     the unaligned regions without exposing stale contents.
> 
> - * ``IOMAP_ATOMIC``: This write is being issued with torn-write
> -   protection.
> + * ``IOMAP_ATOMIC_HW``: This write is being issued with torn-write
> +   protection based on HW-offload support.
>     Only a single bio can be created for the write, and the write must
>     not be split into multiple I/O requests, i.e. flag REQ_ATOMIC must be
>     set.
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 7c54ae5fcbd4..ba2f1e3db7c7 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3467,7 +3467,7 @@ static inline bool ext4_want_directio_fallback(unsigned flags, ssize_t written)
>  		return false;
> 
>  	/* atomic writes are all-or-nothing */
> -	if (flags & IOMAP_ATOMIC)
> +	if (flags & IOMAP_ATOMIC_HW)
>  		return false;
> 
>  	/* can only try again if we wrote nothing */
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index e1e32e2bb0bf..c696ce980796 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -317,7 +317,7 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
>   * clearing the WRITE_THROUGH flag in the dio request.
>   */
>  static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
> -		const struct iomap *iomap, bool use_fua, bool atomic)
> +		const struct iomap *iomap, bool use_fua, bool atomic_hw)
>  {
>  	blk_opf_t opflags = REQ_SYNC | REQ_IDLE;
> 
> @@ -329,7 +329,7 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
>  		opflags |= REQ_FUA;
>  	else
>  		dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
> -	if (atomic)
> +	if (atomic_hw)
>  		opflags |= REQ_ATOMIC;
> 
>  	return opflags;
> @@ -340,8 +340,8 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  	const struct iomap *iomap = &iter->iomap;
>  	struct inode *inode = iter->inode;
>  	unsigned int fs_block_size = i_blocksize(inode), pad;
> +	bool atomic_hw = iter->flags & IOMAP_ATOMIC_HW;
>  	const loff_t length = iomap_length(iter);
> -	bool atomic = iter->flags & IOMAP_ATOMIC;
>  	loff_t pos = iter->pos;
>  	blk_opf_t bio_opf;
>  	struct bio *bio;
> @@ -351,7 +351,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  	u64 copied = 0;
>  	size_t orig_count;
> 
> -	if (atomic && length != fs_block_size)
> +	if (atomic_hw && length != fs_block_size)
>  		return -EINVAL;
> 
>  	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
> @@ -428,7 +428,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  			goto out;
>  	}
> 
> -	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, atomic);
> +	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, atomic_hw);
> 
>  	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
>  	do {
> @@ -461,7 +461,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  		}
> 
>  		n = bio->bi_iter.bi_size;
> -		if (WARN_ON_ONCE(atomic && n != length)) {
> +		if (WARN_ON_ONCE(atomic_hw && n != length)) {
>  			/*
>  			 * This bio should have covered the complete length,
>  			 * which it doesn't, so error. We may need to zero out
> @@ -652,9 +652,6 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	if (iocb->ki_flags & IOCB_NOWAIT)
>  		iomi.flags |= IOMAP_NOWAIT;
> 
> -	if (iocb->ki_flags & IOCB_ATOMIC)
> -		iomi.flags |= IOMAP_ATOMIC;
> -
>  	if (iov_iter_rw(iter) == READ) {
>  		/* reads can always complete inline */
>  		dio->flags |= IOMAP_DIO_INLINE_COMP;
> @@ -689,6 +686,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  			iomi.flags |= IOMAP_OVERWRITE_ONLY;
>  		}
> 
> +		if (iocb->ki_flags & IOCB_ATOMIC)
> +			iomi.flags |= IOMAP_ATOMIC_HW;
> +
>  		/* for data sync or sync, we need sync completion processing */
>  		if (iocb_is_dsync(iocb)) {
>  			dio->flags |= IOMAP_DIO_NEED_SYNC;
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> index 9eab2c8ac3c5..69af89044ebd 100644
> --- a/fs/iomap/trace.h
> +++ b/fs/iomap/trace.h
> @@ -99,7 +99,7 @@ DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
>  	{ IOMAP_FAULT,		"FAULT" }, \
>  	{ IOMAP_DIRECT,		"DIRECT" }, \
>  	{ IOMAP_NOWAIT,		"NOWAIT" }, \
> -	{ IOMAP_ATOMIC,		"ATOMIC" }
> +	{ IOMAP_ATOMIC_HW,	"ATOMIC_HW" }
> 
>  #define IOMAP_F_FLAGS_STRINGS \
>  	{ IOMAP_F_NEW,		"NEW" }, \
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index ea29388b2fba..87cd7079aaf3 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -189,7 +189,7 @@ struct iomap_folio_ops {
>  #else
>  #define IOMAP_DAX		0
>  #endif /* CONFIG_FS_DAX */
> -#define IOMAP_ATOMIC		(1 << 9)
> +#define IOMAP_ATOMIC_HW		(1 << 9)
>  #define IOMAP_DONTCACHE		(1 << 10)
> 
>  struct iomap_ops {
> --
> 2.31.1
> 

