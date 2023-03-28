Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB846CCC45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 23:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjC1Vvq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 17:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjC1Vvp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:51:45 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AAD1B8
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 14:51:44 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso16607128pjb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 14:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680040304;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hxbvrUcd92Aftm13jlXv4qFt9l/JMO2ad78gPhj8aY4=;
        b=poFt38gVuD84goy1xsm9xwT2TUFxfnpHhLnY1HvbP+Ok5U5VdUrG+Knazw+b7ZBZ59
         bAMrriuBFtvkRsPPK4pennoXFQWp4+GO2XgJ/T6NLw1NY1WLSKACNyPvZ4lezUsA5WgM
         K5KntbHzDWChM/GQZ8Y6cVoQ5CQfjxfCU60wla215Z/22wciScjxoLRVmDrDsGPw+LH0
         7pthWFU3XuTdZ07ITT7A4uGhLOmmwLzfeWYDAygL7EcprAZ+pI1rUMsSYTkNwi1hKukN
         y171PMQ+jdvWMzQeNhOdiWS8EGSZM9aIkYo0L4NhhjmTfBAIpmomf+QPEBHQHYuFcH4r
         09RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680040304;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hxbvrUcd92Aftm13jlXv4qFt9l/JMO2ad78gPhj8aY4=;
        b=YNmHmk6jwdGEWTiAYccCTiRfbnEYJHwm8Wa8atgakYpVM6lTGyY2Htr585F+HkUonq
         OjKASH2UYaxlEGrU/JIdwqpZALaoEX4aAkTrJuB2qDBQDOacDCynD3rqRpPKjC/038lg
         XY+S9i9U3L/vzmJw45ViRNehlFey7zsSmDIqx5+Ha8cYdTN5d3gdST0N5jTneu/eXF6k
         /WHWC/gHie+FQiN+t5VOdH3wpuoCateddE4eKezGmTLskPAOV2hGpfJwYtd0vjGmA3X/
         PSLa3cFVMJvdHzJis33MZIsL4o/aD6DQFkbJw8/cekmjDMRQK/cLxllBOWBHVVI1DVCe
         KD9w==
X-Gm-Message-State: AAQBX9dL2bglbYxz5e1qmvorlLIOMt9nHVCZRU74/V4LUPonsIByAOvp
        J/DpiKMMdds5HDkl6lf+KL6S1A==
X-Google-Smtp-Source: AKy350abSaJTWMXk8tJSQJGzym1Sv5gt2lvtCNRGDkiMpZUER3qdVz1GnSPNSIQOfAiacLy8xEr2RA==
X-Received: by 2002:a17:903:32cd:b0:196:8d96:dc6b with SMTP id i13-20020a17090332cd00b001968d96dc6bmr15228022plr.2.1680040303862;
        Tue, 28 Mar 2023 14:51:43 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id iw4-20020a170903044400b0019f2a7f4d16sm21738560plb.39.2023.03.28.14.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 14:51:43 -0700 (PDT)
Message-ID: <f9c5e9e9-0404-f0aa-cd64-d26b9ceafffe@kernel.dk>
Date:   Tue, 28 Mar 2023 15:51:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 5/8] IB/hfi1: make hfi1_write_iter() deal with ITER_UBUF
 iov_iter
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk
References: <20230328173613.555192-1-axboe@kernel.dk>
 <20230328173613.555192-6-axboe@kernel.dk>
 <CAHk-=wj=21dt1ASqkvaNXenzQCEZHydYE39+YOj8AAfzeL5HOQ@mail.gmail.com>
 <ZCM4KsKa3xQR2IOv@casper.infradead.org>
 <CAHk-=wgxYOFJ-95gPk9uo1B6mTd0hx1oyybCuQKnfWD1yP=kjw@mail.gmail.com>
 <CAHk-=wggKW9VQSUzGGpC9Rq3HYiEEsFM3cn2cvAJsUBbU=zEzA@mail.gmail.com>
 <fc3e4956-9956-01ee-7c11-e9eef59b5e38@kernel.dk>
 <ee35b429-bc53-c070-5998-97475e0ae9ff@kernel.dk>
In-Reply-To: <ee35b429-bc53-c070-5998-97475e0ae9ff@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/28/23 3:38 PM, Jens Axboe wrote:
> On 3/28/23 3:21?PM, Jens Axboe wrote:
>> On 3/28/23 1:16?PM, Linus Torvalds wrote:
>>> On Tue, Mar 28, 2023 at 12:05?PM Linus Torvalds
>>> <torvalds@linux-foundation.org> wrote:
>>>>
>>>> But it's not like adding a 'struct iovec' explicitly to the members
>>>> just as extra "code documentation" would be wrong.
>>>>
>>>> I don't think it really helps, though, since you have to have that
>>>> other explicit structure there anyway to get the member names right.
>>>
>>> Actually, thinking a bit more about it, adding a
>>>
>>>     const struct iovec xyzzy;
>>>
>>> member might be a good idea just to avoid a cast. Then that
>>> iter_ubuf_to_iov() macro becomes just
>>>
>>>    #define iter_ubuf_to_iov(iter) (&(iter)->xyzzy)
>>>
>>> and that looks much nicer (plus still acts kind of as a "code comment"
>>> to clarify things).
>>
>> I went down this path, and it _mostly_ worked out. You can view the
>> series here, I'll send it out when I've actually tested it:
>>
>> https://git.kernel.dk/cgit/linux-block/log/?h=iter-ubuf
>>
>> A few mental notes I made along the way:
>>
>> - The IB/sound changes are now just replacing an inappropriate
>>   iter_is_iovec() with iter->user_backed. That's nice and simple.
>>
>> - The iov_iter_iovec() case becomes a bit simpler. Or so I thought,
>>   because we still need to add in the offset so we can't just use
>>   out embedded iovec for that. The above branch is just using the
>>   iovec, but I don't think this is right.
>>
>> - Looks like it exposed a block bug, where the copy in
>>   bio_alloc_map_data() was obvious garbage but happened to work
>>   before.
>>
>> I'm still inclined to favor this approach over the previous, even if the
>> IB driver is a pile of garbage and lighting it a bit more on fire would
>> not really hurt.
>>
>> Opinions? Or do you want me to just send it out for easier reading
> 
> While cleaning up that stuff, we only have a few users of iov_iter_iovec().
> Why don't we just kill them off and the helper too? That drops that
> part of it and it kind of works out nicely beyond that.

Ugh that won't work obviously, as we can't factor in per-vec
offsets... So it has to be a copy.

-- 
Jens Axboe


