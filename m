Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24C23D06FA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 08:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfJIGAd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 02:00:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2790 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727363AbfJIGAd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 02:00:33 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x995vXNQ140235
        for <linux-fsdevel@vger.kernel.org>; Wed, 9 Oct 2019 02:00:32 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vh7t0ukm0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Oct 2019 02:00:31 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 9 Oct 2019 07:00:29 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Oct 2019 07:00:26 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9960P1B54919206
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Oct 2019 06:00:25 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7662A42054;
        Wed,  9 Oct 2019 06:00:25 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4878542049;
        Wed,  9 Oct 2019 06:00:22 +0000 (GMT)
Received: from [9.199.159.72] (unknown [9.199.159.72])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Oct 2019 06:00:22 +0000 (GMT)
Subject: Re: [PATCH v4 3/8] ext4: introduce new callback for IOMAP_REPORT
 operations
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>, tytso@mit.edu,
        jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com,
        riteshh@linux.ibm.com
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <cb2dcb6970da1b53bdf85583f13ba2aaf1684e96.1570100361.git.mbobrowski@mbobrowski.org>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 9 Oct 2019 11:30:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <cb2dcb6970da1b53bdf85583f13ba2aaf1684e96.1570100361.git.mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19100906-0028-0000-0000-000003A8555B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100906-0029-0000-0000-0000246A585A
Message-Id: <20191009060022.4878542049@d06av24.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-09_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910090055
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/3/19 5:03 PM, Matthew Bobrowski wrote:
> As part of ext4_iomap_begin() cleanups and port across direct I/O path
> to make use of iomap infrastructure, we split IOMAP_REPORT operations
> into a separate ->iomap_begin() handler.
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> ---
>   fs/ext4/ext4.h  |   1 +
>   fs/ext4/file.c  |   6 ++-
>   fs/ext4/inode.c | 129 ++++++++++++++++++++++++++++--------------------
>   3 files changed, 80 insertions(+), 56 deletions(-)
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
> index caeb3dec0dec..1dace576b8bd 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3439,6 +3439,72 @@ static int ext4_set_iomap(struct inode *inode, struct iomap *iomap, u16 type,
>   	return 0;
>   }
> 
> +static u16 ext4_iomap_check_delalloc(struct inode *inode,
> +				     struct ext4_map_blocks *map)
> +{
> +	struct extent_status es;
> +	ext4_lblk_t end = map->m_lblk + map->m_len - 1;
> +
> +	ext4_es_find_extent_range(inode, &ext4_es_is_delayed, map->m_lblk,
> +				  end, &es);
> +
> +	/* Entire range is a hole */
> +	if (!es.es_len || es.es_lblk > end)
> +		return IOMAP_HOLE;
> +	if (es.es_lblk <= map->m_lblk) {
> +		ext4_lblk_t offset = 0;
> +
> +		if (es.es_lblk < map->m_lblk)
> +			offset = map->m_lblk - es.es_lblk;
> +		map->m_lblk = es.es_lblk + offset;
This looks redundant no? map->m_lblk never changes actually.
So this is not needed here.


> +		map->m_len = es.es_len - offset;
> +		return IOMAP_DELALLOC;
> +	}
> +
> +	/* Range starts with a hole */
> +	map->m_len = es.es_lblk - map->m_lblk;
> +	return IOMAP_HOLE;
> +}
> +
> +static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
> +				   loff_t length, unsigned flags,
> +				   struct iomap *iomap)
> +{
> +	int ret;
> +	u16 type = 0;
> +	struct ext4_map_blocks map;
> +	u8 blkbits = inode->i_blkbits;
> +	unsigned long first_block, last_block;
> +
> +	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
> +		return -EINVAL;
> +	first_block = offset >> blkbits;
> +	last_block = min_t(loff_t, (offset + length - 1) >> blkbits,
> +			   EXT4_MAX_LOGICAL_BLOCK);
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
> +	map.m_lblk = first_block;
> +	map.m_len = last_block = first_block + 1;
> +	ret = ext4_map_blocks(NULL, inode, &map, 0);
> +	if (ret < 0)
> +		return ret;
> +	if (ret == 0)
> +		type = ext4_iomap_check_delalloc(inode, &map);
> +	return ext4_set_iomap(inode, iomap, type, first_block, &map);
We don't need to send first_block here. Since map->m_lblk
is same as first_block.
Also with Jan comment, we don't even need 'type' parameter.
Then we should be able to rename the function
ext4_set_iomap ==> ext4_map_to_iomap. This better reflects what it is
doing. Thoughts?


> +}
> +
> +const struct iomap_ops ext4_iomap_report_ops = {
> +	.iomap_begin = ext4_iomap_begin_report,
> +};
> +
>   static int ext4_iomap_alloc(struct inode *inode,
>   			    unsigned flags,
>   			    unsigned long first_block,
> @@ -3498,12 +3564,10 @@ static int ext4_iomap_alloc(struct inode *inode,
>   static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   			    unsigned flags, struct iomap *iomap)
>   {
> -	u16 type = 0;
> -	unsigned int blkbits = inode->i_blkbits;
> -	unsigned long first_block, last_block;
> -	struct ext4_map_blocks map;
> -	bool delalloc = false;
>   	int ret;
> +	struct ext4_map_blocks map;
> +	u8 blkbits = inode->i_blkbits;
> +	unsigned long first_block, last_block;
> 
>   	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
>   		return -EINVAL;
> @@ -3511,64 +3575,21 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   	last_block = min_t(loff_t, (offset + length - 1) >> blkbits,
>   			   EXT4_MAX_LOGICAL_BLOCK);
> 
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
> +	if (WARN_ON_ONCE(ext4_has_inline_data(inode)))
> +		return -ERANGE;
> 
>   	map.m_lblk = first_block;
>   	map.m_len = last_block - first_block + 1;
> 
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
> -
> -			if (!es.es_len || es.es_lblk > end) {
> -				/* entire range is a hole */
> -			} else if (es.es_lblk > map.m_lblk) {
> -				/* range starts with a hole */
> -				map.m_len = es.es_lblk - map.m_lblk;
> -			} else {
> -				ext4_lblk_t offs = 0;
> -
> -				if (es.es_lblk < map.m_lblk)
> -					offs = map.m_lblk - es.es_lblk;
> -				map.m_lblk = es.es_lblk + offs;
> -				map.m_len = es.es_len - offs;
> -				delalloc = true;
> -			}
> -		}
> -	} else if (flags & IOMAP_WRITE) {
> +	if (flags & IOMAP_WRITE)
>   		ret = ext4_iomap_alloc(inode, flags, first_block, &map);
> -	} else {
> +	else
>   		ret = ext4_map_blocks(NULL, inode, &map, 0);
> -		if (ret < 0)
> -			return ret;
> -	}
> 
>   	if (ret < 0)
>   		return ret;
> -
> -	if (!ret)
> -		type = delalloc ? IOMAP_DELALLOC : IOMAP_HOLE;
> -	return ext4_set_iomap(inode, iomap, type, first_block, &map);
> +	return ext4_set_iomap(inode, iomap, ret ? 0 : IOMAP_HOLE, first_block,
> +			      &map);
>   }
> 
>   static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
> 

