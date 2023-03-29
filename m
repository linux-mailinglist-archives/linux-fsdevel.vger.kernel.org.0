Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B626CD169
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 07:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjC2FGl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 01:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjC2FGk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 01:06:40 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470FB2723
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 22:06:15 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso2967705pjc.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 22:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680066375;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjcLq9TYMSCEM1QxXkGT3Sk7emAp6wIFay5f/IdlFCI=;
        b=K0sDjl31CF3wQLECFV0Z+qXmmfbY6/nvHtwhUV+gdNIgedwU6XnM9SL+lkP0AsQS72
         h6FxRX1Eba/67jysjsw+a3Yg3lcjnZNMuWL/RMxYWI13y5cB+OWEQQ5vydbpAzqNjOfr
         b7BgjW9UGv41y2niEKTHlC7uvanY/p4+VdnazRZTgxEnDnuI2QnVTCawr5ErsQq7ZI8k
         lIYedhZETnOaE3WYyVtJvhXlboS0gTCezU1Pd9aJj7DQehQBnzls4sKZdMakWjKkTLth
         +8aoJlNSoZ+4tCtPM3zmqdzgfHonxHFdWY5hrfTP0NiwZkAODT53YYfRkVzOwV90Jka/
         Hw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680066375;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GjcLq9TYMSCEM1QxXkGT3Sk7emAp6wIFay5f/IdlFCI=;
        b=DZhBtGC0xmmcTZhPnUC4lx9SjUauRPYsAqowmjnW7Qon0Mk1DERvBekFxiyhMj0ybn
         gy/NvCSwimMlvL0DrBVnNo8V7zqxo80B5/ZqOEPbLVKCMySf4lpIEAeNNWNsrEyFZJK6
         vApTlUwMvFBZFBMW0ORS4vXt86d0RGwENmqaC3/Tg9fIGSxZwSfvPW53DcUddfG1Uqqo
         phpHkJIVnN8YXh+c1uPDoUyEJW2ZlPFslEX8hvLJPT0+Rzt1bdA73toreJ5BxGvBQNnt
         CkyL64KS8e4/XGFBfQOMC6LouOgUlXiqNK7wkQSglJO96dgJ95GbIXAegmDKyeioGSOo
         F4Ig==
X-Gm-Message-State: AAQBX9e7xB5YR6Ug8ynn5EoxcEMrHyt3K6Ay/v5+FeJxNjCedl1qilBa
        xfr78GVSyj4OGq2bpc8q+mLUgQ==
X-Google-Smtp-Source: AKy350ZTGNkadk5EkErfDhJ6zlZsX/8WZzxktyRHEWZEs7dxg+S3jbdRlD777MfiA6AK1tAh84FLZg==
X-Received: by 2002:a17:90b:1a88:b0:23e:aba9:d51d with SMTP id ng8-20020a17090b1a8800b0023eaba9d51dmr19242110pjb.7.1680066374750;
        Tue, 28 Mar 2023 22:06:14 -0700 (PDT)
Received: from [10.3.144.50] ([61.213.176.7])
        by smtp.gmail.com with ESMTPSA id dw24-20020a17090b095800b0023cff7e39a6sm463394pjb.22.2023.03.28.22.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 22:06:14 -0700 (PDT)
Message-ID: <1b99542d-f21b-a27b-fc59-d4fe38e893de@bytedance.com>
Date:   Wed, 29 Mar 2023 13:06:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: Re: [PATCH V4 2/5] cachefiles: extract ondemand info field from
 cachefiles_object
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingbo Xu <jefflexu@linux.alibaba.com>, zhujia.zj@bytedance.com
References: <20230111052515.53941-3-zhujia.zj@bytedance.com>
 <20230111052515.53941-1-zhujia.zj@bytedance.com>
 <132137.1680011908@warthog.procyon.org.uk>
From:   Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <132137.1680011908@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2023/3/28 21:58, David Howells 写道:
> Jia Zhu <zhujia.zj@bytedance.com> wrote:
> 
>> @@ -65,10 +71,7 @@ struct cachefiles_object {
>>   	enum cachefiles_content		content_info:8;	/* Info about content presence */
>>   	unsigned long			flags;
>>   #define CACHEFILES_OBJECT_USING_TMPFILE	0		/* Have an unlinked tmpfile */
>> -#ifdef CONFIG_CACHEFILES_ONDEMAND
>> -	int				ondemand_id;
>> -	enum cachefiles_object_state	state;
>> -#endif
>> +	struct cachefiles_ondemand_info	*private;
> 
> Why is this no longer inside "#ifdef CONFIG_CACHEFILES_ONDEMAND"?
> 

I'll revise it in next version.

> Also, please don't call it "private", but rather something like "ondemand" or
> "ondemand_info".

I'll use @ondemand to replace it.
Thanks.
> 
> David
> 
