Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A709DD440
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2019 00:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405291AbfJRWXb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Oct 2019 18:23:31 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38496 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729538AbfJRWXa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:23:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id w3so4097735pgt.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2019 15:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MzHxhMnXdIAGCCwIEY2WJUBT3wBp1xzFUzIsi1OpW2w=;
        b=IHkudll6CRLvq43RXv2RcZ1qV4+ejpHX8BWSwE1eBovSXO8eDLkjmVrsR/GfQB6WtS
         s4i/pH9ljljbgnBQEfvsMRg7GFglqJNIngIMA/GDjfvJKJNHy+HqqYCXcV3BOZxid0dF
         Dtx0+c/KAFJEnu0YrxLkreI0hz6+SdtYDVwlQblagjMaPzbnR2nn8Za02SAgnj5PRBUx
         jEr11NIRxbSI/pRj+V2vgVTmRYDmgIGYKVx64d5FMXaS62JNCn3qeyY/nI4g8Dgkmp5F
         BQvE7ijk9UVJZ+A7n0ts3YdASiSUdqRDAG+TgnakK2JgdYUkavjadseOKMORS+2waAsM
         93rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MzHxhMnXdIAGCCwIEY2WJUBT3wBp1xzFUzIsi1OpW2w=;
        b=KWiPZ9Pfccu5mHRTbsUXXWyZfJ9WXl9A++lRz/em/Fm74B46bzJ7BBx8PlNplwPbWA
         DsD/PTEVR8V1cOCzPGxl3pzgPcaAoWscS++e5t8l4N7xPpKZBvKvmLjh1uvMiUfyxi1M
         QGiVS3ViLgGirdXj7opQ7pMBOt4mC3431djZhwlfkn24yR+fEiTKIM7OgUUaqsu6rMvc
         Hh81ydCgU0t3VW2RpOJ/TgceUT5xNP4cw9kxzGxzJyYx3s8SXDf2Dj4zx43l6hW3+N23
         1rsvTzbmaTUtbMUR3Gcz4/EQDZ+J6a1McabSkgLVoJNzJSgjy35KasjWqIwBGnERux/1
         FUcw==
X-Gm-Message-State: APjAAAVZDyi+XruEobTBwjINryCRDRFmjGMgKaSTlElRBJNxmf5J4Zzb
        wfj2A51ixW57CDEDfm9iKL09Cg==
X-Google-Smtp-Source: APXvYqyV6C+A/+gL5XOZK94RDm6oRSMXXGsQl43LLXYD6mpTuSZUB50DypiKlwpb/DGPnksFO9oCLw==
X-Received: by 2002:a63:5b07:: with SMTP id p7mr12765457pgb.416.1571437408792;
        Fri, 18 Oct 2019 15:23:28 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::2:cf85])
        by smtp.gmail.com with ESMTPSA id f89sm6831413pje.20.2019.10.18.15.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 15:23:28 -0700 (PDT)
Date:   Fri, 18 Oct 2019 15:23:27 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@fb.com, Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>, linux-api@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/5] btrfs: implement RWF_ENCODED reads
Message-ID: <20191018222327.GC59713@vader>
References: <cover.1571164762.git.osandov@fb.com>
 <338d3b28dd31249053620b83e6ff190ad965fadc.1571164762.git.osandov@fb.com>
 <0c0c3307-de6c-5df9-bbe1-5079cfc70480@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c0c3307-de6c-5df9-bbe1-5079cfc70480@suse.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 16, 2019 at 02:10:10PM +0300, Nikolay Borisov wrote:
