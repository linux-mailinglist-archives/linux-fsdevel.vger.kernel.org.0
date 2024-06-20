Return-Path: <linux-fsdevel+bounces-21952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE185910364
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 13:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC97281B13
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 11:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855521ABCBC;
	Thu, 20 Jun 2024 11:50:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB6F157E84;
	Thu, 20 Jun 2024 11:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718884245; cv=none; b=siYSwH60frAh7VxFuaPDWi7+LSeN/6kAzk1AYsoyE8sfXQa9s5cJ9jZFbeczyXB1Pq18rnOMVUTospfPK85TgpGhKa2bcFztJ6PZGyOLeD35E7Kfm37PIYfd/L5El7EyRCRylUsXD515qa0fvqeZo7pith/JdQP04ChnuPQR7ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718884245; c=relaxed/simple;
	bh=1h3Pr+5WfTNEzig2akkELyh2jILavy32RSE95/pIHfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ia09mE6Oh3TYYLCw7JqCj+CS39d46dI1Yx+HMEe12v8ToiEWGiblh6LTZV++Vm25hL9WD7tls25cE///xEIxCrUNEDdXz1yew0XdKNQe1bnXL9EukSXmggjrd607AWn9KmMCGEttRRq4IRAmKLWmK4z0Z2tSNCAOOdddiF1NqJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W4f0N0tJJzdcfk;
	Thu, 20 Jun 2024 19:49:08 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 3EBC61808CC;
	Thu, 20 Jun 2024 19:50:39 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 19:50:39 +0800
Message-ID: <ef67511b-785e-49f8-8897-a6570d9424da@huawei.com>
Date: Thu, 20 Jun 2024 19:50:38 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hugetlbfs: use tracepoints in hugetlbfs functions.
Content-Language: en-US
To: <muchun.song@linux.dev>, <rostedt@goodmis.org>, <mhiramat@kernel.org>
CC: <mathieu.desnoyers@efficios.com>, <linux-mm@kvack.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <20240612011156.2891254-1-lihongbo22@huawei.com>
 <20240612011156.2891254-3-lihongbo22@huawei.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20240612011156.2891254-3-lihongbo22@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Just a friendly ping to the patch :)

https://lore.kernel.org/all/20240612011156.2891254-1-lihongbo22@huawei.com/

Thanks,
Hongbo

On 2024/6/12 9:11, Hongbo Li wrote:
> Here we use the hugetlbfs tracepoint to track the call stack. And
> the output in trace is as follows:
> 
> ```
> touch-5307    [004] .....  1402.167607: hugetlbfs_alloc_inode: dev = (0,50), ino = 21380, dir = 16921, mode = 0100644
> touch-5307    [004] .....  1402.167638: hugetlbfs_setattr: dev = (0,50), ino = 21380, name = testfile1, ia_valid = 131184, ia_mode = 0132434, ia_uid = 2863018275, ia_gid = 4294967295, old_size = 0, ia_size = 4064
> truncate-5328    [003] .....  1436.031054: hugetlbfs_setattr: dev = (0,50), ino = 21380, name = testfile1, ia_valid = 8296, ia_mode = 0177777, ia_uid = 2862574544, ia_gid = 4294967295, old_size = 0, ia_size = 2097152
> rm-5338    [004] .....  1484.426247: hugetlbfs_evict_inode: dev = (0,50), ino = 21380, i_mode = 0100644, i_size = 2097152, i_nlink = 0, seals = 1, i_blocks = 0
> <idle>-0       [004] ..s1.  1484.446668: hugetlbfs_free_inode: dev = (0,50), ino = 21380, i_mode = 0100644, i_size = 2097152, i_nlink = 0, seals = 1, i_blocks = 0
> ```
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   fs/hugetlbfs/inode.c | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 412f295acebe..f3399c6a02ca 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -39,6 +39,9 @@
>   #include <linux/uaccess.h>
>   #include <linux/sched/mm.h>
>   
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/hugetlbfs.h>
> +
>   static const struct address_space_operations hugetlbfs_aops;
>   static const struct file_operations hugetlbfs_file_operations;
>   static const struct inode_operations hugetlbfs_dir_inode_operations;
> @@ -686,6 +689,7 @@ static void hugetlbfs_evict_inode(struct inode *inode)
>   {
>   	struct resv_map *resv_map;
>   
> +	trace_hugetlbfs_evict_inode(inode);
>   	remove_inode_hugepages(inode, 0, LLONG_MAX);
>   
>   	/*
> @@ -813,8 +817,10 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>   	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
>   		return -EOPNOTSUPP;
>   
> -	if (mode & FALLOC_FL_PUNCH_HOLE)
> -		return hugetlbfs_punch_hole(inode, offset, len);
> +	if (mode & FALLOC_FL_PUNCH_HOLE) {
> +		error = hugetlbfs_punch_hole(inode, offset, len);
> +		goto out_nolock;
> +	}
>   
>   	/*
>   	 * Default preallocate case.
> @@ -918,6 +924,9 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>   	inode_set_ctime_current(inode);
>   out:
>   	inode_unlock(inode);
> +
> +out_nolock:
> +	trace_hugetlbfs_fallocate(inode, mode, offset, len, error);
>   	return error;
>   }
>   
> @@ -934,6 +943,12 @@ static int hugetlbfs_setattr(struct mnt_idmap *idmap,
>   	if (error)
>   		return error;
>   
> +	trace_hugetlbfs_setattr(inode, dentry->d_name.len, dentry->d_name.name,
> +			attr->ia_valid, attr->ia_mode,
> +			from_kuid(&init_user_ns, attr->ia_uid),
> +			from_kgid(&init_user_ns, attr->ia_gid),
> +			inode->i_size, attr->ia_size);
> +
>   	if (ia_valid & ATTR_SIZE) {
>   		loff_t oldsize = inode->i_size;
>   		loff_t newsize = attr->ia_size;
> @@ -1032,6 +1047,7 @@ static struct inode *hugetlbfs_get_inode(struct super_block *sb,
>   			break;
>   		}
>   		lockdep_annotate_inode_mutex_key(inode);
> +		trace_hugetlbfs_alloc_inode(inode, dir, mode);
>   	} else {
>   		if (resv_map)
>   			kref_put(&resv_map->refs, resv_map_release);
> @@ -1274,6 +1290,7 @@ static struct inode *hugetlbfs_alloc_inode(struct super_block *sb)
>   
>   static void hugetlbfs_free_inode(struct inode *inode)
>   {
> +	trace_hugetlbfs_free_inode(inode);
>   	kmem_cache_free(hugetlbfs_inode_cachep, HUGETLBFS_I(inode));
>   }
>   

