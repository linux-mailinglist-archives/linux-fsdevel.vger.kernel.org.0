Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21035B95DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 10:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiIOIBK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 04:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiIOIBJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:01:09 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4ECF4CA30
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Sep 2022 01:01:04 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id q3so16968845pjg.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Sep 2022 01:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=Uz6OOQGn2ojsoy4NxY6r+ZIL82T2lAVU3OWCDkI7HIk=;
        b=FYvuPdzBSIdK7mGtbn5oflgjSb2mpir/rNfKSdUY0XNIVfXdcaZXsX3KfSyK3x4yhP
         xUr7kY6JF+0zWablNOH0kgV6ZYDOqS95hJERCIbozhKzUJgj38Sq9QnbcrQK+S8fiONg
         kps7HWm0muoS8peoR46bcMweeSiCvE55cS2kLJNsyD2D2d+sBuZwgaKu6G4ECOyuoJ4T
         TaX3dgQHXFLZUAHQW7USRDV7wPnrSJu2qSIScIqhnyTl8d9Hwe6o2Kq4Dq7JDx+qFtTu
         IHY5Ipkk2UxgBUnxLpa+zeGi+UBf3cTReLiv3Bn/U0/auxDJaOzVf6puvfMspJf1FrCV
         00ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=Uz6OOQGn2ojsoy4NxY6r+ZIL82T2lAVU3OWCDkI7HIk=;
        b=F0k4JFYAEO3c7jn9HvDw1R0teBB1ptIMOvkGvYZVNd9h4P1KAFbUft6J4XCRurbyaU
         cdFSUI+I3dBN3KcXWquo5kCi6eGpBcp9nDzYedxl8n6aBveunyUfUNlmZZCd2uPFxDEd
         RQYbHmitboZOSlYCB1Q0VOkTHXO/58043V7Or9JzBcBlOXFjQJG1ZuBfaVJMX3Hjslny
         4aO6BEBTc/b3m9r2iU5KWOHz19Lwv7pC/SDkFKol4yDDf0/8pPRyJswT4iuQpGcWbvZm
         IF8+mNvfHT+sZ9BfXHD5JnP7TTEnRqM1L/5iiSDbVUpolsjkJ2DnIhsO6hvI8PpT4miR
         0uUA==
X-Gm-Message-State: ACrzQf0O/EMqe6RRFDhS42EXK8evehCOlN/QLs85XcVNZSGpOb+qP0wj
        r0G6DzYaRkZubjczPzFbvV19z4xt3KH08h3a
X-Google-Smtp-Source: AMsMyM6s1VythNV5AWnn4wFPgqpNcp0ig4hXS8XsbLDwtOWOVMsNCx/FWLVIgO2kydIUeEL9PgPZGw==
X-Received: by 2002:a17:902:6b0b:b0:178:3a78:811d with SMTP id o11-20020a1709026b0b00b001783a78811dmr3062739plk.157.1663228864256;
        Thu, 15 Sep 2022 01:01:04 -0700 (PDT)
Received: from [10.76.37.214] ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id z14-20020aa79e4e000000b00537eb0084f9sm11898989pfq.83.2022.09.15.01.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 01:01:03 -0700 (PDT)
Message-ID: <748071b4-446a-410e-6c75-e8846b990c47@bytedance.com>
Date:   Thu, 15 Sep 2022 16:00:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [External] Re: [PATCH V3 4/6] erofs: introduce fscache-based
 domain
To:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        huyue2@coolpad.com
References: <20220914105041.42970-1-zhujia.zj@bytedance.com>
 <20220914105041.42970-5-zhujia.zj@bytedance.com>
 <YyHVQGftl/0Bf4kW@B-P7TQMD6M-0146.lan>
