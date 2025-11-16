Return-Path: <linux-fsdevel+bounces-68610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE60C61457
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 13:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CE11D361913
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 12:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE51283FEA;
	Sun, 16 Nov 2025 12:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JrSOnihJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1459F23BCF7;
	Sun, 16 Nov 2025 12:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763294586; cv=none; b=jKE/FGKpjr3GRL1KOkm9I/3hWgPkXurL/3TU7kDTOj3V0P1/85J9vEg9mZKtWmBmXImattxixrnL2mxlYSpg/eZfOX9BfW7x/X4cRND15lJ+RoWZfmSz8c/cZRt3jHMjvg1Fhf0XTzlnWGZ7aZE2bhKCiFh9e8TyxSDsY66pT6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763294586; c=relaxed/simple;
	bh=z2xHlz7Bqkcbsmlgrx36Yx5IpgPfrYpXgnChuylUcUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O+L9gUWXYYbeodvXBSSA9rcQIz8wCUNCu9BduiithWafN5ehUY53nx0OjkOvTpF0omuejAB41vdtmALkuVp7Rz7DG51XJv2VykowB4XBH/c9A6m2Jok77nLYfFX4rgQZt9GOit5lT3KXOToVaCi2D29uZtHBavHPQwmD7WAUwO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JrSOnihJ; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763294576; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5zy7VPYvOOZ59Lo31U8JdU6iYnEW1IWMTLcUa7/0tfY=;
	b=JrSOnihJ44wZ+rvsfMy/JwL0lvl1dqWXZi5gqFINMdIL0NEHQa7yh9qQ59VEJm8dfy65mNT734uf74jESLNGAerkxc63H9CK9ulYoqFPSPPClBjpDAZd6yyl61E2Ef3GXs7AJJLKw31+kutreOj9/tOp8aFbHhPqFR7zWYJbMls=
Received: from 30.170.196.81(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WsSK0Ws_1763294575 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 16 Nov 2025 20:02:55 +0800
Message-ID: <3f7e3106-8ad3-46b5-ae88-3de5c6773df1@linux.alibaba.com>
Date: Sun, 16 Nov 2025 20:02:55 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/9] erofs: move `struct erofs_anon_fs_type` to super.c
To: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org,
 djwong@kernel.org, amir73il@gmail.com, joannelkoong@gmail.com
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20251114095516.207555-1-lihongbo22@huawei.com>
 <20251114095516.207555-4-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251114095516.207555-4-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/11/14 17:55, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> Move the `struct erofs_anon_fs_type` to the super.c and
> expose it in preparation for the upcoming page cache share
> feature.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   fs/erofs/fscache.c  | 13 -------------
>   fs/erofs/internal.h |  4 ++++
>   fs/erofs/super.c    | 15 +++++++++++++++
>   3 files changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 362acf828279..2d1683479fc0 100644
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
> index f7f622836198..e80b35db18e4 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -188,6 +188,10 @@ static inline bool erofs_is_fileio_mode(struct erofs_sb_info *sbi)
>   	return IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && sbi->dif0.file;
>   }
>   
> +#if defined(CONFIG_EROFS_FS_ONDEMAND)
> +extern struct file_system_type erofs_anon_fs_type;
> +#endif

It's unnecessary to use #ifdef for "extern", otherwise
it looks good me.

Thanks,
Gao Xiang

