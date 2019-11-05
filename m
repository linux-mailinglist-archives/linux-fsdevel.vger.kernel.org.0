Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C244F01C4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 16:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389905AbfKEPoP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 10:44:15 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45328 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389571AbfKEPoP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:44:15 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA5Fhw54053329;
        Tue, 5 Nov 2019 15:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=S8PS1Ol+7namJ8wS9uwQVS9IG0sqdyl/Y91bz+jueNw=;
 b=rIUygj+1yjQKL/QX4qdNDm7wJd+nKqZFagWt+k1MPgivYyW4YwHUYs08AK/HXMqHeLgZ
 gN+v+mIp0jC0Fla5zmTHK6ypAVs5VX0msaR4ArGZWlP/pxcVWhukrMfzVayX0qXul5fD
 NXr9Gp5d0qJPLPZ4Wql6kzCguL1uqRAVkGqDoifz2fJTQiStZ8bIl++7Qiefh/OV3doV
 iojzfhTJRKY2p78nnr2tqS2Cl8NYFpsWwCcjT+fVGIVR4lbN19n9NKVVe4yVT6DA0Tzs
 B9yvl/o6SFeofkunC1GF9Z3A94BWIi8nN0uihXCRsAX2A1sla/KjLZyQlanWr4Qvjbvo cQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2w11rpydyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Nov 2019 15:43:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA5Fgv1k110324;
        Tue, 5 Nov 2019 15:43:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2w2wck33ud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Nov 2019 15:43:56 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA5Fhsxq005425;
        Tue, 5 Nov 2019 15:43:54 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Nov 2019 07:43:53 -0800
