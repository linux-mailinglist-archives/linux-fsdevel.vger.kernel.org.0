Return-Path: <linux-fsdevel+bounces-72026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFF4CDB7AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 07:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03E53303B18E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 06:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5278B32937E;
	Wed, 24 Dec 2025 06:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="aRnHlXTH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869F6254849;
	Wed, 24 Dec 2025 06:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766557577; cv=none; b=jbhegir0x8r3Go/83dPzfL6mxdbmAP+niydlQCgpbWFiXLIUGXzmhTAG/0n5tPsukwIqF3pBiQoioQUeyuP0sRvcVMNiRyrgOGveF5jByOQk2xSYYbmswSsXC63Hx0f0wlqJKoTjk6H6TCIU5ruGGAPdAHnKofq9+sy8l36HdMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766557577; c=relaxed/simple;
	bh=IMtQsbobyd9tF1rlFq9WQJgmWi1OtdcvYbR479+XJKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hOx8DChAiVQY+h7Tw9qbeBw84dguHdLQQkMq+OwtiDpNos8v+7F+JLrs9kfOkTlUA8yoKx7WGlaFqNrALseG/+KuVnwWDnNwh6eFCcze8XDgm8/ntcqh27Ki9pPjANkCblivd3DD+BITkptirMxXr473uYDpo3Pp1chHSgGlwGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=aRnHlXTH; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=tRD6vTBkMhzsh0XSKyN261ilvkwt2FzgJ+X2pfaPLGU=;
	b=aRnHlXTHO4Ggc/lQ1d4I1TICOpLlGkUhvjDqTi15sSIn3D33i3UBY4bVhBDpBPLtfhAC2VJlK
	5nSraAq61Mvmv0mKGFCsnXojEDKG0UXMsvqCeNAsKWQ0TulEyojBM6AVJD33iao4GIyGRuQAjKf
	ygOUoQTh25X8Tdz496Np+Wc=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dbhdL07mGz1prPg;
	Wed, 24 Dec 2025 14:23:02 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id E3F0520104;
	Wed, 24 Dec 2025 14:26:10 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 24 Dec 2025 14:26:10 +0800
Message-ID: <8f9bbbb2-b53a-424b-871c-d3b1a4484c8a@huawei.com>
Date: Wed, 24 Dec 2025 14:26:09 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 04/10] erofs: move `struct erofs_anon_fs_type` to
 super.c
To: Gao Xiang <hsiangkao@linux.alibaba.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>, Christian Brauner
	<brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Amir Goldstein
	<amir73il@gmail.com>, <hch@lst.de>
References: <20251224040932.496478-1-lihongbo22@huawei.com>
 <20251224040932.496478-5-lihongbo22@huawei.com>
 <0081b97d-4b46-4b20-9d23-18d9642881cf@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <0081b97d-4b46-4b20-9d23-18d9642881cf@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr500015.china.huawei.com (7.202.195.162)



On 2025/12/24 12:25, Gao Xiang wrote:
> 
> 
> On 2025/12/24 12:09, Hongbo Li wrote:
>> From: Gao Xiang <hsiangkao@linux.alibaba.com>
>>
>> Move the `struct erofs_anon_fs_type` to the super.c and
>> expose it in preparation for the upcoming page cache share
>> feature.
>>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> 
> Are you sure this is my previous version of this one?
> 
> Could you please check carefully before sending
> out the next version?

Sorry, I mixed up my local patches. I will check carefully in the next time.

Thanks,
Hongbo

> 
> Thanks,
> Gao Xiang
> 
>> ---
>>   fs/erofs/fscache.c  | 13 -------------
>>   fs/erofs/internal.h |  2 ++
>>   fs/erofs/super.c    | 15 +++++++++++++++
>>   3 files changed, 17 insertions(+), 13 deletions(-)
>>
>> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
>> index 7a346e20f7b7..f4937b025038 100644
>> --- a/fs/erofs/fscache.c
>> +++ b/fs/erofs/fscache.c
>> @@ -3,7 +3,6 @@
>>    * Copyright (C) 2022, Alibaba Cloud
>>    * Copyright (C) 2022, Bytedance Inc. All rights reserved.
>>    */
>> -#include <linux/pseudo_fs.h>
>>   #include <linux/fscache.h>
>>   #include "internal.h"
>> @@ -13,18 +12,6 @@ static LIST_HEAD(erofs_domain_list);
>>   static LIST_HEAD(erofs_domain_cookies_list);
>>   static struct vfsmount *erofs_pseudo_mnt;
>> -static int erofs_anon_init_fs_context(struct fs_context *fc)
>> -{
>> -    return init_pseudo(fc, EROFS_SUPER_MAGIC) ? 0 : -ENOMEM;
>> -}
>> -
>> -static struct file_system_type erofs_anon_fs_type = {
>> -    .owner        = THIS_MODULE,
>> -    .name           = "pseudo_erofs",
>> -    .init_fs_context = erofs_anon_init_fs_context,
>> -    .kill_sb        = kill_anon_super,
>> -};
>> -
>>   struct erofs_fscache_io {
>>       struct netfs_cache_resources cres;
>>       struct iov_iter        iter;
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index f7f622836198..98fe652aea33 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -188,6 +188,8 @@ static inline bool erofs_is_fileio_mode(struct 
>> erofs_sb_info *sbi)
>>       return IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && 
>> sbi->dif0.file;
>>   }
>> +extern struct file_system_type erofs_anon_fs_type;
>> +
>>   static inline bool erofs_is_fscache_mode(struct super_block *sb)
>>   {
>>       return IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) &&
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 937a215f626c..2a44c4e5af4f 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/fs_parser.h>
>>   #include <linux/exportfs.h>
>>   #include <linux/backing-dev.h>
>> +#include <linux/pseudo_fs.h>
>>   #include "xattr.h"
>>   #define CREATE_TRACE_POINTS
>> @@ -936,6 +937,20 @@ static struct file_system_type erofs_fs_type = {
>>   };
>>   MODULE_ALIAS_FS("erofs");
>> +#if defined(CONFIG_EROFS_FS_ONDEMAND)
>> +static int erofs_anon_init_fs_context(struct fs_context *fc)
>> +{
>> +    return init_pseudo(fc, EROFS_SUPER_MAGIC) ? 0 : -ENOMEM;
>> +}
>> +
>> +struct file_system_type erofs_anon_fs_type = {
>> +    .owner        = THIS_MODULE,
>> +    .name           = "pseudo_erofs",
>> +    .init_fs_context = erofs_anon_init_fs_context,
>> +    .kill_sb        = kill_anon_super,
>> +};
>> +#endif
>> +
>>   static int __init erofs_module_init(void)
>>   {
>>       int err;
> 

