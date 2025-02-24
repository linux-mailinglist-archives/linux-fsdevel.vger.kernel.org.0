Return-Path: <linux-fsdevel+bounces-42495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16196A42DA5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 150E63B2AE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 20:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62F6245000;
	Mon, 24 Feb 2025 20:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxlcMljf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FB43B2A0;
	Mon, 24 Feb 2025 20:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740428612; cv=none; b=hRH9C50oUJUh15XBBQmIl3s+sG5GY1UkU3AnyeAHbRB4Q24W3+8eylkO1k0bDCh0pYZ3O/NegIYGaDddmi20aau6C93eK0DlT7odBVeNBBJrT3lwRvFQ1mrVQXVPiMr7/+hkm7zDx0qtSlHqzJHj8zhXVaLttbEaflL1BUMSIH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740428612; c=relaxed/simple;
	bh=fj9sDRa/umZo0BRc92vVFI+fRvhsxSOyR+/mPfQ1iYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGOlgbf/cbEWIvPG3zuOehuUJ4kF+blQsk3Z+cINr6vjiOHF3XtRLDbcGQKmDPeDYl0lsC810ClfUMh5SmkGBTWdmB46oEyeEEDu3cjFqrWma7GiH5m0M8XULKNWjkeVkpf3V3JoGtK7bdP6+ovNQwshuqQkqaaFUESVMZYw7lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxlcMljf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E763C4CED6;
	Mon, 24 Feb 2025 20:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740428611;
	bh=fj9sDRa/umZo0BRc92vVFI+fRvhsxSOyR+/mPfQ1iYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fxlcMljf+waHtF0pSkyePhgbbUyUYydMJmNmavuFK51JfJuBEZjduMPz1w/R9Rwy6
	 VOc8wkO+EK0bOvRYtdHxYHxgc4YAcI/11UKD5XOa7gV6okj2WUlRr/1rCv0zFtJElV
	 fs0x3y0pyI0Qtol+KBoHu1XDER6d/13aOgWBfFD8yJzFDgXh8FAePyGQ6/XQ0C0C+C
	 sE9v8mboZbGAHWapSEcl0+Ti8I4el+QSuOPAfYJLzjpUjm3K68uMx2r0qVMSodZ7CQ
	 XP9p0ttLLxZm8uPAH1znduRbfCMmYUI1251JwOaFAzEp+z2wCc2Jfes+wD8sGTIaLs
	 vFneGjc6VJs8Q==
Date: Mon, 24 Feb 2025 12:23:31 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 01/11] iomap: Rename IOMAP_ATOMIC -> IOMAP_ATOMIC_HW
Message-ID: <20250224202331.GF21808@frogsfrogsfrogs>
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
 <20250213135619.1148432-2-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213135619.1148432-2-john.g.garry@oracle.com>

On Thu, Feb 13, 2025 at 01:56:09PM +0000, John Garry wrote:
> In future xfs will support a CoW-based atomic write, so rename
> IOMAP_ATOMIC -> IOMAP_ATOMIC_HW to be clear which mode is being used.
> 
> Also relocate setting of IOMAP_ATOMIC_HW to the write path in
> __iomap_dio_rw(), to be clear that this flag is only relevant to writes
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Looks fine,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  Documentation/filesystems/iomap/operations.rst |  4 ++--
>  fs/ext4/inode.c                                |  2 +-
>  fs/iomap/direct-io.c                           | 18 +++++++++---------
>  fs/iomap/trace.h                               |  2 +-
>  include/linux/iomap.h                          |  2 +-
>  5 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
> index 2c7f5df9d8b0..82bfe0e8c08e 100644
> --- a/Documentation/filesystems/iomap/operations.rst
> +++ b/Documentation/filesystems/iomap/operations.rst
> @@ -513,8 +513,8 @@ IOMAP_WRITE`` with any combination of the following enhancements:
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
> index b521eb15759e..f87c4277e738 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -271,7 +271,7 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
>   * clearing the WRITE_THROUGH flag in the dio request.
>   */
>  static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
> -		const struct iomap *iomap, bool use_fua, bool atomic)
> +		const struct iomap *iomap, bool use_fua, bool atomic_hw)
>  {
>  	blk_opf_t opflags = REQ_SYNC | REQ_IDLE;
>  
> @@ -283,7 +283,7 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
>  		opflags |= REQ_FUA;
>  	else
>  		dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
> -	if (atomic)
> +	if (atomic_hw)
>  		opflags |= REQ_ATOMIC;
>  
>  	return opflags;
> @@ -295,8 +295,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  	const struct iomap *iomap = &iter->iomap;
>  	struct inode *inode = iter->inode;
>  	unsigned int fs_block_size = i_blocksize(inode), pad;
> +	bool atomic_hw = iter->flags & IOMAP_ATOMIC_HW;
>  	const loff_t length = iomap_length(iter);
> -	bool atomic = iter->flags & IOMAP_ATOMIC;
>  	loff_t pos = iter->pos;
>  	blk_opf_t bio_opf;
>  	struct bio *bio;
> @@ -306,7 +306,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  	size_t copied = 0;
>  	size_t orig_count;
>  
> -	if (atomic && length != fs_block_size)
> +	if (atomic_hw && length != fs_block_size)
>  		return -EINVAL;
>  
>  	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
> @@ -383,7 +383,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  			goto out;
>  	}
>  
> -	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, atomic);
> +	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, atomic_hw);
>  
>  	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
>  	do {
> @@ -416,7 +416,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  		}
>  
>  		n = bio->bi_iter.bi_size;
> -		if (WARN_ON_ONCE(atomic && n != length)) {
> +		if (WARN_ON_ONCE(atomic_hw && n != length)) {
>  			/*
>  			 * This bio should have covered the complete length,
>  			 * which it doesn't, so error. We may need to zero out
> @@ -610,9 +610,6 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	if (iocb->ki_flags & IOCB_NOWAIT)
>  		iomi.flags |= IOMAP_NOWAIT;
>  
> -	if (iocb->ki_flags & IOCB_ATOMIC)
> -		iomi.flags |= IOMAP_ATOMIC;
> -
>  	if (iov_iter_rw(iter) == READ) {
>  		/* reads can always complete inline */
>  		dio->flags |= IOMAP_DIO_INLINE_COMP;
> @@ -647,6 +644,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
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
> index 4118a42cdab0..0c73d91c0485 100644
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
> index 75bf54e76f3b..e7aa05503763 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -182,7 +182,7 @@ struct iomap_folio_ops {
>  #else
>  #define IOMAP_DAX		0
>  #endif /* CONFIG_FS_DAX */
> -#define IOMAP_ATOMIC		(1 << 9)
> +#define IOMAP_ATOMIC_HW		(1 << 9) /* HW-based torn-write protection */
>  
>  struct iomap_ops {
>  	/*
> -- 
> 2.31.1
> 
> 

