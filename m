Return-Path: <linux-fsdevel+bounces-72271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3692ECEB752
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 08:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36D74301F7F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 07:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391D03115B8;
	Wed, 31 Dec 2025 07:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="a+NNmr8q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A7A23ABBF;
	Wed, 31 Dec 2025 07:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767166612; cv=none; b=GDlaJ5sgxudTxqHQqi4wZ1HzSZRDoDPfe9yIKcSzz/uwjWAaQ0ZkMDDmli18BTZvh701ZCybLgZFlnTf3ArC9wUuE02xWWRKAEW19h9btRgPA/NXukWR0PCMBH/SjEiLxUBc39Vx1818vB25PjDkPHwYjjZx3FUX1YsvAweppk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767166612; c=relaxed/simple;
	bh=N1eJtC57Fim+yGDHebA8rs/xgTOVLusgpvJtWsGadJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OAO8c/MOT6ZC8vYRwNVu2bQKBpXdlvRTDqPPj3MAaRXBZDO27w9oqOIizPgA4mpQ/Qu45ZiBh2dmZLBnc5aqeYxpssNkn1guaStN4M3Ji0naqTPXxjTeFKwtG9MQrbY4F2ag9d46vI+Fh7SPKxeZdn2WQ6s3E3ZZmLWW644NFfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=a+NNmr8q; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6kE9Wcr5b/hMrQ+fMS1t90/if7rA3w6ERN/8FpshvNU=;
	b=a+NNmr8qodwUptXTLPGowXSOm157hROqA/Hp9WxjTPmSmJVl8IyObgXiZB1FAyUfkXW0fxnuV
	o9CW9KD5CpXYCOjg25mD/F2oZUSkZQd1wcYjWEzxpM2+LQu3OiLbTLVO4qvfbch+jyYMxYIFZy7
	hNFAW4WlkFUFR5f8s4fx6L0=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dh1sb0K3xz12LDq;
	Wed, 31 Dec 2025 15:33:39 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 6D3FF40363;
	Wed, 31 Dec 2025 15:36:47 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 31 Dec
 2025 15:36:46 +0800
Message-ID: <ce05b3bb-2418-4348-a9c4-115cd7ea7223@huawei.com>
Date: Wed, 31 Dec 2025 15:36:45 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 3/7] ext4: avoid starting handle when dio writing
 an unwritten extent
Content-Language: en-GB
To: Zhang Yi <yi.zhang@huaweicloud.com>, <linux-ext4@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ojaswin@linux.ibm.com>, <ritesh.list@gmail.com>, <yi.zhang@huawei.com>,
	<yizhang089@gmail.com>, <yangerkun@huawei.com>, <yukuai@fnnas.com>
References: <20251223011802.31238-1-yi.zhang@huaweicloud.com>
 <20251223011802.31238-4-yi.zhang@huaweicloud.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20251223011802.31238-4-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-12-23 09:17, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
>
> Since we have deferred the split of the unwritten extent until after I/O
> completion, it is not necessary to initiate the journal handle when
> submitting the I/O.
>
> This can improve the write performance of concurrent DIO for multiple
> files. The fio tests below show a ~25% performance improvement when
> wirting to unwritten files on my VM with a mem disk.
>
>   [unwritten]
>   direct=1
>   ioengine=psync
>   numjobs=16
>   rw=write     # write/randwrite
>   bs=4K
>   iodepth=1
>   directory=/mnt
>   size=5G
>   runtime=30s
>   overwrite=0
>   norandommap=1
>   fallocate=native
>   ramp_time=5s
>   group_reporting=1
>
>  [w/o]
>   w:  IOPS=62.5k, BW=244MiB/s
>   rw: IOPS=56.7k, BW=221MiB/s
>
>  [w]
>   w:  IOPS=79.6k, BW=311MiB/s
>   rw: IOPS=70.2k, BW=274MiB/s
>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Looks good. Feel free to add:

Reviewed-by: Baokun Li <libaokun1@huawei.com>

> ---
>  fs/ext4/file.c  | 4 +---
>  fs/ext4/inode.c | 9 +++++++--
>  2 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 7a8b30932189..9f571acc7782 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -418,9 +418,7 @@ static const struct iomap_dio_ops ext4_dio_write_ops = {
>   *   updating inode i_disksize and/or orphan handling with exclusive lock.
>   *
>   * - shared locking will only be true mostly with overwrites, including
> - *   initialized blocks and unwritten blocks. For overwrite unwritten blocks
> - *   we protect splitting extents by i_data_sem in ext4_inode_info, so we can
> - *   also release exclusive i_rwsem lock.
> + *   initialized blocks and unwritten blocks.
>   *
>   * - Otherwise we will switch to exclusive i_rwsem lock.
>   */
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index ffde24ff7347..ff3ad1a2df45 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3817,9 +3817,14 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  			ret = ext4_map_blocks(NULL, inode, &map, 0);
>  			/*
>  			 * For atomic writes the entire requested length should
> -			 * be mapped.
> +			 * be mapped. For DAX we convert extents to initialized
> +			 * ones before copying the data, otherwise we do it
> +			 * after I/O so there's no need to call into
> +			 * ext4_iomap_alloc().
>  			 */
> -			if (map.m_flags & EXT4_MAP_MAPPED) {
> +			if ((map.m_flags & EXT4_MAP_MAPPED) ||
> +			    (!(flags & IOMAP_DAX) &&
> +			     (map.m_flags & EXT4_MAP_UNWRITTEN))) {
>  				if ((!(flags & IOMAP_ATOMIC) && ret > 0) ||
>  				   (flags & IOMAP_ATOMIC && ret >= orig_mlen))
>  					goto out;



