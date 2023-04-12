Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023036DF883
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 16:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjDLObU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 10:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjDLObT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:31:19 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE30C6A61;
        Wed, 12 Apr 2023 07:31:06 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id o1so15004855lfc.2;
        Wed, 12 Apr 2023 07:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681309865; x=1683901865;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NKqGWSr/G6DRYWjpHEpbc9yXr1XCjxCTx07fgQvzCmM=;
        b=VOOSHSmH6pDlYpZd8rfvNbvW/8Bjclrvi3sCK3u9Igupgt1m1HJ+yzzlS4uRn2Y3M2
         3xgKUwJvdXbKjov1hLmaUO1Kz3Pv5DaQqNsREupl1P5N7UUotck2bKeTdnxDVNRaBInN
         e7W4eruZqvdZhKUP3dTCkuuM40D42k6JrKdzc9CGbk6Sv6aWoHmAICc/2sY8YYwlQ2bg
         Fb2wdsJfT+ew0h9VQhGyeEYqq5ZogsWxKcfxOhw3QFljrT63wm9tuGpBgt7QTejmnb5P
         cPT1o+LSzg9MPEb1DEXpdqrnivh4ejPqeDHwUCwC0MQliJ85T+l0nNcSp/aRG+7Qno7j
         wY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681309865; x=1683901865;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NKqGWSr/G6DRYWjpHEpbc9yXr1XCjxCTx07fgQvzCmM=;
        b=Mjf26W3pvZEm7ed3NxDBFMcvgMmjXd4la4+6fmZ8wddMo6gDFgYg73X/62sOfmiCkN
         TAeLQ1XG0vZN0g4OMymKgxjmNtaJBYni3/THQ1xH0IjVn0ZGe6uU4PCCcRo3WIVnbGm5
         QwPt+JUgytoFhpClRS8r0Q6nvRwt1/s7KTqA/XZdWKMDWAZPbR75vf1+9zk2VDEoz1Vr
         +Y/nrg1nTFZr3lrbiXesNZXihmQzUiZhPDlKh3a4uKfLl6Zh41Z+hgzw1vacInfvEA+2
         EWheIU9y17fCJZiBC0U2jKXzkJNflEYgUTvZy8bHciGb+nRfpSB55HV5WIZe+AZWbgNn
         hPBA==
X-Gm-Message-State: AAQBX9dt8dII8RHtannDBhrk6lMl/gP1BjLsDX3zw1/wnbWfwUW+ZsR5
        TlPLjuCP8DGBPtDHoNp4jCQ=
X-Google-Smtp-Source: AKy350a14DyyTt9Xudbl8SOiZMRo0zVAzLRUPsOW0cufOBSH3zFuiHhPzlSurs2P+AEx5LzPOg8Q4A==
X-Received: by 2002:a05:6512:968:b0:4e9:4d61:e750 with SMTP id v8-20020a056512096800b004e94d61e750mr1530270lft.32.1681309864989;
        Wed, 12 Apr 2023 07:31:04 -0700 (PDT)
Received: from [172.25.56.57] ([212.22.67.162])
        by smtp.gmail.com with ESMTPSA id g1-20020a19ac01000000b004e845954a81sm3020310lfc.296.2023.04.12.07.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 07:31:04 -0700 (PDT)
Message-ID: <df995d93-4b31-fa61-a7ae-db33fd058412@gmail.com>
Date:   Wed, 12 Apr 2023 17:31:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] writeback: fix call of incorrect macro
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@fb.com>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20230119104443.3002-1-korotkov.maxim.s@gmail.com>
 <20230126135258.zpvyfxc2ffhzzsnx@quack3>
Content-Language: en-US
From:   Maxim Korotkov <korotkov.maxim.s@gmail.com>
In-Reply-To: <20230126135258.zpvyfxc2ffhzzsnx@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,
Will this patch be applied or rejected?
best regards, Max

On 26.01.2023 16:52, Jan Kara wrote:
> On Thu 19-01-23 13:44:43, Maxim Korotkov wrote:
>>   the variable 'history' is of type u16, it may be an error
>>   that the hweight32 macro was used for it
>>   I guess macro hweight16 should be used
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Fixes: 2a81490811d0 ("writeback: implement foreign cgroup inode detection")
>> Signed-off-by: Maxim Korotkov <korotkov.maxim.s@gmail.com>
> 
> Looks good to me, although it is mostly a theoretical issue - I don't see
> how hweight32 could do any harm here. Anyway, feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> 								Honza
> 
>> ---
>>   fs/fs-writeback.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
>> index 6fba5a52127b..fc16123b2405 100644
>> --- a/fs/fs-writeback.c
>> +++ b/fs/fs-writeback.c
>> @@ -829,7 +829,7 @@ void wbc_detach_inode(struct writeback_control *wbc)
>>   		 * is okay.  The main goal is avoiding keeping an inode on
>>   		 * the wrong wb for an extended period of time.
>>   		 */
>> -		if (hweight32(history) > WB_FRN_HIST_THR_SLOTS)
>> +		if (hweight16(history) > WB_FRN_HIST_THR_SLOTS)
>>   			inode_switch_wbs(inode, max_id);
>>   	}
>>   
>> -- 
>> 2.37.2
>>

