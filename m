Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 305B1B730F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 08:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387764AbfISGOG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Sep 2019 02:14:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33218 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387580AbfISGOG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Sep 2019 02:14:06 -0400
Received: by mail-pg1-f195.google.com with SMTP id n190so1276792pgn.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2019 23:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8o/BnvRK7ZaW8oip/sgNyCFDUc71eYeH2jGlPwlljwk=;
        b=nQ7wdmKLxazW3m9DdflyXAoLNsi9iyBXxukGHmgyV0Zg4EY9OjHz6P9tFPYmY/vOJi
         ka7ec7XqU40l7wFdoPvfYLmdUtTDpOLs2h7sPKQBqKN6B4C1Vf/IoVZEvP5230EtuGMq
         rksp5eCdG/hU6e9ekWECQQKkaGuJNQU/QAPD8tIXgXdTWQU3Dsi5ARKO3L8ddqtFMWYB
         2p0+g5LhXL/+MVFuKCxjkOoZ4+2bCiHqKz7D9+wo7Yo7jDCu6Yad+aAKf/1grONqkAVC
         VfPemKJ0CZxMbfSedQCqbaMSAZVpzcdoRAw/qYqvm0B/+4CkHmBUrc5xrJ11HnVVMaMM
         KPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8o/BnvRK7ZaW8oip/sgNyCFDUc71eYeH2jGlPwlljwk=;
        b=lnoxug9XFfcbUFQPjWxB5UBpBS52zRZNlknQxfxBO0YVYmX5RL8zqNAqY5gVlPMnSW
         le9Pujc5QKOVrepTDlYfzKC4yi9pipa/RveyfpmQ5mRZuidz04U2QxuJ7cW1P8jHwL28
         +J6amAcdo9O/fs3BLID9mVOWDAiIlntCYVYQ1aymAhYv9jwxLBxr9FEX6XrogiUJuNfQ
         gRJAWfIXS0uOdGfW7Fo2qB0LqKH06PdNzvmlTjjij82p6/TTMUwvPCAkBeutKVLtD0/H
         0bgGEdOW10AceRz9DW9oN1BnB9WsZfbIPoPWnk23wERlb2c0SzJUwltN+oa1ELZSAz2Q
         uTkw==
X-Gm-Message-State: APjAAAVFcbHt3WRnsI5ZoN9vqvh0Av2RcVWpD6nW+pwPk2DfzqhERPg2
        tvLCnvRhRXghbhs3w5T3Q8fqRA==
X-Google-Smtp-Source: APXvYqzxCBpsHW0iJH2PaUuxWSfgMWX++L3s8RaGnDvapbF73XvGvM1X+9MfCXqRk48xk5KSAcctuA==
X-Received: by 2002:a63:1657:: with SMTP id 23mr7441933pgw.389.1568873645025;
        Wed, 18 Sep 2019 23:14:05 -0700 (PDT)
Received: from vader ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id b5sm11796206pfp.38.2019.09.18.23.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 23:14:04 -0700 (PDT)
Date:   Wed, 18 Sep 2019 23:14:04 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: add ioctl for directly writing compressed data
Message-ID: <20190919061404.GA105652@vader>
References: <cover.1567623877.git.osandov@fb.com>
 <8eae56abb90c0fe87c350322485ce8674e135074.1567623877.git.osandov@fb.com>
 <652f5971-2c82-e766-fde4-2076e65cf948@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <652f5971-2c82-e766-fde4-2076e65cf948@suse.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 05, 2019 at 01:33:56PM +0300, Nikolay Borisov wrote:
