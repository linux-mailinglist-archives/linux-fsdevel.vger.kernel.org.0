Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE79E5B9418
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 08:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiIOGIA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 02:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiIOGH6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 02:07:58 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC3786B57
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 23:07:56 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id b75so11803311pfb.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 23:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=VQwNXHpMcNzMWvwc/Da6V70id6z3bbhtKYXslcr+kJo=;
        b=ibO/wc2BrsXme6DE9SPHSIz2siu6/IST8u9oC8WZEquf/PZPbSZhvpQXmnHJvCRxY6
         P3P650X4Z6WQWqQoseR9qY9nnLo2AX/7WsCZeowWK7NL/MKoQUumTE1nOIeRMnp5zKJU
         smkb/ahHd7vLyMjcyF5Y3e3uyg/PPasvZb3VP2kbqY6flS59cC38dMMbusPYVuZb+bk5
         no4MQLvhxUIAOZ9XCgipS5DQkvNKO/ku8eGAZV07XkW0stvUSLsIX3le+noyLTfEi1b1
         8C293LGqPosYXxLNH7Ul8uZtcnn9FooQxc429gR5PnN650ZUBD6On+R+icpBcU2wzHJ+
         DEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=VQwNXHpMcNzMWvwc/Da6V70id6z3bbhtKYXslcr+kJo=;
        b=Ic8aXRiS8lYrIUwqGrNmrmdNFXuVseGPsCgen/XvQic/d1O8SApIi4ku2fSaMoSvJI
         yNWPrsMP5sYMIqUiKbcCIb4lZbv8mtXziEBJKpSHvTe9o5WIxzGYtE9TvtEUvQa51nC8
         l7uZx01QiCCgz3ewMXgA8RhzgyJESaInXvg5ICarqx00KYjTMcgb/mXA6TU/N079luoO
         Emd8456y9/oLidauezrWLRgjGNe52M7EQd1daBh5pwekMlfZQItaOwssGDaf0W0DIgp8
         MGW+yjfF2+8mrYGM8I2GYAdGFNBywMgOeF5r82oOo/jNtD9kU14blxP6AX4Nq+lSzpFc
         l3wg==
X-Gm-Message-State: ACgBeo3fFj6jfNc7kPCyjgddm7pMV8SkvL6Sj8qAttJ4tlV98R7e+HbQ
        HR21k6bfFL+9baHpN2LnYXUpxOkyTdR0Fk9o
X-Google-Smtp-Source: AA6agR5KvTTWQBLOtQc+SAEQY+Ih2ccYRNJQUpPrsBPvLtYvYnw1Qsqe03kAV4U82cJFEsw36KS0/A==
X-Received: by 2002:a63:1e11:0:b0:41c:d233:31f8 with SMTP id e17-20020a631e11000000b0041cd23331f8mr34969128pge.228.1663222075779;
        Wed, 14 Sep 2022 23:07:55 -0700 (PDT)
Received: from [10.76.37.214] ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id u197-20020a6279ce000000b00540e1117c98sm11247458pfc.122.2022.09.14.23.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 23:07:55 -0700 (PDT)
Message-ID: <6da8b963-610c-9692-192f-aa611e64ac82@bytedance.com>
Date:   Thu, 15 Sep 2022 14:07:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [External] Re: [PATCH V3 1/6] erofs: use kill_anon_super() to
 kill super in fscache mode
To:     JeffleXu <jefflexu@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, huyue2@coolpad.com
References: <20220914105041.42970-1-zhujia.zj@bytedance.com>
 <20220914105041.42970-2-zhujia.zj@bytedance.com>
 <b8d9aaac-6e91-f760-c9bc-ac270eecefa6@linux.alibaba.com>
From:   Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <b8d9aaac-6e91-f760-c9bc-ac270eecefa6@linux.alibaba.com>
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



在 2022/9/15 10:28, JeffleXu 写道:
> 
> 
> On 9/14/22 6:50 PM, Jia Zhu wrote:
>> Use kill_anon_super() instead of generic_shutdown_super() since the
>> mount() in erofs fscache mode uses get_tree_nodev() and associated
>> anon bdev needs to be freed.
>>
>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> 
> Thanks. You're welcome to use "Suggested-by" in this case. The same with
> patch 2.
> 
OK, thanks for your suggestion and review.
>> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
>> ---
>>   fs/erofs/super.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 3173debeaa5a..9716d355a63e 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -879,7 +879,7 @@ static void erofs_kill_sb(struct super_block *sb)
>>   	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
>>   
>>   	if (erofs_is_fscache_mode(sb))
>> -		generic_shutdown_super(sb);
>> +		kill_anon_super(sb);
>>   	else
>>   		kill_block_super(sb);
>>   
> 
> Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> 
