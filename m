Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32AB5648F9B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Dec 2022 17:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiLJQFH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Dec 2022 11:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiLJQFG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Dec 2022 11:05:06 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140A2626D
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Dec 2022 08:05:05 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d3so7864288plr.10
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Dec 2022 08:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nj/h9rv3EigkWNYBm72QPEr1eS4OqRKR9gdMlOKytOs=;
        b=oy5IosJuip5UrlkUSuhfry7Z1vgJ/elkt/Rs5URisJgmJWkQe4//6sIQrqeb771mjO
         VdKtSYociU08sYRrJafm3wspHFTR+mnZuV0HKFUccmGL8IzluN+R4Ol83mhqnmzdkk5W
         u4TKCfEoxJfL3jIzOtE7jykfpYMhxecqF8M5OUFRoFaKXivo5POMMsVjONtSOTJkaArj
         ofEU3LWNSjZeufsJs8eRMFXxQfTocLo6S1zwMgse95dIGf4Q3AWUB1GTR3z3ydTwRQ/t
         Nd19fQAiVNiI8yBWnuFqKcDbuj62lJ2sdRVFvGqqG/pdDReZrNkoA7yM/taM2Dz5khSA
         A5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nj/h9rv3EigkWNYBm72QPEr1eS4OqRKR9gdMlOKytOs=;
        b=R0jHls56eGmlUO9eD0+wR1x5uUfTgNJ/r1IlSF6akvh7hsPLNl8ZUjTS3p4Zpb6I8/
         ANUR+CmIsA/N5jwy6zerf1VvZn36rrJImWmi4GY/h4865LuQgnlto/ttp2wDlZ9ZmXvR
         3QxxmP6tGsjKLPNzKSOhOj35Szk4kCrD5+kxNla1g7exVZ6cG+XSuTf4JVtKrYsFeDY0
         Ax6reL3xjvvuABEfvByoGINTPTveRiATG8WnmKddKOizzz1HYcbrOm7RftfP38oaV351
         Fg72/1PpCnt69gzUrYxj/QBys6LZvUbyEOLtJc9DvdszVUbKkOHTub9W/Ec+CB8v+rYf
         /GVg==
X-Gm-Message-State: ANoB5pm3u8i6JrdHpiuhyL636WtzdYqrMmRGJLsf0IgLp++wNOdfJVOH
        QVOlFj7VMQfFYkgj+xliY9/Yig==
X-Google-Smtp-Source: AA0mqf5PsFa37Vo+hb5hSoGMYy4dJpNEw7Ldo3ZEV528fN2U4V4nfqSfPMZitJN7jl/WPzDdDDrJ1w==
X-Received: by 2002:a17:90a:5798:b0:213:bee0:84bc with SMTP id g24-20020a17090a579800b00213bee084bcmr2283390pji.0.1670688304379;
        Sat, 10 Dec 2022 08:05:04 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id gf12-20020a17090ac7cc00b0021904307a53sm2720265pjb.19.2022.12.10.08.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Dec 2022 08:05:03 -0800 (PST)
Message-ID: <e55d191b-d838-88a8-9cdb-e9b2e9ef4005@kernel.dk>
Date:   Sat, 10 Dec 2022 09:05:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [GIT PULL] Add support for epoll min wait time
Content-Language: en-US
To:     Willy Tarreau <w@1wt.eu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <b0901cba-3cb8-a309-701e-7b8cb13f0e8a@kernel.dk>
 <20221210155811.GA22540@1wt.eu>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221210155811.GA22540@1wt.eu>
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

On 12/10/22 8:58?AM, Willy Tarreau wrote:
> Hi Jens,
> 
> On Sat, Dec 10, 2022 at 08:36:11AM -0700, Jens Axboe wrote:
>> Hi Linus,
>>
>> I've had this done for months and posted a few times, but little
>> attention has been received.
> 
> I personally think this is particularly cool, for having faced the
> same needs in the past. I'm just wondering how long we'll avoid the
> need for marking certain FDs as urgent (i.e. for inter-thread wakeup)
> which would bypass the min delay.

Thanks! No opinion on urgent fds, it's not something I have looked
into...

> I'm just seeing something a bit odd in this series:
> 
>> ----------------------------------------------------------------
>> epoll-min_ts-2022-12-08
>>
>> ----------------------------------------------------------------
>> Jens Axboe (8):
>>       eventpoll: cleanup branches around sleeping for events
>>       eventpoll: don't pass in 'timed_out' to ep_busy_loop()
>>       eventpoll: split out wait handling
>>       eventpoll: move expires to epoll_wq
>>       eventpoll: move file checking earlier for epoll_ctl()
>>       eventpoll: add support for min-wait
>>       eventpoll: add method for configuring minimum wait on epoll context
>>       eventpoll: ensure we pass back -EBADF for a bad file descriptor
> 
> This last patch fixes a bug introduced by the 5th one. Why not squash it
> instead of purposely introducing a bug then its fix ? Or maybe it was
> just overlooked when you sent the PR ?

I didn't want to rebase it, so I just put the fix at the end. Not that
important imho, only issue there was an ltp case getting a wrong error
value. Hence didn't deem it important enough to warrant a rebase.

-- 
Jens Axboe

