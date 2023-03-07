Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA746AD435
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 02:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjCGBpR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 20:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjCGBpP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 20:45:15 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062406B5D6;
        Mon,  6 Mar 2023 17:44:56 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MD9X9-1piT4B30oT-00968e; Tue, 07
 Mar 2023 02:44:39 +0100
Message-ID: <88b2fae1-8d95-2172-7bc4-c5dfc4ff7410@gmx.com>
Date:   Tue, 7 Mar 2023 09:44:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230121065031.1139353-1-hch@lst.de>
 <20230121065031.1139353-4-hch@lst.de>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 03/34] btrfs: add a btrfs_inode pointer to struct
 btrfs_bio
In-Reply-To: <20230121065031.1139353-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:vioWvPrhXEM3XZfjg5PaFSq00SI/M1W7AB3kl+1cskWnWDZBIQC
 EDg5CgwFg9MKQYsC0+2jOYBB6Dn8s1IYkxsKkACjLsfZc2sWHlMNpl609DUU81mqqISd52L
 BLSk5E79TQb8KrbWjBM9QsiDdKzsOtJ7BxqwE8A9Qh8skMO5rwxo90eUIBNDIjQKYQApBSv
 KjeL1+VVhaCmt7axGRNrQ==
UI-OutboundReport: notjunk:1;M01:P0:OkWFdUm8BZA=;Nv2cdgsRhKGkDG7cC6KUXc9rD7s
 IiFM697sVtdHb9QhoO613FC/4T81MT1SAvKN6y5kNGxxcH07I/Kn33F3FVz221dyVXrVIbhdt
 BFcDjr1vrfo2/02V5H69izKrT09Fi13mCqwEiLal7I7TT9HLT1iW2pZ5YUvrRRZHx4+EBeNU6
 r5vHSvc84LbYEQ3PdG3a7ABrecHyORO/DDeckic9h4AcEZjtYWGomUlDPy49C/Oduy0C9LcXZ
 pL8Rbci3wLnAHWEh0GXWyeHz1NEZRAXchqoakkKs6XMMQr8qDZiu6tBq7bDv3A8k+5E+oFYPb
 KGx9/Jxrqihkx6JFqjKEHoBdycjsEh17EDFknrtn/F04bf3fJPNsJXD+3Oi0kyDwbZ44iihiC
 tibAk7K7+uweFMRIbzpbHimUe4dN9rFJnYx7aVGQI/XFwzRhEr9AvtuvtgOiCUrTP2zeWMQk/
 YtOuadt9TvNk8MoiRWtoFSdj8/Zr9a+I3SsENpBfMzx8KWcSNP+qH8ySDpHiwt+uA5P3MAeCe
 3zZ41BtJsvVm3WNeLqdiDykYcuf0V6EB8yxzam8mbMCaWd9GQP4NsXzwX0AHvhgaX75tRKWyr
 SellT8JJS//PVNTr9t6vuk8I8oY70/9dBwzImPs1Kc//iVMn5JWPNvyoivONAqJfrbJMgnDWN
 iqfyn2IOhJreJMU0TRHbRqLGqMVPK5Mqdsq+W2Ko7sov7D4sbqAncRMDmbKs4tSx2m6e/b2I+
 vxbRwyEJv32/jwEAZM5ss/E9ZZFwkfRuMUCZd2FEXkTPDwg6qCZFBPB2C4UnyaoOKHo59DBYW
 EEGh1qyFoRFmNZTFzX5TWsAUsdV1Jek/hWYCGYWiI+TwDC1pJErpYX2GD+cguo+hALdItwBWE
 L9sNOuvrbT6WqOHlhY+T89bITvICQwbZ5MHMF0wY1dDWDsPo+nNwK/6jZh16AQrc13rJYSbgY
 uEY0s1biWHtUePOvC2vXPBBszHA=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/1/21 14:50, Christoph Hellwig wrote:
> All btrfs_bio I/Os are associated with an inode.  Add a pointer to that
> inode, which will allow to simplify a lot of calling conventions, and
> which will be needed in the I/O completion path in the future.
> 
> This grow the btrfs_bio struture by a pointer, but that grows will
> be offset by the removal of the device pointer soon.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

With my recent restart on scrub rework, this patch makes me wonder, what 
if scrub wants to use btrfs_bio, but don't want to pass a valid 
btrfs_inode pointer?

E.g. scrub code just wants to read certain mirror of a logical bytenr.
This can simplify the handling of RAID56, as for data stripes the repair 
path is the same, just try the next mirror(s).

Furthermore most of the new btrfs_bio code is handling data reads by 
triggering read-repair automatically.
This can be unnecessary for scrub.

For now, I can workaround the behavior by setting REQ_META and pass
btree_inode as the inode, but this is only a workaround.
This can be problematic especially if we want to merge metadata and data 
verification behavior.

Any better ideas on this?


And since we're here, can we also have btrfs equivalent of on-stack bio?
As scrub can benefit a lot from that, as for sector-by-sector read, we 
want to avoid repeating allocating/freeing a btrfs_bio just for reading 
one sector.
(The existing behavior is using on-stack bio with bio_init/bio_uninit 
inside scrub_recheck_block())