From:   Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <YyHVQGftl/0Bf4kW@B-P7TQMD6M-0146.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/9/14 21:21, Gao Xiang 写道:
> On Wed, Sep 14, 2022 at 06:50:39PM +0800, Jia Zhu wrote:
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
>>   fs/erofs/fscache.c  | 134 ++++++++++++++++++++++++++++++++++++++------
>>   fs/erofs/internal.h |   9 +++
>>   2 files changed, 127 insertions(+), 16 deletions(-)
>>
>> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
>> index 4159cf781924..b2100dc67cde 100644
>> --- a/fs/erofs/fscache.c
>> +++ b/fs/erofs/fscache.c
>> @@ -1,10 +1,14 @@
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
>> +
>>   static struct netfs_io_request *erofs_fscache_alloc_request(struct address_space *mapping,
>>   					     loff_t start, size_t len)
>>   {
>> @@ -417,6 +421,106 @@ const struct address_space_operations erofs_fscache_access_aops = {
>>   	.readahead = erofs_fscache_readahead,
>>   };
>>   
>> +static
>> +struct erofs_domain *erofs_fscache_domain_get(struct erofs_domain *domain)
>> +{
>> +	refcount_inc(&domain->ref);
>> +	return domain;
>> +}
> 
> We can just open-code that.
Thanks, I'll revise it.
> 
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
>> +static int erofs_fscache_register_volume(struct super_block *sb)
>> +{
>> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
>> +	char *domain_id = sbi->opt.domain_id;
>> +	struct fscache_volume *volume;
>> +	char *name;
>> +	int ret = 0;
>> +
>> +	if (domain_id)
>> +		name = kasprintf(GFP_KERNEL, "erofs,%s", domain_id);
>> +	else
>> +		name = kasprintf(GFP_KERNEL, "erofs,%s", sbi->opt.fsid);
> 
> I think we could just use
> 
> 	name = kasprintf(GFP_KERNEL, "erofs,%s",
> 			 domain_id ? domain_id : sbi->opt.fsid);
> 
> here.
Thanks.
> 
>> +	if (!name)
>> +		return -ENOMEM;
>> +
>> +	volume = fscache_acquire_volume(name, NULL, NULL, 0);
>> +	if (IS_ERR_OR_NULL(volume)) {
>> +		erofs_err(sb, "failed to register volume for %s", name);
>> +		ret = volume ? PTR_ERR(volume) : -EOPNOTSUPP;
>> +		volume = NULL;
>> +	}
>> +
>> +	sbi->volume = volume;
>> +	kfree(name);
>> +	return ret;
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
>> +	err = erofs_fscache_register_volume(sb);
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
>> +static int erofs_fscache_register_domain(struct super_block *sb)
>> +{
>> +	int err;
>> +	struct erofs_domain *domain;
>> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
>> +
>> +	mutex_lock(&erofs_domain_list_lock);
>> +	list_for_each_entry(domain, &erofs_domain_list, list) {
>> +		if (!strcmp(domain->domain_id, sbi->opt.domain_id)) {
>> +			sbi->domain = erofs_fscache_domain_get(domain);
>> +			sbi->volume = domain->volume;
>> +			mutex_unlock(&erofs_domain_list_lock);
>> +			return 0;
>> +		}
>> +	}
>> +	err = erofs_fscache_init_domain(sb);
> 
> why introduce erofs_fscache_init_domain?
> 
To make error handling path simpler, avoid lots of 'goto' and 'unlock'
>> +	mutex_unlock(&erofs_domain_list_lock);
>> +	return err;
>> +}
>> +
>>   struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
>>   						     char *name, bool need_inode)
>>   {
>> @@ -486,24 +590,16 @@ void erofs_fscache_unregister_cookie(struct erofs_fscache *ctx)
>>   int erofs_fscache_register_fs(struct super_block *sb)
>>   {
>>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
>> -	struct fscache_volume *volume;
>>   	struct erofs_fscache *fscache;
>> -	char *name;
>> -	int ret = 0;
>> +	int ret;
>>   
>> -	name = kasprintf(GFP_KERNEL, "erofs,%s", sbi->opt.fsid);
>> -	if (!name)
>> -		return -ENOMEM;
>> +	if (sbi->opt.domain_id)
>> +		ret = erofs_fscache_register_domain(sb);
>> +	else
>> +		ret = erofs_fscache_register_volume(sb);
>>   
>> -	volume = fscache_acquire_volume(name, NULL, NULL, 0);
>> -	if (IS_ERR_OR_NULL(volume)) {
>> -		erofs_err(sb, "failed to register volume for %s", name);
>> -		ret = volume ? PTR_ERR(volume) : -EOPNOTSUPP;
>> -		volume = NULL;
>> -	}
>> -
>> -	sbi->volume = volume;
>> -	kfree(name);
>> +	if (ret)
>> +		return ret;
>>   
>>   	fscache = erofs_fscache_register_cookie(sb, sbi->opt.fsid, true);
>>   	if (IS_ERR(fscache))
>> @@ -518,7 +614,13 @@ void erofs_fscache_unregister_fs(struct super_block *sb)
>>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
>>   
>>   	erofs_fscache_unregister_cookie(sbi->s_fscache);
>> -	fscache_relinquish_volume(sbi->volume, NULL, false);
>>   	sbi->s_fscache = NULL;
>> +
>> +	if (sbi->domain)
>> +		erofs_fscache_domain_put(sbi->domain);
>> +	else
>> +		fscache_relinquish_volume(sbi->volume, NULL, false);
>> +
> 
> How about using one helper and pass in sb directly instead?
Thanks for your suggestion, I'll revise it in next version.
> 
> Thanks,
> Gao Xiang
