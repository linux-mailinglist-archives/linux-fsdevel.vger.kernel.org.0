Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50196BB753
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 16:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjCOPQO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 11:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjCOPQN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:16:13 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0ED0301A1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 08:16:12 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id a13so4129507ilr.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 08:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678893372;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OqTD8SXreFBDfGk9Towq94DfzLHb+0jZ+UAuwsdvyrs=;
        b=DbiyGXz9qNPL9QXHwATP3nJqJD2SOEpz+3WaNAmXAdDOSa+6PxebjQKSFjdsDoeRE+
         EIzlkSKsmmR4+tGB/OC3K3yeg5CwKJVfpy0abETQ4j6ia7JV/YFHjz9fkVwjVVT01+gA
         7hoTqPwikzgMhBd/IbtsFOtMFDRt2iakGIh7tF/Hp36/nEeqS3td0uU7ijfWTNGe3lQf
         mO/JICzYF/5eaBS6SyIKhBxE09oXgH9dGuorB80FRmWmsNxCDXLXMHnN3HjXwVPS92vD
         xmBgUmXZM0FRqioXTgQ/Xi/HnDcga3X6gKhnw5onh2R+vWCwNGZHnZ3sNJ0wB+9/X8Dk
         VEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678893372;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OqTD8SXreFBDfGk9Towq94DfzLHb+0jZ+UAuwsdvyrs=;
        b=mchxS56dp7/nO6i2WnlFqZvCww7paOaDj9YaWigaVgdD8oRJlVxClXhhaKBRughWCN
         ZJaXRsWEYl5HEGHua4/1tLPrqontL08GJ9aVpxBbrGVeJnCKkpagXdzZsJbslUZW0Jq9
         I+kYbitt01I/I7Fa6gzJiHdCbTV552zsntJahog3HlokgUkyDBcXXCELBwvn1m6V6dHQ
         +b5WBSxzkX5ErWmv+7hVA0LilRvS8L3bsF/mdNwl2/uiC2adPTEjtOfNC3IA2fpKWqCr
         C18/EKL0hKxuewom/IoMitnrlWMD/PKeGzbgOKqMgiyOa8To/HVVLDlnIPpYpp8apJ+y
         vm4w==
X-Gm-Message-State: AO0yUKVrGPbARA1rPA5cYXM2nDaaptTgbcYIzxZXsbjk2BkO8VQ9jZDg
        9OdnW7hw8P3vc8K6Qv+Ekwqr8g==
X-Google-Smtp-Source: AK7set9D+WVhXnH07DQJu8SFuTg0UgCSR7HRh/a4BCorTjYCvv5e7XLeWp1lkbRIw8v0oOj0MKiCfA==
X-Received: by 2002:a92:7406:0:b0:322:fad5:5d8f with SMTP id p6-20020a927406000000b00322fad55d8fmr7964989ilc.2.1678893372045;
        Wed, 15 Mar 2023 08:16:12 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y17-20020a056e02119100b0031798b87a14sm1696387ili.19.2023.03.15.08.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 08:16:11 -0700 (PDT)
Message-ID: <5e740404-0890-cf34-94fd-7b929a048f6d@kernel.dk>
Date:   Wed, 15 Mar 2023 09:16:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/3] pipe: enable handling of IOCB_NOWAIT
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Christian Brauner <brauner@kernel.org>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>
References: <20230314154203.181070-1-axboe@kernel.dk>
 <20230314154203.181070-3-axboe@kernel.dk>
 <20230315082321.47mw5essznhejv7z@wittgenstein>
 <38781e4c-29b7-2fbc-44a9-f365189f5381@kernel.dk>
 <20230315150237.iwhoj7a3nb4vwazd@wittgenstein>
 <f93b4292-9507-5a11-be47-0e0e99a5fe27@kernel.dk>
In-Reply-To: <f93b4292-9507-5a11-be47-0e0e99a5fe27@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/15/23 9:12 AM, Jens Axboe wrote:
> On 3/15/23 9:02 AM, Christian Brauner wrote:
>> On Wed, Mar 15, 2023 at 08:16:19AM -0600, Jens Axboe wrote:
>>> On 3/15/23 2:23 AM, Christian Brauner wrote:
>>>> On Tue, Mar 14, 2023 at 09:42:02AM -0600, Jens Axboe wrote:
>>>>> In preparation for enabling FMODE_NOWAIT for pipes, ensure that the read
>>>>> and write path handle it correctly. This includes the pipe locking,
>>>>> page allocation for writes, and confirming pipe buffers.
>>>>>
>>>>> Acked-by: Dave Chinner <dchinner@redhat.com>
>>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>> ---
>>>>
>>>> Looks good,
>>>> Reviewed-by: Christian Brauner <brauner@kernel.org>
>>>
>>> Thanks for the review, I'll add that. Are you OK with me carrying
>>> these patches, or do you want to stage them for 6.4?
>>
>> I'n not fuzzed. Since it's fs only I would lean towards carrying it. I
>> can pick it up now and see if Al has any strong opinions on this one.
> 
> Either way is fine with me - let me know if you pick it up, and
> I can drop it from my tree.

Oh and if you do, I should probably send out a v3. Was missing a
kerneldoc in patch 1, corrected that in my tree but it's not in v2.
Outside of that one-liner doc change, same patches in my tree.

-- 
Jens Axboe


