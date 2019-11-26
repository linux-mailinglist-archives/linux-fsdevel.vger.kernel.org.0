Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23C54109DA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 13:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbfKZMNa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 07:13:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:35378 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727650AbfKZMNa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 07:13:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C4E35ADDD;
        Tue, 26 Nov 2019 12:13:26 +0000 (UTC)
Subject: Re: [PATCH 3/5] btrfs: Switch to iomap_dio_rw() for dio
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, hch@infradead.org,
        darrick.wong@oracle.com, fdmanana@kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20191126031456.12150-1-rgoldwyn@suse.de>
 <20191126031456.12150-4-rgoldwyn@suse.de>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b49d3208-3652-53ba-f3c3-f62e4c92c023@suse.com>
Date:   Tue, 26 Nov 2019 14:13:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191126031456.12150-4-rgoldwyn@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 26.11.19 г. 5:14 ч., Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Switch from __blockdev_direct_IO() to iomap_dio_rw().
> Rename btrfs_get_blocks_direct() to btrfs_dio_iomap_begin() and use it
> as iomap_begin() for iomap direct I/O functions. This function
> allocates and locks all the blocks required for the I/O.
> btrfs_submit_direct() is used as the submit_io() hook for direct I/O
> ops.
> 
> Since we need direct I/O reads to go through iomap_dio_rw(), we change
> file_operations.read_iter() to a btrfs_file_read_iter() which calls
> btrfs_direct_IO() for direct reads and falls back to
> generic_file_buffered_read() for incomplete reads and buffered reads.
> 
> We don't need address_space.direct_IO() anymore so set it to noop.
> Similarly, we don't need flags used in __blockdev_direct_IO(). iomap is
> capable of direct I/O reads from a hole, so we don't need to return
> -ENOENT.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/ctree.h |   2 +
>  fs/btrfs/file.c  |  15 ++++-
>  fs/btrfs/inode.c | 171 ++++++++++++++++++++++++++-----------------------------
>  3 files changed, 97 insertions(+), 91 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index fe2b8765d9e6..6f038ba34512 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -2903,6 +2903,8 @@ int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end);
>  void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
>  					  u64 end, int uptodate);
>  extern const struct dentry_operations btrfs_dentry_operations;
> +ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter);
> +ssize_t btrfs_dio_write(struct kiocb *iocb, struct iov_iter *iter);
>  
>  /* ioctl.c */
>  long btrfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 435a502a3226..960a0767f532 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1834,7 +1834,7 @@ static ssize_t __btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
>  	loff_t endbyte;
>  	int err;
>  
> -	written = generic_file_direct_write(iocb, from);
> +	written = btrfs_dio_write(iocb, from);
>  
>  	if (written < 0 || !iov_iter_count(from))
>  		return written;
> @@ -3452,9 +3452,20 @@ static int btrfs_file_open(struct inode *inode, struct file *filp)
>  	return generic_file_open(inode, filp);
>  }
>  
> +static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
> +{
> +	ssize_t ret = 0;
> +	if (iocb->ki_flags & IOCB_DIRECT)
> +		ret = btrfs_dio_read(iocb, to);
> +	if (ret < 0)
> +		return ret;
> +
> +	return generic_file_buffered_read(iocb, to, ret);
> +}
> +
>  const struct file_operations btrfs_file_operations = {
>  	.llseek		= btrfs_file_llseek,
> -	.read_iter      = generic_file_read_iter,
> +	.read_iter      = btrfs_file_read_iter,
>  	.splice_read	= generic_file_splice_read,
>  	.write_iter	= btrfs_file_write_iter,
>  	.mmap		= btrfs_file_mmap,
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 015910079e73..9a39a53b9068 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -29,6 +29,7 @@
>  #include <linux/iversion.h>
>  #include <linux/swap.h>
>  #include <linux/sched/mm.h>
> +#include <linux/iomap.h>
>  #include <asm/unaligned.h>
>  #include "misc.h"
>  #include "ctree.h"
> @@ -7619,28 +7620,7 @@ static struct extent_map *create_io_em(struct inode *inode, u64 start, u64 len,
>  }
>  
>  
> -static int btrfs_get_blocks_direct_read(struct extent_map *em,
> -					struct buffer_head *bh_result,
> -					struct inode *inode,
> -					u64 start, u64 len)
> -{
> -	if (em->block_start == EXTENT_MAP_HOLE ||
> -			test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
> -		return -ENOENT;
> -
> -	len = min(len, em->len - (start - em->start));
> -
> -	bh_result->b_blocknr = (em->block_start + (start - em->start)) >>
> -		inode->i_blkbits;
> -	bh_result->b_size = len;
> -	bh_result->b_bdev = em->bdev;
> -	set_buffer_mapped(bh_result);
> -
> -	return 0;
> -}
> -
>  static int btrfs_get_blocks_direct_write(struct extent_map **map,
> -					 struct buffer_head *bh_result,
>  					 struct inode *inode,
>  					 struct btrfs_dio_data *dio_data,
>  					 u64 start, u64 len)
> @@ -7702,7 +7682,6 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
>  	}
>  
>  	/* this will cow the extent */
> -	len = bh_result->b_size;
>  	free_extent_map(em);
>  	*map = em = btrfs_new_extent_direct(inode, start, len);
>  	if (IS_ERR(em)) {
> @@ -7713,15 +7692,6 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
>  	len = min(len, em->len - (start - em->start));
>  
>  skip_cow:
> -	bh_result->b_blocknr = (em->block_start + (start - em->start)) >>
> -		inode->i_blkbits;
> -	bh_result->b_size = len;
> -	bh_result->b_bdev = em->bdev;
> -	set_buffer_mapped(bh_result);
> -
> -	if (!test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
> -		set_buffer_new(bh_result);
> -
>  	/*
>  	 * Need to update the i_size under the extent lock so buffered
>  	 * readers will get the updated i_size when we unlock.
> @@ -7737,17 +7707,19 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
>  	return ret;
>  }
>  
> -static int btrfs_get_blocks_direct(struct inode *inode, sector_t iblock,
> -				   struct buffer_head *bh_result, int create)
> +static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
> +		loff_t length, unsigned flags, struct iomap *iomap,
> +		struct iomap *srcmap)
>  {
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	struct extent_map *em;
>  	struct extent_state *cached_state = NULL;
>  	struct btrfs_dio_data *dio_data = NULL;
> -	u64 start = iblock << inode->i_blkbits;
>  	u64 lockstart, lockend;
> -	u64 len = bh_result->b_size;
> +	int create = flags & IOMAP_WRITE;
>  	int ret = 0;
> +	u64 len = length;
> +	bool unlock_extents = false;
>  
>  	if (!create)
>  		len = min_t(u64, len, fs_info->sectorsize);
> @@ -7755,6 +7727,17 @@ static int btrfs_get_blocks_direct(struct inode *inode, sector_t iblock,
>  	lockstart = start;
>  	lockend = start + len - 1;
>  
> +	/*
> +	 * The generic stuff only does filemap_write_and_wait_range, which
> +	 * isn't enough if we've written compressed pages to this area, so
> +	 * we need to flush the dirty pages again to make absolutely sure
> +	 * that any outstanding dirty pages are on disk.
> +	 */
> +	if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
> +		     &BTRFS_I(inode)->runtime_flags))
> +		ret = filemap_fdatawrite_range(inode->i_mapping, start,
> +					 start + length - 1);
> +
>  	if (current->journal_info) {
>  		/*
>  		 * Need to pull our outstanding extents and set journal_info to NULL so
> @@ -7803,35 +7786,45 @@ static int btrfs_get_blocks_direct(struct inode *inode, sector_t iblock,
>  	}
>  
>  	if (create) {
> -		ret = btrfs_get_blocks_direct_write(&em, bh_result, inode,
> +		ret = btrfs_get_blocks_direct_write(&em, inode,
>  						    dio_data, start, len);
>  		if (ret < 0)
>  			goto unlock_err;
> -
> -		unlock_extent_cached(&BTRFS_I(inode)->io_tree, lockstart,
> -				     lockend, &cached_state);
> +		unlock_extents = true;
> +	} else if (em->block_start == EXTENT_MAP_HOLE ||
> +			test_bit(EXTENT_FLAG_PREALLOC, &em->flags)) {
> +		/* Unlock in case of direct reading from a hole */
> +		unlock_extents = true;
>  	} else {
> -		ret = btrfs_get_blocks_direct_read(em, bh_result, inode,
> -						   start, len);
> -		/* Can be negative only if we read from a hole */
> -		if (ret < 0) {
> -			ret = 0;
> -			free_extent_map(em);
> -			goto unlock_err;
> -		}
> +
> +		len = min(len, em->len - (start - em->start));
>  		/*
>  		 * We need to unlock only the end area that we aren't using.
>  		 * The rest is going to be unlocked by the endio routine.
>  		 */
> -		lockstart = start + bh_result->b_size;
> -		if (lockstart < lockend) {
> -			unlock_extent_cached(&BTRFS_I(inode)->io_tree,
> -					     lockstart, lockend, &cached_state);
> -		} else {
> +		lockstart = start + len;
> +		if (lockstart < lockend)
> +			unlock_extents = true;
> +		else
>  			free_extent_state(cached_state);
> -		}
>  	}
>  
> +	if (unlock_extents)
> +		unlock_extent_cached(&BTRFS_I(inode)->io_tree,
> +				lockstart, lockend, &cached_state);
> +
> +	if ((em->block_start == EXTENT_MAP_HOLE) ||
> +	    (test_bit(EXTENT_FLAG_PREALLOC, &em->flags) && !create)) {
> +		iomap->addr = IOMAP_NULL_ADDR;
> +		iomap->type = IOMAP_HOLE;
> +	} else {
> +		iomap->addr = em->block_start;
> +		iomap->type = IOMAP_MAPPED;
> +	}
> +	iomap->offset = em->start;
> +	iomap->bdev = em->bdev;
> +	iomap->length = em->len;
> +

So here you always return a full extent worth of data, why not trimming
it to the requested range? I think this is still correct because the
generic iomap infrastructure will only process the requested range, at
least as far as iomap->length is concerned. But I'm not so sure about
iomap->offset though.
