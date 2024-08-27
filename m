Return-Path: <linux-fsdevel+bounces-27264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4774995FE8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 03:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004E4281C9A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 01:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5895EBA49;
	Tue, 27 Aug 2024 01:55:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1992D9463;
	Tue, 27 Aug 2024 01:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724723726; cv=none; b=i574Z+GT5A/+CWxYgCg/9QvSeT/r0jAeytLwxIDsRMb1kfX1bfyFisCmi1wGG4odriVbqAyDBGmBFTcTQdK0fCVwElZhRqdKZcoGuryPNWc9tRwL+Ci401FWuQjV2mxi/O77Ghzjv8S1VNkBhQQdN2gUNadlw9iMy/lDLxlHtKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724723726; c=relaxed/simple;
	bh=tXLxGXjEZTqcUiNwTZEIRddkthJ7uvs+qtXA8PjI5p4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CaMn6vL5tIGUlYY2D3bf75tl0A0WCHTTUZnAp6HEcTi2wefY3kFMz+G0zetADEbIJAfJ9OywWyj1CBudLSCSTsL7+MK4BMKC4a1dTHZX5lLTevDycArAOrfdEtOx3Y/mv9Oeiof1NoAwsaJHfg4P8i65/ulhwaMnI3EcIYrokUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wt9VJ3f9mz20mrB;
	Tue, 27 Aug 2024 09:50:32 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 57C45140154;
	Tue, 27 Aug 2024 09:55:20 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 09:55:20 +0800
Message-ID: <e313ee9f-54fc-44c0-887d-612121f7b088@huawei.com>
Date: Tue, 27 Aug 2024 09:55:19 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] nilfs2: support STATX_DIOALIGN for statx file
To: <konishi.ryusuke@gmail.com>
CC: <linux-nilfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <20240827020029.620357-1-lihongbo22@huawei.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20240827020029.620357-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Sorry, I send the wrong patch, just ignore this.

On 2024/8/27 10:00, Hongbo Li wrote:
> Add support for STATX_DIOALIGN to nilfs2, so that direct I/O alignment
> restrictions are exposed to userspace in a generic way.
> 
> By default, nilfs2 uses the default getattr implemented at vfs layer,
> so we should implement getattr in nilfs2 to fill the dio_xx_align
> members. We have done the following test:
> 
> [Before]
> ```
> ./statx_test /mnt/nilfs2/testfile
> statx(/mnt/nilfs2/test) = 0
> dio mem align:0
> dio offset align:0
> ```
> 
> [After]
> ```
> ./statx_test /mnt/nilfs2/test
> statx(/mnt/nilfs2/test) = 0
> dio mem align:512
> dio offset align:512
> ```
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   fs/nilfs2/file.c  |  1 +
>   fs/nilfs2/inode.c | 20 ++++++++++++++++++++
>   fs/nilfs2/namei.c |  2 ++
>   fs/nilfs2/nilfs.h |  2 ++
>   4 files changed, 25 insertions(+)
> 
> diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
> index 0e3fc5ba33c7..5528918d4b96 100644
> --- a/fs/nilfs2/file.c
> +++ b/fs/nilfs2/file.c
> @@ -154,6 +154,7 @@ const struct file_operations nilfs_file_operations = {
>   
>   const struct inode_operations nilfs_file_inode_operations = {
>   	.setattr	= nilfs_setattr,
> +	.getattr	= nilfs_getattr,
>   	.permission     = nilfs_permission,
>   	.fiemap		= nilfs_fiemap,
>   	.fileattr_get	= nilfs_fileattr_get,
> diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
> index 7340a01d80e1..7bf062793642 100644
> --- a/fs/nilfs2/inode.c
> +++ b/fs/nilfs2/inode.c
> @@ -1001,6 +1001,26 @@ int nilfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>   	return err;
>   }
>   
> +int nilfs_getattr(struct mnt_idmap *idmap, const struct path *path,
> +			struct kstat *stat, u3 request_mask, unsigned int query_flags)
> +{
> +	struct inode *const inode = d_inode(path->dentry);
> +	struct block_device *bdev = inode->i_sb->s_bdev;
> +	unsigned int blksize = (1 << inode->i_blkbits);
> +
> +	if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode)) {
> +		stat->result_mask |= STATX_DIOALIGN;
> +
> +		if (bdev)
> +			blksize = bdev_logical_block_size(bdev);
> +		stat->dio_mem_align = blksize;
> +		stat->dio_offset_align = blksize;
> +	}
> +
> +	generic_fillattr(idmap, request_mask, inode, stat);
> +	return 0;
> +}
> +
>   int nilfs_permission(struct mnt_idmap *idmap, struct inode *inode,
>   		     int mask)
>   {
> diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
> index c950139db6ef..ad56f4f8be1f 100644
> --- a/fs/nilfs2/namei.c
> +++ b/fs/nilfs2/namei.c
> @@ -546,6 +546,7 @@ const struct inode_operations nilfs_dir_inode_operations = {
>   	.mknod		= nilfs_mknod,
>   	.rename		= nilfs_rename,
>   	.setattr	= nilfs_setattr,
> +	.getattr	= nilfs_getattr,
>   	.permission	= nilfs_permission,
>   	.fiemap		= nilfs_fiemap,
>   	.fileattr_get	= nilfs_fileattr_get,
> @@ -554,6 +555,7 @@ const struct inode_operations nilfs_dir_inode_operations = {
>   
>   const struct inode_operations nilfs_special_inode_operations = {
>   	.setattr	= nilfs_setattr,
> +	.getattr	= nilfs_getattr,
>   	.permission	= nilfs_permission,
>   };
>   
> diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
> index 4017f7856440..c2182bb660bf 100644
> --- a/fs/nilfs2/nilfs.h
> +++ b/fs/nilfs2/nilfs.h
> @@ -280,6 +280,8 @@ extern void nilfs_truncate(struct inode *);
>   extern void nilfs_evict_inode(struct inode *);
>   extern int nilfs_setattr(struct mnt_idmap *, struct dentry *,
>   			 struct iattr *);
> +extern int nilfs_getattr(struct mnt_idmap *idmap, const struct path *path,
> +			struct kstat *stat, u3 request_mask, unsigned int query_flags);
>   extern void nilfs_write_failed(struct address_space *mapping, loff_t to);
>   int nilfs_permission(struct mnt_idmap *idmap, struct inode *inode,
>   		     int mask);

