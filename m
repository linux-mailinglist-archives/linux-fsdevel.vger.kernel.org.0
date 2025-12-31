Return-Path: <linux-fsdevel+bounces-72270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4C4CEB734
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 08:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E6D3300976D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 07:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE673126AD;
	Wed, 31 Dec 2025 07:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="VNmqi7pq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B4F1A238F;
	Wed, 31 Dec 2025 07:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767166542; cv=none; b=ckQSdLY7k2iIZLYZiqveQxEC1tHEwkNNJ4JtoySiKKPwZCIZTNSd/sEss2pzxg12vcETnRseUfADxS0uNfqigKuJGpy+dLO/RCJsogdGbu3OrF2W5biIBbUumM0NJRh1/uZ9KhxTXehIOqi8cmjtdwchT0noijpniwd/GXMCwqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767166542; c=relaxed/simple;
	bh=4MzRf3yyDZdIr9gDp9yVkDobmAxXke2YEa0PuUu49bY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CdwpOw/5fc+fAQdU9XgaVpjcUH8KKu7opuxHIt42UfGXs7vOySwsAjCgv/DSrFzEto9eWj6/UCui7kPr7yjl7E+jhkjO90bJkMjC43M2FagbJHN9uY89SowTK8LSHftupi2f/KtKWKFzDDKL4J3ug4DH+o5Slm/gCZlk4IUVEkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=VNmqi7pq; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=5azde3eJNBsQxbVctUq+vh/IWlFVqs4bE8apderF/A0=;
	b=VNmqi7pqmCQWlvv2dvzJ3CKFsUXqT21liYUAAWC8Yqsa66rLbmHd0K2tAw8TBZuD/T8QtBKXR
	4iQp0lb9+fMPtMOI6WjuOyo36VfxT3g9XZIUog/c6Tfq8k7LQN+Jp2wfZBNDLP2eB0cOrad95ay
	Vtjs3Mi/brUi2rOjngzgXRo=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dh1rC6Z0kz12LDq;
	Wed, 31 Dec 2025 15:32:27 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 518384056A;
	Wed, 31 Dec 2025 15:35:36 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 31 Dec
 2025 15:35:35 +0800
Message-ID: <d66c0a1c-ea5b-4e1a-bcda-a4b8cf115919@huawei.com>
Date: Wed, 31 Dec 2025 15:35:34 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 2/7] ext4: don't split extent before submitting
 I/O
Content-Language: en-GB
To: Zhang Yi <yi.zhang@huaweicloud.com>, <linux-ext4@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ojaswin@linux.ibm.com>, <ritesh.list@gmail.com>, <yi.zhang@huawei.com>,
	<yizhang089@gmail.com>, <yangerkun@huawei.com>, <yukuai@fnnas.com>
References: <20251223011802.31238-1-yi.zhang@huaweicloud.com>
 <20251223011802.31238-3-yi.zhang@huaweicloud.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20251223011802.31238-3-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-12-23 09:17, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
>
> Currently, when writing back dirty pages to the filesystem with the
> dioread_nolock feature enabled and when doing DIO, if the area to be
> written back is part of an unwritten extent, the
> EXT4_GET_BLOCKS_IO_CREATE_EXT flag is set during block allocation before
> submitting I/O. The function ext4_split_convert_extents() then attempts
> to split this extent in advance. This approach is designed to prevents
> extent splitting and conversion to the written type from failing due to
> insufficient disk space at the time of I/O completion, which could
> otherwise result in data loss.
>
> However, we already have two mechanisms to ensure successful extent
> conversion. The first is the EXT4_GET_BLOCKS_METADATA_NOFAIL flag, which
> is a best effort, it permits the use of 2% of the reserved space or
> 4,096 blocks in the file system when splitting extents. This flag covers
> most scenarios where extent splitting might fail. The second is the
> EXT4_EXT_MAY_ZEROOUT flag, which is also set during extent splitting. If
> the reserved space is insufficient and splitting fails, it does not
> retry the allocation. Instead, it directly zeros out the extra part of
> the extent, thereby avoiding splitting and directly converting the
> entire extent to the written type.
>
> These two mechanisms also exist when I/Os are completed because there is
> a concurrency window between write-back and fallocate, which may still
> require us to split extents upon I/O completion. There is no much
> difference between splitting extents before submitting I/O. Therefore,
> It seems possible to defer the splitting until I/O completion, it won't
> increase the risk of I/O failure and data loss. On the contrary, if some
> I/Os can be merged when I/O completion, it can also reduce unnecessary
> splitting operations, thereby alleviating the pressure on reserved
> space.
>
> In addition, deferring extent splitting until I/O completion can
> also simplify the IO submission process and avoid initiating unnecessary
> journal handles when writing unwritten extents.
>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Looks good to me. Feel free to add:

Reviewed-by: Baokun Li <libaokun1@huawei.com>

> ---
>  fs/ext4/extents.c | 13 +------------
>  fs/ext4/inode.c   |  4 ++--
>  2 files changed, 3 insertions(+), 14 deletions(-)
>
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index e53959120b04..c98f7c5482b4 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3787,21 +3787,10 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
>  	ext_debug(inode, "logical block %llu, max_blocks %u\n",
>  		  (unsigned long long)ee_block, ee_len);
>  
> -	/* If extent is larger than requested it is a clear sign that we still
> -	 * have some extent state machine issues left. So extent_split is still
> -	 * required.
> -	 * TODO: Once all related issues will be fixed this situation should be
> -	 * illegal.
> -	 */
>  	if (ee_block != map->m_lblk || ee_len > map->m_len) {
>  		int flags = EXT4_GET_BLOCKS_CONVERT |
>  			    EXT4_GET_BLOCKS_METADATA_NOFAIL;
> -#ifdef CONFIG_EXT4_DEBUG
> -		ext4_warning(inode->i_sb, "Inode (%ld) finished: extent logical block %llu,"
> -			     " len %u; IO logical block %llu, len %u",
> -			     inode->i_ino, (unsigned long long)ee_block, ee_len,
> -			     (unsigned long long)map->m_lblk, map->m_len);
> -#endif
> +
>  		path = ext4_split_convert_extents(handle, inode, map, path,
>  						  flags, NULL);
>  		if (IS_ERR(path))
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index bb8165582840..ffde24ff7347 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2376,7 +2376,7 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
>  
>  	dioread_nolock = ext4_should_dioread_nolock(inode);
>  	if (dioread_nolock)
> -		get_blocks_flags |= EXT4_GET_BLOCKS_IO_CREATE_EXT;
> +		get_blocks_flags |= EXT4_GET_BLOCKS_UNWRIT_EXT;
>  
>  	err = ext4_map_blocks(handle, inode, map, get_blocks_flags);
>  	if (err < 0)
> @@ -3744,7 +3744,7 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
>  	else if (EXT4_LBLK_TO_B(inode, map->m_lblk) >= i_size_read(inode))
>  		m_flags = EXT4_GET_BLOCKS_CREATE;
>  	else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> -		m_flags = EXT4_GET_BLOCKS_IO_CREATE_EXT;
> +		m_flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
>  
>  	if (flags & IOMAP_ATOMIC)
>  		ret = ext4_map_blocks_atomic_write(handle, inode, map, m_flags,