> 
> 
> On 15.10.19 г. 21:42 ч., Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > There are 4 main cases:
> > 
> > 1. Inline extents: we copy the data straight out of the extent buffer.
> > 2. Hole/preallocated extents: we indicate the size of the extent
> >    starting from the read position; we don't need to copy zeroes.
> > 3. Regular, uncompressed extents: we read the sectors we need directly
> >    from disk.
> > 4. Regular, compressed extents: we read the entire compressed extent
> >    from disk and indicate what subset of the decompressed extent is in
> >    the file.
> > 
> > This initial implementation simplifies a few things that can be improved
> > in the future:
> > 
> > - We hold the inode lock during the operation.
> > - Cases 1, 3, and 4 allocate temporary memory to read into before
> >   copying out to userspace.
> > - Cases 3 and 4 do not implement repair yet.
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >  fs/btrfs/ctree.h |   2 +
> >  fs/btrfs/file.c  |  12 +-
> >  fs/btrfs/inode.c | 462 +++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 475 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index 71552b2ca340..3b2aa1c7218c 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -2906,6 +2906,8 @@ int btrfs_run_delalloc_range(struct inode *inode, struct page *locked_page,
> >  int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end);
> >  void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
> >  					  u64 end, int uptodate);
> > +ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter);
> > +
> >  extern const struct dentry_operations btrfs_dentry_operations;
> >  
> >  /* ioctl.c */
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index 27e5b269e729..51740cee39fc 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -390,6 +390,16 @@ int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info)
> >  	return 0;
> >  }
> >  
> > +static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
> > +{
> > +	if (iocb->ki_flags & IOCB_ENCODED) {
> > +		if (iocb->ki_flags & IOCB_NOWAIT)
> > +			return -EOPNOTSUPP;
> > +		return btrfs_encoded_read(iocb, iter);
> > +	}
> > +	return generic_file_read_iter(iocb, iter);
> > +}
> > +
> >  /* simple helper to fault in pages and copy.  This should go away
> >   * and be replaced with calls into generic code.
> >   */
> > @@ -3457,7 +3467,7 @@ static int btrfs_file_open(struct inode *inode, struct file *filp)
> >  
> >  const struct file_operations btrfs_file_operations = {
> >  	.llseek		= btrfs_file_llseek,
> > -	.read_iter      = generic_file_read_iter,
> > +	.read_iter      = btrfs_file_read_iter,
> >  	.splice_read	= generic_file_splice_read,
> >  	.write_iter	= btrfs_file_write_iter,
> >  	.mmap		= btrfs_file_mmap,
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 8bce46122ef7..174d0738d2c9 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -10593,6 +10593,468 @@ void btrfs_set_range_writeback(struct extent_io_tree *tree, u64 start, u64 end)
> >  	}
> >  }
> >  
> > +static int encoded_iov_compression_from_btrfs(struct encoded_iov *encoded,
> > +					      unsigned int compress_type)
> > +{
> > +	switch (compress_type) {
> > +	case BTRFS_COMPRESS_NONE:
> > +		encoded->compression = ENCODED_IOV_COMPRESSION_NONE;
> > +		break;
> > +	case BTRFS_COMPRESS_ZLIB:
> > +		encoded->compression = ENCODED_IOV_COMPRESSION_ZLIB;
> > +		break;
> > +	case BTRFS_COMPRESS_LZO:
> > +		encoded->compression = ENCODED_IOV_COMPRESSION_LZO;
> > +		break;
> > +	case BTRFS_COMPRESS_ZSTD:
> > +		encoded->compression = ENCODED_IOV_COMPRESSION_ZSTD;
> > +		break;
> > +	default:
> > +		return -EIO;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static ssize_t btrfs_encoded_read_inline(struct kiocb *iocb,
> > +					 struct iov_iter *iter, u64 start,
> > +					 u64 lockend,
> > +					 struct extent_state **cached_state,
> > +					 u64 extent_start, size_t count,
> > +					 struct encoded_iov *encoded,
> > +					 bool *unlocked)
> > +{
> > +	struct inode *inode = file_inode(iocb->ki_filp);
> > +	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
> > +	struct btrfs_path *path;
> > +	struct extent_buffer *leaf;
> > +	struct btrfs_file_extent_item *item;
> > +	u64 ram_bytes;
> > +	unsigned long ptr;
> > +	void *tmp;
> > +	ssize_t ret;
> > +
> > +	path = btrfs_alloc_path();
> > +	if (!path) {
> > +		ret = -ENOMEM;
> > +		goto out;
> > +	}
> > +	ret = btrfs_lookup_file_extent(NULL, BTRFS_I(inode)->root, path,
> > +				       btrfs_ino(BTRFS_I(inode)), extent_start,
> > +				       0);
> > +	if (ret) {
> > +		if (ret > 0) {
> > +			/* The extent item disappeared? */
> > +			ret = -EIO;
> > +		}
> > +		goto out;
> > +	}
> > +	leaf = path->nodes[0];
> > +	item = btrfs_item_ptr(leaf, path->slots[0],
> > +			      struct btrfs_file_extent_item);
> > +
> > +	ram_bytes = btrfs_file_extent_ram_bytes(leaf, item);
> > +	ptr = btrfs_file_extent_inline_start(item);
> > +
> > +	encoded->len = (min_t(u64, extent_start + ram_bytes, inode->i_size) -
> > +			iocb->ki_pos);
> > +	ret = encoded_iov_compression_from_btrfs(encoded,
> > +				 btrfs_file_extent_compression(leaf, item));
> > +	if (ret)
> > +		goto out;
> > +	if (encoded->compression) {
> > +		size_t inline_size;
> > +
> > +		inline_size = btrfs_file_extent_inline_item_len(leaf,
> > +						btrfs_item_nr(path->slots[0]));
> > +		if (inline_size > count) {
> > +			ret = -EFBIG;
> > +			goto out;
> > +		}
> > +		count = inline_size;
> > +		encoded->unencoded_len = ram_bytes;
> > +		encoded->unencoded_offset = iocb->ki_pos - extent_start;
> > +	} else {
> > +		encoded->len = encoded->unencoded_len = count =
> > +			min_t(u64, count, encoded->len);
> > +		ptr += iocb->ki_pos - extent_start;
> > +	}
> > +
> > +	tmp = kmalloc(count, GFP_NOFS);
> > +	if (!tmp) {
> > +		ret = -ENOMEM;
> > +		goto out;
> > +	}
> > +	read_extent_buffer(leaf, tmp, ptr, count);
> > +	btrfs_free_path(path);
> > +	path = NULL;
> > +	unlock_extent_cached(io_tree, start, lockend, cached_state);
> > +	inode_unlock(inode);
> > +	*unlocked = true;
> > +	if (copy_to_iter(encoded, sizeof(*encoded), iter) == sizeof(*encoded) &&
> > +	    copy_to_iter(tmp, count, iter) == count)
> > +		ret = count;
> > +	else
> > +		ret = -EFAULT;
> > +	kfree(tmp);
> > +
> > +out:
> > +	btrfs_free_path(path);
> > +	return ret;
> > +}
> > +
> > +struct btrfs_encoded_read_private {
> > +	struct inode *inode;
> > +	wait_queue_head_t wait;
> > +	atomic_t pending;
> > +	bool uptodate;
> > +	bool skip_csum;
> > +};
> > +
> > +static bool btrfs_encoded_read_check_csums(struct btrfs_io_bio *io_bio)
> > +{
> > +	struct btrfs_encoded_read_private *priv = io_bio->bio.bi_private;
> > +	struct inode *inode = priv->inode;
> > +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> > +	u32 sectorsize = fs_info->sectorsize;
> > +	struct bio_vec *bvec;
> > +	struct bvec_iter_all iter_all;
> > +	u64 offset = 0;
> > +
> > +	if (priv->skip_csum)
> > +		return true;
> > +	bio_for_each_segment_all(bvec, &io_bio->bio, iter_all) {
> > +		unsigned int i, nr_sectors, pgoff;
> > +
> > +		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info, bvec->bv_len);
> > +		pgoff = bvec->bv_offset;
> > +		for (i = 0; i < nr_sectors; i++) {
> > +			int csum_pos;
> > +
> > +			csum_pos = BTRFS_BYTES_TO_BLKS(fs_info, offset);
> > +			if (__readpage_endio_check(inode, io_bio, csum_pos,
> > +						   bvec->bv_page, pgoff,
> > +						   io_bio->logical + offset,
> > +						   sectorsize))
> > +				return false;
> > +			offset += sectorsize;
> > +			pgoff += sectorsize;
> > +		}
> > +	}
> > +	return true;
> > +}
> > +
> > +static void btrfs_encoded_read_endio(struct bio *bio)
> > +{
> > +	struct btrfs_encoded_read_private *priv = bio->bi_private;
> > +	struct btrfs_io_bio *io_bio = btrfs_io_bio(bio);
> > +
> > +	if (bio->bi_status || !btrfs_encoded_read_check_csums(io_bio))
> > +		priv->uptodate = false;
> > +	if (!atomic_dec_return(&priv->pending))
> > +		wake_up(&priv->wait);
> > +	btrfs_io_bio_free_csum(io_bio);
> > +	bio_put(bio);
> > +}
> > +
> > +static bool btrfs_submit_encoded_read(struct bio *bio)
> > +{
> > +	struct btrfs_encoded_read_private *priv = bio->bi_private;
> > +	struct inode *inode = priv->inode;
> > +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> > +	blk_status_t status;
> > +
> > +	atomic_inc(&priv->pending);
> > +
> > +	if (!priv->skip_csum) {
> > +		status = btrfs_lookup_bio_sums_at_offset(inode, bio,
> > +							 btrfs_io_bio(bio)->logical,
> > +							 NULL);
> > +		if (status)
> > +			goto out;
> > +	}
> > +
> > +	status = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
> > +	if (status)
> > +		goto out;
> > +
> > +	status = btrfs_map_bio(fs_info, bio, 0, 0);
> > +out:
> > +	if (status) {
> > +		bio->bi_status = status;
> > +		bio_endio(bio);
> > +		return false;
> > +	}
> > +	return true;
> > +}
> > +
> > +static ssize_t btrfs_encoded_read_regular(struct kiocb *iocb,
> > +					  struct iov_iter *iter,
> > +					  u64 start, u64 lockend,
> > +					  struct extent_state **cached_state,
> > +					  struct block_device *bdev,
> > +					  u64 offset, u64 disk_io_size,
> > +					  size_t count,
> > +					  const struct encoded_iov *encoded,
> > +					  bool *unlocked)
> > +{
> > +	struct inode *inode = file_inode(iocb->ki_filp);
> > +	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
> > +	struct btrfs_encoded_read_private priv = {
> > +		.inode = inode,
> > +		.wait = __WAIT_QUEUE_HEAD_INITIALIZER(priv.wait),
> > +		.pending = ATOMIC_INIT(1),
> > +		.uptodate = true,
> > +		.skip_csum = BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM,
> > +	};
> > +	struct page **pages;
> > +	unsigned long nr_pages, i;
> > +	struct bio *bio = NULL;
> > +	u64 cur;
> > +	size_t page_offset;
> > +	ssize_t ret;
> > +
> > +	nr_pages = (disk_io_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
> > +	pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
> > +	if (!pages)
> > +		return -ENOMEM;
> > +	for (i = 0; i < nr_pages; i++) {
> > +		pages[i] = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
> > +		if (!pages[i]) {
> > +			ret = -ENOMEM;
> > +			goto out;
> > +		}
> > +	}
> > +
> > +	i = 0;
> > +	cur = 0;
> > +	while (cur < disk_io_size) {
> > +		size_t bytes = min_t(u64, disk_io_size - cur,
> > +				     PAGE_SIZE);
> > +
> > +		if (!bio) {
> > +			bio = btrfs_bio_alloc(offset + cur);
> > +			bio_set_dev(bio, bdev);
> > +			bio->bi_end_io = btrfs_encoded_read_endio;
> > +			bio->bi_private = &priv;
> > +			bio->bi_opf = REQ_OP_READ;
> > +			btrfs_io_bio(bio)->logical = start + cur;
> > +		}
> > +
> > +		if (bio_add_page(bio, pages[i], bytes, 0) < bytes) {
> > +			bool success;
> > +
> > +			success = btrfs_submit_encoded_read(bio);
> > +			bio = NULL;
> > +			if (!success)
> > +				break;
> > +			continue;
> > +		}
> > +		i++;
> > +		cur += bytes;
> > +	}
> > +
> > +	if (bio)
> > +		btrfs_submit_encoded_read(bio);
> > +	if (atomic_dec_return(&priv.pending))
> > +		wait_event(priv.wait, !atomic_read(&priv.pending));
> > +	if (!priv.uptodate) {
> > +		ret = -EIO;
> > +		goto out;
> > +	}
> > +
> > +	unlock_extent_cached(io_tree, start, lockend, cached_state);
> > +	inode_unlock(inode);
> > +	*unlocked = true;
> > +
> > +	if (copy_to_iter(encoded, sizeof(*encoded), iter) != sizeof(*encoded)) {
> > +		ret = -EFAULT;
> > +		goto out;
> > +	}
> > +	if (encoded->compression) {
> > +		i = 0;
> > +		page_offset = 0;
> > +	} else {
> > +		i = (iocb->ki_pos - start) >> PAGE_SHIFT;
> > +		page_offset = (iocb->ki_pos - start) & (PAGE_SIZE - 1);
> > +	}
> > +	cur = 0;
> > +	while (cur < count) {
> > +		size_t bytes = min_t(size_t, count - cur,
> > +				     PAGE_SIZE - page_offset);
> > +
> > +		if (copy_page_to_iter(pages[i], page_offset, bytes,
> > +				      iter) != bytes) {
> > +			ret = -EFAULT;
> > +			goto out;
> > +		}
> > +		i++;
> > +		cur += bytes;
> > +		page_offset = 0;
> > +	}
> > +	ret = count;
> > +out:
> > +	for (i = 0; i < nr_pages; i++) {
> > +		if (pages[i])
> > +			put_page(pages[i]);
> > +	}
> > +	kfree(pages);
> > +	return ret;
> > +}
> > +
> > +ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter)
> > +{
> > +	struct inode *inode = file_inode(iocb->ki_filp);
> > +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> > +	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
> > +	ssize_t ret;
> > +	size_t count;
> > +	struct block_device *em_bdev;
> > +	u64 start, lockend, offset, disk_io_size;
> > +	struct extent_state *cached_state = NULL;
> > +	struct extent_map *em;
> > +	struct encoded_iov encoded = {};
> > +	bool unlocked = false;
> > +
> > +	ret = check_encoded_read(iocb, iter);
> > +	if (ret < 0)
> > +		return ret;
> > +	if (ret == 0) {
> > +empty:
> > +		if (copy_to_iter(&encoded, sizeof(encoded), iter) ==
> > +		    sizeof(encoded))
> > +			return 0;
> > +		else
> > +			return -EFAULT;
> 
> nit: Just put the label at the end of the function since it's a simple
> error handler.

It's not really an error handler, it's a corner case. It doesn't seem
any nicer to have the corner case far away at the end of the function
and goto it from two places.

> > +	}
> > +	count = ret;
> > +
> > +	file_accessed(iocb->ki_filp);
> > +
> > +	inode_lock(inode);
> > +
> > +	if (iocb->ki_pos >= inode->i_size) {
> > +		inode_unlock(inode);
> > +		goto empty;
> 
> That way you won't have to jump backwards here ...
> 
> > +	}
> > +	start = ALIGN_DOWN(iocb->ki_pos, fs_info->sectorsize);
> > +	/*
> > +	 * We don't know how long the extent containing iocb->ki_pos is, but if
> > +	 * it's compressed we know that it won't be longer than this.
> > +	 */
> > +	lockend = start + BTRFS_MAX_UNCOMPRESSED - 1;
> > +
> > +	for (;;) {
> > +		struct btrfs_ordered_extent *ordered;
> > +
> > +		ret = btrfs_wait_ordered_range(inode, start,
> > +					       lockend - start + 1);
> > +		if (ret)
> > +			goto out_unlock_inode;
> > +		lock_extent_bits(io_tree, start, lockend, &cached_state);
> > +		ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), start,
> > +						     lockend - start + 1);
> > +		if (!ordered)
> > +			break;
> > +		btrfs_put_ordered_extent(ordered);
> > +		unlock_extent_cached(io_tree, start, lockend, &cached_state);
> > +		cond_resched();
> > +	}
> > +
> > +	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, start,
> > +			      lockend - start + 1, 0);
> > +	if (IS_ERR(em)) {
> > +		ret = PTR_ERR(em);
> > +		goto out_unlock_extent;
> > +	}
> > +	em_bdev = em->bdev;
> > +
> > +	if (em->block_start == EXTENT_MAP_INLINE) {
> > +		u64 extent_start = em->start;
> > +
> > +		/*
> > +		 * For inline extents we get everything we need out of the
> > +		 * extent item.
> > +		 */
> > +		free_extent_map(em);
> > +		em = NULL;
> > +		ret = btrfs_encoded_read_inline(iocb, iter, start, lockend,
> > +						&cached_state, extent_start,
> > +						count, &encoded, &unlocked);
> > +		goto out;
> > +	}
> > +
> > +	/*
> > +	 * We only want to return up to EOF even if the extent extends beyond
> > +	 * that.
> > +	 */
> > +	encoded.len = (min_t(u64, extent_map_end(em), inode->i_size) -
> > +		       iocb->ki_pos);
> > +	if (em->block_start == EXTENT_MAP_HOLE ||
> > +	    test_bit(EXTENT_FLAG_PREALLOC, &em->flags)) {
> > +		offset = EXTENT_MAP_HOLE;
> > +	} else if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags)) {
> > +		offset = em->block_start;
> > +		/*
> > +		 * Bail if the buffer isn't large enough to return the whole
> > +		 * compressed extent.
> > +		 */
> > +		if (em->block_len > count) {
> > +			ret = -EFBIG;
> > +			goto out_em;
> > +		}
> > +		disk_io_size = count = em->block_len;
> > +		encoded.unencoded_len = em->ram_bytes;
> > +		encoded.unencoded_offset = iocb->ki_pos - em->orig_start;
> > +		ret = encoded_iov_compression_from_btrfs(&encoded,
> > +							 em->compress_type);
> > +		if (ret)
> > +			goto out_em;
> > +	} else {
> > +		offset = em->block_start + (start - em->start);
> > +		if (encoded.len > count)
> > +			encoded.len = count;
> > +		/*
> > +		 * Don't read beyond what we locked. This also limits the page
> > +		 * allocations that we'll do.
> > +		 */
> > +		disk_io_size = min(lockend + 1, iocb->ki_pos + encoded.len) - start;
> > +		encoded.len = encoded.unencoded_len = count =
> > +			start + disk_io_size - iocb->ki_pos;
> > +		disk_io_size = ALIGN(disk_io_size, fs_info->sectorsize);
> > +	}
> > +	free_extent_map(em);
> > +	em = NULL;
> > +
> > +	if (offset == EXTENT_MAP_HOLE) {
> > +		unlock_extent_cached(io_tree, start, lockend, &cached_state);
> > +		inode_unlock(inode);
> > +		unlocked = true;
> > +		if (copy_to_iter(&encoded, sizeof(encoded), iter) ==
> > +		    sizeof(encoded))
> > +			ret = 0;
> > +		else
> > +			ret = -EFAULT;
> > +	} else {
> > +		ret = btrfs_encoded_read_regular(iocb, iter, start, lockend,
> > +						 &cached_state, em_bdev, offset,
> > +						 disk_io_size, count, &encoded,
> > +						 &unlocked);
> > +	}
> > +
> > +out:
> > +	if (ret >= 0)
> > +		iocb->ki_pos += encoded.len;
> > +out_em:
> > +	free_extent_map(em);
> > +out_unlock_extent:
> > +	if (!unlocked)
> > +		unlock_extent_cached(io_tree, start, lockend, &cached_state);
> > +out_unlock_inode:
> > +	if (!unlocked)
> > +		inode_unlock(inode);
> > +	return ret;
> > +}
> > +
> >  #ifdef CONFIG_SWAP
> >  /*
> >   * Add an entry indicating a block group or device which is pinned by a
> > 
