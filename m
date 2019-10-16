Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E746D8EFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 13:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404868AbfJPLKR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 07:10:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:49482 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730377AbfJPLKR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:10:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BAE63B29A;
        Wed, 16 Oct 2019 11:10:12 +0000 (UTC)
Subject: Re: [RFC PATCH v2 4/5] btrfs: implement RWF_ENCODED reads
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     kernel-team@fb.com, Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>, linux-api@vger.kernel.org
References: <cover.1571164762.git.osandov@fb.com>
 <338d3b28dd31249053620b83e6ff190ad965fadc.1571164762.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 mQINBFiKBz4BEADNHZmqwhuN6EAzXj9SpPpH/nSSP8YgfwoOqwrP+JR4pIqRK0AWWeWCSwmZ
 T7g+RbfPFlmQp+EwFWOtABXlKC54zgSf+uulGwx5JAUFVUIRBmnHOYi/lUiE0yhpnb1KCA7f
 u/W+DkwGerXqhhe9TvQoGwgCKNfzFPZoM+gZrm+kWv03QLUCr210n4cwaCPJ0Nr9Z3c582xc
 bCUVbsjt7BN0CFa2BByulrx5xD9sDAYIqfLCcZetAqsTRGxM7LD0kh5WlKzOeAXj5r8DOrU2
 GdZS33uKZI/kZJZVytSmZpswDsKhnGzRN1BANGP8sC+WD4eRXajOmNh2HL4P+meO1TlM3GLl
 EQd2shHFY0qjEo7wxKZI1RyZZ5AgJnSmehrPCyuIyVY210CbMaIKHUIsTqRgY5GaNME24w7h
 TyyVCy2qAM8fLJ4Vw5bycM/u5xfWm7gyTb9V1TkZ3o1MTrEsrcqFiRrBY94Rs0oQkZvunqia
 c+NprYSaOG1Cta14o94eMH271Kka/reEwSZkC7T+o9hZ4zi2CcLcY0DXj0qdId7vUKSJjEep
 c++s8ncFekh1MPhkOgNj8pk17OAESanmDwksmzh1j12lgA5lTFPrJeRNu6/isC2zyZhTwMWs
 k3LkcTa8ZXxh0RfWAqgx/ogKPk4ZxOXQEZetkEyTFghbRH2BIwARAQABtCNOaWtvbGF5IEJv
 cmlzb3YgPG5ib3Jpc292QHN1c2UuY29tPokCOAQTAQIAIgUCWIo48QIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AACgkQcb6CRuU/KFc0eg/9GLD3wTQz9iZHMFbjiqTCitD7B6dTLV1C
 ddZVlC8Hm/TophPts1bWZORAmYIihHHI1EIF19+bfIr46pvfTu0yFrJDLOADMDH+Ufzsfy2v
 HSqqWV/nOSWGXzh8bgg/ncLwrIdEwBQBN9SDS6aqsglagvwFD91UCg/TshLlRxD5BOnuzfzI
 Leyx2c6YmH7Oa1R4MX9Jo79SaKwdHt2yRN3SochVtxCyafDlZsE/efp21pMiaK1HoCOZTBp5
 VzrIP85GATh18pN7YR9CuPxxN0V6IzT7IlhS4Jgj0NXh6vi1DlmKspr+FOevu4RVXqqcNTSS
 E2rycB2v6cttH21UUdu/0FtMBKh+rv8+yD49FxMYnTi1jwVzr208vDdRU2v7Ij/TxYt/v4O8
 V+jNRKy5Fevca/1xroQBICXsNoFLr10X5IjmhAhqIH8Atpz/89ItS3+HWuE4BHB6RRLM0gy8
 T7rN6ja+KegOGikp/VTwBlszhvfLhyoyjXI44Tf3oLSFM+8+qG3B7MNBHOt60CQlMkq0fGXd
 mm4xENl/SSeHsiomdveeq7cNGpHi6i6ntZK33XJLwvyf00PD7tip/GUj0Dic/ZUsoPSTF/mG
 EpuQiUZs8X2xjK/AS/l3wa4Kz2tlcOKSKpIpna7V1+CMNkNzaCOlbv7QwprAerKYywPCoOSC
 7P25Ag0EWIoHPgEQAMiUqvRBZNvPvki34O/dcTodvLSyOmK/MMBDrzN8Cnk302XfnGlW/YAQ
 csMWISKKSpStc6tmD+2Y0z9WjyRqFr3EGfH1RXSv9Z1vmfPzU42jsdZn667UxrRcVQXUgoKg
 QYx055Q2FdUeaZSaivoIBD9WtJq/66UPXRRr4H/+Y5FaUZx+gWNGmBT6a0S/GQnHb9g3nonD
 jmDKGw+YO4P6aEMxyy3k9PstaoiyBXnzQASzdOi39BgWQuZfIQjN0aW+Dm8kOAfT5i/yk59h
 VV6v3NLHBjHVw9kHli3jwvsizIX9X2W8tb1SefaVxqvqO1132AO8V9CbE1DcVT8fzICvGi42
 FoV/k0QOGwq+LmLf0t04Q0csEl+h69ZcqeBSQcIMm/Ir+NorfCr6HjrB6lW7giBkQl6hhomn
 l1mtDP6MTdbyYzEiBFcwQD4terc7S/8ELRRybWQHQp7sxQM/Lnuhs77MgY/e6c5AVWnMKd/z
 MKm4ru7A8+8gdHeydrRQSWDaVbfy3Hup0Ia76J9FaolnjB8YLUOJPdhI2vbvNCQ2ipxw3Y3c
 KhVIpGYqwdvFIiz0Fej7wnJICIrpJs/+XLQHyqcmERn3s/iWwBpeogrx2Lf8AGezqnv9woq7
 OSoWlwXDJiUdaqPEB/HmGfqoRRN20jx+OOvuaBMPAPb+aKJyle8zABEBAAGJAh8EGAECAAkF
 AliKBz4CGwwACgkQcb6CRuU/KFdacg/+M3V3Ti9JYZEiIyVhqs+yHb6NMI1R0kkAmzsGQ1jU
 zSQUz9AVMR6T7v2fIETTT/f5Oout0+Hi9cY8uLpk8CWno9V9eR/B7Ifs2pAA8lh2nW43FFwp
 IDiSuDbH6oTLmiGCB206IvSuaQCp1fed8U6yuqGFcnf0ZpJm/sILG2ECdFK9RYnMIaeqlNQm
 iZicBY2lmlYFBEaMXHoy+K7nbOuizPWdUKoKHq+tmZ3iA+qL5s6Qlm4trH28/fPpFuOmgP8P
 K+7LpYLNSl1oQUr+WlqilPAuLcCo5Vdl7M7VFLMq4xxY/dY99aZx0ZJQYFx0w/6UkbDdFLzN
 upT7NIN68lZRucImffiWyN7CjH23X3Tni8bS9ubo7OON68NbPz1YIaYaHmnVQCjDyDXkQoKC
 R82Vf9mf5slj0Vlpf+/Wpsv/TH8X32ajva37oEQTkWNMsDxyw3aPSps6MaMafcN7k60y2Wk/
 TCiLsRHFfMHFY6/lq/c0ZdOsGjgpIK0G0z6et9YU6MaPuKwNY4kBdjPNBwHreucrQVUdqRRm
 RcxmGC6ohvpqVGfhT48ZPZKZEWM+tZky0mO7bhZYxMXyVjBn4EoNTsXy1et9Y1dU3HVJ8fod
 5UqrNrzIQFbdeM0/JqSLrtlTcXKJ7cYFa9ZM2AP7UIN9n1UWxq+OPY9YMOewVfYtL8M=
