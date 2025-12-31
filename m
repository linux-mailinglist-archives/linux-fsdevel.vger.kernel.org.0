Return-Path: <linux-fsdevel+bounces-72275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08390CEB7D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 08:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0346C302EA33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 07:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615AB3126C6;
	Wed, 31 Dec 2025 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="bV1Rlt87"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE983A1E82;
	Wed, 31 Dec 2025 07:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767167762; cv=none; b=r/AFvUpHocPDw4KD8plKYch/Nx9iwvMAEO/dynYt0ofzlp68R2R5gx0kb2S3C5pBOvWlrpTmPJGJk0VrTKNg2sZzAGxPmZEc7bx2qRzOnWG/HQ/O+hqGvRdzo8B+CA2KMV6/eFekzWPYRj2KsoBIhyKihynhQQfTbXm+PIYkhEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767167762; c=relaxed/simple;
	bh=5ZKhd7DVCFFo1v/qI17TR1e8KnYI49V8gKuZ3mg90i8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=r+9VJbS3WK41h8QFrQx3Q+MBuiRvdX8DuwIIG5rKbI+wX1c1XZW6lVPrng1ow0Hr8L+qAdB9uIC3uvjp3POU5AzXDXwrz7ipdXSrcnfzR4mnRrRX3CwQPk1l2MNATpWic15siWO2m2L30ZkOR0iEnqwPfbeXnIImWl0cttwKr+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=bV1Rlt87; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=f9XRkIBTX5PSlStEA/tNzNbzSS+s7sdVWESPm59BP9M=;
	b=bV1Rlt87TIm8GvzBsdZibHbpBo67SRkOI1E9LNQ9Vkwu64QlQDRXWi5IzzHEAopbVBOOwRixP
	UrNJyeOjWPqKchkfuGGprgKZckH4RZ1hpFPDlGzQC9522b3Y9GDCeaydP+zPv+4PM7eeISakbka
	3heUKEIAzTHbYXhTaKqyAig=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dh2HV04ppzLlXc;
	Wed, 31 Dec 2025 15:52:38 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F68740565;
	Wed, 31 Dec 2025 15:55:48 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 31 Dec
 2025 15:55:47 +0800
Message-ID: <474927ab-e7e1-47a1-9704-ba057580519c@huawei.com>
Date: Wed, 31 Dec 2025 15:55:46 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 7/7] ext4: remove EXT4_GET_BLOCKS_IO_CREATE_EXT
Content-Language: en-GB
To: Zhang Yi <yi.zhang@huaweicloud.com>, <linux-ext4@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ojaswin@linux.ibm.com>, <ritesh.list@gmail.com>, <yi.zhang@huawei.com>,
	<yizhang089@gmail.com>, <yangerkun@huawei.com>, <yukuai@fnnas.com>
References: <20251223011802.31238-1-yi.zhang@huaweicloud.com>
 <20251223011802.31238-8-yi.zhang@huaweicloud.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20251223011802.31238-8-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-12-23 09:18, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
>
> We do not use EXT4_GET_BLOCKS_IO_CREATE_EXT or split extents before
> submitting I/O; therefore, remove the related code.
>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Looks good. Feel free to add:

Reviewed-by: Baokun Li <libaokun1@huawei.com>

> ---
>  fs/ext4/ext4.h    |  9 ---------
>  fs/ext4/extents.c | 29 -----------------------------
>  fs/ext4/inode.c   | 11 -----------
>  3 files changed, 49 deletions(-)
>
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 9a71357f192d..174c51402864 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -707,15 +707,6 @@ enum {
>  	 * found an unwritten extent, we need to split it.
>  	 */
>  #define EXT4_GET_BLOCKS_SPLIT_NOMERGE		0x0008
> -	/*
> -	 * Caller is from the dio or dioread_nolock buffered IO, reqest to
> -	 * create an unwritten extent if it does not exist or split the
> -	 * found unwritten extent. Also do not merge the newly created
> -	 * unwritten extent, io end will convert unwritten to written,
> -	 * and try to merge the written extent.
> -	 */
> -#define EXT4_GET_BLOCKS_IO_CREATE_EXT		(EXT4_GET_BLOCKS_SPLIT_NOMERGE|\
> -					 EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT)
>  	/* Convert unwritten extent to initialized. */
>  #define EXT4_GET_BLOCKS_CONVERT			0x0010
>  	/* Eventual metadata allocation (due to growing extent tree)
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index c98f7c5482b4..c7c66ab825e7 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3925,34 +3925,6 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>  	trace_ext4_ext_handle_unwritten_extents(inode, map, flags,
>  						*allocated, newblock);
>  
> -	/* get_block() before submitting IO, split the extent */
> -	if (flags & EXT4_GET_BLOCKS_SPLIT_NOMERGE) {
> -		int depth;
> -
> -		path = ext4_split_convert_extents(handle, inode, map, path,
> -						  flags, allocated);
> -		if (IS_ERR(path))
> -			return path;
> -		/*
> -		 * shouldn't get a 0 allocated when splitting an extent unless
> -		 * m_len is 0 (bug) or extent has been corrupted
> -		 */
> -		if (unlikely(*allocated == 0)) {
> -			EXT4_ERROR_INODE(inode,
> -					 "unexpected allocated == 0, m_len = %u",
> -					 map->m_len);
> -			err = -EFSCORRUPTED;
> -			goto errout;
> -		}
> -		/* Don't mark unwritten if the extent has been zeroed out. */
> -		path = ext4_find_extent(inode, map->m_lblk, path, flags);
> -		if (IS_ERR(path))
> -			return path;
> -		depth = ext_depth(inode);
> -		if (ext4_ext_is_unwritten(path[depth].p_ext))
> -			map->m_flags |= EXT4_MAP_UNWRITTEN;
> -		goto out;
> -	}
>  	/* IO end_io complete, convert the filled extent to written */
>  	if (flags & EXT4_GET_BLOCKS_CONVERT) {
>  		path = ext4_convert_unwritten_extents_endio(handle, inode,
> @@ -4006,7 +3978,6 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>  		goto errout;
>  	}
>  
> -out:
>  	map->m_flags |= EXT4_MAP_NEW;
>  map_out:
>  	map->m_flags |= EXT4_MAP_MAPPED;
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 67fe7d0f47e3..2e79b09fe2f0 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -588,7 +588,6 @@ static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
>  static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
>  				  struct ext4_map_blocks *map, int flags)
>  {
> -	struct extent_status es;
>  	unsigned int status;
>  	int err, retval = 0;
>  
> @@ -649,16 +648,6 @@ static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
>  			return err;
>  	}
>  
> -	/*
> -	 * If the extent has been zeroed out, we don't need to update
> -	 * extent status tree.
> -	 */
> -	if (flags & EXT4_GET_BLOCKS_SPLIT_NOMERGE &&
> -	    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es, &map->m_seq)) {
> -		if (ext4_es_is_written(&es))
> -			return retval;
> -	}
> -
>  	status = map->m_flags & EXT4_MAP_UNWRITTEN ?
>  			EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
>  	ext4_es_insert_extent(inode, map->m_lblk, map->m_len, map->m_pblk,



