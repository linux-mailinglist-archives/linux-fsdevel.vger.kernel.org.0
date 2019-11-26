Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50D6810A027
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 15:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbfKZOSv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 09:18:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:57478 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727870AbfKZOSv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 09:18:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 40FEFB152;
        Tue, 26 Nov 2019 14:18:48 +0000 (UTC)
Subject: Re: [RFC PATCH v3 05/12] btrfs: don't advance offset for compressed
 bios in btrfs_csum_one_bio()
To:     Omar Sandoval <osandov@osandov.com>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1574273658.git.osandov@fb.com>
 <a669365a9165b18814c635f61ed566fdcd47a96f.1574273658.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9669273e-5a73-540f-2091-5ce64e093062@suse.com>
Date:   Tue, 26 Nov 2019 16:18:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <a669365a9165b18814c635f61ed566fdcd47a96f.1574273658.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 20.11.19 г. 20:24 ч., Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> btrfs_csum_one_bio() loops over each sector in the bio while keeping a

'sector' here is ambiguous it really loops over every fs block (which in
btrfs is also known as sector). SO perhaps change the wording in the
changelog but also in the function instead of nr_sectors perhahps it
could be renamed to blockcount?

> cursor of its current logical position in the file in order to look up
> the ordered extent to add the checksums to. However, this doesn't make
> much sense for compressed extents, as a sector on disk does not
> correspond to a sector of decompressed file data. It happens to work
> because 1) the compressed bio always covers one ordered extent and 2)
> the size of the bio is always less than the size of the ordered extent.
> However, the second point will not always be true for encoded writes.
> 
> Let's add a boolean parameter to btrfs_csum_one_bio() to indicate that
> it can assume that the bio only covers one ordered extent. Since we're
> already changing the signature, let's make contig bool instead of int,
> too.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  fs/btrfs/compression.c |  5 +++--
>  fs/btrfs/ctree.h       |  2 +-
>  fs/btrfs/file-item.c   | 19 +++++++++++--------
>  fs/btrfs/inode.c       |  8 ++++----
>  4 files changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 4df6f0c58dc9..05b6e404a291 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -374,7 +374,8 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
>  			BUG_ON(ret); /* -ENOMEM */
>  
>  			if (!skip_sum) {
> -				ret = btrfs_csum_one_bio(inode, bio, start, 1);
> +				ret = btrfs_csum_one_bio(inode, bio, start,
> +							 true, true);
>  				BUG_ON(ret); /* -ENOMEM */
>  			}
>  
> @@ -405,7 +406,7 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
>  	BUG_ON(ret); /* -ENOMEM */
>  
>  	if (!skip_sum) {
> -		ret = btrfs_csum_one_bio(inode, bio, start, 1);
> +		ret = btrfs_csum_one_bio(inode, bio, start, true, true);
>  		BUG_ON(ret); /* -ENOMEM */
>  	}
>  
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 4bc40bf49b0e..c32741879088 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -2802,7 +2802,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
>  			   struct btrfs_root *root,
>  			   struct btrfs_ordered_sum *sums);
>  blk_status_t btrfs_csum_one_bio(struct inode *inode, struct bio *bio,
> -		       u64 file_start, int contig);
> +				u64 file_start, bool contig, bool one_ordered);
>  int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
>  			     struct list_head *list, int search_commit);
>  void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index a87c40502267..c95772949b00 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -423,13 +423,14 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
>   * @inode:	 Owner of the data inside the bio
>   * @bio:	 Contains the data to be checksummed
>   * @file_start:  offset in file this bio begins to describe
> - * @contig:	 Boolean. If true/1 means all bio vecs in this bio are
> - *		 contiguous and they begin at @file_start in the file. False/0
> - *		 means this bio can contains potentially discontigous bio vecs
> - *		 so the logical offset of each should be calculated separately.
> + * @contig:      If true, all bio vecs in @bio are contiguous and they begin at
> + *               @file_start in the file. If false, @bio may contain
> + *               discontigous bio vecs, so the logical offset of each should be
> + *               calculated separately (@file_start is ignored).
> + * @one_ordered: If true, @bio only refers to one ordered extent.
>   */
>  blk_status_t btrfs_csum_one_bio(struct inode *inode, struct bio *bio,
> -		       u64 file_start, int contig)
> +				u64 file_start, bool contig, bool one_ordered)
>  {
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
> @@ -482,8 +483,9 @@ blk_status_t btrfs_csum_one_bio(struct inode *inode, struct bio *bio,
>  						 - 1);
>  
>  		for (i = 0; i < nr_sectors; i++) {
> -			if (offset >= ordered->file_offset + ordered->len ||
> -				offset < ordered->file_offset) {
> +			if (!one_ordered &&
> +			    (offset >= ordered->file_offset + ordered->len ||
> +			     offset < ordered->file_offset)) {
>  				unsigned long bytes_left;
>  
>  				sums->len = this_sum_bytes;
> @@ -515,7 +517,8 @@ blk_status_t btrfs_csum_one_bio(struct inode *inode, struct bio *bio,
>  			kunmap_atomic(data);
>  			crypto_shash_final(shash, (char *)(sums->sums + index));
>  			index += csum_size;
> -			offset += fs_info->sectorsize;
> +			if (!one_ordered)
> +				offset += fs_info->sectorsize;
>  			this_sum_bytes += fs_info->sectorsize;
>  			total_bytes += fs_info->sectorsize;
>  		}
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index ad5bffb24199..4c1ed6dddfd8 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2039,7 +2039,7 @@ static blk_status_t btrfs_submit_bio_start(void *private_data, struct bio *bio,
>  	struct inode *inode = private_data;
>  	blk_status_t ret = 0;
>  
> -	ret = btrfs_csum_one_bio(inode, bio, 0, 0);
> +	ret = btrfs_csum_one_bio(inode, bio, 0, false, false);
>  	BUG_ON(ret); /* -ENOMEM */
>  	return 0;
>  }
> @@ -2104,7 +2104,7 @@ static blk_status_t btrfs_submit_bio_hook(struct inode *inode, struct bio *bio,
>  					  0, inode, btrfs_submit_bio_start);
>  		goto out;
>  	} else if (!skip_sum) {
> -		ret = btrfs_csum_one_bio(inode, bio, 0, 0);
> +		ret = btrfs_csum_one_bio(inode, bio, 0, false, false);
>  		if (ret)
>  			goto out;
>  	}
> @@ -8272,7 +8272,7 @@ static blk_status_t btrfs_submit_bio_start_direct_io(void *private_data,
>  {
>  	struct inode *inode = private_data;
>  	blk_status_t ret;
> -	ret = btrfs_csum_one_bio(inode, bio, offset, 1);
> +	ret = btrfs_csum_one_bio(inode, bio, offset, true, false);
>  	BUG_ON(ret); /* -ENOMEM */
>  	return 0;
>  }
> @@ -8379,7 +8379,7 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
>  		 * If we aren't doing async submit, calculate the csum of the
>  		 * bio now.
>  		 */
> -		ret = btrfs_csum_one_bio(inode, bio, file_offset, 1);
> +		ret = btrfs_csum_one_bio(inode, bio, file_offset, true, false);
>  		if (ret)
>  			goto err;
>  	} else {
> 
