Return-Path: <linux-fsdevel+bounces-72269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F0ECEB728
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 08:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B182D3031366
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 07:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925D33126A8;
	Wed, 31 Dec 2025 07:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Drs/aQS3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7744E1A238F;
	Wed, 31 Dec 2025 07:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767166501; cv=none; b=sR0/wuvwViAXBjM/UvNzfa2WHlrqswEyUmATWXWTN0ky442VUkks/paVj8SG18pxzdKwTKrtdujjQ7KWc5r7wkfGhSc1zBRkuPWDiUum61nG/NSVR90LXgCAWk/wXQZviC04xX/m9fVIZ+Ej0JnqfeLRkU/DKGrlX+rluUDx2A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767166501; c=relaxed/simple;
	bh=frjUieR8caA+olY0AW/5wAiUOhN4SDkrDlYvHbD3WMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SaDOXZLU9IYnvPix86NK3zTdp9rz/kLDBgh83oyxi6n7lmb3N5UGJ/C3os8GjIgIwiJEB6pmd+dDJvk+1HSncs3r1sFQ7bp7YsotdMK/+e0RNiWtbJJZ7Lo0rjruRlPMBcCeNlP7EnATVpFXpnAuHLFg/SVmzbTUyvzniDmxoZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Drs/aQS3; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+8qAKvYNl44DpfUKLuUgR2FpRE8fJBz+tvrN421qYr0=;
	b=Drs/aQS3alg/7o3Q0eVOk79G0WWv2jyC3pRdGW4nl+iuPmeGLh15jlLQUlKgHltbj0oydcENJ
	uoa/p0pYW/5oKc9UM8puoMRJRohf4gcj6WfnwCxzEDaO9jpN8hSEhaeTyMsT9xneCfZJ58iw3jM
	a/dvdbqzLw3dVYeuT3WlwpY=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dh1qL1sl7zRhQt;
	Wed, 31 Dec 2025 15:31:42 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id AF0BB40606;
	Wed, 31 Dec 2025 15:34:53 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 31 Dec
 2025 15:34:52 +0800
Message-ID: <c05d7382-27c8-46cb-a008-56c5dc2fde5d@huawei.com>
Date: Wed, 31 Dec 2025 15:34:51 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 1/7] ext4: use reserved metadata blocks when
 splitting extent on endio
Content-Language: en-GB
To: Zhang Yi <yi.zhang@huaweicloud.com>, <linux-ext4@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ojaswin@linux.ibm.com>, <ritesh.list@gmail.com>, <yi.zhang@huawei.com>,
	<yizhang089@gmail.com>, <yangerkun@huawei.com>, <yukuai@fnnas.com>
References: <20251223011802.31238-1-yi.zhang@huaweicloud.com>
 <20251223011802.31238-2-yi.zhang@huaweicloud.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20251223011802.31238-2-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-12-23 09:17, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
>
> When performing buffered writes, we may need to split and convert an
> unwritten extent into a written one during the end I/O process. However,
> we do not reserve space specifically for these metadata changes, we only
> reserve 2% of space or 4096 blocks. To address this, we use
> EXT4_GET_BLOCKS_PRE_IO to potentially split extents in advance and
> EXT4_GET_BLOCKS_METADATA_NOFAIL to utilize reserved space if necessary.
>
> These two approaches can reduce the likelihood of running out of space
> and losing data. However, these methods are merely best efforts, we
> could still run out of space, and there is not much difference between
> converting an extent during the writeback process and the end I/O
> process, it won't increase the rick of losing data if we postpone the
> conversion.
>
> Therefore, also use EXT4_GET_BLOCKS_METADATA_NOFAIL in
> ext4_convert_unwritten_extents_endio() to prepare for the buffered I/O
> iomap conversion, which may perform extent conversion during the end I/O
> process.
>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Fair point, that is consistent with how
ext4_ext_handle_unwritten_extents() handles it.

Reviewed-by: Baokun Li <libaokun1@huawei.com>

> ---
>  fs/ext4/extents.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 27eb2c1df012..e53959120b04 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3794,6 +3794,8 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
>  	 * illegal.
>  	 */
>  	if (ee_block != map->m_lblk || ee_len > map->m_len) {
> +		int flags = EXT4_GET_BLOCKS_CONVERT |
> +			    EXT4_GET_BLOCKS_METADATA_NOFAIL;
>  #ifdef CONFIG_EXT4_DEBUG
>  		ext4_warning(inode->i_sb, "Inode (%ld) finished: extent logical block %llu,"
>  			     " len %u; IO logical block %llu, len %u",
> @@ -3801,7 +3803,7 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
>  			     (unsigned long long)map->m_lblk, map->m_len);
>  #endif
>  		path = ext4_split_convert_extents(handle, inode, map, path,
> -						EXT4_GET_BLOCKS_CONVERT, NULL);
> +						  flags, NULL);
>  		if (IS_ERR(path))
>  			return path;
>  



