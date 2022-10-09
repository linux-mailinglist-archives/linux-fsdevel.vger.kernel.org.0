Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FBF5F8A72
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Oct 2022 11:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiJIJwj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Oct 2022 05:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiJIJwi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Oct 2022 05:52:38 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C9C1B9CE
        for <linux-fsdevel@vger.kernel.org>; Sun,  9 Oct 2022 02:52:37 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id f193so8204372pgc.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Oct 2022 02:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSVDnAgp4oFS6GtK5rwH8v4//Iq76mLV9/G+ci+5hkU=;
        b=5X6uW2V+efbPbpyDNO3HlTgh8q1X5rnRaOc6ctfh4Nyq+P+npywuh1EOO5ouC2B8Pj
         S//KvKWa8t5eAgr4fmtMzJBmpY27L5ZomycvSDcVYpkoDjD4DkKEaGBQhHXrpvlpTJf+
         /vywDKTauGCQoTz02QOGcT95fyWQEQMOVMp9BfI8nD+HDUnp8CBQ6a4V/zqSPqpUe9eQ
         Ih3Bnk4n+7voDmxcf/d+fCO9EnGN6uOlOe1K0oGr7j0ePkR5XiTBTB8h4AegVlCAkUmx
         CSr3ILx2UbazKdN2vbowNDI43x6gdknGrj1pO4/hL+yfEeK3vdle+o6mDaea1gxUZwlN
         vYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vSVDnAgp4oFS6GtK5rwH8v4//Iq76mLV9/G+ci+5hkU=;
        b=sX4VLpSxEVAPa1+OVgK7ZCQuknjZ9dAYpBJDHHkHiuPMLDumB7dGYbff/W4HbdyAa9
         Akz6tm+roLe7U7zjkvBhTumcVw+y/reVi87x0Qi0zS6ElzMJJvvvSG//N1mao8XALKiB
         HgvuIrKkDOvGpSrZR4RlWKlv4wgI8NJ6zTp1cXaNJLLEyWNoEw/tCTD65SReb0TOpsGj
         kSl4hHCkN67a5ZwjotyWeeAr+7seerYt93646OujcLO8+zOhcIzwU/ps9sDzrMaM7kwi
         ush8yx0AAWB2OmQvIzroEGOA2fdoU4T8Yj4mLmStUsx6rCiojGAKJ2SsfjbNICE/lYfW
         z0Ug==
X-Gm-Message-State: ACrzQf0nHutCRCf3wD8l7TpRQffBnllWDj0DzUfSunvc+ng9dfUUawXV
        MD8+lKlPjSVjtH3VjMkZHomVGg==
X-Google-Smtp-Source: AMsMyM7IzOZu1tCczAGU+xbSMs7nJWyuEw0Ic2cn/6a4gM+q7tFnu7M34AMMxZfdqitGv9f1oFrLDg==
X-Received: by 2002:a65:44c1:0:b0:428:ab8f:62dd with SMTP id g1-20020a6544c1000000b00428ab8f62ddmr11994518pgs.211.1665309157196;
        Sun, 09 Oct 2022 02:52:37 -0700 (PDT)
Received: from [10.3.156.122] ([63.216.146.187])
        by smtp.gmail.com with ESMTPSA id c82-20020a624e55000000b0056265011136sm4678686pfb.112.2022.10.09.02.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Oct 2022 02:52:36 -0700 (PDT)
Message-ID: <bdbf258d-096c-4c44-c195-0ecff7504a32@bytedance.com>
Date:   Sun, 9 Oct 2022 17:52:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [External] Re: [RFC PATCH 5/5] cachefiles: add restore command to
 recover inflight ondemand read requests
To:     JeffleXu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
        xiang@kernel.org
Cc:     linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20220818135204.49878-1-zhujia.zj@bytedance.com>
 <20220818135204.49878-6-zhujia.zj@bytedance.com>
 <514c06f7-017d-bca5-6a87-0dae54c0d83d@linux.alibaba.com>
From:   Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <514c06f7-017d-bca5-6a87-0dae54c0d83d@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/10/8 17:00, JeffleXu 写道:
> 
> 
> On 8/18/22 9:52 PM, Jia Zhu wrote:
>> Previously, in ondemand read scenario, if the anonymous fd was closed by
>> user daemon, inflight and subsequent read requests would return EIO.
>> As long as the device connection is not released, user daemon can hold
>> and restore inflight requests by setting the request flag to
>> CACHEFILES_REQ_NEW.
>>
>> Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
>> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
>> ---
>>   fs/cachefiles/daemon.c   |  1 +
>>   fs/cachefiles/internal.h |  3 +++
>>   fs/cachefiles/ondemand.c | 23 +++++++++++++++++++++++
>>   3 files changed, 27 insertions(+)
>>
>> diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
>> index c74bd1f4ecf5..014369266cb2 100644
>> --- a/fs/cachefiles/daemon.c
>> +++ b/fs/cachefiles/daemon.c
>> @@ -77,6 +77,7 @@ static const struct cachefiles_daemon_cmd cachefiles_daemon_cmds[] = {
>>   	{ "tag",	cachefiles_daemon_tag		},
>>   #ifdef CONFIG_CACHEFILES_ONDEMAND
>>   	{ "copen",	cachefiles_ondemand_copen	},
>> +	{ "restore",	cachefiles_ondemand_restore	},
>>   #endif
>>   	{ "",		NULL				}
>>   };
>> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
>> index b4af67f1cbd6..d504c61a5f03 100644
>> --- a/fs/cachefiles/internal.h
>> +++ b/fs/cachefiles/internal.h
>> @@ -303,6 +303,9 @@ extern ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>>   extern int cachefiles_ondemand_copen(struct cachefiles_cache *cache,
>>   				     char *args);
>>   
>> +extern int cachefiles_ondemand_restore(struct cachefiles_cache *cache,
>> +					char *args);
>> +
>>   extern int cachefiles_ondemand_init_object(struct cachefiles_object *object);
>>   extern void cachefiles_ondemand_clean_object(struct cachefiles_object *object);
>>   
>> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
>> index 79ffb19380cd..5b1c447da976 100644
>> --- a/fs/cachefiles/ondemand.c
>> +++ b/fs/cachefiles/ondemand.c
>> @@ -178,6 +178,29 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>>   	return ret;
>>   }
>>   
>> +int cachefiles_ondemand_restore(struct cachefiles_cache *cache, char *args)
>> +{
>> +	struct cachefiles_req *req;
>> +
>> +	XA_STATE(xas, &cache->reqs, 0);
>> +
>> +	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
>> +		return -EOPNOTSUPP;
>> +
>> +	/*
>> +	 * Search the requests which being processed before
>> +	 * the user daemon crashed.
>> +	 * Set the CACHEFILES_REQ_NEW flag and user daemon will reprocess it.
>> +	 */
> 
> The comment can be improved as:
> 
> 	Reset the requests to CACHEFILES_REQ_NEW state, so that the
>          requests have been processed halfway before the crash of the
>          user daemon could be reprocessed after the recovery.
> 
Thanks, I'll apply it.
> 
>> +	xas_lock(&xas);
>> +	xas_for_each(&xas, req, ULONG_MAX)
>> +		xas_set_mark(&xas, CACHEFILES_REQ_NEW);
>> +	xas_unlock(&xas);
>> +
>> +	wake_up_all(&cache->daemon_pollwq);
>> +	return 0;
>> +}
>> +
>>   static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
>>   {
>>   	struct cachefiles_object *object;
> 
