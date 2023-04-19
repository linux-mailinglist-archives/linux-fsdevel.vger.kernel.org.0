Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712426E7FD9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 18:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjDSQmX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 12:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbjDSQmV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 12:42:21 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2107AAE
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 09:42:19 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63b875d0027so16848b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 09:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681922539; x=1684514539;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RxLjpyfcWNtlWOdh1ySH+g8hP125zqr+2pf1QMqfd8s=;
        b=N23iIdeE3sO2uNX5THDu5Gry3LExo49/uDjzBM6b1AVEh/6nFahJ/kqhfY5yWCQsuz
         44My5Ywz3SK0v1I69W6BaEE9El0SR6dv+4gkZ9DEciy0lShfozzh/q0Ofq4La/cCfJbd
         hnv7Mw2F4Viu+fOXN+r/mFZj07Jae9aysr9vXW3heRV6OgMkuMtXnJNOkYdWq/90IzRA
         Ntt/sdo16L3wcv4nPThKdagjTY54125CV9whX0uqZN0/wB4/qG5smC09cukmglJtLqvU
         tu5RuxAmbYQZK8YLBwcLH2EoKRcZsbFCNuYeVRTAliEhrUYvEq42WCqlchFLU6AX9bsW
         UCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681922539; x=1684514539;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RxLjpyfcWNtlWOdh1ySH+g8hP125zqr+2pf1QMqfd8s=;
        b=i4ylU5bUwvlWEveOwpxUZLAKr6gH0xSx1K4fg+2URzvSKMDOYg4kPPaj7Bo8lCjEWo
         0wh05/M/TcO+/L21AH2m0LWE3tEaRHgwbneV5sMoO3jbVtUGghIcOzVbxlEl1uvtEKRR
         zBnvUUCykGRSQWuG5wbgw8EPHGQ06NFjnA573jCUBgdtDH3yItNpAhy00LTH31ZYQCC0
         tD3OWPLKiFo+LcyURLdwwyJM+xhHDR+kF6w49RZSE0k8HihbVzTCInX5Pq1DTWuCbYGv
         SDTvH8zJM5wdY5Rotxdhx83RXtHEkjnEReHoMbLNe32J+LgUJ1WmvmDnUQRzagBGjU3x
         lMkw==
X-Gm-Message-State: AAQBX9d7XQHVD8Q3ZHfHC1QbOt7arKV4D0mdJHCdW8Nn4ZLh3UcLKs6c
        8btJYJ8MUd4JN68xh5SWpSV2bg==
X-Google-Smtp-Source: AKy350YsLJcgKXLSYcTK4M0eUET8e8S84/nLjBZ7/eTNMzty54gG8MA8d/Evst6SrrCrHkVKGziX5g==
X-Received: by 2002:a05:6a00:4106:b0:635:4f6:2f38 with SMTP id bu6-20020a056a00410600b0063504f62f38mr18799098pfb.2.1681922538763;
        Wed, 19 Apr 2023 09:42:18 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id g12-20020a62e30c000000b0063d2bb0d107sm4683674pfh.64.2023.04.19.09.42.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 09:42:18 -0700 (PDT)
Message-ID: <868ceaa3-4854-345f-900e-52a79b924aa6@kernel.dk>
Date:   Wed, 19 Apr 2023 10:42:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] eventfd: support delayed wakeup for non-semaphore eventfd
 to reduce cpu utilization
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     Wen Yang <wenyang.linux@foxmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Paolo Bonzini <pbonzini@redhat.com>, Fu Wei <wefu@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_AF886EF226FD9F39D28FE4D9A94A95FA2605@qq.com>
 <817984a2-570c-cb23-4121-0d75005ebd4d@kernel.dk>
 <tencent_9D8583482619D25B9953FCA89E69AA92A909@qq.com>
 <7dded5a8-32c1-e994-52a0-ce32011d5e6b@kernel.dk>
 <20230419-blinzeln-sortieren-343826ee30ce@brauner>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230419-blinzeln-sortieren-343826ee30ce@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/19/23 3:12?AM, Christian Brauner wrote:
> On Tue, Apr 18, 2023 at 08:15:03PM -0600, Jens Axboe wrote:
>> On 4/17/23 10:32?AM, Wen Yang wrote:
>>>
>>> ? 2023/4/17 22:38, Jens Axboe ??:
>>>> On 4/16/23 5:31?AM, wenyang.linux@foxmail.com wrote:
>>>>> From: Wen Yang <wenyang.linux@foxmail.com>
>>>>>
>>>>> For the NON SEMAPHORE eventfd, if it's counter has a nonzero value,
>>>>> then a read(2) returns 8 bytes containing that value, and the counter's
>>>>> value is reset to zero. Therefore, in the NON SEMAPHORE scenario,
>>>>> N event_writes vs ONE event_read is possible.
>>>>>
>>>>> However, the current implementation wakes up the read thread immediately
>>>>> in eventfd_write so that the cpu utilization increases unnecessarily.
>>>>>
>>>>> By adding a configurable delay after eventfd_write, these unnecessary
>>>>> wakeup operations are avoided, thereby reducing cpu utilization.
>>>> What's the real world use case of this, and what would the expected
>>>> delay be there? With using a delayed work item for this, there's
>>>> certainly a pretty wide grey zone in terms of delay where this would
>>>> perform considerably worse than not doing any delayed wakeups at all.
>>>
>>>
>>> Thanks for your comments.
>>>
>>> We have found that the CPU usage of the message middleware is high in
>>> our environment, because sensor messages from MCU are very frequent
>>> and constantly reported, possibly several hundred thousand times per
>>> second. As a result, the message receiving thread is frequently
>>> awakened to process short messages.
>>>
>>> The following is the simplified test code:
>>> https://github.com/w-simon/tests/blob/master/src/test.c
>>>
>>> And the test code in this patch is further simplified.
>>>
>>> Finally, only a configuration item has been added here, allowing users
>>> to make more choices.
>>
>> I think you'd have a higher chance of getting this in if the delay
>> setting was per eventfd context, rather than a global thing.
> 
> That patch seems really weird. Is that an established paradigm to
> address problems like this through a configured wakeup delay? Because
> naively this looks like a pretty brutal hack.

It is odd, and it is a brutal hack. My worries were outlined in an
earlier reply, there's quite a big gap where no delay would be better
and the delay approach would be miserable because it'd cause extra
latency and extra context switches. It'd be much cleaner if you KNEW
there'd be more events coming, as you could then get rid of that delayed
work item completely. And I suspect, if this patch makes sense, that
it'd be better to have a number+time limit as well and if you hit the
event number count that you'd notify inline and put some smarts in the
delayed work handling to just not do anything if nothing is pending.

-- 
Jens Axboe

