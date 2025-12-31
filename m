Return-Path: <linux-fsdevel+bounces-72272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A58ACEB75B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 08:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E7DD301F3FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 07:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609A9311C33;
	Wed, 31 Dec 2025 07:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="bzem3fQp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C77F23ABBF;
	Wed, 31 Dec 2025 07:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767166820; cv=none; b=nNtqaaoH9oUdxyGBS9FfahPzuKQ8Vt7hLxG4eratUb8XNzWt4WkFC32LICu9KzWKfswQ0Me+OqtYamm/bVUeIy8OWB0jlccJNw49dvu4Hk7HHOvxXM1bPhH5i+ivRRZLtIo8HZ8KVm5Aw3qZYYO0KIhPvZPjzOHzgkUTOVKGSS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767166820; c=relaxed/simple;
	bh=sDJP+HgYr0xrYW31EykPOOrha1WFC8vE7kGinmtzXfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aL5lVc/neQo7WFMhFUVK/izqiJe6X9k417i+wh8J4NQI6ughyfxEboL2Q7gMhE8Dptr/0nfixSzxZjOBnAI9N7AwPVvz9gF5sStC273UZuwYpktEpwF4v5A/gg9jdrmQsu2XTAUIcfCtc7Vq1C6BAoTOp0FifHFqNAsh9tZG7q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=bzem3fQp; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=tGFPittuG6mWd/JRuKOdMr1zpd8UOWY7sQpef4+EwpE=;
	b=bzem3fQptYPSKqCPuYQu8qhs67k4vKJko0vvlAAHE0E8htFQbclmYcbiAH5akg3RAG32Eb7le
	yLPjJ6qRUfYaszg6VhZvichcBB9oc2Ywv6y8SyGop6wvKttxZCGm5jHQk1cOx9Uoqoeb4SLqsMC
	r9Ixe5limdXpAkD8vwVLubk=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dh1xY0Dn5znTZx;
	Wed, 31 Dec 2025 15:37:05 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 6D1F340538;
	Wed, 31 Dec 2025 15:40:13 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 31 Dec
 2025 15:40:12 +0800
Message-ID: <f290e8d7-a382-4164-a87f-731682076100@huawei.com>
Date: Wed, 31 Dec 2025 15:40:11 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 4/7] ext4: remove useless
 ext4_iomap_overwrite_ops
Content-Language: en-GB
To: Zhang Yi <yi.zhang@huaweicloud.com>, <linux-ext4@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ojaswin@linux.ibm.com>, <ritesh.list@gmail.com>, <yi.zhang@huawei.com>,
	<yizhang089@gmail.com>, <yangerkun@huawei.com>, <yukuai@fnnas.com>
References: <20251223011802.31238-1-yi.zhang@huaweicloud.com>
 <20251223011802.31238-5-yi.zhang@huaweicloud.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20251223011802.31238-5-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-12-23 09:17, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
>
> ext4_iomap_overwrite_ops was introduced in commit 8cd115bdda17 ("ext4:
> Optimize ext4 DIO overwrites"), which can optimize pure overwrite
> performance by dropping the IOMAP_WRITE flag to only query the mapped
> mapping information. This avoids starting a new journal handle, thereby
> improving speed. Later, commit 9faac62d4013 ("ext4: optimize file
> overwrites") also optimized similar scenarios, but it performs the check
> later, examining the mappings status only when the actual block mapping
> is needed. Thus, it can handle the previous commit scenario. That means
> in the case of an overwrite scenario, the condition
> "offset + length <= i_size_read(inode)" in the write path must always be
> true.
>
> Therefore, it is acceptable to remove the ext4_iomap_overwrite_ops,
> which will also clarify the write and read paths of ext4_iomap_begin.
>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Nice cleanup! Feel free to add:

Reviewed-by: Baokun Li <libaokun1@huawei.com>

> ---
>  fs/ext4/ext4.h  |  1 -
>  fs/ext4/file.c  |  5 +----
>  fs/ext4/inode.c | 24 ------------------------
>  3 files changed, 1 insertion(+), 29 deletions(-)
>
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 56112f201cac..9a71357f192d 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3909,7 +3909,6 @@ static inline void ext4_clear_io_unwritten_flag(ext4_io_end_t *io_end)
>  }
>  
>  extern const struct iomap_ops ext4_iomap_ops;
> -extern const struct iomap_ops ext4_iomap_overwrite_ops;
>  extern const struct iomap_ops ext4_iomap_report_ops;
>  
>  static inline int ext4_buffer_uptodate(struct buffer_head *bh)
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 9f571acc7782..6b4b68f830d5 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -506,7 +506,6 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	struct inode *inode = file_inode(iocb->ki_filp);
>  	loff_t offset = iocb->ki_pos;
>  	size_t count = iov_iter_count(from);
> -	const struct iomap_ops *iomap_ops = &ext4_iomap_ops;
>  	bool extend = false, unwritten = false;
>  	bool ilock_shared = true;
>  	int dio_flags = 0;
> @@ -573,9 +572,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  			goto out;
>  	}
>  
> -	if (ilock_shared && !unwritten)
> -		iomap_ops = &ext4_iomap_overwrite_ops;
> -	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
> +	ret = iomap_dio_rw(iocb, from, &ext4_iomap_ops, &ext4_dio_write_ops,
>  			   dio_flags, NULL, 0);
>  	if (ret == -ENOTBLK)
>  		ret = 0;
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index ff3ad1a2df45..b84a2a10dfb8 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3833,10 +3833,6 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  		}
>  		ret = ext4_iomap_alloc(inode, &map, flags);
>  	} else {
> -		/*
> -		 * This can be called for overwrites path from
> -		 * ext4_iomap_overwrite_begin().
> -		 */
>  		ret = ext4_map_blocks(NULL, inode, &map, 0);
>  	}
>  
> @@ -3865,30 +3861,10 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  	return 0;
>  }
>  
> -static int ext4_iomap_overwrite_begin(struct inode *inode, loff_t offset,
> -		loff_t length, unsigned flags, struct iomap *iomap,
> -		struct iomap *srcmap)
> -{
> -	int ret;
> -
> -	/*
> -	 * Even for writes we don't need to allocate blocks, so just pretend
> -	 * we are reading to save overhead of starting a transaction.
> -	 */
> -	flags &= ~IOMAP_WRITE;
> -	ret = ext4_iomap_begin(inode, offset, length, flags, iomap, srcmap);
> -	WARN_ON_ONCE(!ret && iomap->type != IOMAP_MAPPED);
> -	return ret;
> -}
> -
>  const struct iomap_ops ext4_iomap_ops = {
>  	.iomap_begin		= ext4_iomap_begin,
>  };
>  
> -const struct iomap_ops ext4_iomap_overwrite_ops = {
> -	.iomap_begin		= ext4_iomap_overwrite_begin,
> -};
> -
>  static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
>  				   loff_t length, unsigned int flags,
>  				   struct iomap *iomap, struct iomap *srcmap)



