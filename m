Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C3E5B955A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 09:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiIOH1j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 03:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiIOH1J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:27:09 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885E386732
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Sep 2022 00:26:47 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id c24so16511518pgg.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Sep 2022 00:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=LIWBWWFb8yy1MssxtI6bn2YpTDb4Q6/dddLLzhJ4bpQ=;
        b=wNo7hBk9fMWUOj/3ynTodNOVDRJXMwJmtYMzu04+LkzdaP8h61LFrdZcor4jT7Jgpn
         GVtl/I+x5gEYJoKS/hILQc4cQC/gdv2L15Aeke7THm1rbLKET+QYlZT4sWxZTbnSYmFC
         DkNUc2Wnppf+b2eMb6jyQL5PKRw+6meelewWknLf/YQBdlrdPaGKyC6KyfLXR/QfbIeH
         G4AibeCjUYLsGX9KHjadMcHPHcO/v9NyIbCZn6Me1c8AgmJSOjNI5Fhulf6SOBTage9N
         4WkFmgh8JyxyMYpm4xuRrmb+5IQj7gGiZXXVcu+OILkMHcVx+5Ir8Zf60WNFYcivJ/Uw
         9q9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=LIWBWWFb8yy1MssxtI6bn2YpTDb4Q6/dddLLzhJ4bpQ=;
        b=YuTVBVL4NfGwgWB4hk01W6a7Ndo8VPDaVZp8AK4KoCPU+yLMKvviwSqAmjS+5moqge
         K3EUnvlIGpYZv+qGXs7uoj6Mq5RXZjbiohGYfXthaF3gVzKDaH81oG0SM+JTal9PuwbB
         MBRsyzDO3Ijw9Lpce06ukilWgFt5excAxbb6xOcl+fShv/GI7r6UywOw5Eq804feEJLA
         18yPjDYTHSuzRAZ+Hd+HCXg4Zg04yRjjlzsLspOieTvQ5JScU7a4hIqGjE74BrO2oGCq
         PklnKqfN+mf+jW/yvYgZoSa4UVD1bYselJxkjqHHKU865mqdnCBAm2vYtUGNxBmKcDBa
         xttQ==
X-Gm-Message-State: ACgBeo2l7ljePLTsiLFnDzQdCezhxRZa61UXrO/eJsOUDKWFPoiQHDvq
        Ke2BAFs2Ii0+rV5w6YJm0u0P6g==
X-Google-Smtp-Source: AA6agR7SguljpcebTu70uYUSvx77z7+wrSQ9Blo2OucBtIKVi31yByPXunvFvYqh3JBw4vm3ltSiLw==
X-Received: by 2002:a63:e25:0:b0:41c:30f7:c39c with SMTP id d37-20020a630e25000000b0041c30f7c39cmr34809101pgl.147.1663226802094;
        Thu, 15 Sep 2022 00:26:42 -0700 (PDT)
Received: from [10.76.37.214] ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id h29-20020a056a00001d00b0053e9ecf58f0sm11715954pfk.20.2022.09.15.00.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 00:26:41 -0700 (PDT)
Message-ID: <c6da4306-a89f-ff28-920c-4fc3f12b55e3@bytedance.com>
Date:   Thu, 15 Sep 2022 15:26:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [External] Re: [PATCH V3 6/6] erofs: Support sharing cookies in
 the same domain
To:     JeffleXu <jefflexu@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, huyue2@coolpad.com
References: <20220914105041.42970-1-zhujia.zj@bytedance.com>
 <20220914105041.42970-7-zhujia.zj@bytedance.com>
 <82473542-7810-3474-3f78-b61f9927d682@linux.alibaba.com>
