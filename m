Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB245F8A6E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Oct 2022 11:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJIJvJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Oct 2022 05:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJIJvH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Oct 2022 05:51:07 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6017914D31
        for <linux-fsdevel@vger.kernel.org>; Sun,  9 Oct 2022 02:51:05 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y1so1343781pfr.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Oct 2022 02:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4m/+MFcLOu4fQCGtHWhklBXP7FJWyhQPBvhnJItC0c=;
        b=M0BkIGpCPs5WRIhkp5YvPZkU11BRLUcfcPNWBr3DX2G/p7/g7R0/gWmemHB6ZtiJw6
         jJlsadqBG5YSHH1FbvPluGZTEHsH8CynoCL5n/Rwvbfq8AZ2s00eduguIaNplfp168nJ
         4SVwb1BM4Imfwk5YISPgREglA7TCyGIo6lW/AYsnrm14/mFiDBLBGZzhrWTxpiJKh7RJ
         XNXZ4/CSmAl0PZ/G4AMnlnLtPQikFhtu9tEE2Vg2y7E8MWtLkyUk82+9jT/kuIeVRX5r
         EjTPdmtsl7eDlzOYEogrczXyUuRKb6e3pJ6r9lm1bfWt1RfSVz+EJXZlpENZgJP8AIbd
         vDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z4m/+MFcLOu4fQCGtHWhklBXP7FJWyhQPBvhnJItC0c=;
        b=cHl8MDEB0ZKtGrNSoSbdxWsJldAMMoFljtAaHpSzBKU/4/5PjnGZK4CcuWHS1JyGgD
         wFmMcYnZpwu44pgH3p+qvUcfy4MdGgKUMeEy/X/ec7Ews2rOrpQmSBmICdVvXMd1FWw5
         GNolT+GVXF2VDcMWj3MO1X8jDdgVd+dd2uz3wEwmF1wOoS8bpU9JYmLxmOQW4fYvRQtB
         d5yeI65AB+BP284ANCFXoF7zo/9z1isa0UjaTUjcJwAdJiMi2BEKPL+eCFTFQfV1kGce
         rO7k4pw6/bhzZMsoWA+e4fvtvmZqRrU2hn/LqdWpFqmTjHnJ4PJQ8itpXeKWtkjMlz2A
         tkLw==
X-Gm-Message-State: ACrzQf3NpVg2xKf63uZoGxmnheMJHRBSYQ7mtSM4ITzQDfsacNnicF17
        DRhmjAZp348RsOOYs/phxpy7at7FwVPvBQ==
X-Google-Smtp-Source: AMsMyM7F2xzqmrYGH1iUoyWGCA+/PPWnIKp4VkJG06mIj7pLxR5nygmemQM7ncAmvXBG27h9VFZziw==
X-Received: by 2002:a05:6a00:1a08:b0:545:362c:b219 with SMTP id g8-20020a056a001a0800b00545362cb219mr13787740pfv.27.1665309064778;
        Sun, 09 Oct 2022 02:51:04 -0700 (PDT)
Received: from [10.3.156.122] ([63.216.146.190])
        by smtp.gmail.com with ESMTPSA id b7-20020a621b07000000b0053b723a74f7sm4795147pfb.90.2022.10.09.02.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Oct 2022 02:51:04 -0700 (PDT)
Message-ID: <35dfe983-f916-d972-497d-269ec44cf7bf@bytedance.com>
Date:   Sun, 9 Oct 2022 17:50:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [External] Re: [RFC PATCH 2/5] cachefiles: extract ondemand info
 field from cachefiles_object
To:     JeffleXu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
        xiang@kernel.org
Cc:     linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com
References: <20220818135204.49878-1-zhujia.zj@bytedance.com>
 <20220818135204.49878-3-zhujia.zj@bytedance.com>
 <4fbf60f5-4ed1-3dd8-e4d3-de796e701956@linux.alibaba.com>
From:   Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <4fbf60f5-4ed1-3dd8-e4d3-de796e701956@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/10/8 17:06, JeffleXu 写道:
> 
> 
> On 8/18/22 9:52 PM, Jia Zhu wrote:
> 
>>   /*
>>    * Backing file state.
>>    */
>> @@ -67,8 +73,7 @@ struct cachefiles_object {
>>   	unsigned long			flags;
>>   #define CACHEFILES_OBJECT_USING_TMPFILE	0		/* Have an unlinked tmpfile */
>>   #ifdef CONFIG_CACHEFILES_ONDEMAND
>> -	int				ondemand_id;
>> -	enum cachefiles_object_state	state;
>> +	void				*private;
>>   #endif
>>   };
> 
> Personally I would prefer
> 
> 	struct cachefiles_object {
> 		...
> 	#ifdef CONFIG_CACHEFILES_ONDEMAND
> 		struct cachefiles_ondemand_info *private;
> 	#endif
> 	}
> 
> and
> 
>> @@ -88,6 +93,7 @@ void cachefiles_put_object(struct cachefiles_object
> *object,
>>   		ASSERTCMP(object->file, ==, NULL);
>>
>>   		kfree(object->d_name);
>> + #ifdef CONFIG_CACHEFILES_ONDEMAND
>> +		kfree(object->private);
>> + #endif
>>
>>   		cache = object->volume->cache->cache;
>>   		fscache_put_cookie(object->cookie,
> 
> so that we can get rid of CACHEFILES_ONDEMAND_OBJINFO() stuff, to make
> the code more readable.
Hi JingBo. Thanks for your review. I'll revise it in next version.
> 
> 
> 
