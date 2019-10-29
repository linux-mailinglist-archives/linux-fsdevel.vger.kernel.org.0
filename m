Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAF9E7FCC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2019 06:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732010AbfJ2Fmb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Oct 2019 01:42:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11760 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732004AbfJ2Fma (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Oct 2019 01:42:30 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9T4uFYt095044
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2019 01:42:30 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vxckwck28-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2019 01:42:29 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 29 Oct 2019 05:42:27 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 29 Oct 2019 05:42:22 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9T5gL2b63176730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 05:42:22 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8131A405F;
        Tue, 29 Oct 2019 05:42:21 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDC1BA4054;
        Tue, 29 Oct 2019 05:42:19 +0000 (GMT)
Received: from [9.199.158.60] (unknown [9.199.158.60])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 29 Oct 2019 05:42:19 +0000 (GMT)
Subject: Re: [PATCH v6 06/11] ext4: introduce new callback for IOMAP_REPORT
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>, tytso@mit.edu,
        jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
References: <cover.1572255424.git.mbobrowski@mbobrowski.org>
 <1c115e4dfc0d0b10d195c85dd48271cfc5167580.1572255425.git.mbobrowski@mbobrowski.org>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Tue, 29 Oct 2019 11:12:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1c115e4dfc0d0b10d195c85dd48271cfc5167580.1572255425.git.mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19102905-0020-0000-0000-0000038079C8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102905-0021-0000-0000-000021D680A3
Message-Id: <20191029054219.DDC1BA4054@b06wcsmtp001.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-29_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910290044
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/28/19 4:22 PM, Matthew Bobrowski wrote:
> As part of the ext4_iomap_begin() cleanups that precede this patch, we
> also split up the IOMAP_REPORT branch into a completely separate
> ->iomap_begin() callback named ext4_iomap_begin_report(). Again, the
> raionale for this change is to reduce the overall clutter within
> ext4_iomap_begin().
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> Reviewed-by: Jan Kara <jack@suse.cz>


Thanks for the patch. Looks good to me.
You may add:
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

> ---
>   fs/ext4/ext4.h  |   1 +
>   fs/ext4/file.c  |   6 ++-
>   fs/ext4/inode.c | 134 +++++++++++++++++++++++++++++-------------------
>   3 files changed, 85 insertions(+), 56 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 03db3e71676c..d0d88f411a44 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3379,6 +3379,7 @@ static inline void ext4_clear_io_unwritten_flag(ext4_io_end_t *io_end)
>   }
> 
>   extern const struct iomap_ops ext4_iomap_ops;
> +extern const struct iomap_ops ext4_iomap_report_ops;
> 
>   static inline int ext4_buffer_uptodate(struct buffer_head *bh)
>   {
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 8d2bbcc2d813..ab75aee3e687 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -494,12 +494,14 @@ loff_t ext4_llseek(struct file *file, loff_t offset, int whence)
>   						maxbytes, i_size_read(inode));
>   	case SEEK_HOLE:
>   		inode_lock_shared(inode);
> -		offset = iomap_seek_hole(inode, offset, &ext4_iomap_ops);
> +		offset = iomap_seek_hole(inode, offset,
> +					 &ext4_iomap_report_ops);
>   		inode_unlock_shared(inode);
>   		break;
>   	case SEEK_DATA:
>   		inode_lock_shared(inode);
> -		offset = iomap_seek_data(inode, offset, &ext4_iomap_ops);
> +		offset = iomap_seek_data(inode, offset,
> +					 &ext4_iomap_report_ops);
>   		inode_unlock_shared(inode);
>   		break;
>   	}
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 325abba6482c..50b4835cd927 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3513,74 +3513,32 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
>   static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   		unsigned flags, struct iomap *iomap, struct iomap *srcmap)
>   {
> -	unsigned int blkbits = inode->i_blkbits;
> -	unsigned long first_block, last_block;
> -	struct ext4_map_blocks map;
> -	bool delalloc = false;
>   	int ret;
> +	struct ext4_map_blocks map;
> +	u8 blkbits = inode->i_blkbits;
> 
>   	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
>   		return -EINVAL;
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
>   		ret = ext4_iomap_alloc(inode, &map, flags);
> -	} else {
> +	else
>   		ret = ext4_map_blocks(NULL, inode, &map, 0);
> -	}
> 
>   	if (ret < 0)
>   		return ret;
> 
>   	ext4_set_iomap(inode, iomap, &map, offset, length);
> -	if (delalloc && iomap->type == IOMAP_HOLE)
> -		iomap->type = IOMAP_DELALLOC;
> 
>   	return 0;
>   }
> @@ -3642,6 +3600,74 @@ const struct iomap_ops ext4_iomap_ops = {
>   	.iomap_end		= ext4_iomap_end,
>   };
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
>   static int ext4_end_io_dio(struct kiocb *iocb, loff_t offset,
>   			    ssize_t size, void *private)
>   {
> 