From:   Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <82473542-7810-3474-3f78-b61f9927d682@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/9/15 14:53, JeffleXu 写道:
> 
> 
> On 9/14/22 6:50 PM, Jia Zhu wrote:
>> Several erofs filesystems can belong to one domain, and data blobs can
>> be shared among these erofs filesystems of same domain.
>>
>> Users could specify domain_id mount option to create or join into a
>> domain.
>>
>> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
>> ---
>>   fs/erofs/fscache.c  | 89 +++++++++++++++++++++++++++++++++++++++++++--
>>   fs/erofs/internal.h |  4 +-
>>   2 files changed, 89 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
>> index 4e0a441afb7d..e9ae1ee963e2 100644
>> --- a/fs/erofs/fscache.c
>> +++ b/fs/erofs/fscache.c
>> @@ -7,6 +7,7 @@
>>   #include "internal.h"
>>   
>>   static DEFINE_MUTEX(erofs_domain_list_lock);
>> +static DEFINE_MUTEX(erofs_domain_cookies_lock);
>>   static LIST_HEAD(erofs_domain_list);
>>   static struct vfsmount *erofs_pseudo_mnt;
>>   
>> @@ -504,7 +505,6 @@ static int erofs_fscache_init_domain(struct super_block *sb)
>>   
>>   	domain->volume = sbi->volume;
>>   	refcount_set(&domain->ref, 1);
>> -	mutex_init(&domain->mutex);
> 
> This needs to be folded into patch 4.
Thanks.
> 
> 
>>   	list_add(&domain->list, &erofs_domain_list);
>>   	return 0;
>>   out:
>> @@ -534,8 +534,8 @@ static int erofs_fscache_register_domain(struct super_block *sb)
>>   	return err;
>>   }
>>   
>> -struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
>> -						     char *name, bool need_inode)
>> +struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
>> +						    char *name, bool need_inode)
>>   {
>>   	struct fscache_volume *volume = EROFS_SB(sb)->volume;
>>   	struct erofs_fscache *ctx;
>> @@ -585,13 +585,96 @@ struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
>>   	return ERR_PTR(ret);
>>   }
>>   
>> +static
>> +struct erofs_fscache *erofs_fscache_domain_init_cookie(struct super_block *sb,
>> +							char *name, bool need_inode)
>> +{
>> +	struct inode *inode;
>> +	struct erofs_fscache *ctx;
>> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
>> +	struct erofs_domain *domain = sbi->domain;
>> +
>> +	ctx = erofs_fscache_acquire_cookie(sb, name, need_inode);
>> +	if (IS_ERR(ctx))
>> +		return ctx;
>> +
>> +	ctx->name = kstrdup(name, GFP_KERNEL);
>> +	if (!ctx->name)
>> +		return ERR_PTR(-ENOMEM);
> 
> The previously registered erofs_fscache needs to be cleaned up in the
> error path.
Thanks for catching this. I'll fix it in next version.
> 
>> +
>> +	inode = new_inode(erofs_pseudo_mnt->mnt_sb);
>> +	if (!inode) {
>> +		kfree(ctx->name);
>> +		return ERR_PTR(-ENOMEM);
>> +	}
> 
> Ditto.
> 
>> +
>> +	ctx->domain = domain;
>> +	ctx->anon_inode = inode;
>> +	inode->i_private = ctx;
>> +	erofs_fscache_domain_get(domain);
>> +	return ctx;
>> +}
>> +
>> +static
>> +struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
>> +						    char *name, bool need_inode)
>> +{
>> +	struct inode *inode;
>> +	struct erofs_fscache *ctx;
>> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
>> +	struct erofs_domain *domain = sbi->domain;
>> +	struct super_block *psb = erofs_pseudo_mnt->mnt_sb;
>> +
>> +	mutex_lock(&erofs_domain_cookies_lock);
>> +	list_for_each_entry(inode, &psb->s_inodes, i_sb_list) {
>> +		ctx = inode->i_private;
>> +		if (!ctx)
>> +			continue;
>> +		if (ctx->domain == domain && !strcmp(ctx->name, name)) {
>> +			igrab(inode);
>> +			mutex_unlock(&erofs_domain_cookies_lock);
>> +			return ctx;
>> +		}
>> +	}
>> +	ctx = erofs_fscache_domain_init_cookie(sb, name, need_inode);
>> +	mutex_unlock(&erofs_domain_cookies_lock);
>> +	return ctx;
>> +}
>> +
>> +struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
>> +						     char *name, bool need_inode)
>> +{
>> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
>> +
>> +	if (sbi->opt.domain_id)
>> +		return erofs_domain_register_cookie(sb, name, need_inode);
>> +	else
>> +		return erofs_fscache_acquire_cookie(sb, name, need_inode);
>> +}
>> +
>>   void erofs_fscache_unregister_cookie(struct erofs_fscache *ctx)
>>   {
>> +	struct erofs_domain *domain;
>> +
>>   	if (!ctx)
>>   		return;
>> +	domain = ctx->domain;
>> +	if (domain) {
>> +		mutex_lock(&erofs_domain_cookies_lock);
>> +		/* Cookie is still in use */
>> +		if (atomic_read(&ctx->anon_inode->i_count) > 1) {
>> +			iput(ctx->anon_inode);
>> +			mutex_unlock(&erofs_domain_cookies_lock);
>> +			return;
>> +		}
>> +		iput(ctx->anon_inode);
>> +		kfree(ctx->name);
>> +		mutex_unlock(&erofs_domain_cookies_lock);
> 
> 		mutex_lock(&erofs_domain_cookies_lock);
> 		drop = atomic_read(&ctx->anon_inode->i_count) == 1;
> 		iput(ctx->anon_inode);
> 		mutex_unlock(&erofs_domain_cookies_lock);
> 
> 		if (!drop)
> 			return;
This code style is more intuitive, I'll revise it, thanks.
>> +	}
>>   >  	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
>>   	fscache_relinquish_cookie(ctx->cookie, false);
>> +	erofs_fscache_domain_put(domain);
>>   	ctx->cookie = NULL;
> 
> 	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
> 	fscache_relinquish_cookie(ctx->cookie, false);
> 	erofs_fscache_domain_put(domain);
> 	kfree(ctx->name);
> 
>>   
>>   	iput(ctx->inode);
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index 4dd0b545755a..8a6f94b27a23 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -101,7 +101,6 @@ struct erofs_sb_lz4_info {
>>   
>>   struct erofs_domain {
>>   	refcount_t ref;
>> -	struct mutex mutex;
>>   	struct list_head list;
>>   	struct fscache_volume *volume;
>>   	char *domain_id;
>> @@ -110,6 +109,9 @@ struct erofs_domain {
>>   struct erofs_fscache {
>>   	struct fscache_cookie *cookie;
>>   	struct inode *inode;
>> +	struct inode *anon_inode;
>> +	struct erofs_domain *domain;
>> +	char *name;
>>   };
>>   
>>   struct erofs_sb_info {
> 
