Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08BC6491F6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Dec 2022 03:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiLKCbN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Dec 2022 21:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiLKCbL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Dec 2022 21:31:11 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987D213DF5
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Dec 2022 18:31:08 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id x66so6323698pfx.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Dec 2022 18:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=75+s5qZCeuIvAhBhOyPdI3eWv9aX2MgCwwudSC1cg88=;
        b=sUBYNbbs2JzQktJf98LK7sN69LbZh4xirvamj9Wye/YUU2WK8Lpi3+/mQhRI6S33uN
         SFdoDfGGdWhViLajT11le+iyLw3YB/k+xU1QST5Ynm6ZY5Q38wqtW3Jh0se8qeVRRi3C
         qu0qp1Oe+ad+5JgpOeEtbyp3J/VpXe3js7GOq8QAFwil0VJ7pPIS7f99JSGMCZZzDaxa
         fpIId8t3RoVfs2BT0T2Kz5gE4T8AdVZ+WgUpDZszpojak6vDCWDnT7SSb06SPEr4qGyb
         peoMXn8O2DUrtA/lAFgb88w4h8h7BvCxzdIycIYSbQvBv8qO9/7uG7G6q0VTFlKa76F2
         RfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=75+s5qZCeuIvAhBhOyPdI3eWv9aX2MgCwwudSC1cg88=;
        b=K/6rzLZNi39TVfZrzjO464r2xtv1qgCGu7cFE6JZT+qPiaT6A8ALfk15nY3QSpJ2dd
         /aK8phJ6BemnuXCkaNatRFYyxhEWaXLx5lMImsEEQlLIwYtmblUJiVHUYdXV60dx7m2T
         M776y40vU6Y5FMPvRpQCU4/cs1BCI/tWpsuMRWO/Duqw9XHt5M3R4QI67djnWRizE5QS
         RL726Ar+AMUqC0mhrUasHkPd5HZAUqLXuGcPE6KOmLFlbr6Wi+CIkmooM/dm/fgb4A+z
         YSdQCYPsFLEAPTMDjEXAolcbH74X62zpCr34usjRSZptf8RC0MJY7bCBGCAQmgMwd7ok
         8y6g==
X-Gm-Message-State: ANoB5pljB+U/xIA1vp3uXG0FvuTL7a6pBohziN4eIOdGJkYA351roUqC
        uPo0GVoLn9/CptML8thI6CnNX7bh2wlPf+LIDHA=
X-Google-Smtp-Source: AA0mqf6xW3dIWJb21IyD5nWJ+YlnOJtcXYy0mFbfruJYU+4U/eSyKxnsT4Etg8WrMAibMOg1wVsQcw==
X-Received: by 2002:a05:6a00:2294:b0:577:7fe8:b916 with SMTP id f20-20020a056a00229400b005777fe8b916mr2526690pfe.0.1670725868011;
        Sat, 10 Dec 2022 18:31:08 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q14-20020aa7842e000000b0056bd6b14144sm3270557pfn.180.2022.12.10.18.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Dec 2022 18:31:07 -0800 (PST)
Message-ID: <581a6498-efcd-b57d-02b6-4237559c72e6@kernel.dk>
Date:   Sat, 10 Dec 2022 19:31:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [GIT PULL] Add support for epoll min wait time
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     netdev <netdev@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <b0901cba-3cb8-a309-701e-7b8cb13f0e8a@kernel.dk>
 <CAHk-=whgzBzTR5t6Dc6gZ_XS1q=UrqeiBf62op_fahbwns+xvQ@mail.gmail.com>
 <26c376ac-7239-66fe-9c7e-ec99dfb880cd@kernel.dk>
 <4a649974-39db-83e9-8070-d1b7f3b2a03f@kernel.dk>
In-Reply-To: <4a649974-39db-83e9-8070-d1b7f3b2a03f@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/10/22 7:20?PM, Jens Axboe wrote:
> On 12/10/22 6:58?PM, Jens Axboe wrote:
>> On 12/10/22 11:51?AM, Linus Torvalds wrote:
>>> On Sat, Dec 10, 2022 at 7:36 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> This adds an epoll_ctl method for setting the minimum wait time for
>>>> retrieving events.
>>>
>>> So this is something very close to what the TTY layer has had forever,
>>> and is useful (well... *was* useful) for pretty much the same reason.
>>>
>>> However, let's learn from successful past interfaces: the tty layer
>>> doesn't have just VTIME, it has VMIN too.
>>>
>>> And I think they very much go hand in hand: you want for at least VMIN
>>> events or for at most VTIME after the last event.
>>
>> It has been suggested before too. A more modern example is how IRQ
>> coalescing works on eg nvme or nics. Those generally are of the nature
>> of "wait for X time, or until Y events are available". We can certainly
>> do something like that here too, it's just adding a minevents and
>> passing them in together.
>>
>> I'll add that, really should be trivial, and resend later in the merge
>> window once we're happy with that.
> 
> Took a quick look, and it's not that trivial. The problem is you have
> to wake the task to reap events anyway, this cannot be checked at
> wakeup time. And now you lose the nice benefit of reducing the
> context switch rate, which was a good chunk of the win here...

One approximation we could make is that once we've done that first reap
of events, let's say we get N events (where N could be zero), the number
of wakeups post that is a rough approximation of the number of events
that have arrived. We already use this to break out of min_wait if we
think we'll exceed maxevents. We could use that same metric to estimate
if we've hit minevents as well. It would not be guaranteed accurate, but
probably good enough. Even if we didn't quite hit minevents there, we'd
return rather than do another sleep and wakeup cycle.

-- 
Jens Axboe