> 
> 
> On 4.09.19 г. 22:13 ч., Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > This adds an API for writing compressed data directly to the filesystem.
> > The use case that I have in mind is send/receive: currently, when
> > sending data from one compressed filesystem to another, the sending side
> > decompresses the data and the receiving side recompresses it before
> > writing it out. This is wasteful and can be avoided if we can just send
> > and write compressed extents. The send part will be implemented in a
> > separate series, as this ioctl can stand alone.
> > 
> > The interface is essentially pwrite(2) with some extra information:
> > 
> > - The input buffer contains the compressed data.
> > - Both the compressed and decompressed sizes of the data are given.
> > - The compression type (zlib, lzo, or zstd) is given.
> > 
> > The interface is general enough that it can be extended to encrypted or
> > otherwise encoded extents in the future. A more detailed description,
> > including restrictions and edge cases, is included in
> > include/uapi/linux/btrfs.h.
> > 
> > The implementation is similar to direct I/O: we have to flush any
> > ordered extents, invalidate the page cache, and do the io
> > tree/delalloc/extent map/ordered extent dance. From there, we can reuse
> > the compression code with a minor modification to distinguish the new
> > ioctl from writeback.
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> 
> 
> Should we choose to continue with this interface (based on Dave's
> feedback) I'd rather see the following things changed:
> 
> > ---
> >  fs/btrfs/compression.c     |   6 +-
> >  fs/btrfs/compression.h     |  14 +--
> >  fs/btrfs/ctree.h           |   6 ++
> >  fs/btrfs/file.c            |  13 ++-
> >  fs/btrfs/inode.c           | 192 ++++++++++++++++++++++++++++++++++++-
> >  fs/btrfs/ioctl.c           |  95 ++++++++++++++++++
> >  include/uapi/linux/btrfs.h |  69 +++++++++++++
> >  7 files changed, 380 insertions(+), 15 deletions(-)
> > 
> > diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> > index b05b361e2062..6632dd8d2e4d 100644
> > --- a/fs/btrfs/compression.c
> > +++ b/fs/btrfs/compression.c
> > @@ -276,7 +276,8 @@ static void end_compressed_bio_write(struct bio *bio)
> >  			bio->bi_status == BLK_STS_OK);
> >  	cb->compressed_pages[0]->mapping = NULL;
> >  
> > -	end_compressed_writeback(inode, cb);
> > +	if (cb->writeback)
> > +		end_compressed_writeback(inode, cb);
> >  	/* note, our inode could be gone now */
> >  
> >  	/*
> > @@ -311,7 +312,7 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
> >  				 unsigned long compressed_len,
> >  				 struct page **compressed_pages,
> >  				 unsigned long nr_pages,
> > -				 unsigned int write_flags)
> > +				 unsigned int write_flags, bool writeback)
> >  {
> >  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> >  	struct bio *bio = NULL;
> > @@ -336,6 +337,7 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
> >  	cb->mirror_num = 0;
> >  	cb->compressed_pages = compressed_pages;
> >  	cb->compressed_len = compressed_len;
> > +	cb->writeback = writeback;
> >  	cb->orig_bio = NULL;
> >  	cb->nr_pages = nr_pages;
> >  
> > diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
> > index 4cb8be9ff88b..5b48eb730362 100644
> > --- a/fs/btrfs/compression.h
> > +++ b/fs/btrfs/compression.h
> > @@ -6,6 +6,7 @@
> >  #ifndef BTRFS_COMPRESSION_H
> >  #define BTRFS_COMPRESSION_H
> >  
> > +#include <linux/btrfs.h>
> >  #include <linux/sizes.h>
> >  
> >  /*
> > @@ -47,6 +48,9 @@ struct compressed_bio {
> >  	/* the compression algorithm for this bio */
> >  	int compress_type;
> >  
> > +	/* Whether this is a write for writeback. */
> > +	bool writeback;
> > +
> >  	/* number of compressed pages in the array */
> >  	unsigned long nr_pages;
> >  
> > @@ -93,20 +97,12 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
> >  				  unsigned long compressed_len,
> >  				  struct page **compressed_pages,
> >  				  unsigned long nr_pages,
> > -				  unsigned int write_flags);
> > +				  unsigned int write_flags, bool writeback);
> >  blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
> >  				 int mirror_num, unsigned long bio_flags);
> >  
> >  unsigned int btrfs_compress_str2level(unsigned int type, const char *str);
> >  
> > -enum btrfs_compression_type {
> > -	BTRFS_COMPRESS_NONE  = 0,
> > -	BTRFS_COMPRESS_ZLIB  = 1,
> > -	BTRFS_COMPRESS_LZO   = 2,
> > -	BTRFS_COMPRESS_ZSTD  = 3,
> > -	BTRFS_COMPRESS_TYPES = 3,
> > -};
> > -
> >  struct workspace_manager {
> >  	const struct btrfs_compress_op *ops;
> >  	struct list_head idle_ws;
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index 19d669d12ca1..9fae9b3f1f62 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -2905,6 +2905,10 @@ int btrfs_run_delalloc_range(struct inode *inode, struct page *locked_page,
> >  int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end);
> >  void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
> >  					  u64 end, int uptodate);
> > +
> > +ssize_t btrfs_raw_write(struct kiocb *iocb, struct iov_iter *from,
> > +			struct btrfs_ioctl_raw_pwrite_args *raw);
> > +
> >  extern const struct dentry_operations btrfs_dentry_operations;
> >  
> >  /* ioctl.c */
> > @@ -2928,6 +2932,8 @@ int btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
> >  			   struct btrfs_inode *inode);
> >  int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info);
> >  void btrfs_cleanup_defrag_inodes(struct btrfs_fs_info *fs_info);
> > +ssize_t btrfs_do_write_iter(struct kiocb *iocb, struct iov_iter *from,
> > +			    struct btrfs_ioctl_raw_pwrite_args *args);
> >  int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync);
> >  void btrfs_drop_extent_cache(struct btrfs_inode *inode, u64 start, u64 end,
> >  			     int skip_pinned);
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index 8fe4eb7e5045..ed23aa65b2d5 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -1872,8 +1872,8 @@ static void update_time_for_write(struct inode *inode)
> >  		inode_inc_iversion(inode);
> >  }
> >  
> > -static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
> > -				    struct iov_iter *from)
> > +ssize_t btrfs_do_write_iter(struct kiocb *iocb, struct iov_iter *from,
> > +			    struct btrfs_ioctl_raw_pwrite_args *raw)
> >  {
> >  	struct file *file = iocb->ki_filp;
> >  	struct inode *inode = file_inode(file);
> > @@ -1965,7 +1965,9 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
> >  	if (sync)
> >  		atomic_inc(&BTRFS_I(inode)->sync_writers);
> >  
> > -	if (iocb->ki_flags & IOCB_DIRECT) {
> > +	if (raw) {
> > +		num_written = btrfs_raw_write(iocb, from, raw);
> > +	} else if (iocb->ki_flags & IOCB_DIRECT) {
> >  		num_written = __btrfs_direct_write(iocb, from);
> >  	} else {
> >  		num_written = btrfs_buffered_write(iocb, from);
> > @@ -1996,6 +1998,11 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
> >  	return num_written ? num_written : err;
> >  }
> >  
> > +static ssize_t btrfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
> > +{
> > +	return btrfs_do_write_iter(iocb, from, NULL);
> > +}
> > +
> >  int btrfs_release_file(struct inode *inode, struct file *filp)
> >  {
> >  	struct btrfs_file_private *private = filp->private_data;
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index a0546401bc0a..c8eaa1e5bf06 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -865,7 +865,7 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
> >  				    ins.objectid,
> >  				    ins.offset, async_extent->pages,
> >  				    async_extent->nr_pages,
> > -				    async_chunk->write_flags)) {
> > +				    async_chunk->write_flags, true)) {
> >  			struct page *p = async_extent->pages[0];
> >  			const u64 start = async_extent->start;
> >  			const u64 end = start + async_extent->ram_size - 1;
> > @@ -10590,6 +10590,196 @@ void btrfs_set_range_writeback(struct extent_io_tree *tree, u64 start, u64 end)
> >  	}
> >  }
> >  
> > +/* Currently, this only supports raw writes of compressed data. */
> > +ssize_t btrfs_raw_write(struct kiocb *iocb, struct iov_iter *from,
> > +			struct btrfs_ioctl_raw_pwrite_args *raw)
> > +{
> > +	struct file *file = iocb->ki_filp;
> > +	struct inode *inode = file_inode(file);
> > +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> > +	struct btrfs_root *root = BTRFS_I(inode)->root;
> > +	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
> > +	struct extent_changeset *data_reserved = NULL;
> > +	struct extent_state *cached_state = NULL;
> > +	unsigned long nr_pages, i;
> > +	struct page **pages;
> > +	u64 disk_num_bytes, num_bytes;
> > +	u64 start, end;
> > +	struct btrfs_key ins;
> > +	struct extent_map *em;
> > +	ssize_t ret;
> > +
> > +	if (iov_iter_count(from) != raw->num_bytes) {
> > +		/*
> > +		 * The write got truncated by generic_write_checks(). We can't
> > +		 * do a partial raw write.
> > +		 */
> > +		return -EFBIG;
> > +	}
> > +
> > +	/* This should be handled higher up. */
> > +	ASSERT(raw->num_bytes != 0);
> 
> This is already checked, indirectly via rw_verify_area, there's :
> 
>  if (unlikely((ssize_t) count < 0))
>                   return retval;
> 
> So you can remove this assert.

These are different checks. The assert is checking that we didn't get
here with a count of zero, whereas rw_verify_area() checks that the
count doesn't overflow a ssize_t. I removed the assert regardless.

> > +	/* The extent size must be sane. */
> > +	if (raw->num_bytes > BTRFS_MAX_UNCOMPRESSED ||
> > +	    raw->disk_num_bytes > BTRFS_MAX_COMPRESSED ||
> > +	    raw->disk_num_bytes == 0)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * The compressed data on disk must be sector-aligned. For convenience,
> > +	 * we extend the compressed data with zeroes if it isn't.
> > +	 */
> > +	disk_num_bytes = ALIGN(raw->disk_num_bytes, fs_info->sectorsize);
> > +	/*
> > +	 * The extent in the file must also be sector-aligned. However, we allow
> > +	 * a write which ends at or extends i_size to have an unaligned length;
> > +	 * we round up the extent size and set i_size to the given length.
> > +	 */
> > +	start = iocb->ki_pos;
> > +	if ((start & (fs_info->sectorsize - 1)))
> 
> if (!IS_ALIGNED(start, fs_info->sectorsize))

Fixed, thanks.

> > +		return -EINVAL;
> > +	if (start + raw->num_bytes >= inode->i_size) {
> > +		num_bytes = ALIGN(raw->num_bytes, fs_info->sectorsize);
> > +	} else {
> > +		num_bytes = raw->num_bytes;
> > +		if ((num_bytes & (fs_info->sectorsize - 1)))
> 
> ditto

Fixed.

> > +			return -EINVAL;
> > +	}
> > +	end = start + num_bytes - 1;
> > +
> > +	/*
> > +	 * It's valid for compressed data to be larger than or the same size as
> > +	 * the decompressed data. However, for buffered I/O, we never write out
> > +	 * a compressed extent unless it's smaller than the decompressed data,
> > +	 * so for now, let's not allow creating such extents with the ioctl,
> > +	 * either.
> > +	 */
> > +	if (disk_num_bytes >= num_bytes)
> > +		return -EINVAL;
> > +
> > +	nr_pages = DIV_ROUND_UP(disk_num_bytes, PAGE_SIZE);
> > +	pages = kcalloc(nr_pages, sizeof(struct page *),
> > +			GFP_USER | __GFP_NOWARN);
> > +	if (!pages)
> > +		return -ENOMEM;
> > +	for (i = 0; i < nr_pages; i++) {
> > +		unsigned long offset = i << PAGE_SHIFT, n;
> > +		char *kaddr;
> > +
> > +		pages[i] = alloc_page(GFP_USER | __GFP_NOWARN);
> > +		if (!pages[i]) {
> > +			ret = -ENOMEM;
> > +			goto out_pages;
> > +		}
> > +		kaddr = kmap(pages[i]);
> > +		if (offset < raw->disk_num_bytes) {
> > +			n = min_t(unsigned long, PAGE_SIZE,
> > +				  raw->disk_num_bytes - offset);
> > +			if (copy_from_user(kaddr, raw->buf + offset, n)) {
> > +				kunmap(pages[i]);
> > +				ret = -EFAULT;
> > +				goto out_pages;
> > +			}
> > +		} else {
> > +			n = 0;
> > +		}
> > +		if (n < PAGE_SIZE)
> > +			memset(kaddr + n, 0, PAGE_SIZE - n);
> > +		kunmap(pages[i]);
> > +	}
> > +
> > +	for (;;) {
> > +		struct btrfs_ordered_extent *ordered;
> > +
> > +		lock_extent_bits(io_tree, start, end, &cached_state);
> > +		ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), start,
> > +						     end - start + 1);
> > +		if (!ordered &&
> > +		    !filemap_range_has_page(inode->i_mapping, start, end))
> > +			break;
> > +		if (ordered)
> > +			btrfs_put_ordered_extent(ordered);
> > +		unlock_extent_cached(&BTRFS_I(inode)->io_tree, start, end,
> > +				     &cached_state);
> > +		cond_resched();
> > +		ret = btrfs_wait_ordered_range(inode, start, end);
> > +		if (ret)
> > +			goto out_pages;
> > +		ret = invalidate_inode_pages2_range(inode->i_mapping,
> > +						    start >> PAGE_SHIFT,
> > +						    end >> PAGE_SHIFT);
> > +		if (ret)
> > +			goto out_pages;
> > +	}
> 
> Won't btrfs_lock_and_flush_ordered_range suffice here? Perhaps call that
> function + invalidate_inode_pages2_range ?

No, btrfs_lock_and_flush_ordered_range() doesn't write out dirty pages,
so it's not sufficient here.

Thanks for the review!
