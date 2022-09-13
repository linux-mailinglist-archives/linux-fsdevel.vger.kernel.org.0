Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF605B6706
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 06:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiIMEiW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 00:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiIMEhs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 00:37:48 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240F4632A
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 21:37:47 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id e5so10618939pfl.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 21:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=b7Bt/6YykyrjMchIDnbFXbVoXcDSV6FDpCyHEofA/qI=;
        b=tDZt8AcWokd/xVHEI5fGydFkbJEPKf/viuCMk7B4IQI4/2/VcQwYi1aOxJUi3CE+SO
         lDX6xyUveu3H03QWTLGMIEuSIA9Qc9KdB7APrKrxHt8Jpry8IEvY4nMf2AmX457HS95L
         K9NNtnlsucaFPOaNgmPoXoDZACoBQ6HRRoYeE/MivzjAdB/JpSnsmlC+uROYaKaBLp3a
         ugjk6/qyB9SLQCaQ7HIFafa01ei7997gJBzIkILPvCvIShXZiD7jWbeISymZzRn7yhdu
         vYfc0Mh+ip3peQVLfCqR6xKLjUP11unFz7AAHtMiCT9Ir+52CQ1HRoLQI+uvxcWNlGKT
         7hCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=b7Bt/6YykyrjMchIDnbFXbVoXcDSV6FDpCyHEofA/qI=;
        b=OizZ6Q/9oKSXhx+9f9QSZoeAH5MZrKEqyQoZRhLBa36Ja+GOKjBwYDbGOZwm3ijoyW
         xgne+vXQ3N7Pu91HVDf2mw4W6qulAfCMuMvvtQ5v2yFPOJn4/DK2qr0oNZSVCCy6qtnr
         5Qom3ftJyiyi6frc8lrl0yrT/ijjP++lxZOaPSGHJH6XtgidLXKxFjBKQLbaYc0GTBnP
         KznRCBlee3FIJr2mja3dWfNJi4KkyC1O+MzA0ntMKk++hXpSCtCbOhtqptSGNCmyyL8j
         235ziRP5Zg2P/wntCojIcNT4E6SNZ9KJExr0XbLXw87frDXZNtD1oY5+H7VqQd9YZY/a
         B+Hw==
X-Gm-Message-State: ACgBeo0cxQIIltvh8VnH4J89NXKTVS/p30Pg0F2m6mwUlIuedQKmIvuj
        wxs2YTEHLhzubeFhfRz6BBNh+3LRXtA1bg==
X-Google-Smtp-Source: AA6agR5kvBhdwDorYv+Mc7NkXS46ff4TVEzUhnp1Hcyrx7C2S7lBeLtqJ9awLb2i14mmmLKXZuFm8g==
X-Received: by 2002:aa7:9e12:0:b0:53e:27d8:b71b with SMTP id y18-20020aa79e12000000b0053e27d8b71bmr31213065pfq.46.1663043866649;
        Mon, 12 Sep 2022 21:37:46 -0700 (PDT)
Received: from [10.76.37.214] ([114.251.196.103])
        by smtp.gmail.com with ESMTPSA id t3-20020a17090a6a0300b002002fb120d7sm6198682pjj.8.2022.09.12.21.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 21:37:46 -0700 (PDT)
Message-ID: <8c17fa4d-96a3-36e7-38db-17673c4bf552@bytedance.com>
Date:   Tue, 13 Sep 2022 12:37:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [External] Re: [PATCH V2 4/5] erofs: remove duplicated
 unregister_cookie
To:     JeffleXu <jefflexu@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, huyue2@coolpad.com
References: <20220902105305.79687-1-zhujia.zj@bytedance.com>
 <20220902105305.79687-5-zhujia.zj@bytedance.com>
 <3f75d266-7ccd-be6d-657c-fe0633b25687@linux.alibaba.com>
From:   Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <3f75d266-7ccd-be6d-657c-fe0633b25687@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/9/9 17:55, JeffleXu 写道:
> 
> 
> On 9/2/22 6:53 PM, Jia Zhu wrote:
>> In erofs umount scenario, erofs_fscache_unregister_cookie() is called
>> twice in kill_sb() and put_super().
>>
>> It works for original semantics, cause 'ctx' will be set to NULL in
>> put_super() and will not be unregister again in kill_sb().
>> However, in shared domain scenario, we use refcount to maintain the
>> lifecycle of cookie. Unregister the cookie twice will cause it to be
>> released early.
>>
>> For the above reasons, this patch removes duplicate unregister_cookie
>> and move fscache_unregister_* before shotdown_super() to prevent busy
>> inode(ctx->inode) when umount.
>>
>> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
>> ---
>>   fs/erofs/super.c | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 69de1731f454..667a78f0ee70 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -919,19 +919,20 @@ static void erofs_kill_sb(struct super_block *sb)
>>   		kill_litter_super(sb);
>>   		return;
>>   	}
>> -	if (erofs_is_fscache_mode(sb))
>> -		generic_shutdown_super(sb);
>> -	else
>> -		kill_block_super(sb);
>> -
>>   	sbi = EROFS_SB(sb);
>>   	if (!sbi)
>>   		return;
>>   
>> +	if (erofs_is_fscache_mode(sb)) {
>> +		erofs_fscache_unregister_cookie(&sbi->s_fscache);
>> +		erofs_fscache_unregister_fs(sb);
>> +		generic_shutdown_super(sb);
> 
> Generally we can't do clean ups before generic_shutdown_super(), since
> generic_shutdown_super() may trigger IO, e.g. in sync_filesystem(),
> though it's not the case for erofs (read-only).
> 
> How about embedding erofs_fscache_unregister_cookie() into
> erofs_fscache_unregister_fs(), and thus we can check domain_id in
> erofs_fscache_unregister_fs()?
> 
Thanks.
>> +	} else {
>> +		kill_block_super(sb);
>> +	}
>> +
>>   	erofs_free_dev_context(sbi->devs);
>>   	fs_put_dax(sbi->dax_dev, NULL);
>> -	erofs_fscache_unregister_cookie(&sbi->s_fscache);
>> -	erofs_fscache_unregister_fs(sb);
>>   	kfree(sbi->opt.fsid);
>>   	kfree(sbi->opt.domain_id);
>>   	kfree(sbi);
>> @@ -951,7 +952,6 @@ static void erofs_put_super(struct super_block *sb)
>>   	iput(sbi->managed_cache);
>>   	sbi->managed_cache = NULL;
>>   #endif
>> -	erofs_fscache_unregister_cookie(&sbi->s_fscache);
>>   }
>>   
>>   struct file_system_type erofs_fs_type = {
> 
