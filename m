Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DB16491D6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Dec 2022 03:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiLKCUM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Dec 2022 21:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiLKCUL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Dec 2022 21:20:11 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD0F13CE4
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Dec 2022 18:20:10 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id k7so8697278pll.6
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Dec 2022 18:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GrzXmTMEV+6AktoaOsFPZfhD4jlzOl0gDoVrOwKNT8M=;
        b=ec6w1zMf9F+h+GQ1LGlFsqlyqhQOUa5Rqh+2eEcXympWaaF415Xsdici5XUNPjkvV9
         loWRbwsY+8GBfJ6Tc+AwQrjQaYDjQ1lwaCktUE6v50mdJM2d2qDeHFQ45jizf7k+tRPT
         gEF+GJBd3jb1l8HfAywWZSMqut0zgBOLaXKlRzQAUJXk8jKmQmeb2IVtE0iJrRJkBw4+
         mmqDhn2GMLjGM7y1u2+p/KNzj76eITGsc5QKsHDjgYTNm8v5fgvTIQ8G30zDZ2CfzrYg
         PnXp+iSweJzypYEzded3rIVmz++CO472/eg1porWtYOYj7vTzn1u9m/hG1v6pCeVuSh7
         PAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GrzXmTMEV+6AktoaOsFPZfhD4jlzOl0gDoVrOwKNT8M=;
        b=AKniwQiRPhJ7f6nrrMOlMsbd+aOWEF1xzKN6uinT4o8f2OrbU/1RrnxP1TOBe4iQoG
         Fmmiuppn64S6ouH/KiqKmHciX2REJvFIaBwhCIkYELeSYdIROqeKUKO+1P/x9qO3+BhA
         xCAw1X5qaXAMHUp/qNBum1rDKBV11m3ezpVxlio7Y3UFNwFxJur1EaLGQr7RI6RbntLy
         Hleg/1SN8HJs+BL008/hfOS7vMNFnRCDmJw6RJ/Kwk5/VNN6C1iDaAavQiawOTnjxujE
         cfeZruZ28YNDjMNauAbVoK/5AjoHTqfkLf8IOt64Z1V/+CA4Q4O9H/vxSW+oMHkWdT9B
         9vMQ==
X-Gm-Message-State: ANoB5pk7sF9AzYPNKTPwnbBPGfOUXZFVeIY0hac+uu8I5DHGEheZPbwz
        rwI5DxLvtfBAd22qCvxP1BFhAQ==
X-Google-Smtp-Source: AA0mqf6XOzu62P2ktDXnv2llsOEcc0VvR6TBaAWguH5/ZkdEexCFssK8I5IgnlqfEIowXGkV55voBg==
X-Received: by 2002:a17:902:6905:b0:189:8a36:2571 with SMTP id j5-20020a170902690500b001898a362571mr2885059plk.1.1670725209592;
        Sat, 10 Dec 2022 18:20:09 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x3-20020a170902a38300b0018957322953sm3569300pla.45.2022.12.10.18.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Dec 2022 18:20:09 -0800 (PST)
Message-ID: <4a649974-39db-83e9-8070-d1b7f3b2a03f@kernel.dk>
Date:   Sat, 10 Dec 2022 19:20:07 -0700
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
In-Reply-To: <26c376ac-7239-66fe-9c7e-ec99dfb880cd@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/10/22 6:58 PM, Jens Axboe wrote:
> On 12/10/22 11:51?AM, Linus Torvalds wrote:
>> On Sat, Dec 10, 2022 at 7:36 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> This adds an epoll_ctl method for setting the minimum wait time for
>>> retrieving events.
>>
>> So this is something very close to what the TTY layer has had forever,
>> and is useful (well... *was* useful) for pretty much the same reason.
>>
>> However, let's learn from successful past interfaces: the tty layer
>> doesn't have just VTIME, it has VMIN too.
>>
>> And I think they very much go hand in hand: you want for at least VMIN
>> events or for at most VTIME after the last event.
> 
> It has been suggested before too. A more modern example is how IRQ
> coalescing works on eg nvme or nics. Those generally are of the nature
> of "wait for X time, or until Y events are available". We can certainly
> do something like that here too, it's just adding a minevents and
> passing them in together.
> 
> I'll add that, really should be trivial, and resend later in the merge
> window once we're happy with that.

Took a quick look, and it's not that trivial. The problem is you have
to wake the task to reap events anyway, this cannot be checked at
wakeup time. And now you lose the nice benefit of reducing the
context switch rate, which was a good chunk of the win here...

This can obviously very easily be done with io_uring, since that's
how it already works in terms of waiting. The min-wait part was done
separately there, though hasn't been posted or included upstream yet.

So now we're a bit stuck...

-- 
Jens Axboe