Date:   Tue, 5 Nov 2019 07:43:47 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        riteshh@linux.ibm.com
Subject: Re: [PATCH v7 06/11] ext4: introduce new callback for IOMAP_REPORT
Message-ID: <20191105154347.GB15203@magnolia>
References: <cover.1572949325.git.mbobrowski@mbobrowski.org>
 <5c97a569e26ddb6696e3d3ac9fbde41317e029a0.1572949325.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c97a569e26ddb6696e3d3ac9fbde41317e029a0.1572949325.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9432 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911050128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9432 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911050128
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 05, 2019 at 11:03:31PM +1100, Matthew Bobrowski wrote:
> As part of the ext4_iomap_begin() cleanups that precede this patch, we
> also split up the IOMAP_REPORT branch into a completely separate
> ->iomap_begin() callback named ext4_iomap_begin_report(). Again, the
> raionale for this change is to reduce the overall clutter within
> ext4_iomap_begin().
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  fs/ext4/ext4.h  |   1 +
>  fs/ext4/file.c  |   6 ++-
>  fs/ext4/inode.c | 134 +++++++++++++++++++++++++++++-------------------
>  3 files changed, 85 insertions(+), 56 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 3616f1b0c987..5c6c4acea8b1 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3388,6 +3388,7 @@ static inline void ext4_clear_io_unwritten_flag(ext4_io_end_t *io_end)
>  }
>  
>  extern const struct iomap_ops ext4_iomap_ops;
> +extern const struct iomap_ops ext4_iomap_report_ops;
>  
>  static inline int ext4_buffer_uptodate(struct buffer_head *bh)
>  {
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 8d2bbcc2d813..ab75aee3e687 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -494,12 +494,14 @@ loff_t ext4_llseek(struct file *file, loff_t offset, int whence)
>  						maxbytes, i_size_read(inode));
>  	case SEEK_HOLE:
>  		inode_lock_shared(inode);
> -		offset = iomap_seek_hole(inode, offset, &ext4_iomap_ops);
> +		offset = iomap_seek_hole(inode, offset,
> +					 &ext4_iomap_report_ops);
>  		inode_unlock_shared(inode);
>  		break;
>  	case SEEK_DATA:
>  		inode_lock_shared(inode);
> -		offset = iomap_seek_data(inode, offset, &ext4_iomap_ops);
> +		offset = iomap_seek_data(inode, offset,
> +					 &ext4_iomap_report_ops);
>  		inode_unlock_shared(inode);
>  		break;
>  	}
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index b540f2903faa..b5ba6767b276 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3553,74 +3553,32 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
>  static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  		unsigned flags, struct iomap *iomap, struct iomap *srcmap)
>  {
> -	unsigned int blkbits = inode->i_blkbits;
> -	unsigned long first_block, last_block;
> -	struct ext4_map_blocks map;
> -	bool delalloc = false;
>  	int ret;
> +	struct ext4_map_blocks map;
> +	u8 blkbits = inode->i_blkbits;
>  
>  	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
>  		return -EINVAL;
> -	first_block = offset >> blkbits;
> -	last_block = min_t(loff_t, (offset + length - 1) >> blkbits,
> -			   EXT4_MAX_LOGICAL_BLOCK);
> -
> -	if (flags & IOMAP_REPORT) {
> -		if (ext4_has_inline_data(inode)) {
> -			ret = ext4_inline_data_iomap(inode, iomap);
> -			if (ret != -EAGAIN) {
> -				if (ret == 0 && offset >= iomap->length)
> -					ret = -ENOENT;
> -				return ret;
> -			}
> -		}
> -	} else {
> -		if (WARN_ON_ONCE(ext4_has_inline_data(inode)))
> -			return -ERANGE;
> -	}
>  
> -	map.m_lblk = first_block;
> -	map.m_len = last_block - first_block + 1;
> -
> -	if (flags & IOMAP_REPORT) {
> -		ret = ext4_map_blocks(NULL, inode, &map, 0);
> -		if (ret < 0)
> -			return ret;
> -
> -		if (ret == 0) {
> -			ext4_lblk_t end = map.m_lblk + map.m_len - 1;
> -			struct extent_status es;
> -
> -			ext4_es_find_extent_range(inode, &ext4_es_is_delayed,
> -						  map.m_lblk, end, &es);
> +	if (WARN_ON_ONCE(ext4_has_inline_data(inode)))
> +		return -ERANGE;
>  
> -			if (!es.es_len || es.es_lblk > end) {
> -				/* entire range is a hole */
> -			} else if (es.es_lblk > map.m_lblk) {
> -				/* range starts with a hole */
> -				map.m_len = es.es_lblk - map.m_lblk;
> -			} else {
> -				ext4_lblk_t offs = 0;
> +	/*
> +	 * Calculate the first and last logical blocks respectively.
> +	 */
> +	map.m_lblk = offset >> blkbits;
> +	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
> +			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
>  
> -				if (es.es_lblk < map.m_lblk)
> -					offs = map.m_lblk - es.es_lblk;
> -				map.m_lblk = es.es_lblk + offs;
> -				map.m_len = es.es_len - offs;
> -				delalloc = true;
> -			}
> -		}
> -	} else if (flags & IOMAP_WRITE) {
> +	if (flags & IOMAP_WRITE)
>  		ret = ext4_iomap_alloc(inode, &map, flags);

FWIW you could even split non-buffered read and write into separate iomap
ops and avoid this split... but that's a cleanup that can wait until
after the main series lands.

> -	} else {
> +	else
>  		ret = ext4_map_blocks(NULL, inode, &map, 0);
> -	}
>  
>  	if (ret < 0)
>  		return ret;
>  
>  	ext4_set_iomap(inode, iomap, &map, offset, length);
> -	if (delalloc && iomap->type == IOMAP_HOLE)
> -		iomap->type = IOMAP_DELALLOC;
>  
>  	return 0;
>  }
> @@ -3682,6 +3640,74 @@ const struct iomap_ops ext4_iomap_ops = {
>  	.iomap_end		= ext4_iomap_end,
>  };
>  
> +static bool ext4_iomap_is_delalloc(struct inode *inode,
> +				   struct ext4_map_blocks *map)
> +{
> +	struct extent_status es;
> +	ext4_lblk_t offset = 0, end = map->m_lblk + map->m_len - 1;
> +
> +	ext4_es_find_extent_range(inode, &ext4_es_is_delayed,
> +				  map->m_lblk, end, &es);
> +
> +	if (!es.es_len || es.es_lblk > end)
> +		return false;
> +
> +	if (es.es_lblk > map->m_lblk) {
> +		map->m_len = es.es_lblk - map->m_lblk;
> +		return false;
> +	}
> +
> +	offset = map->m_lblk - es.es_lblk;
> +	map->m_len = es.es_len - offset;
> +
> +	return true;
> +}
> +
> +static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
> +				   loff_t length, unsigned int flags,
> +				   struct iomap *iomap, struct iomap *srcmap)
> +{
> +	int ret;
> +	bool delalloc = false;
> +	struct ext4_map_blocks map;
> +	u8 blkbits = inode->i_blkbits;
> +
> +	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
> +		return -EINVAL;
> +
> +	if (ext4_has_inline_data(inode)) {
> +		ret = ext4_inline_data_iomap(inode, iomap);
> +		if (ret != -EAGAIN) {
> +			if (ret == 0 && offset >= iomap->length)
> +				ret = -ENOENT;
> +			return ret;
> +		}
> +	}
> +
> +	/*
> +	 * Calculate the first and last logical block respectively.
> +	 */
> +	map.m_lblk = offset >> blkbits;
> +	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
> +			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
> +
> +	ret = ext4_map_blocks(NULL, inode, &map, 0);
> +	if (ret < 0)
> +		return ret;
> +	if (ret == 0)
> +		delalloc = ext4_iomap_is_delalloc(inode, &map);

If you can tell that a mapping is delalloc from @inode and @map, how
about pushing the ext4_iomap_is_delalloc call into ext4_set_iomap?

Oh, humm, the _is_delalloc function isn't a predicate after all; it
modifies @map.  Urrk.

--D

> +
> +	ext4_set_iomap(inode, iomap, &map, offset, length);
> +	if (delalloc && iomap->type == IOMAP_HOLE)
> +		iomap->type = IOMAP_DELALLOC;
> +
> +	return 0;
> +}
> +
> +const struct iomap_ops ext4_iomap_report_ops = {
> +	.iomap_begin = ext4_iomap_begin_report,
> +};
> +
>  static int ext4_end_io_dio(struct kiocb *iocb, loff_t offset,
>  			    ssize_t size, void *private)
>  {
> -- 
> 2.20.1
> 
