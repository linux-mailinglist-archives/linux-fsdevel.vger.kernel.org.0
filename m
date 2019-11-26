Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7857109FAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 14:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbfKZN4g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 08:56:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:43820 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727379AbfKZN4g (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:56:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 29252B1E4;
        Tue, 26 Nov 2019 13:56:33 +0000 (UTC)
Subject: Re: [RFC PATCH v3 04/12] btrfs: get rid of trivial
 __btrfs_lookup_bio_sums() wrappers
To:     Omar Sandoval <osandov@osandov.com>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1574273658.git.osandov@fb.com>
 <bca47beb2f4eef766accebef683137e94313f7d3.1574273658.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <dc600214-0f19-b321-8573-6193b5f47e16@suse.com>
Date:   Tue, 26 Nov 2019 15:56:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <bca47beb2f4eef766accebef683137e94313f7d3.1574273658.git.osandov@fb.com>
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
> Currently, we have two wrappers for __btrfs_lookup_bio_sums():
> btrfs_lookup_bio_sums_dio(), which is used for direct I/O, and
> btrfs_lookup_bio_sums(), which is used everywhere else. The only
> difference is that the _dio variant looks up csums starting at the given
> offset instead of using the page index, which isn't actually direct
> I/O-specific. Let's clean up the signature and return value of
> __btrfs_lookup_bio_sums(), rename it to btrfs_lookup_bio_sums(), and get
> rid of the trivial helpers.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Overall looks good but 2 nits, see below.

In any case:

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
>  fs/btrfs/compression.c |  4 ++--
>  fs/btrfs/ctree.h       |  4 +---
>  fs/btrfs/file-item.c   | 35 +++++++++++++++++------------------
>  fs/btrfs/inode.c       |  6 +++---
>  4 files changed, 23 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index b05b361e2062..4df6f0c58dc9 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -660,7 +660,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  
>  			if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
>  				ret = btrfs_lookup_bio_sums(inode, comp_bio,
> -							    sums);
> +							    false, 0, sums);
>  				BUG_ON(ret); /* -ENOMEM */
>  			}
>  
> @@ -689,7 +689,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  	BUG_ON(ret); /* -ENOMEM */
>  
>  	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
> -		ret = btrfs_lookup_bio_sums(inode, comp_bio, sums);
> +		ret = btrfs_lookup_bio_sums(inode, comp_bio, false, 0, sums);
>  		BUG_ON(ret); /* -ENOMEM */
>  	}
>  
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index fe2b8765d9e6..4bc40bf49b0e 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -2787,9 +2787,7 @@ struct btrfs_dio_private;
>  int btrfs_del_csums(struct btrfs_trans_handle *trans,
>  		    struct btrfs_fs_info *fs_info, u64 bytenr, u64 len);
>  blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
> -				   u8 *dst);
> -blk_status_t btrfs_lookup_bio_sums_dio(struct inode *inode, struct bio *bio,
> -			      u64 logical_offset);
> +				   bool at_offset, u64 offset, u8 *dst);
>  int btrfs_insert_file_extent(struct btrfs_trans_handle *trans,
>  			     struct btrfs_root *root,
>  			     u64 objectid, u64 pos,
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 1a599f50837b..a87c40502267 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -148,8 +148,21 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
>  	return ret;
>  }
>  
> -static blk_status_t __btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
> -				   u64 logical_offset, u8 *dst, int dio)
> +/**
> + * btrfs_lookup_bio_sums - Look up checksums for a bio.
> + * @inode: inode that the bio is for.
> + * @bio: bio embedded in btrfs_io_bio.
> + * @at_offset: If true, look up checksums for the extent at @c offset.

nit: that @c is an editing artifact? On the other hand rather than
having an explicit bool signifying whether we want a specific offset
can't we simply check if offset is != 0 ?

<snip>
