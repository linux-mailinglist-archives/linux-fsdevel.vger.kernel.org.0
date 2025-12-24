Return-Path: <linux-fsdevel+bounces-72025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C369BCDB54D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 05:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B4873089ABC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 04:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3397D329C73;
	Wed, 24 Dec 2025 04:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VkfLPkl7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB98B329C57;
	Wed, 24 Dec 2025 04:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766550359; cv=none; b=tE2rd7w9zCHy3X3uThY1lb3QasOb6nz9cKUCiKcKdHNyxcshMgPL0Z8sIZoAvKtgaOEPML53T/63UXaHik2I3D41qzkHc6V/J9yWOintHhwNyFNeNCY0ZXqIDoz8tUtCswDoo3O2D+/1sDBkRjUWEiwFTZpS49KyxDedjaTLYr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766550359; c=relaxed/simple;
	bh=qPBt9Zns8J4vAABRmGJrkmBah5cEQEorCZCgDfJgFV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aXan20RB2q3Ht3DzXz5H468RqdIu63sl1feC4eZ612/yA67h0dM00hlDQGnlJqa0vaV1KnkKff3XPGZGqlWl3aWtyojr2SqS1nTwqRkZy1LufYgM4Te6Xbg7ODrweMNg1PY7Tr9ezeu0mZKBuL/kQToutbOBuq1PB/+cWCUgH0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VkfLPkl7; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766550350; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=KBK63GOTpwsyi+9/TViMKjqeqT7DORlU7E0BXR5JHBo=;
	b=VkfLPkl7UGrCdwUQdbsOXMhfUb6lM52TOF9j1xK6IV2AAB71Xz2Mh9gs8sfl59wsJcp30tnv1PY+QraNCASOzHavjGl/kecpR3FxFe9bc18cbkD9ZrfIcoVkC6p1yFvoxFKsEln6Nlph/rQi8kL6nclNIK0EBlSuaIvJ90PC0Wc=
Received: from 30.221.133.159(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvZpwLY_1766550349 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 24 Dec 2025 12:25:49 +0800
Message-ID: <0081b97d-4b46-4b20-9d23-18d9642881cf@linux.alibaba.com>
Date: Wed, 24 Dec 2025 12:25:48 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 04/10] erofs: move `struct erofs_anon_fs_type` to
 super.c
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, Amir Goldstein <amir73il@gmail.com>, hch@lst.de
References: <20251224040932.496478-1-lihongbo22@huawei.com>
 <20251224040932.496478-5-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251224040932.496478-5-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/12/24 12:09, Hongbo Li wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Move the `struct erofs_anon_fs_type` to the super.c and
> expose it in preparation for the upcoming page cache share
> feature.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Are you sure this is my previous version of this one?

Could you please check carefully before sending
out the next version?

Thanks,
Gao Xiang

> ---
>   fs/erofs/fscache.c  | 13 -------------
>   fs/erofs/internal.h |  2 ++
>   fs/erofs/super.c    | 15 +++++++++++++++
>   3 files changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 7a346e20f7b7..f4937b025038 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2022, Alibaba Cloud
>    * Copyright (C) 2022, Bytedance Inc. All rights reserved.
>    */
> -#include <linux/pseudo_fs.h>
>   #include <linux/fscache.h>
>   #include "internal.h"
>   
> @@ -13,18 +12,6 @@ static LIST_HEAD(erofs_domain_list);
>   static LIST_HEAD(erofs_domain_cookies_list);
>   static struct vfsmount *erofs_pseudo_mnt;
>   
> -static int erofs_anon_init_fs_context(struct fs_context *fc)
> -{
> -	return init_pseudo(fc, EROFS_SUPER_MAGIC) ? 0 : -ENOMEM;
> -}
> -
> -static struct file_system_type erofs_anon_fs_type = {
> -	.owner		= THIS_MODULE,
> -	.name           = "pseudo_erofs",
> -	.init_fs_context = erofs_anon_init_fs_context,
> -	.kill_sb        = kill_anon_super,
> -};
> -
>   struct erofs_fscache_io {
>   	struct netfs_cache_resources cres;
>   	struct iov_iter		iter;
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index f7f622836198..98fe652aea33 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -188,6 +188,8 @@ static inline bool erofs_is_fileio_mode(struct erofs_sb_info *sbi)
>   	return IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && sbi->dif0.file;
>   }
>   
> +extern struct file_system_type erofs_anon_fs_type;
> +
>   static inline bool erofs_is_fscache_mode(struct super_block *sb)
>   {
>   	return IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) &&
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 937a215f626c..2a44c4e5af4f 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -11,6 +11,7 @@
>   #include <linux/fs_parser.h>
>   #include <linux/exportfs.h>
>   #include <linux/backing-dev.h>
> +#include <linux/pseudo_fs.h>
>   #include "xattr.h"
>   
>   #define CREATE_TRACE_POINTS
> @@ -936,6 +937,20 @@ static struct file_system_type erofs_fs_type = {
>   };
>   MODULE_ALIAS_FS("erofs");
>   
> +#if defined(CONFIG_EROFS_FS_ONDEMAND)
> +static int erofs_anon_init_fs_context(struct fs_context *fc)
> +{
> +	return init_pseudo(fc, EROFS_SUPER_MAGIC) ? 0 : -ENOMEM;
> +}
> +
> +struct file_system_type erofs_anon_fs_type = {
> +	.owner		= THIS_MODULE,
> +	.name           = "pseudo_erofs",
> +	.init_fs_context = erofs_anon_init_fs_context,
> +	.kill_sb        = kill_anon_super,
> +};
> +#endif
> +
>   static int __init erofs_module_init(void)
>   {
>   	int err;


