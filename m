Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92115B66FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 06:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiIMEhL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 00:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiIMEgr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 00:36:47 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B5625C6F
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 21:31:43 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id h188so10173161pgc.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 21:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=+nxBZprjDfeQSRH0ATA3UKT3yTg4cCfDFL/tf8PL9b8=;
        b=pYir8x4ncAwSlz0DLaMJONJx9A46DFcEuc7X2shmRpS5pLhaUFQ38JbBnBhgECnFHw
         2Y/0UvYOW23A+jXD4uvr2JQPQLXJfkYK4gUB8FUjBHi62L3OT67uii+mO4V6SMvoezNA
         whrtPbDuQtdj6Z6czAf4rlRWBslSBUmcK6yQAFalSU9lrQo9c1KmdEz/8iurnGkN6/FO
         gYIJwB37W3oVCruUAnH/Y+emPF+gbSgT6+ndkmPruZuYo+gi1nFPwKFhV8qGYEbaGEUM
         8WiZ8zb2btPVJ5ujiDWvf/W7EA3rKm308iv8ef9RT5h39hbSn2/g5gteK5BlHJZ5nQ6K
         rFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=+nxBZprjDfeQSRH0ATA3UKT3yTg4cCfDFL/tf8PL9b8=;
        b=BfMlbGGF8vtHio58RgK5nHtlILhueplvvv4FcM0xa9P8KFh5D6HudKS0YMVE6chtNJ
         gwCLGVc4yh536R8b9tn6YFW12x1BpRz8idiFxxkBRRwukpC19KZcXo6glqTMIEXgrgWy
         ECEIPUixAyiCofKZtu/C2/aZxUzCC/X9Q9xY2pQ60EpSYuT+6q89AG2U6HJpSktLywI9
         Lldfljwys1ir6CrommILXb8/Q4dj3l4EN+q2wFdDVgienfJVJVVFFnbPWirGJuUtyVuc
         ia9eg+dXQe+lrghiRKxT9x6cuw7OBL8lSiWmDv1g45VySdjgNXW25JbSgtTOHJswDjke
         neSg==
X-Gm-Message-State: ACgBeo1+b8V3+zPU0qzcA1MPokKlM+JWaQNoXlLpKCzmF7CIzESmOTQi
        5J6O258zzft9kRkgdaqVKsV3+w==
X-Google-Smtp-Source: AA6agR7cHnx/3sHKS3lY4L52GRjkaIfFjIsJHJXgg2SqBfS3JpJc2qFZkqyO3GitwZWnr/iffmanbQ==
X-Received: by 2002:a65:5b4c:0:b0:439:b3a:e8e6 with SMTP id y12-20020a655b4c000000b004390b3ae8e6mr6607145pgr.330.1663043502861;
        Mon, 12 Sep 2022 21:31:42 -0700 (PDT)
Received: from [10.76.37.214] ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id j8-20020a17090a318800b002005114fbf5sm1957921pjb.22.2022.09.12.21.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 21:31:42 -0700 (PDT)
Message-ID: <fe9199a2-a8d5-98c9-461b-e7a2cbf87516@bytedance.com>
Date:   Tue, 13 Sep 2022 12:31:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [External] Re: [PATCH V2 2/5] erofs: introduce fscache-based
 domain
To:     JeffleXu <jefflexu@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, huyue2@coolpad.com
References: <20220902105305.79687-1-zhujia.zj@bytedance.com>
 <20220902105305.79687-3-zhujia.zj@bytedance.com>
 <ac567b29-dd30-7b65-aefb-3f23e59781cb@linux.alibaba.com>