Message-ID: <0c0c3307-de6c-5df9-bbe1-5079cfc70480@suse.com>
Date:   Wed, 16 Oct 2019 14:10:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <338d3b28dd31249053620b83e6ff190ad965fadc.1571164762.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 15.10.19 г. 21:42 ч., Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> There are 4 main cases:
> 
> 1. Inline extents: we copy the data straight out of the extent buffer.
> 2. Hole/preallocated extents: we indicate the size of the extent
>    starting from the read position; we don't need to copy zeroes.
> 3. Regular, uncompressed extents: we read the sectors we need directly
>    from disk.
> 4. Regular, compressed extents: we read the entire compressed extent
>    from disk and indicate what subset of the decompressed extent is in
>    the file.
> 
> This initial implementation simplifies a few things that can be improved
> in the future:
> 
> - We hold the inode lock during the operation.
> - Cases 1, 3, and 4 allocate temporary memory to read into before
>   copying out to userspace.
> - Cases 3 and 4 do not implement repair yet.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  fs/btrfs/ctree.h |   2 +
>  fs/btrfs/file.c  |  12 +-
>  fs/btrfs/inode.c | 462 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 475 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 71552b2ca340..3b2aa1c7218c 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -2906,6 +2906,8 @@ int btrfs_run_delalloc_range(struct inode *inode, struct page *locked_page,
>  int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end);
>  void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
>  					  u64 end, int uptodate);
> +ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter);
> +
>  extern const struct dentry_operations btrfs_dentry_operations;
>  
>  /* ioctl.c */
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 27e5b269e729..51740cee39fc 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -390,6 +390,16 @@ int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info)
>  	return 0;
>  }
>  
> +static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
> +{
> +	if (iocb->ki_flags & IOCB_ENCODED) {
> +		if (iocb->ki_flags & IOCB_NOWAIT)
> +			return -EOPNOTSUPP;
> +		return btrfs_encoded_read(iocb, iter);
> +	}
> +	return generic_file_read_iter(iocb, iter);
> +}
> +
>  /* simple helper to fault in pages and copy.  This should go away
>   * and be replaced with calls into generic code.
>   */
> @@ -3457,7 +3467,7 @@ static int btrfs_file_open(struct inode *inode, struct file *filp)
>  
>  const struct file_operations btrfs_file_operations = {
>  	.llseek		= btrfs_file_llseek,
> -	.read_iter      = generic_file_read_iter,
> +	.read_iter      = btrfs_file_read_iter,
>  	.splice_read	= generic_file_splice_read,
>  	.write_iter	= btrfs_file_write_iter,
>  	.mmap		= btrfs_file_mmap,
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 8bce46122ef7..174d0738d2c9 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -10593,6 +10593,468 @@ void btrfs_set_range_writeback(struct extent_io_tree *tree, u64 start, u64 end)
>  	}
>  }
>  
> +static int encoded_iov_compression_from_btrfs(struct encoded_iov *encoded,
> +					      unsigned int compress_type)
> +{
> +	switch (compress_type) {
> +	case BTRFS_COMPRESS_NONE:
> +		encoded->compression = ENCODED_IOV_COMPRESSION_NONE;
> +		break;
> +	case BTRFS_COMPRESS_ZLIB:
> +		encoded->compression = ENCODED_IOV_COMPRESSION_ZLIB;
> +		break;
> +	case BTRFS_COMPRESS_LZO:
> +		encoded->compression = ENCODED_IOV_COMPRESSION_LZO;
> +		break;
> +	case BTRFS_COMPRESS_ZSTD:
> +		encoded->compression = ENCODED_IOV_COMPRESSION_ZSTD;
> +		break;
> +	default:
> +		return -EIO;
> +	}
> +	return 0;
> +}
> +
> +static ssize_t btrfs_encoded_read_inline(struct kiocb *iocb,
> +					 struct iov_iter *iter, u64 start,
> +					 u64 lockend,
> +					 struct extent_state **cached_state,
> +					 u64 extent_start, size_t count,
> +					 struct encoded_iov *encoded,
> +					 bool *unlocked)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
> +	struct btrfs_path *path;
> +	struct extent_buffer *leaf;
> +	struct btrfs_file_extent_item *item;
> +	u64 ram_bytes;
> +	unsigned long ptr;
> +	void *tmp;
> +	ssize_t ret;
> +
> +	path = btrfs_alloc_path();
> +	if (!path) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	ret = btrfs_lookup_file_extent(NULL, BTRFS_I(inode)->root, path,
> +				       btrfs_ino(BTRFS_I(inode)), extent_start,
> +				       0);
> +	if (ret) {
> +		if (ret > 0) {
> +			/* The extent item disappeared? */
> +			ret = -EIO;
> +		}
> +		goto out;
> +	}
> +	leaf = path->nodes[0];
> +	item = btrfs_item_ptr(leaf, path->slots[0],
> +			      struct btrfs_file_extent_item);
> +
> +	ram_bytes = btrfs_file_extent_ram_bytes(leaf, item);
> +	ptr = btrfs_file_extent_inline_start(item);
> +
> +	encoded->len = (min_t(u64, extent_start + ram_bytes, inode->i_size) -
> +			iocb->ki_pos);
> +	ret = encoded_iov_compression_from_btrfs(encoded,
> +				 btrfs_file_extent_compression(leaf, item));
> +	if (ret)
> +		goto out;
> +	if (encoded->compression) {
> +		size_t inline_size;
> +
> +		inline_size = btrfs_file_extent_inline_item_len(leaf,
> +						btrfs_item_nr(path->slots[0]));
> +		if (inline_size > count) {
> +			ret = -EFBIG;
> +			goto out;
> +		}
> +		count = inline_size;
> +		encoded->unencoded_len = ram_bytes;
> +		encoded->unencoded_offset = iocb->ki_pos - extent_start;
> +	} else {
> +		encoded->len = encoded->unencoded_len = count =
> +			min_t(u64, count, encoded->len);
> +		ptr += iocb->ki_pos - extent_start;
> +	}
> +
> +	tmp = kmalloc(count, GFP_NOFS);
> +	if (!tmp) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	read_extent_buffer(leaf, tmp, ptr, count);
> +	btrfs_free_path(path);
> +	path = NULL;
> +	unlock_extent_cached(io_tree, start, lockend, cached_state);
> +	inode_unlock(inode);
> +	*unlocked = true;
> +	if (copy_to_iter(encoded, sizeof(*encoded), iter) == sizeof(*encoded) &&
> +	    copy_to_iter(tmp, count, iter) == count)
> +		ret = count;
> +	else
> +		ret = -EFAULT;
> +	kfree(tmp);
> +
> +out:
> +	btrfs_free_path(path);
> +	return ret;
> +}
> +
> +struct btrfs_encoded_read_private {
> +	struct inode *inode;
> +	wait_queue_head_t wait;
> +	atomic_t pending;
> +	bool uptodate;
> +	bool skip_csum;
> +};
> +
> +static bool btrfs_encoded_read_check_csums(struct btrfs_io_bio *io_bio)
> +{
> +	struct btrfs_encoded_read_private *priv = io_bio->bio.bi_private;
> +	struct inode *inode = priv->inode;
> +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> +	u32 sectorsize = fs_info->sectorsize;
> +	struct bio_vec *bvec;
> +	struct bvec_iter_all iter_all;
> +	u64 offset = 0;
> +
> +	if (priv->skip_csum)
> +		return true;
> +	bio_for_each_segment_all(bvec, &io_bio->bio, iter_all) {
> +		unsigned int i, nr_sectors, pgoff;
> +
> +		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info, bvec->bv_len);
> +		pgoff = bvec->bv_offset;
> +		for (i = 0; i < nr_sectors; i++) {
> +			int csum_pos;
> +
> +			csum_pos = BTRFS_BYTES_TO_BLKS(fs_info, offset);
> +			if (__readpage_endio_check(inode, io_bio, csum_pos,
> +						   bvec->bv_page, pgoff,
> +						   io_bio->logical + offset,
> +						   sectorsize))
> +				return false;
> +			offset += sectorsize;
> +			pgoff += sectorsize;
> +		}
> +	}
> +	return true;
> +}
> +
> +static void btrfs_encoded_read_endio(struct bio *bio)
> +{
> +	struct btrfs_encoded_read_private *priv = bio->bi_private;
> +	struct btrfs_io_bio *io_bio = btrfs_io_bio(bio);
> +
> +	if (bio->bi_status || !btrfs_encoded_read_check_csums(io_bio))
> +		priv->uptodate = false;
> +	if (!atomic_dec_return(&priv->pending))
> +		wake_up(&priv->wait);
> +	btrfs_io_bio_free_csum(io_bio);
> +	bio_put(bio);
> +}
> +
> +static bool btrfs_submit_encoded_read(struct bio *bio)
> +{
> +	struct btrfs_encoded_read_private *priv = bio->bi_private;
> +	struct inode *inode = priv->inode;
> +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> +	blk_status_t status;
> +
> +	atomic_inc(&priv->pending);
> +
> +	if (!priv->skip_csum) {
> +		status = btrfs_lookup_bio_sums_at_offset(inode, bio,
> +							 btrfs_io_bio(bio)->logical,
> +							 NULL);
> +		if (status)
> +			goto out;
> +	}
> +
> +	status = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
> +	if (status)
> +		goto out;
> +
> +	status = btrfs_map_bio(fs_info, bio, 0, 0);
> +out:
> +	if (status) {
> +		bio->bi_status = status;
> +		bio_endio(bio);
> +		return false;
> +	}
> +	return true;
> +}
> +
> +static ssize_t btrfs_encoded_read_regular(struct kiocb *iocb,
> +					  struct iov_iter *iter,
> +					  u64 start, u64 lockend,
> +					  struct extent_state **cached_state,
> +					  struct block_device *bdev,
> +					  u64 offset, u64 disk_io_size,
> +					  size_t count,
> +					  const struct encoded_iov *encoded,
> +					  bool *unlocked)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
> +	struct btrfs_encoded_read_private priv = {
> +		.inode = inode,
> +		.wait = __WAIT_QUEUE_HEAD_INITIALIZER(priv.wait),
> +		.pending = ATOMIC_INIT(1),
> +		.uptodate = true,
> +		.skip_csum = BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM,
> +	};
> +	struct page **pages;
> +	unsigned long nr_pages, i;
> +	struct bio *bio = NULL;
> +	u64 cur;
> +	size_t page_offset;
> +	ssize_t ret;
> +
> +	nr_pages = (disk_io_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
> +	pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
> +	if (!pages)
> +		return -ENOMEM;
> +	for (i = 0; i < nr_pages; i++) {
> +		pages[i] = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
> +		if (!pages[i]) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +	}
> +
> +	i = 0;
> +	cur = 0;
> +	while (cur < disk_io_size) {
> +		size_t bytes = min_t(u64, disk_io_size - cur,
> +				     PAGE_SIZE);
> +
> +		if (!bio) {
> +			bio = btrfs_bio_alloc(offset + cur);
> +			bio_set_dev(bio, bdev);
> +			bio->bi_end_io = btrfs_encoded_read_endio;
> +			bio->bi_private = &priv;
> +			bio->bi_opf = REQ_OP_READ;
> +			btrfs_io_bio(bio)->logical = start + cur;
> +		}
> +
> +		if (bio_add_page(bio, pages[i], bytes, 0) < bytes) {
> +			bool success;
> +
> +			success = btrfs_submit_encoded_read(bio);
> +			bio = NULL;
> +			if (!success)
> +				break;
> +			continue;
> +		}
> +		i++;
> +		cur += bytes;
> +	}
> +
> +	if (bio)
> +		btrfs_submit_encoded_read(bio);
> +	if (atomic_dec_return(&priv.pending))
> +		wait_event(priv.wait, !atomic_read(&priv.pending));
> +	if (!priv.uptodate) {
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	unlock_extent_cached(io_tree, start, lockend, cached_state);
> +	inode_unlock(inode);
> +	*unlocked = true;
> +
> +	if (copy_to_iter(encoded, sizeof(*encoded), iter) != sizeof(*encoded)) {
> +		ret = -EFAULT;
> +		goto out;
> +	}
> +	if (encoded->compression) {
> +		i = 0;
> +		page_offset = 0;
> +	} else {
> +		i = (iocb->ki_pos - start) >> PAGE_SHIFT;
> +		page_offset = (iocb->ki_pos - start) & (PAGE_SIZE - 1);
> +	}
> +	cur = 0;
> +	while (cur < count) {
> +		size_t bytes = min_t(size_t, count - cur,
> +				     PAGE_SIZE - page_offset);
> +
> +		if (copy_page_to_iter(pages[i], page_offset, bytes,
> +				      iter) != bytes) {
> +			ret = -EFAULT;
> +			goto out;
> +		}
> +		i++;
> +		cur += bytes;
> +		page_offset = 0;
> +	}
> +	ret = count;
> +out:
> +	for (i = 0; i < nr_pages; i++) {
> +		if (pages[i])
> +			put_page(pages[i]);
> +	}
> +	kfree(pages);
> +	return ret;
> +}
> +
> +ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> +	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
> +	ssize_t ret;
> +	size_t count;
> +	struct block_device *em_bdev;
> +	u64 start, lockend, offset, disk_io_size;
> +	struct extent_state *cached_state = NULL;
> +	struct extent_map *em;
> +	struct encoded_iov encoded = {};
> +	bool unlocked = false;
> +
> +	ret = check_encoded_read(iocb, iter);
> +	if (ret < 0)
> +		return ret;
> +	if (ret == 0) {
> +empty:
> +		if (copy_to_iter(&encoded, sizeof(encoded), iter) ==
> +		    sizeof(encoded))
> +			return 0;
> +		else
> +			return -EFAULT;

nit: Just put the label at the end of the function since it's a simple
error handler.

> +	}
> +	count = ret;
> +
> +	file_accessed(iocb->ki_filp);
> +
> +	inode_lock(inode);
> +
> +	if (iocb->ki_pos >= inode->i_size) {
> +		inode_unlock(inode);
> +		goto empty;

That way you won't have to jump backwards here ...

> +	}
> +	start = ALIGN_DOWN(iocb->ki_pos, fs_info->sectorsize);
> +	/*
> +	 * We don't know how long the extent containing iocb->ki_pos is, but if
> +	 * it's compressed we know that it won't be longer than this.
> +	 */
> +	lockend = start + BTRFS_MAX_UNCOMPRESSED - 1;
> +
> +	for (;;) {
> +		struct btrfs_ordered_extent *ordered;
> +
> +		ret = btrfs_wait_ordered_range(inode, start,
> +					       lockend - start + 1);
> +		if (ret)
> +			goto out_unlock_inode;
> +		lock_extent_bits(io_tree, start, lockend, &cached_state);
> +		ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), start,
> +						     lockend - start + 1);
> +		if (!ordered)
> +			break;
> +		btrfs_put_ordered_extent(ordered);
> +		unlock_extent_cached(io_tree, start, lockend, &cached_state);
> +		cond_resched();
> +	}
> +
> +	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, start,
> +			      lockend - start + 1, 0);
> +	if (IS_ERR(em)) {
> +		ret = PTR_ERR(em);
> +		goto out_unlock_extent;
> +	}
> +	em_bdev = em->bdev;
> +
> +	if (em->block_start == EXTENT_MAP_INLINE) {
> +		u64 extent_start = em->start;
> +
> +		/*
> +		 * For inline extents we get everything we need out of the
> +		 * extent item.
> +		 */
> +		free_extent_map(em);
> +		em = NULL;
> +		ret = btrfs_encoded_read_inline(iocb, iter, start, lockend,
> +						&cached_state, extent_start,
> +						count, &encoded, &unlocked);
> +		goto out;
> +	}
> +
> +	/*
> +	 * We only want to return up to EOF even if the extent extends beyond
> +	 * that.
> +	 */
> +	encoded.len = (min_t(u64, extent_map_end(em), inode->i_size) -
> +		       iocb->ki_pos);
> +	if (em->block_start == EXTENT_MAP_HOLE ||
> +	    test_bit(EXTENT_FLAG_PREALLOC, &em->flags)) {
> +		offset = EXTENT_MAP_HOLE;
> +	} else if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags)) {
> +		offset = em->block_start;
> +		/*
> +		 * Bail if the buffer isn't large enough to return the whole
> +		 * compressed extent.
> +		 */
> +		if (em->block_len > count) {
> +			ret = -EFBIG;
> +			goto out_em;
> +		}
> +		disk_io_size = count = em->block_len;
> +		encoded.unencoded_len = em->ram_bytes;
> +		encoded.unencoded_offset = iocb->ki_pos - em->orig_start;
> +		ret = encoded_iov_compression_from_btrfs(&encoded,
> +							 em->compress_type);
> +		if (ret)
> +			goto out_em;
> +	} else {
> +		offset = em->block_start + (start - em->start);
> +		if (encoded.len > count)
> +			encoded.len = count;
> +		/*
> +		 * Don't read beyond what we locked. This also limits the page
> +		 * allocations that we'll do.
> +		 */
> +		disk_io_size = min(lockend + 1, iocb->ki_pos + encoded.len) - start;
> +		encoded.len = encoded.unencoded_len = count =
> +			start + disk_io_size - iocb->ki_pos;
> +		disk_io_size = ALIGN(disk_io_size, fs_info->sectorsize);
> +	}
> +	free_extent_map(em);
> +	em = NULL;
> +
> +	if (offset == EXTENT_MAP_HOLE) {
> +		unlock_extent_cached(io_tree, start, lockend, &cached_state);
> +		inode_unlock(inode);
> +		unlocked = true;
> +		if (copy_to_iter(&encoded, sizeof(encoded), iter) ==
> +		    sizeof(encoded))
> +			ret = 0;
> +		else
> +			ret = -EFAULT;
> +	} else {
> +		ret = btrfs_encoded_read_regular(iocb, iter, start, lockend,
> +						 &cached_state, em_bdev, offset,
> +						 disk_io_size, count, &encoded,
> +						 &unlocked);
> +	}
> +
> +out:
> +	if (ret >= 0)
> +		iocb->ki_pos += encoded.len;
> +out_em:
> +	free_extent_map(em);
> +out_unlock_extent:
> +	if (!unlocked)
> +		unlock_extent_cached(io_tree, start, lockend, &cached_state);
> +out_unlock_inode:
> +	if (!unlocked)
> +		inode_unlock(inode);
> +	return ret;
> +}
> +
>  #ifdef CONFIG_SWAP
>  /*
>   * Add an entry indicating a block group or device which is pinned by a
> 
