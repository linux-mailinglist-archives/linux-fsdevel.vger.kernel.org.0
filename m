Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513996CF3A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 21:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjC2Tum (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 15:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjC2Tui (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:50:38 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8ED57286
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 12:50:12 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id d22so6304204iow.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 12:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680119367; x=1682711367;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J/UO1iwasLqXd6Ax+75QaF+Dc3N1uwHqFiAzck8opiE=;
        b=vzzgPlJ/LgiVOGHOEsdVuiDkvVWlTJGmRaWGNic2XAuY3Xr2w50OjA2YwGV5nzS+Nv
         bnwqShngkAI2HPCJyq+wNe2fTGMVFB2IkCnGozH+GMHpW4nJoYCWwgr387ap0k7yYC2f
         ODqdx8WVR4Wnz0dynmj2x+wqJgeK2Svbv5gbwo7ncCjq22bVgim6GGiJQfCYgVzdmoU3
         bYWPylP1OhN2CN9Z0aTBRenG8G2jJBkqi6nPYghJCIsIjOwJRquLWxmdNFUtdSccQ2yo
         8QjFehzsEz15bV4GWGCZSeSZdNdaMx9a2odzYLIzj/4VoOJZ9NhhKqS7Vl1ocRIZspCW
         Zqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680119367; x=1682711367;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J/UO1iwasLqXd6Ax+75QaF+Dc3N1uwHqFiAzck8opiE=;
        b=AmmrSgZ2Ynr/++4S4KLETp/FrOrmvUmKO3DbYgBgiZ/+muFsnfoTszYQvixyv8+TC/
         21Ls7NbCkJ8h4YqkUucwNlCMu/ISzEl20PaBXhrhCmEfrFp3ptioBowlaRvQ2P93Qfvo
         k4U0wi8nXINIjKlxqqj385ufyzvz343mUrV2Q7JvA3FybPqu4B8Za3y+wk+BmUJ+PzPc
         4zQu89CdSAo06nqrWkJCENH4QXE+jg8zn6SGj6wJ4kiCNN53YuOkM4oD9bogcmtOZ2JD
         h+xwTBGmLNrQcOno+KatTG+mPiraRQx4txSobzXrbNpKGDNH0TIXZ56EfDugPp4QAfgp
         sXeg==
X-Gm-Message-State: AO0yUKWV2+Jd80dBSLYcdYvG8csQ9V7ZbhbG4Gw77qyl3CHvNSSxg7ve
        vmMQ3Cs8iJND6va0+HN6+Fer2YDEFZggshKaKPfrCw==
X-Google-Smtp-Source: AK7set/+SYAdarDSrMsTvPVH21q2cLT85NEARMVAg91+nK//ucI+HHVC6KNGdc1UFp6LyK/y2MXAJQ==
X-Received: by 2002:a5d:9d96:0:b0:757:f2a2:affa with SMTP id ay22-20020a5d9d96000000b00757f2a2affamr12917465iob.1.1680119367551;
        Wed, 29 Mar 2023 12:49:27 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id f5-20020a056638112500b00405a03433a0sm10501910jar.156.2023.03.29.12.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 12:49:26 -0700 (PDT)
Message-ID: <f12452c7-0bab-3b5d-024c-6ab76672068f@kernel.dk>
Date:   Wed, 29 Mar 2023 13:49:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 06/11] iov_iter: overlay struct iovec and ubuf/len
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk
References: <20230329184055.1307648-1-axboe@kernel.dk>
 <20230329184055.1307648-7-axboe@kernel.dk>
 <CAHk-=wg2q64+WLKE+0+UNeZav=LjXJZx2gHJ5NR3_5LxvQC8Mg@mail.gmail.com>
 <554cd099-aa7f-361a-2397-515f7a9f7191@kernel.dk>
 <a0911019-9eb9-bf2a-783d-fe5b5d8a9ec0@kernel.dk>
In-Reply-To: <a0911019-9eb9-bf2a-783d-fe5b5d8a9ec0@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/29/23 1:42 PM, Jens Axboe wrote:
> On 3/29/23 1:38 PM, Jens Axboe wrote:
>> On 3/29/23 1:30 PM, Linus Torvalds wrote:
>>> On Wed, Mar 29, 2023 at 11:41 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> +               struct iovec __ubuf_iovec;
>>>
>>> I think this is the third time I say this: this should be "const struct iovec".
>>
>> Doh sorry, not sure why I keep missing that... But yes, it should, I'll make
>> the edit and actually amend it.
> 
> Now I recall why that ended up like that again, during the initial fiddling
> with this. If we leave it const, we get:
> 
>   CC      arch/arm64/kernel/asm-offsets.s
> In file included from ./include/linux/socket.h:8,
>                  from ./include/linux/compat.h:15,
>                  from ./arch/arm64/include/asm/ftrace.h:52,
>                  from ./include/linux/ftrace.h:23,
>                  from arch/arm64/kernel/asm-offsets.c:12:
> ./include/linux/uio.h: In function ‘iov_iter_ubuf’:
> ./include/linux/uio.h:374:12: error: assignment of read-only location ‘*i’
>   374 |         *i = (struct iov_iter) {
>       |            ^
> make[1]: *** [scripts/Makefile.build:114: arch/arm64/kernel/asm-offsets.s] Error 1
> make: *** [Makefile:1286: prepare0] Error 2
> 
> Let me take a closer look at that...

We can get rid of these if we convert the iov_iter initializers to
just assign the members rather than the copy+zero fill. The automatic
zero fill is nice though, in terms of sanity.

-- 
Jens Axboe