From:   Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <ac567b29-dd30-7b65-aefb-3f23e59781cb@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/9/9 16:42, JeffleXu 写道:
> 
> 
> On 9/2/22 6:53 PM, Jia Zhu wrote:
>> A new fscache-based shared domain mode is going to be introduced for
>> erofs. In which case, same data blobs in same domain will be shared
>> and reused to reduce on-disk space usage.
>>
>> As the first step, we use pseudo mnt to manage and maintain domain's
>> lifecycle.
>>
>> The implementation of sharing blobs will be introduced in subsequent
>> patches.
>>
>> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
>> ---
>>   fs/erofs/fscache.c  | 95 ++++++++++++++++++++++++++++++++++++++++++++-
>>   fs/erofs/internal.h | 18 ++++++++-
>>   fs/erofs/super.c    | 51 ++++++++++++++++++------
>>   3 files changed, 149 insertions(+), 15 deletions(-)
>>
>> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
>> index 8e01d89c3319..439dd3cc096a 100644
>> --- a/fs/erofs/fscache.c
>> +++ b/fs/erofs/fscache.c
>> @@ -1,10 +1,15 @@
>>   // SPDX-License-Identifier: GPL-2.0-or-later
>>   /*
>>    * Copyright (C) 2022, Alibaba Cloud
>> + * Copyright (C) 2022, Bytedance Inc. All rights reserved.
>>    */
>>   #include <linux/fscache.h>
>>   #include "internal.h"
>>   
>> +static DEFINE_MUTEX(erofs_domain_list_lock);
>> +static LIST_HEAD(erofs_domain_list);
>> +static struct vfsmount *erofs_pseudo_mnt;
>> +
>>   static struct netfs_io_request *erofs_fscache_alloc_request(struct address_space *mapping,
>>   					     loff_t start, size_t len)
>>   {
>> @@ -417,6 +422,87 @@ const struct address_space_operations erofs_fscache_access_aops = {
>>   	.readahead = erofs_fscache_readahead,
>>   };
>>   
>> +static void erofs_fscache_domain_get(struct erofs_domain *domain)
>> +{
>> +	if (!domain)
>> +		return;
>> +	refcount_inc(&domain->ref);
>> +}
> 
Hi Jingbo,
Thanks for your careful review.
> It seems that the input @domain can not be NULL, and thus the NULL check
> is not needed.
> 
I will remove it in next version.
> Besides how about:
> 
> struct erofs_domain *domain erofs_fscache_domain_get(struct erofs_domain
> *domain)
> {
> 	refcount_inc(&domain->ref);
> 	return domain;
> }
> 
Thanks for the suggestion, I will apply it.
>> +
>> +static void erofs_fscache_domain_put(struct erofs_domain *domain)
>> +{
>> +	if (!domain)
>> +		return;
>> +	if (refcount_dec_and_test(&domain->ref)) {
>> +		fscache_relinquish_volume(domain->volume, NULL, false);
>> +		mutex_lock(&erofs_domain_list_lock);
>> +		list_del(&domain->list);
>> +		mutex_unlock(&erofs_domain_list_lock);
>> +		kfree(domain->domain_id);
>> +		kfree(domain);
>> +	}
>> +}
>> +
>> +static int erofs_fscache_init_domain(struct super_block *sb)
>> +{
>> +	int err;
>> +	struct erofs_domain *domain;
>> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
>> +
>> +	domain = kzalloc(sizeof(struct erofs_domain), GFP_KERNEL);
>> +	if (!domain)
>> +		return -ENOMEM;
>> +
>> +	domain->domain_id = kstrdup(sbi->opt.domain_id, GFP_KERNEL);
>> +	if (!domain->domain_id) {
>> +		kfree(domain);
>> +		return -ENOMEM;
>> +	}
>> +	sbi->domain = domain;
>> +	if (!erofs_pseudo_mnt) {
>> +		erofs_pseudo_mnt = kern_mount(&erofs_fs_type);
>> +		if (IS_ERR(erofs_pseudo_mnt)) {
>> +			err = PTR_ERR(erofs_pseudo_mnt);
>> +			goto out;
>> +		}
>> +	}
>> +	err = erofs_fscache_register_fs(sb);
>> +	if (err)
>> +		goto out;
>> +
>> +	domain->volume = sbi->volume;
>> +	refcount_set(&domain->ref, 1);
>> +	mutex_init(&domain->mutex);
>> +	list_add(&domain->list, &erofs_domain_list);
>> +	return 0;
>> +out:
>> +	kfree(domain->domain_id);
>> +	kfree(domain);
>> +	sbi->domain = NULL;
>> +	return err;
>> +}
>> +
>> +int erofs_fscache_register_domain(struct super_block *sb)
>> +{
>> +	int err;
>> +	struct erofs_domain *domain;
>> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
>> +
>> +	mutex_lock(&erofs_domain_list_lock);
>> +	list_for_each_entry(domain, &erofs_domain_list, list) {
>> +		if (!strcmp(domain->domain_id, sbi->opt.domain_id)) {
>> +			erofs_fscache_domain_get(domain);
>> +			sbi->domain = domain;
> 
> 			sbi->domain = erofs_fscache_domain_get(domain);
> 			
>> +			sbi->volume = domain->volume;
>> +			mutex_unlock(&erofs_domain_list_lock);
>> +			return 0;
>> +		}
>> +	}
>> +	err = erofs_fscache_init_domain(sb);
>> +	mutex_unlock(&erofs_domain_list_lock);
>> +	return err;
>> +}
>> +
>>   int erofs_fscache_register_cookie(struct super_block *sb,
>>   				  struct erofs_fscache **fscache,
>>   				  char *name, bool need_inode)
>> @@ -495,7 +581,8 @@ int erofs_fscache_register_fs(struct super_block *sb)
>>   	char *name;
>>   	int ret = 0;
>>   
>> -	name = kasprintf(GFP_KERNEL, "erofs,%s", sbi->opt.fsid);
>> +	name = kasprintf(GFP_KERNEL, "erofs,%s",
>> +			sbi->domain ? sbi->domain->domain_id : sbi->opt.fsid);
> 
> Do we also need to encode the cookie name in the "<domain_id>,<fsid>"
> format? This will affect the path of the cache files.
> 
I think even though the cookies have the same name, they belong to
different volumes(path). Cookies do not affect each other.
Are there other benefits to doing so?
>>   	if (!name)
>>   		return -ENOMEM;
>>   
>> @@ -515,6 +602,10 @@ void erofs_fscache_unregister_fs(struct super_block *sb)
>>   {
>>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
>>   
>> -	fscache_relinquish_volume(sbi->volume, NULL, false);
>> +	if (sbi->domain)
>> +		erofs_fscache_domain_put(sbi->domain);
>> +	else
>> +		fscache_relinquish_volume(sbi->volume, NULL, false);
>>   	sbi->volume = NULL;
>> +	sbi->domain = NULL;
>>   }
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index fe435d077f1a..2790c93ffb83 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -99,6 +99,14 @@ struct erofs_sb_lz4_info {
>>   	u16 max_pclusterblks;
>>   };
>>   
>> +struct erofs_domain {
>> +	refcount_t ref;
>> +	struct mutex mutex;
>> +	struct list_head list;
>> +	struct fscache_volume *volume;
>> +	char *domain_id;
>> +};
>> +
>>   struct erofs_fscache {
>>   	struct fscache_cookie *cookie;
>>   	struct inode *inode;
>> @@ -158,6 +166,7 @@ struct erofs_sb_info {
>>   	/* fscache support */
>>   	struct fscache_volume *volume;
>>   	struct erofs_fscache *s_fscache;
>> +	struct erofs_domain *domain;
>>   };
>>   
>>   #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
>> @@ -394,6 +403,7 @@ struct page *erofs_grab_cache_page_nowait(struct address_space *mapping,
>>   }
>>   
>>   extern const struct super_operations erofs_sops;
>> +extern struct file_system_type erofs_fs_type;
>>   
>>   extern const struct address_space_operations erofs_raw_access_aops;
>>   extern const struct address_space_operations z_erofs_aops;
>> @@ -610,6 +620,7 @@ static inline int z_erofs_load_lzma_config(struct super_block *sb,
>>   #ifdef CONFIG_EROFS_FS_ONDEMAND
>>   int erofs_fscache_register_fs(struct super_block *sb);
>>   void erofs_fscache_unregister_fs(struct super_block *sb);
>> +int erofs_fscache_register_domain(struct super_block *sb);
>>   
>>   int erofs_fscache_register_cookie(struct super_block *sb,
>>   				  struct erofs_fscache **fscache,
>> @@ -620,10 +631,15 @@ extern const struct address_space_operations erofs_fscache_access_aops;
>>   #else
>>   static inline int erofs_fscache_register_fs(struct super_block *sb)
>>   {
>> -	return 0;
>> +	return -EOPNOTSUPP;
>>   }
>>   static inline void erofs_fscache_unregister_fs(struct super_block *sb) {}
>>   
>> +static inline int erofs_fscache_register_domain(const struct super_block *sb)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>>   static inline int erofs_fscache_register_cookie(struct super_block *sb,
>>   						struct erofs_fscache **fscache,
>>   						char *name, bool need_inode)
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index d01109069c6b..69de1731f454 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -688,6 +688,13 @@ static const struct export_operations erofs_export_ops = {
>>   	.get_parent = erofs_get_parent,
>>   };
>>   
>> +static int erofs_fc_fill_pseudo_super(struct super_block *sb, struct fs_context *fc)
>> +{
>> +	static const struct tree_descr empty_descr = {""};
>> +
>> +	return simple_fill_super(sb, EROFS_SUPER_MAGIC, &empty_descr);
>> +}
>> +
>>   static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>>   {
>>   	struct inode *inode;
>> @@ -715,12 +722,17 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>>   		sb->s_blocksize = EROFS_BLKSIZ;
>>   		sb->s_blocksize_bits = LOG_BLOCK_SIZE;
>>   
>> -		err = erofs_fscache_register_fs(sb);
>> -		if (err)
>> -			return err;
>> -
>> -		err = erofs_fscache_register_cookie(sb, &sbi->s_fscache,
>> -						    sbi->opt.fsid, true);
>> +		if (sbi->opt.domain_id) {
>> +			err = erofs_fscache_register_domain(sb);
>> +			if (err)
>> +				return err;
>> +		} else {
>> +			err = erofs_fscache_register_fs(sb);
>> +			if (err)
>> +				return err;
>> +			err = erofs_fscache_register_cookie(sb, &sbi->s_fscache,
>> +					sbi->opt.fsid, true);
> 
> We'd better keep only one entry to the fscache related codes. How about
> moving erofs_fscache_register_cookie(), i.e. registering cookie for
> bootstrap, into erofs_fscache_register_fs()? Similarly, check the
> domain_id and call erofs_fscache_register_domain() inside
> erofs_fscache_register_fs().
> 
> Similarly, check domain_id and call erofs_domain_register_cookie()
> inside erofs_fscache_register_cookie().
> 
Thanks, that looks great, I will revise it in next version.
> 
> 
>> +		}
>>   		if (err)
>>   			return err;
>>   
>> @@ -798,8 +810,12 @@ static int erofs_fc_get_tree(struct fs_context *fc)
>>   {
>>   	struct erofs_fs_context *ctx = fc->fs_private;
>>   
>> -	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && ctx->opt.fsid)
>> -		return get_tree_nodev(fc, erofs_fc_fill_super);
>> +	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND)) {
>> +		if (!ctx && fc->sb_flags & SB_KERNMOUNT)
>> +			return get_tree_nodev(fc, erofs_fc_fill_pseudo_super);
>> +		if (ctx->opt.fsid)
>> +			return get_tree_nodev(fc, erofs_fc_fill_super);
>> +	}
>>   
>>   	return get_tree_bdev(fc, erofs_fc_fill_super);
>>   }
>> @@ -849,6 +865,8 @@ static void erofs_fc_free(struct fs_context *fc)
>>   {
>>   	struct erofs_fs_context *ctx = fc->fs_private;
>>   
>> +	if (!ctx)
>> +		return;
>>   	erofs_free_dev_context(ctx->devs);
>>   	kfree(ctx->opt.fsid);
>>   	kfree(ctx->opt.domain_id);
>> @@ -864,8 +882,12 @@ static const struct fs_context_operations erofs_context_ops = {
>>   
>>   static int erofs_init_fs_context(struct fs_context *fc)
>>   {
>> -	struct erofs_fs_context *ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>> +	struct erofs_fs_context *ctx;
>>   
>> +	if (fc->sb_flags & SB_KERNMOUNT)
>> +		goto out;
>> +
>> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>>   	if (!ctx)
>>   		return -ENOMEM;
>>   	ctx->devs = kzalloc(sizeof(struct erofs_dev_context), GFP_KERNEL);
>> @@ -878,6 +900,7 @@ static int erofs_init_fs_context(struct fs_context *fc)
>>   	idr_init(&ctx->devs->tree);
>>   	init_rwsem(&ctx->devs->rwsem);
>>   	erofs_default_options(ctx);
>> +out:
>>   	fc->ops = &erofs_context_ops;
>>   	return 0;
>>   }
>> @@ -892,6 +915,10 @@ static void erofs_kill_sb(struct super_block *sb)
>>   
>>   	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
>>   
>> +	if (sb->s_flags & SB_KERNMOUNT) {
>> +		kill_litter_super(sb);
>> +		return;
>> +	}
>>   	if (erofs_is_fscache_mode(sb))
>>   		generic_shutdown_super(sb);
>>   	else
>> @@ -916,8 +943,8 @@ static void erofs_put_super(struct super_block *sb)
>>   {
>>   	struct erofs_sb_info *const sbi = EROFS_SB(sb);
>>   
>> -	DBG_BUGON(!sbi);
>> -
>> +	if (!sbi)
>> +		return;
>>   	erofs_unregister_sysfs(sb);
>>   	erofs_shrinker_unregister(sb);
>>   #ifdef CONFIG_EROFS_FS_ZIP
>> @@ -927,7 +954,7 @@ static void erofs_put_super(struct super_block *sb)
>>   	erofs_fscache_unregister_cookie(&sbi->s_fscache);
>>   }
>>   
>> -static struct file_system_type erofs_fs_type = {
>> +struct file_system_type erofs_fs_type = {
>>   	.owner          = THIS_MODULE,
>>   	.name           = "erofs",
>>   	.init_fs_context = erofs_init_fs_context,
> 