Thanks,
Qu
> ---
>   fs/btrfs/bio.c         | 8 ++++++--
>   fs/btrfs/bio.h         | 5 ++++-
>   fs/btrfs/compression.c | 3 ++-
>   fs/btrfs/extent_io.c   | 8 ++++----
>   fs/btrfs/inode.c       | 4 +++-
>   5 files changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 8affc88b0e0a4b..2398bb263957b2 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -22,9 +22,11 @@ static struct bio_set btrfs_bioset;
>    * is already initialized by the block layer.
>    */
>   static inline void btrfs_bio_init(struct btrfs_bio *bbio,
> +				  struct btrfs_inode *inode,
>   				  btrfs_bio_end_io_t end_io, void *private)
>   {
>   	memset(bbio, 0, offsetof(struct btrfs_bio, bio));
> +	bbio->inode = inode;
>   	bbio->end_io = end_io;
>   	bbio->private = private;
>   }
> @@ -37,16 +39,18 @@ static inline void btrfs_bio_init(struct btrfs_bio *bbio,
>    * a mempool.
>    */
>   struct bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
> +			    struct btrfs_inode *inode,
>   			    btrfs_bio_end_io_t end_io, void *private)
>   {
>   	struct bio *bio;
>   
>   	bio = bio_alloc_bioset(NULL, nr_vecs, opf, GFP_NOFS, &btrfs_bioset);
> -	btrfs_bio_init(btrfs_bio(bio), end_io, private);
> +	btrfs_bio_init(btrfs_bio(bio), inode, end_io, private);
>   	return bio;
>   }
>   
>   struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size,
> +				    struct btrfs_inode *inode,
>   				    btrfs_bio_end_io_t end_io, void *private)
>   {
>   	struct bio *bio;
> @@ -56,7 +60,7 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size,
>   
>   	bio = bio_alloc_clone(orig->bi_bdev, orig, GFP_NOFS, &btrfs_bioset);
>   	bbio = btrfs_bio(bio);
> -	btrfs_bio_init(bbio, end_io, private);
> +	btrfs_bio_init(bbio, inode, end_io, private);
>   
>   	bio_trim(bio, offset >> 9, size >> 9);
>   	bbio->iter = bio->bi_iter;
> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> index baaa27961cc812..8d69d0b226d99b 100644
> --- a/fs/btrfs/bio.h
> +++ b/fs/btrfs/bio.h
> @@ -41,7 +41,8 @@ struct btrfs_bio {
>   	unsigned int is_metadata:1;
>   	struct bvec_iter iter;
>   
> -	/* File offset that this I/O operates on. */
> +	/* Inode and offset into it that this I/O operates on. */
> +	struct btrfs_inode *inode;
>   	u64 file_offset;
>   
>   	/* @device is for stripe IO submission. */
> @@ -80,8 +81,10 @@ int __init btrfs_bioset_init(void);
>   void __cold btrfs_bioset_exit(void);
>   
>   struct bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
> +			    struct btrfs_inode *inode,
>   			    btrfs_bio_end_io_t end_io, void *private);
>   struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size,
> +				    struct btrfs_inode *inode,
>   				    btrfs_bio_end_io_t end_io, void *private);
>   
>   
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 4a5aeb8dd4793a..b8e3e899974b34 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -344,7 +344,8 @@ static struct bio *alloc_compressed_bio(struct compressed_bio *cb, u64 disk_byte
>   	struct bio *bio;
>   	int ret;
>   
> -	bio = btrfs_bio_alloc(BIO_MAX_VECS, opf, endio_func, cb);
> +	bio = btrfs_bio_alloc(BIO_MAX_VECS, opf, BTRFS_I(cb->inode), endio_func,
> +			      cb);
>   	bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
>   
>   	em = btrfs_get_chunk_map(fs_info, disk_bytenr, fs_info->sectorsize);
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 9bd32daa9b9a6f..faf9312a46c0e1 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -740,7 +740,8 @@ int btrfs_repair_one_sector(struct btrfs_inode *inode, struct btrfs_bio *failed_
>   		return -EIO;
>   	}
>   
> -	repair_bio = btrfs_bio_alloc(1, REQ_OP_READ, failed_bbio->end_io,
> +	repair_bio = btrfs_bio_alloc(1, REQ_OP_READ, failed_bbio->inode,
> +				     failed_bbio->end_io,
>   				     failed_bbio->private);
>   	repair_bbio = btrfs_bio(repair_bio);
>   	repair_bbio->file_offset = start;
> @@ -1394,9 +1395,8 @@ static int alloc_new_bio(struct btrfs_inode *inode,
>   	struct bio *bio;
>   	int ret;
>   
> -	ASSERT(bio_ctrl->end_io_func);
> -
> -	bio = btrfs_bio_alloc(BIO_MAX_VECS, opf, bio_ctrl->end_io_func, NULL);
> +	bio = btrfs_bio_alloc(BIO_MAX_VECS, opf, inode, bio_ctrl->end_io_func,
> +			      NULL);
>   	/*
>   	 * For compressed page range, its disk_bytenr is always @disk_bytenr
>   	 * passed in, no matter if we have added any range into previous bio.
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 3c49742f0d4556..0a85e42f114cc5 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8097,7 +8097,8 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
>   		 * the allocation is backed by btrfs_bioset.
>   		 */
>   		bio = btrfs_bio_clone_partial(dio_bio, clone_offset, clone_len,
> -					      btrfs_end_dio_bio, dip);
> +					      BTRFS_I(inode), btrfs_end_dio_bio,
> +					      dip);
>   		btrfs_bio(bio)->file_offset = file_offset;
>   
>   		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
> @@ -10409,6 +10410,7 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
>   
>   			if (!bio) {
>   				bio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ,
> +						      inode,
>   						      btrfs_encoded_read_endio,
>   						      &priv);
>   				bio->bi_iter.bi_sector =
