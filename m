Return-Path: <linux-fsdevel+bounces-72274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E2CCEB770
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 08:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D40D301F01D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 07:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C512E091D;
	Wed, 31 Dec 2025 07:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Pi9XuF0c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7692AE70;
	Wed, 31 Dec 2025 07:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767167188; cv=none; b=julOi0zUQDfFVMuuDSxbiV26+L4JlQZnVdYFDUiFD8gWHi9r2/6bMB8UHwIDcclKuqZYPnLO+7rV9yiPN9+BS2SF3krCeA9wNWw/458HoFNAUQnHg19rGKbx0KboMwJMNUmVWXPmT69czmFOzo/wsUpZ/UmOEO0rocke2GbVDs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767167188; c=relaxed/simple;
	bh=iBkZD85chhanwQQuFMd9eUoiCLSqRMuvLdnJo9O3Ers=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g4KgRToX8GlsOHisR5NL7UOj45+43PbxD6nbVqKJ7r2JsJ0QGgOeJYTsXMh3lkg/RNBbjL6H/mdnsmNmwt5abVV47aBdV1HNXpCIdSkWPEia/8XTcMGezSD3/eAujGUISU452mmZdKIsMj9yl6bKBZ8eK0CO5LPoV9m6H63BRkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Pi9XuF0c; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Pee7Hdi+CKtfsyuR4wU0ELvYZgSYce+bDuxyAadhdbQ=;
	b=Pi9XuF0c64/Bth/M6Z/sQMUrmuddu9FxT5m0qUfXrXWrlU9Pty4d4aXtswOKdglcDJqy/JRRU
	00dhfRjdBE+WW8GKGcTl3omeHnJumKZM14/SOghtD1pO/aben3EDZAKBjlXyc3TWrtE06uODrVF
	XQ4bvQxDhjXmAfraIyv67E4=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dh24V1BHWz1cySN;
	Wed, 31 Dec 2025 15:43:06 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id C9CE640538;
	Wed, 31 Dec 2025 15:46:16 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 31 Dec
 2025 15:46:15 +0800
Message-ID: <65ffdc21-1f94-428c-be06-f81c87f019bc@huawei.com>
Date: Wed, 31 Dec 2025 15:46:14 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 6/7] ext4: simply the mapping query logic in
 ext4_iomap_begin()
Content-Language: en-GB
To: Zhang Yi <yi.zhang@huaweicloud.com>, <linux-ext4@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ojaswin@linux.ibm.com>, <ritesh.list@gmail.com>, <yi.zhang@huawei.com>,
	<yizhang089@gmail.com>, <yangerkun@huawei.com>, <yukuai@fnnas.com>
References: <20251223011802.31238-1-yi.zhang@huaweicloud.com>
 <20251223011802.31238-7-yi.zhang@huaweicloud.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20251223011802.31238-7-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-12-23 09:18, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
>
> In the write path mapping check of ext4_iomap_begin(), the return value
> 'ret' should never greater than orig_mlen. If 'ret' equals 'orig_mlen',
> it can be returned directly without checking IOMAP_ATOMIC.
>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Looks good. Feel free to add:

Reviewed-by: Baokun Li <libaokun1@huawei.com>

> ---
>  fs/ext4/inode.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index b84a2a10dfb8..67fe7d0f47e3 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3816,17 +3816,19 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  		if (offset + length <= i_size_read(inode)) {
>  			ret = ext4_map_blocks(NULL, inode, &map, 0);
>  			/*
> -			 * For atomic writes the entire requested length should
> -			 * be mapped. For DAX we convert extents to initialized
> -			 * ones before copying the data, otherwise we do it
> -			 * after I/O so there's no need to call into
> -			 * ext4_iomap_alloc().
> +			 * For DAX we convert extents to initialized ones before
> +			 * copying the data, otherwise we do it after I/O so
> +			 * there's no need to call into ext4_iomap_alloc().
>  			 */
>  			if ((map.m_flags & EXT4_MAP_MAPPED) ||
>  			    (!(flags & IOMAP_DAX) &&
>  			     (map.m_flags & EXT4_MAP_UNWRITTEN))) {
> -				if ((!(flags & IOMAP_ATOMIC) && ret > 0) ||
> -				   (flags & IOMAP_ATOMIC && ret >= orig_mlen))
> +				/*
> +				 * For atomic writes the entire requested
> +				 * length should be mapped.
> +				 */
> +				if (ret == orig_mlen ||
> +				    (!(flags & IOMAP_ATOMIC) && ret > 0))
>  					goto out;
>  			}
>  			map.m_len = orig_mlen;



